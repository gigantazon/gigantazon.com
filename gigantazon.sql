--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO gigantic;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO gigantic;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO gigantic;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO gigantic;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO gigantic;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO gigantic;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO gigantic;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO gigantic;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO gigantic;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO gigantic;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO gigantic;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO gigantic;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    content_type_id integer,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO gigantic;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO gigantic;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO gigantic;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO gigantic;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO gigantic;

--
-- Name: ideas_comments; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE ideas_comments (
    id integer NOT NULL,
    idea_id integer NOT NULL,
    comment character varying(5000) NOT NULL,
    date timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    path integer[] NOT NULL,
    depth smallint NOT NULL,
    CONSTRAINT ideas_comments_depth_check CHECK ((depth >= 0))
);


ALTER TABLE public.ideas_comments OWNER TO gigantic;

--
-- Name: ideas_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE ideas_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ideas_comments_id_seq OWNER TO gigantic;

--
-- Name: ideas_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE ideas_comments_id_seq OWNED BY ideas_comments.id;


--
-- Name: ideas_drops; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE ideas_drops (
    id integer NOT NULL,
    data character varying(250) NOT NULL,
    drop_type character varying(15) NOT NULL,
    user_id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    parent_id_id integer,
    origin_id smallint NOT NULL,
    url character varying(1000) NOT NULL,
    CONSTRAINT ideas_drops_origin_id_check CHECK ((origin_id >= 0))
);


ALTER TABLE public.ideas_drops OWNER TO gigantic;

--
-- Name: ideas_drops_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE ideas_drops_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ideas_drops_id_seq OWNER TO gigantic;

--
-- Name: ideas_drops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE ideas_drops_id_seq OWNED BY ideas_drops.id;


--
-- Name: ideas_userprofile; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE ideas_userprofile (
    id integer NOT NULL,
    user_id integer NOT NULL,
    username character varying(25) NOT NULL,
    website character varying(200) NOT NULL
);


ALTER TABLE public.ideas_userprofile OWNER TO gigantic;

--
-- Name: ideas_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE ideas_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ideas_userprofile_id_seq OWNER TO gigantic;

--
-- Name: ideas_userprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE ideas_userprofile_id_seq OWNED BY ideas_userprofile.id;


--
-- Name: south_migrationhistory; Type: TABLE; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE TABLE south_migrationhistory (
    id integer NOT NULL,
    app_name character varying(255) NOT NULL,
    migration character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.south_migrationhistory OWNER TO gigantic;

--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: gigantic
--

CREATE SEQUENCE south_migrationhistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.south_migrationhistory_id_seq OWNER TO gigantic;

--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigantic
--

ALTER SEQUENCE south_migrationhistory_id_seq OWNED BY south_migrationhistory.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY ideas_comments ALTER COLUMN id SET DEFAULT nextval('ideas_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY ideas_drops ALTER COLUMN id SET DEFAULT nextval('ideas_drops_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY ideas_userprofile ALTER COLUMN id SET DEFAULT nextval('ideas_userprofile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY south_migrationhistory ALTER COLUMN id SET DEFAULT nextval('south_migrationhistory_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add migration history	7	add_migrationhistory
20	Can change migration history	7	change_migrationhistory
21	Can delete migration history	7	delete_migrationhistory
22	Can add user profile	8	add_userprofile
23	Can change user profile	8	change_userprofile
24	Can delete user profile	8	delete_userprofile
34	Can add comments	12	add_comments
35	Can change comments	12	change_comments
36	Can delete comments	12	delete_comments
37	Can add drops	13	add_drops
38	Can change drops	13	change_drops
39	Can delete drops	13	delete_drops
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('auth_permission_id_seq', 39, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$12000$kmrtYb0sTV9m$SY+DbGRoKB7+Se6tXkRcgNddQHAbQaYGNhXXv1SAW3U=	2014-09-29 13:18:26.615686-04	t	gigantazon@gmail.com			gigantazon@gmail.com	t	t	2014-09-26 14:07:56.640031-04
3	pbkdf2_sha256$12000$c8hQOPn7sVsR$gGfD2U8Omq5o7Vhc/tY9fu0RWIb4MUQ3rEZKjJMlHiI=	2014-10-02 11:06:56.128736-04	f	miavarone			matt@ciranttechnologies.com	f	t	2014-10-02 11:06:56.128808-04
4	pbkdf2_sha256$12000$K4EcSc841a54$c+1x8TH1tHNFqhTH/nLn/IE4RSI79AQo3phlLNIu6NU=	2014-10-02 11:52:24.793272-04	f	evilpig			gigantazon@evilpig.org	f	t	2014-10-02 11:52:24.793368-04
5	pbkdf2_sha256$12000$RYjvPkUUyNRW$2Z5RSu1Rs74hKIUjeavt92iohZz74H2ZDePa76OP8KU=	2014-12-08 08:22:22.455051-05	t	matt				t	t	2014-10-06 08:14:40.221219-04
2	pbkdf2_sha256$12000$In0DMpfyNwW4$oUi0GPEPkZ4X66B1LU7DYKr7kck3A4Q7EUUH0LMEmnk=	2014-12-21 08:23:07.845006-05	f	matt.iavarone@gmail.com			matt.iavarone@gmail.com	f	t	2014-09-26 14:13:46-04
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('auth_user_id_seq', 5, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY django_admin_log (id, action_time, user_id, content_type_id, object_id, object_repr, action_flag, change_message) FROM stdin;
1	2014-09-26 14:13:46.471971-04	1	4	2	matt.iavarone@gmail.com	1	
2	2014-09-26 14:14:35.78785-04	1	4	2	matt.iavarone@gmail.com	2	Changed email.
11	2014-11-28 10:01:28.249108-05	5	13	6	apps	1	
12	2014-11-28 10:02:09.274325-05	5	13	7	kits	1	
13	2014-11-28 10:02:21.417702-05	5	13	8	sauces	1	
14	2014-11-28 10:02:32.959845-05	5	13	9	resell	1	
15	2014-11-28 10:02:45.879414-05	5	13	10	charity/public service	1	
16	2014-11-28 10:09:55.876288-05	5	13	11	a children's book that answers the question, "what do you want to be when you grow up?"	1	
17	2014-11-28 11:13:37.184376-05	5	13	12	i think often about how many times kids have to answer this question - usually with something general and of direct influence to shows, books, and stereotypes. "fireman," "princess," "police officer,"	1	
18	2014-11-28 11:13:59.580658-05	5	13	13	cover: what do you want to be when you grow up?	1	
19	2014-11-28 11:14:26.261654-05	5	13	14	page one: what do you want to be when you grow, little one?	1	
20	2014-11-28 11:14:43.781044-05	5	13	15	page one: what do you want to be when you grow, little one?	1	
21	2014-11-28 11:15:33.731783-05	5	13	16	eat delicious food	1	
22	2014-11-28 18:38:53.335709-05	5	13	17	knock off apps (like instead of the "yo" app, the "bro" app)	1	
23	2014-11-28 18:39:27.391599-05	5	13	18	the quintessential hipster kit (a hipster starter kit): black-rimmed glasses, a mustache comb, an ironic book, and a flannel shirt...or something	1	
24	2014-11-28 18:39:45.453917-05	5	13	19	brewmaster starter kit: everything you need to start homebrewing	1	
25	2014-11-28 18:39:57.64049-05	5	13	20	bay area home/bar cocktail kits	1	
26	2014-11-28 18:41:14.433906-05	5	13	21	find recipes like these to make the elements of cocktails for home - then start shopping them at bars	1	
27	2014-11-28 18:41:42.806622-05	5	13	22	keller's killer kahlua - how to make it at home	1	
28	2014-11-28 18:42:02.44174-05	5	13	23	limoncello - how to make it at home	1	
29	2014-11-28 18:42:28.492589-05	5	13	24	spicy mayo	1	
30	2014-11-28 18:42:44.535477-05	5	13	25	teriyaki sauce	1	
31	2014-11-28 18:42:54.013719-05	5	13	26	thai chili sauce	1	
32	2014-11-28 18:43:07.780081-05	5	13	27	scrumptious asian flavors sauce	1	
33	2014-11-28 18:43:44.120773-05	5	13	28	sounds simple and easy!	1	
34	2014-11-28 18:45:09.541419-05	5	13	29	Empowering entrepreneurs in developing countries with a turn-key Shop franchise to offer affordable drinking water, phone charging and smart home appliances to low income earners. The market is the ma	1	
35	2014-11-28 18:45:51.334878-05	5	13	30	The solution explained in more detail!	1	
36	2014-11-28 18:46:15.356439-05	5	13	31	With the crowd to a proven concept! Contribute starting at as little as $5!	1	
37	2014-11-28 18:46:33.04135-05	5	13	32	Would appreciate feedback and impression from anyone!	1	
38	2014-11-28 18:46:48.92125-05	5	13	33	I would say electricity is the hardest one to get to the world, short of hand crank. There are a number of good handheld reusable water filters out there, and electronics can be fairly cheap these day	1	
39	2014-11-28 18:47:46.039695-05	5	13	34	engaging local chefs to participate in school menu planning	1	
40	2014-11-28 18:48:19.232306-05	5	13	35	starting around 9.30, what he says really resonated with me regarding the people passing food to our children.	1	
41	2014-11-28 18:48:42.261536-05	5	13	36	clearly not the first idea about it - but how do we build this into a "thing" that chefs do?	1	
42	2014-11-28 18:49:10.183882-05	5	13	37	if over 21 million students have been reached with a program like this, then why do we still have the obesity problem in america?	1	
43	2014-11-28 18:49:25.293336-05	5	13	38	local food companies should also actively participate in school lunches - especially those who are healthier by nature (i.e., not genetically modified foods or overly processed foods)	1	
44	2014-11-28 18:50:36.139735-05	5	13	39	maybe having the kids actively involved in the raising then preparation of the food	1	
45	2014-11-28 18:51:04.578982-05	5	13	40	the secret's in identifying "meals that are both healthy and appealing to kids"	1	
46	2014-11-28 18:51:31.29141-05	5	13	41	it helps to involve people who are wholly invested in the future of the children as well, who can coordinate the chef community	1	
47	2014-11-28 18:52:14.829757-05	5	13	42	How might we design the best online learning platform for sharing ideas and projects?	1	
48	2014-11-28 18:52:39.802765-05	5	13	43	Sparks should be able to show an image or video according to the content of their link.	1	
49	2014-12-08 08:22:51.670969-05	5	13	44	What's the big idea?	1	
50	2014-12-08 08:23:45.382677-05	5	13	45	Inspiration can strike at any time!	1	
51	2014-12-08 08:24:15.609181-05	5	13	46	The mind is constantly firing up new ideas	1	
52	2014-12-08 08:24:43.245418-05	5	13	47	Where can we go to increase the inspiration? 	1	
53	2014-12-08 08:25:10.639565-05	5	13	48	More people contribute to the conversation.	1	
54	2014-12-08 08:25:34.203402-05	5	13	49	New Ideas branch off into other diverse conversations	1	
55	2014-12-08 08:25:58.167452-05	5	13	50	A new fighter has entered the arena!	1	
56	2014-12-08 08:26:11.950931-05	5	13	51	What is going to be the next great idea?	1	
57	2014-12-08 08:26:29.670743-05	5	13	52	We need to take action immediately	1	
58	2014-12-08 08:26:43.917987-05	5	13	53	How did it all go down in the end?	1	
59	2014-12-08 08:27:01.339308-05	5	13	54	What should be done in the future?	1	
60	2014-12-08 08:27:27.092054-05	5	13	55	There is more to tell.	1	
61	2014-12-08 08:27:58.710639-05	5	13	56	What can we do now?	1	
62	2014-12-08 08:28:27.888725-05	5	13	57	We should meet up this Tuesday for coffee!	1	
63	2014-12-08 08:28:54.834269-05	5	13	58	We should meet up on Tuesdays every week.	1	
64	2014-12-08 08:29:29.780707-05	5	13	59	There are so many great ideas.	1	
65	2014-12-08 08:29:56.870924-05	5	13	60	What could we have done differently?	1	
66	2014-12-08 08:30:18.339862-05	5	13	61	I wonder what we could do better.	1	
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 66, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	log entry	admin	logentry
2	permission	auth	permission
3	group	auth	group
4	user	auth	user
5	content type	contenttypes	contenttype
6	session	sessions	session
7	migration history	south	migrationhistory
8	user profile	ideas	userprofile
12	comments	ideas	comments
13	drops	ideas	drops
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('django_content_type_id_seq', 13, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
lx33woa4s8w40z3m9c453fdc5r6cxwqd	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-10-25 23:43:28.49408-04
ocd107zmwgcus6e1zq5w5if2h1nd6wdo	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2014-10-30 15:22:31.155896-04
grl66e1koopzprs860t5fz9f8cernilx	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2014-12-05 13:38:14.213773-05
a9f8d22wf4bsrl6vr1jzjlcz452fftdm	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2014-10-12 17:28:40.591843-04
i3n0ir5gjygt0von6fhrnfcsljm01knv	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-09 15:07:11.155901-05
q98hbztqg4c9x5dqp1qbdowi21xgimwy	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-09 15:07:35.822524-05
atv7kc05bxeoowf2owunp763zg1egpwt	YWI5Yzk3M2M2MGE3OGE2MjZmYjBjNWM1MWY2YjJlMzBmODgxMTI0Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=	2014-10-13 13:18:26.618171-04
pg8dybgpfekrn7c56wirykrpzkjru9po	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2014-10-14 13:06:15.972224-04
aqoowwnnnttc9njfku4olx2ztyf4hb0g	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-10 08:56:03.772563-05
z4fmgmiixtljt4fb0dfdi81xcf03om3m	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2014-10-14 19:51:23.431456-04
0v2rlw933t8v40kh0cdz0y98je4pu9co	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-10-14 19:54:30.086498-04
htbnsainzag8o8kr5lt88nez0qj0o1bj	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2014-12-10 11:39:12.978261-05
knu5t1y3gbj9ahn4rey2w0fubhx6ljuo	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2014-10-14 20:00:43.381281-04
dh90fgj5rnvty0nufzppzpivovx9qjzx	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2014-10-15 15:00:41.224834-04
em0285llptjtfninmuh8nyd78u7j7592	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-10-15 16:16:25.049316-04
twkpi5uxdr8n7m2kjb5z4etk13b0nnyw	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-10-15 17:09:44.354089-04
yp9l06hjywa32n3iqn8d8vurwi2t9v2o	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-10-16 09:35:18.200324-04
hqil1ltdfc8l3fll4uo23pj1y2t8eu2y	OTEwN2I1MDdiNDcyN2E0Zjc4MjY1YmRiODVjYTc0MTU1ODkwZDY3Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NX0=	2014-12-12 10:00:32.908346-05
8cdmtlejh2iwg9ew7l6n5zlgisfxpzuj	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-10-18 12:05:37.080078-04
3kzj2qt7e3f3hxiiv0ndu1ssmxbzogko	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-10-18 19:52:50.685635-04
7hi6oqv3thz6tyh8j7wgb6k3zb5wtszg	OTEwN2I1MDdiNDcyN2E0Zjc4MjY1YmRiODVjYTc0MTU1ODkwZDY3Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NX0=	2014-12-12 18:32:41.129566-05
vbfsv8ku6hb3pold1n6hr5892q76zr99	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-10-18 21:57:41.905458-04
q9gz2dj8gh7il0dplk00z5h48pf9r1av	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-10-18 21:57:56.741239-04
qsb5lipuhpbw6yroi23spwkyhnzfgpce	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-10-18 23:12:57.340906-04
25lhnt1de8hr0ekcrz5ibs4vjjc97n0q	OTEwN2I1MDdiNDcyN2E0Zjc4MjY1YmRiODVjYTc0MTU1ODkwZDY3Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NX0=	2014-12-12 21:37:21.650305-05
ng15w4es0504agqmz6zyck1b8se6tsyj	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-14 08:22:15.492389-05
566z184ka5zlrbkz3jpsxpi7apklhbfd	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-14 09:30:27.668542-05
p2tfosyfihyjy1i9khuq1hgta6y4c8x9	OTEwN2I1MDdiNDcyN2E0Zjc4MjY1YmRiODVjYTc0MTU1ODkwZDY3Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NX0=	2014-10-20 08:14:46.930093-04
jl1gutcs26w8ut9i86kebio1b3vgfgm3	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-14 09:30:39.754345-05
wbragi11z59c4t1upjrc0biufmip9wis	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-10-20 20:21:19.715445-04
ig2ly9o60gjme5slrjbdk3q2d9yfkhu0	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2014-10-21 12:15:36.764504-04
mjijzyra1etyzkv16qnfts216edh7ns3	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2014-12-15 13:51:24.509216-05
y1nl57twdhfmiqkfgy6ia4yrirlqj0j2	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-18 15:05:46.513067-05
2pva7yf7dgpdyr1o5bm2eic07vmp3oz2	OTEwN2I1MDdiNDcyN2E0Zjc4MjY1YmRiODVjYTc0MTU1ODkwZDY3Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NX0=	2014-12-22 08:22:22.45864-05
234e28cypqykv4n3ezge36jwubpdck41	OTEwN2I1MDdiNDcyN2E0Zjc4MjY1YmRiODVjYTc0MTU1ODkwZDY3Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NX0=	2014-10-25 12:07:20.510556-04
elveij5gf75qewwpzr4fagefngvddq0g	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-22 08:42:50.175131-05
lgpxerl24ge3dncxb77wz1nocojrolbi	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2014-10-25 12:26:22.766802-04
t5b8693tsh193emy95osc8no36g63xpc	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-22 16:37:21.30438-05
rx6myk6416g2c8s7awb7nzws7fqfg6wb	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-22 19:11:18.339521-05
l3vv956mw1is01gvwvkye6fprj30quc7	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-23 10:15:09.252655-05
mbr96whjv5pg8s6qpzukepoohl6sd1l2	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-23 13:25:06.506374-05
xq3b76pg5kbhzgvrurpawlullfa564hm	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-24 17:04:14.662295-05
dbu61k44kqgh6r1fk6gtvuf2yoaehaco	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-24 22:30:53.186631-05
6webas5a3b3j4mz62xbo6c2pm4xhdcfx	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-25 12:17:40.714878-05
2cyyb50m6q3bfsfh3ingf0s6yf8gauoq	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-25 16:08:11.907406-05
nysxll3n18so28r2em919d9aqrdyjizi	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-28 08:58:08.959551-05
6mdh9fl3pxaexjdhgt39ddaczbzjffwg	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2014-12-29 14:39:27.306172-05
3ltpcdry6n8ks5vvj3k4k6tvppwesgbe	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2015-01-01 17:33:43.907085-05
ihl6ohebechx4vlc5rl1m9swb8vwuo5n	YzdjMDQyMjVhMmMxOWJiMDlhZTI0MmY5N2NjNDEwMmI3ODBjZGFhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=	2015-01-04 08:23:07.849358-05
aiaokk9oladllaz3qjvhgg23893wbnrt	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2015-01-04 08:45:29.441642-05
3oz07uz1fd1f55eulkku5ami4c5j0udz	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2015-01-04 08:48:17.573958-05
sq77n10p8qyqno9ajlx9x5wl3jntulod	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2015-01-05 13:18:34.388369-05
cvglwbufrhixzjtltvzcjc8sql6es7iw	MDdjNDlhOTI4NGQzZTlhYTg4MzY5Y2RiOGU1OTdiZWUxYmVjNjIzYzp7fQ==	2015-02-03 15:26:18.249308-05
\.


--
-- Data for Name: ideas_comments; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY ideas_comments (id, idea_id, comment, date, user_id, path, depth) FROM stdin;
\.


--
-- Name: ideas_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('ideas_comments_id_seq', 1, false);


--
-- Data for Name: ideas_drops; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY ideas_drops (id, data, drop_type, user_id, date, parent_id_id, origin_id, url) FROM stdin;
3	j&j pimp ass solutions	idea	1	2014-11-22 09:41:18.316498-05	\N	0	
4	Secure document and image storage using a web service and third party cloud storage to segment and store files.	idea	1	2014-11-23 08:54:27.71367-05	\N	0	
5	This web service would track parts of files that are stored in object stores, like Amazon's S3,and assemble them for viewing or sharing through the service only. Store locations would be stored locally in a DB. A URL would be provided for sharing	idea	1	2014-11-23 09:00:02.007677-05	4	4	
6	apps	idea	5	2014-11-28 10:01:28.247722-05	3	3	
7	kits	idea	5	2014-11-28 10:02:09.272663-05	3	3	
8	sauces	idea	5	2014-11-28 10:02:21.416462-05	3	3	
9	resell	idea	5	2014-11-28 10:02:32.958547-05	3	3	
10	charity/public service	idea	5	2014-11-28 10:02:45.878166-05	3	3	
11	a children's book that answers the question, "what do you want to be when you grow up?"	idea	5	2014-11-28 10:09:55.874356-05	\N	0	
12	i think often about how many times kids have to answer this question - usually with something general and of direct influence to shows, books, and stereotypes. "fireman," "princess," "police officer," "ballerina," "airplane driver" (that was mine!)	spark	5	2014-11-28 11:13:37.182616-05	11	11	http://thiskidreviewsbooks.com/2014/04/28/when-i-grow-up-i-want-to-be-by-wigu-publishing/
13	cover: what do you want to be when you grow up?	idea	5	2014-11-28 11:13:59.579114-05	11	11	
14	page one: what do you want to be when you grow, little one?	idea	5	2014-11-28 11:14:26.260373-05	13	11	
15	page one: what do you want to be when you grow, little one?	idea	5	2014-11-28 11:14:43.779709-05	13	11	
16	eat delicious food	idea	5	2014-11-28 11:15:33.730451-05	13	11	
17	knock off apps (like instead of the "yo" app, the "bro" app)	idea	5	2014-11-28 18:38:53.333589-05	6	3	
18	the quintessential hipster kit (a hipster starter kit): black-rimmed glasses, a mustache comb, an ironic book, and a flannel shirt...or something	idea	5	2014-11-28 18:39:27.389522-05	7	3	
19	brewmaster starter kit: everything you need to start homebrewing	idea	5	2014-11-28 18:39:45.451867-05	7	3	
20	bay area home/bar cocktail kits	idea	5	2014-11-28 18:39:57.639138-05	7	3	
21	find recipes like these to make the elements of cocktails for home - then start shopping them at bars	spark	5	2014-11-28 18:41:14.43183-05	20	3	http://www.tastingtable.com/entry_detail/national/17517/recipes_home/How_to_Make_a_Mudslide_at_Home.htm
22	keller's killer kahlua - how to make it at home	spark	5	2014-11-28 18:41:42.804602-05	20	3	http://www.simplynotable.com/2013/homemade-killer-kahlua/
23	limoncello - how to make it at home	spark	5	2014-11-28 18:42:02.440594-05	20	3	http://theitaliandishblog.com/imported-20090913150324/2012/7/3/how-to-make-homemade-limoncello.html?utm_source=feedburner&utm_medium=email&utm_campaign=Feed%3A+TheItalianDish+(The+Italian+Dish)
24	spicy mayo	idea	5	2014-11-28 18:42:28.491082-05	8	3	
25	teriyaki sauce	idea	5	2014-11-28 18:42:44.533351-05	8	3	
26	thai chili sauce	idea	5	2014-11-28 18:42:54.012144-05	8	3	
27	scrumptious asian flavors sauce	idea	5	2014-11-28 18:43:07.778237-05	8	3	
28	sounds simple and easy!	spark	5	2014-11-28 18:43:44.11871-05	27	3	http://www.tastingtable.com/entry_detail/national/17502/How_to_Make_Jonathan_Waxmans_Favorite_Sauce.htm?utm_medium=email&utm_source=national&utm_campaign=Jonathan_Waxmans_Secret_Weapon_2014_07_21&utm_content=Cooking_editorial
29	Empowering entrepreneurs in developing countries with a turn-key Shop franchise to offer affordable drinking water, phone charging and smart home appliances to low income earners. The market is the majority of the world, who's needs are not being met	idea	5	2014-11-28 18:45:09.538899-05	\N	0	
30	The solution explained in more detail!	spark	5	2014-11-28 18:45:51.332895-05	29	29	https://vimeo.com/84304036
31	With the crowd to a proven concept! Contribute starting at as little as $5!	spark	5	2014-11-28 18:46:15.354918-05	29	29	http://igg.me/at/SunnyRiver/x/6451595
32	Would appreciate feedback and impression from anyone!	idea	5	2014-11-28 18:46:33.04003-05	29	29	
33	I would say electricity is the hardest one to get to the world, short of hand crank. There are a number of good handheld reusable water filters out there, and electronics can be fairly cheap these days, but power itself is tough.	idea	5	2014-11-28 18:46:48.919953-05	32	29	
34	engaging local chefs to participate in school menu planning	idea	5	2014-11-28 18:47:46.037359-05	\N	0	
35	starting around 9.30, what he says really resonated with me regarding the people passing food to our children.	spark	5	2014-11-28 18:48:19.230977-05	34	34	http://www.ted.com/talks/jamie_oliver.html
36	clearly not the first idea about it - but how do we build this into a "thing" that chefs do?	spark	5	2014-11-28 18:48:42.260096-05	34	34	http://www.letsmove.gov/chefs-move-schools
37	if over 21 million students have been reached with a program like this, then why do we still have the obesity problem in america?	spark	5	2014-11-28 18:49:10.182618-05	34	34	http://www.farmtoschool.org/
38	local food companies should also actively participate in school lunches - especially those who are healthier by nature (i.e., not genetically modified foods or overly processed foods)	idea	5	2014-11-28 18:49:25.291365-05	34	34	
39	maybe having the kids actively involved in the raising then preparation of the food	spark	5	2014-11-28 18:50:36.138236-05	35	34	http://beverly-mtgreenwood.patch.com/groups/goodnews/p/ag-school-students-and-local-chefs-team-up-for-community-thanksgiving-dinner
40	the secret's in identifying "meals that are both healthy and appealing to kids"	spark	5	2014-11-28 18:51:04.577218-05	37	34	http://grist.org/school-lunches/2012-01-04-greasy-to-gourmet-seattle-chefs-help-schools-trade-corn-dogs-for/
41	it helps to involve people who are wholly invested in the future of the children as well, who can coordinate the chef community	spark	5	2014-11-28 18:51:31.289421-05	37	34	http://www.foodservicedirector.com/news/articles/top-chefs-help-revamp-lunch-programs-minneapolis-public-schools
42	How might we design the best online learning platform for sharing ideas and projects?	idea	5	2014-11-28 18:52:14.828014-05	\N	0	
43	Sparks should be able to show an image or video according to the content of their link.	idea	5	2014-11-28 18:52:39.801197-05	42	42	
44	What's the big idea?	idea	5	2014-12-08 08:22:51.665821-05	\N	0	
45	Inspiration can strike at any time!	spark	5	2014-12-08 08:23:45.381401-05	44	44	
46	The mind is constantly firing up new ideas	spark	5	2014-12-08 08:24:15.607844-05	44	44	
47	Where can we go to increase the inspiration? 	spark	5	2014-12-08 08:24:43.244077-05	44	44	
48	More people contribute to the conversation.	idea	5	2014-12-08 08:25:10.638323-05	44	44	
49	New Ideas branch off into other diverse conversations	idea	5	2014-12-08 08:25:34.202118-05	44	44	
50	A new fighter has entered the arena!	idea	5	2014-12-08 08:25:58.166211-05	44	44	
51	What is going to be the next great idea?	idea	5	2014-12-08 08:26:11.949491-05	44	44	
52	We need to take action immediately	action	5	2014-12-08 08:26:29.669413-05	44	44	
53	How did it all go down in the end?	action	5	2014-12-08 08:26:43.916681-05	44	44	
54	What should be done in the future?	action	5	2014-12-08 08:27:01.337366-05	44	44	
55	There is more to tell.	spark	5	2014-12-08 08:27:27.090371-05	48	44	
56	What can we do now?	idea	5	2014-12-08 08:27:58.70912-05	51	44	
57	We should meet up this Tuesday for coffee!	action	5	2014-12-08 08:28:27.887505-05	51	44	
58	We should meet up on Tuesdays every week.	action	5	2014-12-08 08:28:54.83302-05	51	44	
59	There are so many great ideas.	spark	5	2014-12-08 08:29:29.779403-05	54	44	
60	What could we have done differently?	idea	5	2014-12-08 08:29:56.869564-05	53	44	
61	I wonder what we could do better.	idea	5	2014-12-08 08:30:18.338603-05	53	44	
\.


--
-- Name: ideas_drops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('ideas_drops_id_seq', 61, true);


--
-- Data for Name: ideas_userprofile; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY ideas_userprofile (id, user_id, username, website) FROM stdin;
\.


--
-- Name: ideas_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('ideas_userprofile_id_seq', 1, false);


--
-- Data for Name: south_migrationhistory; Type: TABLE DATA; Schema: public; Owner: gigantic
--

COPY south_migrationhistory (id, app_name, migration, applied) FROM stdin;
1	ideas	0001_initial	2014-11-22 09:31:27.727749-05
2	ideas	0002_auto__add_field_drops_url	2014-11-28 10:04:56.606297-05
\.


--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigantic
--

SELECT pg_catalog.setval('south_migrationhistory_id_seq', 2, true);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_model_key; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_key UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: ideas_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY ideas_comments
    ADD CONSTRAINT ideas_comments_pkey PRIMARY KEY (id);


--
-- Name: ideas_drops_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY ideas_drops
    ADD CONSTRAINT ideas_drops_pkey PRIMARY KEY (id);


--
-- Name: ideas_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY ideas_userprofile
    ADD CONSTRAINT ideas_userprofile_pkey PRIMARY KEY (id);


--
-- Name: ideas_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY ideas_userprofile
    ADD CONSTRAINT ideas_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: south_migrationhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: gigantic; Tablespace: 
--

ALTER TABLE ONLY south_migrationhistory
    ADD CONSTRAINT south_migrationhistory_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_like; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX auth_group_name_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_like; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX auth_user_username_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX django_admin_log_content_type_id ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX django_admin_log_user_id ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX django_session_expire_date ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_like; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX django_session_session_key_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: ideas_comments_idea_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX ideas_comments_idea_id ON ideas_comments USING btree (idea_id);


--
-- Name: ideas_comments_user_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX ideas_comments_user_id ON ideas_comments USING btree (user_id);


--
-- Name: ideas_drops_parent_id_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX ideas_drops_parent_id_id ON ideas_drops USING btree (parent_id_id);


--
-- Name: ideas_drops_user_id; Type: INDEX; Schema: public; Owner: gigantic; Tablespace: 
--

CREATE INDEX ideas_drops_user_id ON ideas_drops USING btree (user_id);


--
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_93d2d1f8; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT content_type_id_refs_id_93d2d1f8 FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_d043b34a; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT content_type_id_refs_id_d043b34a FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_f4b32aac; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_f4b32aac FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: idea_id_refs_id_da849fc8; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY ideas_comments
    ADD CONSTRAINT idea_id_refs_id_da849fc8 FOREIGN KEY (idea_id) REFERENCES ideas_drops(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: parent_id_id_refs_id_6136e50e; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY ideas_drops
    ADD CONSTRAINT parent_id_id_refs_id_6136e50e FOREIGN KEY (parent_id_id) REFERENCES ideas_drops(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_1c148e34; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY ideas_drops
    ADD CONSTRAINT user_id_refs_id_1c148e34 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_40c41112; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_40c41112 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_4dc23c39; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT user_id_refs_id_4dc23c39 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_86d5bbba; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY ideas_userprofile
    ADD CONSTRAINT user_id_refs_id_86d5bbba FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_c0d12874; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT user_id_refs_id_c0d12874 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_e13ac572; Type: FK CONSTRAINT; Schema: public; Owner: gigantic
--

ALTER TABLE ONLY ideas_comments
    ADD CONSTRAINT user_id_refs_id_e13ac572 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

