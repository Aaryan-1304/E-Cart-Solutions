import faiss
import torch
from transformers import AutoTokenizer, AutoModel
import psycopg2
import numpy as np 

model_name = "sentence-transformers/all-MiniLM-L6-v2"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModel.from_pretrained(mode_name)


def get_embedding(text):
    inputs = tokenizer(text, retrun_tensors = "pt", padding = True, truncation = True)
    with torch.no_grad():
        outputs = model(**inputs)
    return outputs.last_hidden_state.mean(dim=1).numpy()

conn = psycopg2.connect("dbname = ApplicationInformation user = postgres password = butala@130403 host = localhost")
cur = conn.cursor()


cur.execute("SELECT product_id, product_name, product_description FROM products")
products = cur.fetchall()

index = faiss.IndexFlatL2(384)
id_map = {}

for product in products:
    product_id, product_name, product_description = product
    text = f"{product_name} {product_description}"
    vector = get_embedding(text)
    
    index.add(vector)
    id_map[len(id_map)] = product_id
    
faiss.write_index(index, "product_index.faiss")    
