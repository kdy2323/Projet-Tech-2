--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-05-22 15:08:13

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 239 (class 1255 OID 16559)
-- Name: ajout_admin(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ajout_admin(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '
	-- déclarations
	DECLARE p_login ALIAS FOR $1; -- premier paramètre reçu
	DECLARE p_password ALIAS FOR $2;
	DECLARE id INTEGER;
	DECLARE retour INTEGER;
BEGIN	
	-- select de l''admin portant ce login et password
	SELECT INTO id id_admin FROM admin WHERE login = p_login and password = p_password;
	IF NOT FOUND
	THEN
	  INSERT INTO admin (login, password) VALUES (p_login,p_password);
	  SELECT INTO id id_admin FROM admin WHERE login = p_login and password = p_password;
	  IF NOT FOUND
	  THEN
	    retour = -1; -- échec insertion
	  ELSE
	    retour = 1; -- réussie réussie
	  END IF;
	ELSE
	  retour = 0;
	END IF;
return retour;	
END;	
';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 237 (class 1259 OID 16552)
-- Name: admin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin (
    login text NOT NULL,
    password text NOT NULL,
    id_admin integer NOT NULL
);


--
-- TOC entry 238 (class 1259 OID 16579)
-- Name: admin_id_admin_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_id_admin_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 238
-- Name: admin_id_admin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_id_admin_seq OWNED BY public.admin.id_admin;


--
-- TOC entry 224 (class 1259 OID 16446)
-- Name: boite; Type: TABLE; Schema: public; Owner: -
--

CREATE OR REPLACE FUNCTION verifier_connexion(login VARCHAR, password VARCHAR)
    RETURNS BOOLEAN AS $$
DECLARE
    is_valid BOOLEAN;
BEGIN
    -- Exemple de vérification d'un utilisateur dans une table `utilisateurs`
    SELECT INTO is_valid
        CASE
            WHEN public.admin.password = password THEN TRUE
            ELSE FALSE
            END
    FROM client
    WHERE public.admin.login = login;

    RETURN is_valid;
END;
$$ LANGUAGE plpgsql;

CREATE TABLE public.boite (
    id_boite integer NOT NULL,
    adresse text NOT NULL,
    numero integer
);


--
-- TOC entry 223 (class 1259 OID 16445)
-- Name: boite_id_boite_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.boite_id_boite_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 223
-- Name: boite_id_boite_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.boite_id_boite_seq OWNED BY public.boite.id_boite;


--
-- TOC entry 216 (class 1259 OID 16400)
-- Name: categorie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categorie (
    id_categorie integer NOT NULL,
    nom_categorie text NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: categorie_id_categorie_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categorie_id_categorie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 215
-- Name: categorie_id_categorie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categorie_id_categorie_seq OWNED BY public.categorie.id_categorie;


--
-- TOC entry 228 (class 1259 OID 16469)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id_client integer NOT NULL,
    nom_client text NOT NULL,
    email text NOT NULL,
    adresse text NOT NULL,
    numero text NOT NULL,
    id_ville integer NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 16468)
-- Name: client_id_client_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.client_id_client_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 227
-- Name: client_id_client_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.client_id_client_seq OWNED BY public.client.id_client;


--
-- TOC entry 234 (class 1259 OID 16519)
-- Name: facture; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.facture (
    id_facture integer NOT NULL,
    date_facture date NOT NULL,
    paye boolean NOT NULL,
    id_voiture integer NOT NULL,
    id_client integer NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 16518)
-- Name: facture_id_facture_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.facture_id_facture_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 233
-- Name: facture_id_facture_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.facture_id_facture_seq OWNED BY public.facture.id_facture;


--
-- TOC entry 236 (class 1259 OID 16536)
-- Name: livraison; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.livraison (
    id_livraison integer NOT NULL,
    id_magasin integer,
    id_facture integer
);


--
-- TOC entry 235 (class 1259 OID 16535)
-- Name: livraison_id_livraison_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.livraison_id_livraison_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 235
-- Name: livraison_id_livraison_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.livraison_id_livraison_seq OWNED BY public.livraison.id_livraison;


--
-- TOC entry 226 (class 1259 OID 16455)
-- Name: magasin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.magasin (
    id_magasin integer NOT NULL,
    nom_magasin text NOT NULL,
    adresse text NOT NULL,
    numero text NOT NULL,
    localite text NOT NULL,
    code_postal text NOT NULL,
    id_ville integer NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16454)
-- Name: magasin_id_magasin_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.magasin_id_magasin_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 225
-- Name: magasin_id_magasin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.magasin_id_magasin_seq OWNED BY public.magasin.id_magasin;


--
-- TOC entry 232 (class 1259 OID 16502)
-- Name: panier; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.panier (
    id_panier integer NOT NULL,
    quantite integer NOT NULL,
    id_client integer NOT NULL,
    id_voiture integer NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 16501)
-- Name: panier_id_panier_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.panier_id_panier_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 231
-- Name: panier_id_panier_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.panier_id_panier_seq OWNED BY public.panier.id_panier;


--
-- TOC entry 220 (class 1259 OID 16423)
-- Name: pays; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pays (
    id_pays integer NOT NULL,
    nom_pays text NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 16422)
-- Name: pays_id_pays_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pays_id_pays_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 219
-- Name: pays_id_pays_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pays_id_pays_seq OWNED BY public.pays.id_pays;


--
-- TOC entry 230 (class 1259 OID 16483)
-- Name: voiture; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.voiture (
    id_voiture integer NOT NULL,
    nom_voiture text NOT NULL,
    prix double precision,
    stock integer,
    relais boolean,
    id_magasin integer NOT NULL,
    id_sous_categorie integer NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 16482)
-- Name: voiture_id_voiture_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.voiture_id_voiture_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 229
-- Name: voiture_id_voiture_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.voiture_id_voiture_seq OWNED BY public.voiture.id_voiture;

--
-- TOC entry 213 (class 1259 OID 73759)
-- Name: vue_voitures; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vue_voitures AS
SELECT sous_categorie.id_sous_categorie,
       sous_categorie.nom_sous_categorie,
       voiture.id_voiture,
       voiture.nom_voiture,
       voiture.stock,
       voiture.prix,
       voiture.relais
FROM public.sous_categorie,
     public.voiture
WHERE (sous_categorie.id_sous_categorie = voiture.id_sous_categorie);
--
-- TOC entry 218 (class 1259 OID 16409)
-- Name: sous_categorie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sous_categorie (
    id_sous_categorie integer NOT NULL,
    nom_sous_categorie text NOT NULL,
    id_categorie integer NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16408)
-- Name: sous_categorie_id_sous_categorie_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sous_categorie_id_sous_categorie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 217
-- Name: sous_categorie_id_sous_categorie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sous_categorie_id_sous_categorie_seq OWNED BY public.sous_categorie.id_sous_categorie;


--
-- TOC entry 222 (class 1259 OID 16432)
-- Name: ville; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ville (
    id_ville integer NOT NULL,
    nom_ville text NOT NULL,
    code_postal text NOT NULL,
    id_pays integer NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 16431)
-- Name: ville_id_ville_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ville_id_ville_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 221
-- Name: ville_id_ville_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ville_id_ville_seq OWNED BY public.ville.id_ville;


--
-- TOC entry 4755 (class 2604 OID 16580)
-- Name: admin id_admin; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin ALTER COLUMN id_admin SET DEFAULT nextval('public.admin_id_admin_seq'::regclass);


--
-- TOC entry 4748 (class 2604 OID 16449)
-- Name: boite id_boite; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.boite ALTER COLUMN id_boite SET DEFAULT nextval('public.boite_id_boite_seq'::regclass);


--
-- TOC entry 4744 (class 2604 OID 16403)
-- Name: categorie id_categorie; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categorie ALTER COLUMN id_categorie SET DEFAULT nextval('public.categorie_id_categorie_seq'::regclass);


--
-- TOC entry 4750 (class 2604 OID 16472)
-- Name: client id_client; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client ALTER COLUMN id_client SET DEFAULT nextval('public.client_id_client_seq'::regclass);


--
-- TOC entry 4753 (class 2604 OID 16522)
-- Name: facture id_facture; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facture ALTER COLUMN id_facture SET DEFAULT nextval('public.facture_id_facture_seq'::regclass);


--
-- TOC entry 4754 (class 2604 OID 16539)
-- Name: livraison id_livraison; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.livraison ALTER COLUMN id_livraison SET DEFAULT nextval('public.livraison_id_livraison_seq'::regclass);


--
-- TOC entry 4749 (class 2604 OID 16458)
-- Name: magasin id_magasin; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.magasin ALTER COLUMN id_magasin SET DEFAULT nextval('public.magasin_id_magasin_seq'::regclass);


--
-- TOC entry 4752 (class 2604 OID 16505)
-- Name: panier id_panier; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier ALTER COLUMN id_panier SET DEFAULT nextval('public.panier_id_panier_seq'::regclass);


--
-- TOC entry 4746 (class 2604 OID 16426)
-- Name: pays id_pays; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pays ALTER COLUMN id_pays SET DEFAULT nextval('public.pays_id_pays_seq'::regclass);


--
-- TOC entry 4751 (class 2604 OID 16486)
-- Name: voiture id_voiture; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.voiture ALTER COLUMN id_voiture SET DEFAULT nextval('public.voiture_id_voiture_seq'::regclass);


--
-- TOC entry 4745 (class 2604 OID 16412)
-- Name: sous_categorie id_sous_categorie; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sous_categorie ALTER COLUMN id_sous_categorie SET DEFAULT nextval('public.sous_categorie_id_sous_categorie_seq'::regclass);


--
-- TOC entry 4747 (class 2604 OID 16435)
-- Name: ville id_ville; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ville ALTER COLUMN id_ville SET DEFAULT nextval('public.ville_id_ville_seq'::regclass);


--
-- TOC entry 4957 (class 0 OID 16552)
-- Dependencies: 237
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.admin (login, password, id_admin) VALUES ('christian', 'mddd', 1);
INSERT INTO public.admin (login, password, id_admin) VALUES ('duponr', 'acer', 2);
INSERT INTO public.voiture (id_voiture, nom_voiture, prix, stock, relais, id_magasin, id_sous_categorie) VALUES (1, 'Audi RS3', '87.000', 10,'TRUE' , 1,1);

--
-- TOC entry 4944 (class 0 OID 16446)
-- Dependencies: 224
-- Data for Name: boite; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4936 (class 0 OID 16400)
-- Dependencies: 216
-- Data for Name: categorie; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4948 (class 0 OID 16469)
-- Dependencies: 228
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4954 (class 0 OID 16519)
-- Dependencies: 234
-- Data for Name: facture; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4956 (class 0 OID 16536)
-- Dependencies: 236
-- Data for Name: livraison; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4946 (class 0 OID 16455)
-- Dependencies: 226
-- Data for Name: magasin; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4952 (class 0 OID 16502)
-- Dependencies: 232
-- Data for Name: panier; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4940 (class 0 OID 16423)
-- Dependencies: 220
-- Data for Name: pays; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4950 (class 0 OID 16483)
-- Dependencies: 230
-- Data for Name: voiture; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4938 (class 0 OID 16409)
-- Dependencies: 218
-- Data for Name: sous_categorie; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4942 (class 0 OID 16432)
-- Dependencies: 222
-- Data for Name: ville; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 238
-- Name: admin_id_admin_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_id_admin_seq', 1, true);


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 223
-- Name: boite_id_boite_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.boite_id_boite_seq', 1, false);


--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 215
-- Name: categorie_id_categorie_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categorie_id_categorie_seq', 1, false);


--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 227
-- Name: client_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.client_id_client_seq', 1, false);


--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 233
-- Name: facture_id_facture_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.facture_id_facture_seq', 1, false);


--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 235
-- Name: livraison_id_livraison_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.livraison_id_livraison_seq', 1, false);


--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 225
-- Name: magasin_id_magasin_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.magasin_id_magasin_seq', 1, false);


--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 231
-- Name: panier_id_panier_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.panier_id_panier_seq', 1, false);


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 219
-- Name: pays_id_pays_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pays_id_pays_seq', 1, false);


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 229
-- Name: voiture_id_voiture_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.voiture_id_voiture_seq', 1, false);


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 217
-- Name: sous_categorie_id_sous_categorie_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sous_categorie_id_sous_categorie_seq', 1, false);


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 221
-- Name: ville_id_ville_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ville_id_ville_seq', 1, false);


--
-- TOC entry 4779 (class 2606 OID 16587)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);


--
-- TOC entry 4765 (class 2606 OID 16453)
-- Name: boite boite_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.boite
    ADD CONSTRAINT boite_pkey PRIMARY KEY (id_boite);


--
-- TOC entry 4757 (class 2606 OID 16407)
-- Name: categorie categorie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (id_categorie);


--
-- TOC entry 4769 (class 2606 OID 16476)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);


--
-- TOC entry 4775 (class 2606 OID 16524)
-- Name: facture facture_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_pkey PRIMARY KEY (id_facture);


--
-- TOC entry 4777 (class 2606 OID 16541)
-- Name: livraison livraison_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.livraison
    ADD CONSTRAINT livraison_pkey PRIMARY KEY (id_livraison);


--
-- TOC entry 4767 (class 2606 OID 16462)
-- Name: magasin magasin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.magasin
    ADD CONSTRAINT magasin_pkey PRIMARY KEY (id_magasin);


--
-- TOC entry 4773 (class 2606 OID 16507)
-- Name: panier panier_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_pkey PRIMARY KEY (id_panier);


--
-- TOC entry 4761 (class 2606 OID 16430)
-- Name: pays pays_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pays
    ADD CONSTRAINT pays_pkey PRIMARY KEY (id_pays);


--
-- TOC entry 4771 (class 2606 OID 16490)
-- Name: voiture voiture_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.voiture
    ADD CONSTRAINT voiture_pkey PRIMARY KEY (id_voiture);


--
-- TOC entry 4759 (class 2606 OID 16416)
-- Name: sous_categorie sous_categorie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sous_categorie
    ADD CONSTRAINT sous_categorie_pkey PRIMARY KEY (id_sous_categorie);


--
-- TOC entry 4763 (class 2606 OID 16439)
-- Name: ville ville_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_pkey PRIMARY KEY (id_ville);


--
-- TOC entry 4783 (class 2606 OID 16477)
-- Name: client client_id_ville_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_id_ville_fkey FOREIGN KEY (id_ville) REFERENCES public.ville(id_ville);


--
-- TOC entry 4788 (class 2606 OID 16530)
-- Name: facture facture_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id_client);


--
-- TOC entry 4789 (class 2606 OID 16525)
-- Name: facture facture_id_voiture_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_id_voiture_fkey FOREIGN KEY (id_voiture) REFERENCES public.voiture(id_voiture);


--
-- TOC entry 4790 (class 2606 OID 16547)
-- Name: livraison livraison_id_facture_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.livraison
    ADD CONSTRAINT livraison_id_facture_fkey FOREIGN KEY (id_facture) REFERENCES public.facture(id_facture);


--
-- TOC entry 4791 (class 2606 OID 16542)
-- Name: livraison livraison_id_magasin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.livraison
    ADD CONSTRAINT livraison_id_magasin_fkey FOREIGN KEY (id_magasin) REFERENCES public.magasin(id_magasin);


--
-- TOC entry 4782 (class 2606 OID 16463)
-- Name: magasin magasin_id_ville_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.magasin
    ADD CONSTRAINT magasin_id_ville_fkey FOREIGN KEY (id_ville) REFERENCES public.ville(id_ville);


--
-- TOC entry 4786 (class 2606 OID 16508)
-- Name: panier panier_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id_client);


--
-- TOC entry 4787 (class 2606 OID 16513)
-- Name: panier panier_id_produit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_id_produit_fkey FOREIGN KEY (id_voiture) REFERENCES public.voiture(id_voiture);


--
-- TOC entry 4784 (class 2606 OID 16491)
-- Name: produit produit_id_magasin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.voiture
    ADD CONSTRAINT produit_id_magasin_fkey FOREIGN KEY (id_magasin) REFERENCES public.magasin(id_magasin);


--
-- TOC entry 4785 (class 2606 OID 16496)
-- Name: produit produit_id_sous_categorie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.voiture
    ADD CONSTRAINT produit_id_sous_categorie_fkey FOREIGN KEY (id_sous_categorie) REFERENCES public.sous_categorie(id_sous_categorie);


--
-- TOC entry 4780 (class 2606 OID 16417)
-- Name: sous_categorie sous_categorie_id_categorie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sous_categorie
    ADD CONSTRAINT sous_categorie_id_categorie_fkey FOREIGN KEY (id_categorie) REFERENCES public.categorie(id_categorie);


--
-- TOC entry 4781 (class 2606 OID 16440)
-- Name: ville ville_id_pays_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_id_pays_fkey FOREIGN KEY (id_pays) REFERENCES public.pays(id_pays);


-- Completed on 2024-05-22 15:08:13

--
-- PostgreSQL database dump complete
--

