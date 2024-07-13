--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2024-07-13 14:32:38

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4800 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16494)
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16493)
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.authors_id_seq OWNER TO postgres;

--
-- TOC entry 4801 (class 0 OID 0)
-- Dependencies: 215
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;


--
-- TOC entry 218 (class 1259 OID 16501)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    author_id integer NOT NULL
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16500)
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_id_seq OWNER TO postgres;

--
-- TOC entry 4802 (class 0 OID 0)
-- Dependencies: 217
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- TOC entry 4639 (class 2604 OID 16497)
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);


--
-- TOC entry 4640 (class 2604 OID 16504)
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- TOC entry 4792 (class 0 OID 16494)
-- Dependencies: 216
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authors (id, name) FROM stdin;
4	Harper Lee
7	Aldous Huxley
8	J.D. Salinger
10	William Golding
11	Jane Austen
12	J.R.R. Tolkien
13	J.K. Rowling
14	C.S. Lewis
15	Herman Melville
16	John Steinbeck
17	Cormac McCarthy
18	Douglas Adams
19	Charlotte Bronte
20	Emily Bronte
22	Leo Tolstoy
23	Fyodor Dostoevsky
26	Gabriel Garcia Marquez
27	Alexandre Dumas
28	Oscar Wilde
29	Victor Hugo
30	Lewis Carroll
31	Charles Dickens
32	Paulo Coelho
33	Miguel de Cervantes
34	Margaret Mitchell
35	Homer
36	Mark Twain
37	Nathaniel Hawthorne
38	Mary Shelley
39	Bram Stoker
41	Joseph Conrad
42	Ernest Hemingway
43	Sylvia Plath
44	Margaret Atwood
45	Kurt Vonnegut
46	Joseph Heller
47	Albert Camus
48	Umberto Eco
49	Stephen King
98	George Orwell
99	F. Scott Fitzgerald
\.


--
-- TOC entry 4794 (class 0 OID 16501)
-- Dependencies: 218
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (id, title, author_id) FROM stdin;
14	Brave New World	7
15	The Catcher in the Rye	8
17	Lord of the Flies	10
18	Pride and Prejudice	11
19	The Hobbit	12
20	Harry Potter and the Sorcerer's Stone	13
21	The Chronicles of Narnia	14
22	Moby-Dick	15
23	The Grapes of Wrath	16
24	The Road	17
25	The Hitchhiker's Guide to the Galaxy	18
26	Jane Eyre	19
27	Wuthering Heights	20
28	The Lord of the Rings	12
29	War and Peace	22
30	Crime and Punishment	23
31	The Brothers Karamazov	23
32	Anna Karenina	22
33	One Hundred Years of Solitude	26
34	The Count of Monte Cristo	27
35	The Picture of Dorian Gray	28
36	Les Misérables	29
37	Alice's Adventures in Wonderland	30
38	A Tale of Two Cities	31
39	The Alchemist	32
40	Don Quixote	33
41	Gone with the Wind	34
42	The Odyssey	35
43	The Adventures of Huckleberry Finn	36
44	The Scarlet Letter	37
45	Frankenstein	38
46	Dracula	39
47	The Iliad	35
48	Heart of Darkness	41
49	The Sun Also Rises	42
50	The Bell Jar	43
51	The Handmaid's Tale	44
52	Slaughterhouse-Five	45
53	Catch-22	46
55	The Name of the Rose	48
56	The Shining	49
57	The Stand	49
11	To Kill a Mockingbird	4
105	1984	98
106	The Great Gatsby	99
107	Animal Farm	98
54	The Stranger	47
\.


--
-- TOC entry 4803 (class 0 OID 0)
-- Dependencies: 215
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_id_seq', 100, true);


--
-- TOC entry 4804 (class 0 OID 0)
-- Dependencies: 217
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 107, true);


--
-- TOC entry 4642 (class 2606 OID 16499)
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- TOC entry 4646 (class 2606 OID 16506)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- TOC entry 4644 (class 2606 OID 16943)
-- Name: authors unique_author_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT unique_author_name UNIQUE (name);


--
-- TOC entry 4647 (class 2606 OID 16507)
-- Name: books fk_author; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES public.authors(id) ON DELETE CASCADE;


-- Completed on 2024-07-13 14:32:38

--
-- PostgreSQL database dump complete
--

