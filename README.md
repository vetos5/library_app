# Library Management System

## Overview

This is a Flask-based web application designed to manage a library of books and authors. It provides functionality for adding, updating, deleting, and filtering books and authors, as well as exporting book data to a CSV file. The application uses a PostgreSQL database to store data.

## Features

- Add, update, and delete books
- Add and delete authors(if an author is deleted, all their books are also deleted)
- Filter books by title or author name
- Export book data to a CSV file

## Prerequisites

Before running the application, ensure you have the following installed on your system:

- Python 3.11.4
- Flask
- Flask-SQLAlchemy
- Flask-CORS
- PostgreSQL

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/vetos5/library_app
    cd library-management-system
    ```

2. Create a virtual environment and activate it:

    - **On Unix-based systems (Linux and macOS):**

        ```bash
        python3 -m venv venv
        source venv/bin/activate
        ```

    - **On Windows:**

        ```bash
        python -m venv venv
        venv\Scripts\activate
        ```

    After activating the virtual environment, your shell prompt should change to indicate that the virtual environment is active. You can deactivate it by running `deactivate`.


3. Install the required Python packages:

    ```bash
    pip install -r requirements.txt
    ```

4. Configure the PostgreSQL database:

    - Install PostgreSQL if you haven't already.
    - Create a database named `library`.
    - Update the `SQLALCHEMY_DATABASE_URI` in `app.py` with your PostgreSQL credentials.

    Example:

    ```python
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://username:password@localhost/library'
    ```

5. Restore the database dump:

    - There is dump file provided, you can restore it using the following command:

        ```bash
        psql -U username -d library -f dump-library-202407131432.sql
        ```

    This will populate your `library` database with the data from the dump file.

6. (Optional) Initialize the database (if not using a dump file):

    ```bash
    flask db init
    flask db migrate -m "Initial migration."
    flask db upgrade
    ```

## Usage

1. Run the Flask application:

    ```bash
    flask run
    ```

    By default, the application will run on `http://0.0.0.0:5003`.

2. Open a web browser and navigate to `http://localhost:5003` to access the application.

## Application Structure

The application consists of the following routes:

- `/` or `/page/<int:page>`: Homepage of the website, displays a paginated list of books.
- `/add_book`: Allows adding a new book.
- `/add_author`: Allows adding a new author.
- `/export_books`: Exports the list of books to a CSV file.
- `/filter_books`: Allows filtering books by title or author name.
- `/update_book/<int:book_id>`: Allows updating an existing book.
- `/delete_book/<int:book_id>`: Allows deleting a book.
- `/delete_author`: Allows deleting an author.

## Templates

The HTML templates used for rendering the pages are located in the `templates` directory. The main templates include:

- `index.html`: Main page displaying the list of books.
- `add_book.html`: Page for adding a new book.
- `add_author.html`: Page for adding a new author.
- `export_books.html`: Page for exporting books to CSV.
- `filter_books.html`: Page for filtering books.
- `update_books.html`: Page for updating an existing book.
- `delete_book.html`: Confirmation page for deleting a book.
- `delete_author.html`: Page for deleting an author.

## Contributing

If you would like to contribute to the project, please fork the repository and submit a pull request with your changes.

