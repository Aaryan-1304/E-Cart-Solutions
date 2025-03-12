import faiss
import numpy as np
from sentence_transformers import SentenceTransformer
import psycopg2
import json
import os

# Load the model
model = SentenceTransformer("all-MiniLM-L6-v2")

# Secure database credentials using environment variables
DB_NAME = os.getenv("DB_NAME", "ApplicationInformation")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD", "butala@130403")
DB_HOST = os.getenv("DB_HOST", "localhost")

# Database connection
def get_db_connection():
    return psycopg2.connect(
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST
    )

# Ensure FAISS index and ID map exist
INDEX_FILE = "product_index.faiss"
ID_MAP_FILE = "product_id_map.json"

# Create the FAISS index
def create_index():
    conn = get_db_connection()
    cur = conn.cursor()
    
    cur.execute("SELECT product_id, product_name, product_description FROM products")
    products = cur.fetchall()
    
    embedding_size = 384  # Size for all-MiniLM-L6-v2
    index = faiss.IndexFlatL2(embedding_size)
    
    id_map = {}

    for i, product in enumerate(products):
        product_id, product_name, product_description = product
        searchable_text = f"{product_name} {product_description}"
        embedding = model.encode([searchable_text])[0]
        
        index.add(np.array([embedding], dtype=np.float32))
        id_map[i] = product_id  # Store mapping

    faiss.write_index(index, INDEX_FILE)
    
    with open(ID_MAP_FILE, "w") as f:
        json.dump(id_map, f)

    cur.close()
    conn.close()
    
    print(f"Index created with {len(products)} products")

# Search products
def search_products(query, top_k=5):
    # Check if index files exist
    if not (os.path.exists(INDEX_FILE) and os.path.exists(ID_MAP_FILE)):
        raise FileNotFoundError("FAISS index or ID map not found! Run with '--create-index' first.")

    # Load FAISS index and ID mapping
    index = faiss.read_index(INDEX_FILE)
    
    with open(ID_MAP_FILE, "r") as f:
        id_map = json.load(f)
    
    # Convert keys to integers
    id_map = {int(k): v for k, v in id_map.items()}
    
    # Generate query embedding
    query_embedding = model.encode([query])
    
    # Perform search
    distances, indices = index.search(np.array(query_embedding, dtype=np.float32), top_k)
    
    # Get product IDs
    product_ids = [id_map[idx] for idx in indices[0] if idx in id_map]

    # Fetch product details in a **single** query
    if not product_ids:
        return []

    conn = get_db_connection()
    cur = conn.cursor()
    
    sql = f"SELECT product_id, product_name, product_price, product_category, product_image FROM products WHERE product_id IN %s"
    cur.execute(sql, (tuple(product_ids),))  # Use tuple to prevent SQL errors

    results = [
        {"id": row[0], "name": row[1], "price": row[2], "category": row[3], "image": row[4]}
        for row in cur.fetchall()
    ]
    
    cur.close()
    conn.close()
    
    return results

# Command-line execution
if __name__ == "__main__":
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python search_products.py <query>")
        print("       python search_products.py --create-index")
        sys.exit(1)
    
    if sys.argv[1] == "--create-index":
        create_index()
    else:
        query = sys.argv[1]
        results = search_products(query)
        for product in results:
            print(f"{product['name']} - ${product['price']}")
