import os
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Application Factory Pattern
def create_app():
    app = Flask(__name__)

    # Correct PostgreSQL Connection String
    # Format: postgresql://username:password@host:port/database
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:butala%40130403@localhost:5432/ApplicationInformation'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    # Initialize SQLAlchemy
    db = SQLAlchemy(app)

    # Product Model
    class Product(db.Model):
        __tablename__ = 'products'
        product_id = db.Column(db.Integer, primary_key=True)
        product_name = db.Column(db.String(255), nullable=False)
        product_price = db.Column(db.String(255))
        product_category = db.Column(db.String(100))
        product_image = db.Column(db.String(255))
        quantity = db.Column(db.Integer)
        product_description = db.Column(db.Text)

        def to_dict(self):
            return {
                "product_id": self.product_id,
                "product_name": self.product_name,
                "product_price": self.product_price,
                "product_category": self.product_category,
                "product_image": self.product_image,
                "quantity": self.quantity,
                "product_description": self.product_description
            }

    # Semantic Search Endpoint
    @app.route('/semanticSearch', methods=['GET'])
    def semantic_search():
        query = request.args.get('query', '').strip()
        if not query:
            return jsonify({"message": "Please provide a search query."}), 400

        # For PostgreSQL, use more efficient text search
        results = Product.query.filter(
            (db.func.lower(Product.product_name).contains(query.lower())) |
            (db.func.lower(Product.product_category).contains(query.lower())) |
            (db.func.lower(Product.product_description).contains(query.lower()))
        ).all()

        if not results:
            return jsonify([])  # Return empty list instead of 404

        # Return only product IDs for Java integration
        product_ids = [str(product.product_id) for product in results]
        return jsonify(product_ids)

    # Initialization route
    @app.route('/')
    def home():
        return "Semantic Search Service is running!"

    return app, db

# Main entry point
if __name__ == '__main__':
    # Create app and db
    app, db = create_app()

    # Ensure database is created
    with app.app_context():
        db.create_all()

    # Run the app
    app.run(host='0.0.0.0', port=5000, debug=True)