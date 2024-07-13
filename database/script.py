import csv
import psycopg2
from psycopg2 import Error

connection_parameters = {
    "host": "localhost",
    "database": "library",
    "user": "postgres",
    "password": "silpo1"
}

csv_file = 'books.csv'

csv_file = 'books.csv'


def connect_to_db():
    try:
        conn = psycopg2.connect(**connection_parameters)
        return conn
    except Error as e:
        print(f"Error connecting to PostgreSQL: {e}")
        return None


def add_books_from_csv(conn, csv_file):
    try:
        cursor = conn.cursor()

        with open(csv_file, 'r', encoding='utf-8') as file:
            reader = csv.reader(file)
            next(reader)

            for row in reader:
                title = row[0]
                author_name = row[1]

                # Check if the book with the same title already exists
                cursor.execute("SELECT id FROM books WHERE title = %s", (title,))
                existing_book = cursor.fetchone()

                if existing_book:
                    print(f"Book '{title}' already exists in the database. Skipping insertion.")
                    continue

                cursor.execute("INSERT INTO authors (name) VALUES (%s) ON CONFLICT (name) DO NOTHING", (author_name,))

                cursor.execute("SELECT id FROM authors WHERE name = %s", (author_name,))
                author_id = cursor.fetchone()[0]

                cursor.execute("INSERT INTO books (title, author_id) VALUES (%s, %s)", (title, author_id))

        conn.commit()
        print("Successfully added books from csv file!")

    except Error as e:
        conn.rollback()
        print(f"Error inserting data into PostgreSQL: {e}")

    finally:
        cursor.close()


def main():
    conn = connect_to_db()
    if conn is not None:
        add_books_from_csv(conn, csv_file)
        conn.close()
    else:
        print("Connection error.")


if __name__ == "__main__":
    main()