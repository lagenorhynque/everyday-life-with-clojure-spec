--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7 (Debian 11.7-2.pgdg90+1)
-- Dumped by pg_dump version 11.7 (Debian 11.7-2.pgdg90+1)

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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: artist; Type: TABLE; Schema: public; Owner: aqoursql_dev
--

CREATE TABLE public.artist (
    id bigint NOT NULL,
    type smallint NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.artist OWNER TO aqoursql_dev;

--
-- Name: COLUMN artist.type; Type: COMMENT; Schema: public; Owner: aqoursql_dev
--

COMMENT ON COLUMN public.artist.type IS '1: group, 2: solo';


--
-- Name: artist_id_seq; Type: SEQUENCE; Schema: public; Owner: aqoursql_dev
--

CREATE SEQUENCE public.artist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artist_id_seq OWNER TO aqoursql_dev;

--
-- Name: artist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aqoursql_dev
--

ALTER SEQUENCE public.artist_id_seq OWNED BY public.artist.id;


--
-- Name: artist_member; Type: TABLE; Schema: public; Owner: aqoursql_dev
--

CREATE TABLE public.artist_member (
    artist_id bigint NOT NULL,
    member_id bigint NOT NULL
);


ALTER TABLE public.artist_member OWNER TO aqoursql_dev;

--
-- Name: member; Type: TABLE; Schema: public; Owner: aqoursql_dev
--

CREATE TABLE public.member (
    id bigint NOT NULL,
    name character varying(30) NOT NULL,
    organization_id bigint NOT NULL
);


ALTER TABLE public.member OWNER TO aqoursql_dev;

--
-- Name: member_id_seq; Type: SEQUENCE; Schema: public; Owner: aqoursql_dev
--

CREATE SEQUENCE public.member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.member_id_seq OWNER TO aqoursql_dev;

--
-- Name: member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aqoursql_dev
--

ALTER SEQUENCE public.member_id_seq OWNED BY public.member.id;


--
-- Name: organization; Type: TABLE; Schema: public; Owner: aqoursql_dev
--

CREATE TABLE public.organization (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.organization OWNER TO aqoursql_dev;

--
-- Name: organization_id_seq; Type: SEQUENCE; Schema: public; Owner: aqoursql_dev
--

CREATE SEQUENCE public.organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_id_seq OWNER TO aqoursql_dev;

--
-- Name: organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aqoursql_dev
--

ALTER SEQUENCE public.organization_id_seq OWNED BY public.organization.id;


--
-- Name: song; Type: TABLE; Schema: public; Owner: aqoursql_dev
--

CREATE TABLE public.song (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    artist_id bigint NOT NULL,
    release_date date NOT NULL
);


ALTER TABLE public.song OWNER TO aqoursql_dev;

--
-- Name: song_id_seq; Type: SEQUENCE; Schema: public; Owner: aqoursql_dev
--

CREATE SEQUENCE public.song_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.song_id_seq OWNER TO aqoursql_dev;

--
-- Name: song_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aqoursql_dev
--

ALTER SEQUENCE public.song_id_seq OWNED BY public.song.id;


--
-- Name: artist id; Type: DEFAULT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.artist ALTER COLUMN id SET DEFAULT nextval('public.artist_id_seq'::regclass);


--
-- Name: member id; Type: DEFAULT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.member ALTER COLUMN id SET DEFAULT nextval('public.member_id_seq'::regclass);


--
-- Name: organization id; Type: DEFAULT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.organization ALTER COLUMN id SET DEFAULT nextval('public.organization_id_seq'::regclass);


--
-- Name: song id; Type: DEFAULT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.song ALTER COLUMN id SET DEFAULT nextval('public.song_id_seq'::regclass);


--
-- Name: artist idx_16387_primary; Type: CONSTRAINT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.artist
    ADD CONSTRAINT idx_16387_primary PRIMARY KEY (id);


--
-- Name: artist_member idx_16391_primary; Type: CONSTRAINT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.artist_member
    ADD CONSTRAINT idx_16391_primary PRIMARY KEY (artist_id, member_id);


--
-- Name: member idx_16396_primary; Type: CONSTRAINT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT idx_16396_primary PRIMARY KEY (id);


--
-- Name: organization idx_16402_primary; Type: CONSTRAINT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT idx_16402_primary PRIMARY KEY (id);


--
-- Name: song idx_16413_primary; Type: CONSTRAINT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.song
    ADD CONSTRAINT idx_16413_primary PRIMARY KEY (id);


--
-- Name: idx_16391_member_id; Type: INDEX; Schema: public; Owner: aqoursql_dev
--

CREATE INDEX idx_16391_member_id ON public.artist_member USING btree (member_id);


--
-- Name: idx_16396_organization_id; Type: INDEX; Schema: public; Owner: aqoursql_dev
--

CREATE INDEX idx_16396_organization_id ON public.member USING btree (organization_id);


--
-- Name: idx_16413_artist_id; Type: INDEX; Schema: public; Owner: aqoursql_dev
--

CREATE INDEX idx_16413_artist_id ON public.song USING btree (artist_id);


--
-- Name: artist_member artist_member_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.artist_member
    ADD CONSTRAINT artist_member_ibfk_1 FOREIGN KEY (artist_id) REFERENCES public.artist(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: artist_member artist_member_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.artist_member
    ADD CONSTRAINT artist_member_ibfk_2 FOREIGN KEY (member_id) REFERENCES public.member(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: member member_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_ibfk_1 FOREIGN KEY (organization_id) REFERENCES public.organization(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: song song_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: aqoursql_dev
--

ALTER TABLE ONLY public.song
    ADD CONSTRAINT song_ibfk_1 FOREIGN KEY (artist_id) REFERENCES public.artist(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

