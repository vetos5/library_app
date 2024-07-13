from flask import Flask, request, render_template, redirect, url_for, send_file
from flask_sqlalchemy import SQLAlchemy
import csv

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:silpo1@localhost/library'
db = SQLAlchemy(app)


class Authors(db.Model):
    __tablename__ = 'authors'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    books = db.relationship('Books', backref='author', cascade="all, delete-orphan")


class Books(db.Model):
    __tablename__ = 'books'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    author_id = db.Column(db.Integer, db.ForeignKey('authors.id'), nullable=False)


@app.route('/')
def index():
    books = Books.query.all()
    authors = Authors.query.all()
    return render_template('index.html', books=books, authors=authors)


@app.route('/add_book', methods=['GET', 'POST'])
def add_book():
    if request.method == 'POST':
        title = request.form['title']
        author_id = request.form['author_id']
        if title and author_id:
            try:
                new_book = Books(title=title, author_id=author_id)
                db.session.add(new_book)
                db.session.commit()
                return redirect(url_for('index'))
            except Exception as e:
                return "Error adding book: " + str(e)
        else:
            return "Title and author ID are required"
    authors = Authors.query.all()
    return render_template('add_book.html', authors=authors)


@app.route("/add_author", methods=["GET", "POST"])
def add_author():
    if request.method == "POST":
        name = request.form["name"]
        if name:
            try:
                author = Authors(name=name)
                db.session.add(author)
                db.session.commit()
                return redirect(url_for("index"))
            except Exception as e:
                return "Error adding author: " + str(e)
        else:
            return "Author name is required"
    return render_template("add_author.html")


@app.route("/export_books", methods=["GET", "POST"])
def export_books():
    if request.method == "POST":
        books = Books.query.all()
        csv_data = []
        for book in books:
            csv_data.append([book.title, book.author.name])
        csv_file = "books_export.csv"
        with open(csv_file, "w", newline="") as f:
            writer = csv.writer(f)
            writer.writerow(["Title", "Author"])  # header row
            writer.writerows(csv_data)
        return send_file(csv_file, as_attachment=True)
    return render_template("export_books.html")


@app.route("/filter_books", methods=["GET", "POST"])
def filter_books():
    if request.method == "POST":
        if request.form.get("delete_filter"):
            return redirect(url_for("filter_books"))
        else:
            search_query = request.form["search"]
            if search_query:
                try:
                    books = Books.query.join(Authors).filter(
                        (Books.title.ilike("%" + search_query + "%")) |
                        (Authors.name.ilike("%" + search_query + "%"))
                    ).all()
                    return render_template("filter_books.html", books=books, search_query=search_query)
                except Exception as e:
                    return "Error filtering books: " + str(e)
            else:
                return "Search query is required"
    return render_template("filter_books.html")


@app.route('/update_book/<int:book_id>', methods=['GET', 'POST'])
def update_book(book_id):
    book = Books.query.get_or_404(book_id)
    if request.method == 'POST':
        title = request.form['title']
        author_id = request.form['author_id']
        if title and author_id:
            try:
                book.title = title
                book.author_id = author_id
                db.session.commit()
                return redirect(url_for('index'))
            except Exception as e:
                return "Error updating book: " + str(e)
        else:
            return "Title and author ID are required"
    authors = Authors.query.all()
    return render_template('update_book.html', book=book, authors=authors)


@app.route("/delete_book/<int:book_id>", methods=["GET", "POST"])
def delete_book(book_id):
    book = Books.query.get_or_404(book_id)
    if request.method == "POST":
        db.session.delete(book)
        db.session.commit()
        return redirect(url_for("index"))
    return render_template("delete_book.html", book=book)

@app.route('/delete_author', methods=['GET', 'POST'])
def delete_author():
    authors = Authors.query.all()

    if request.method == 'POST':
        author_id = request.form['author_id']
        author = Authors.query.get(author_id)

        if author:
            try:
                db.session.delete(author)
                db.session.commit()
                return redirect(url_for('index'))
            except Exception as e:
                db.session.rollback()
                print(f"Error deleting author: {e}")
                return "Error deleting author"
        else:
            return "Author not found"

    return render_template('delete_author.html', authors=authors)
if __name__ == '__main__':
    app.run(debug=True, port=5003, host='127.0.0.1')
