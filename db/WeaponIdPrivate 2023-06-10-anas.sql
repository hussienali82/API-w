--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-06-10 12:59:09

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
-- TOC entry 857 (class 1247 OID 18000)
-- Name: approval_part; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.approval_part AS ENUM (
    'person',
    'weapon'
);


ALTER TYPE public.approval_part OWNER TO postgres;

--
-- TOC entry 860 (class 1247 OID 18006)
-- Name: approval_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.approval_role AS ENUM (
    'Prime_mimister',
    'Minister'
);


ALTER TYPE public.approval_role OWNER TO postgres;

--
-- TOC entry 863 (class 1247 OID 18012)
-- Name: gender_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.gender_type AS ENUM (
    'male',
    'female'
);


ALTER TYPE public.gender_type OWNER TO postgres;

--
-- TOC entry 866 (class 1247 OID 18018)
-- Name: status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status AS ENUM (
    'PENDING',
    'APPROVED',
    'DECLINED'
);


ALTER TYPE public.status OWNER TO postgres;

--
-- TOC entry 869 (class 1247 OID 18026)
-- Name: user_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_type AS ENUM (
    'identification_managment',
    'approval_destination'
);


ALTER TYPE public.user_type OWNER TO postgres;

--
-- TOC entry 244 (class 1255 OID 26233)
-- Name: fn_status1(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_status1(approval_dest_id_par integer) RETURNS TABLE(status integer)
    LANGUAGE plpgsql STABLE
    AS $$
  DECLARE status_intellig_var integer;
  

  

  BEGIN
  
status_intellig_var=
(select status1 from (
	SELECT 
 
  MAX(a.created_at),MAX(a.status) as status1
  
 FROM approvals a left join approval_destination d
 on a.approval_dest_id=d.id  
   left join  subidentity s 
   on a.sub_identity=s.sudid
            where 
			 a.approval_dest_id=approval_dest_id_par ) as statuses
);

return query select status_intellig_var as status;

	

  END;
$$;


ALTER FUNCTION public.fn_status1(approval_dest_id_par integer) OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 26234)
-- Name: fn_status2(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_status2(sub_identity_par integer) RETURNS TABLE(status integer)
    LANGUAGE plpgsql STABLE
    AS $$
  DECLARE status_Identification_count integer;
  

  BEGIN
  
status_Identification_count=
(select status1 from (
	SELECT 
 
  MAX(a.created_at),MAX(a.status) as status1
  
 FROM approvals a left join approval_destination d
 on a.approval_dest_id=d.id  
   left join  subidentity s 
   on a.sub_identity=s.sudid
            where 
			 a.sub_identity=sub_identity_par ) as statuses
);

return query select status_Identification_count as status;

	

  END;
$$;


ALTER FUNCTION public.fn_status2(sub_identity_par integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 18031)
-- Name: approval_destination; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.approval_destination (
    id integer NOT NULL,
    destination text NOT NULL,
    role_type smallint NOT NULL,
    approval_part smallint
);


ALTER TABLE public.approval_destination OWNER TO postgres;

--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 214
-- Name: COLUMN approval_destination.role_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.approval_destination.role_type IS '0 none -> userType = 1,
1 accept suspense -> userType = 2, 
2 accept reject userType = 2,
3 supervisor userType = 2';


--
-- TOC entry 215 (class 1259 OID 18036)
-- Name: app_person_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.app_person_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_person_type_id_seq OWNER TO postgres;

--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 215
-- Name: app_person_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.app_person_type_id_seq OWNED BY public.approval_destination.id;


--
-- TOC entry 216 (class 1259 OID 18037)
-- Name: approvals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.approvals (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    req_details_id uuid NOT NULL,
    approval_dest_id integer,
    approval_part smallint NOT NULL,
    status smallint,
    reason text,
    booknum text,
    bookdate timestamp with time zone,
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by integer,
    updated_at timestamp with time zone,
    updated_by integer,
    audit bit(1),
    audit_updated timestamp with time zone,
    sub_identity smallint
);


ALTER TABLE public.approvals OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 18044)
-- Name: biometric; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.biometric (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    pict text,
    iris text,
    fing_right text NOT NULL,
    fing_left text NOT NULL,
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by integer,
    updated_at timestamp with time zone,
    updated_by integer
);


ALTER TABLE public.biometric OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 18051)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id integer NOT NULL,
    cat text NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 18056)
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO postgres;

--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 219
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- TOC entry 220 (class 1259 OID 18057)
-- Name: identification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identification (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    req_det_id uuid NOT NULL,
    printtime date NOT NULL,
    idnum integer NOT NULL,
    expdate timestamp with time zone NOT NULL,
    permdate timestamp with time zone,
    note text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by integer,
    updated_at timestamp with time zone,
    updated_by integer,
    is_print boolean DEFAULT false
);


ALTER TABLE public.identification OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 18065)
-- Name: license_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.license_type (
    id integer NOT NULL,
    license text NOT NULL
);


ALTER TABLE public.license_type OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 18070)
-- Name: license_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.license_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.license_type_id_seq OWNER TO postgres;

--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 222
-- Name: license_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.license_type_id_seq OWNED BY public.license_type.id;


--
-- TOC entry 223 (class 1259 OID 18071)
-- Name: province; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.province (
    id integer NOT NULL,
    pro_name text NOT NULL
);


ALTER TABLE public.province OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 18076)
-- Name: province_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.province_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.province_id_seq OWNER TO postgres;

--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 224
-- Name: province_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.province_id_seq OWNED BY public.province.id;


--
-- TOC entry 225 (class 1259 OID 18077)
-- Name: requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name1 text NOT NULL,
    name2 text NOT NULL,
    name3 text NOT NULL,
    name4 text NOT NULL,
    surname text,
    profession text NOT NULL,
    birdate timestamp with time zone NOT NULL,
    gender_type smallint NOT NULL,
    cat_id integer NOT NULL,
    monam1 text NOT NULL,
    monam2 text NOT NULL,
    monam3 text NOT NULL,
    idnum text NOT NULL,
    pro_id integer NOT NULL,
    addresses text NOT NULL,
    phone text NOT NULL,
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by integer,
    updated_at timestamp with time zone,
    updated_by integer,
    approv_num text,
    approv_date date
);


ALTER TABLE public.requests OWNER TO postgres;

--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN requests.gender_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.requests.gender_type IS '1- male
2- female';


--
-- TOC entry 226 (class 1259 OID 18084)
-- Name: requests_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requests_details (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    req_id uuid NOT NULL,
    license_id integer NOT NULL,
    approval_role smallint,
    name1 text NOT NULL,
    name2 text NOT NULL,
    name3 text NOT NULL,
    name4 text NOT NULL,
    surname text,
    gender_type smallint,
    cat_id integer NOT NULL,
    birdate timestamp with time zone NOT NULL,
    monam1 text NOT NULL,
    monam2 text NOT NULL,
    monam3 text NOT NULL,
    idnum text NOT NULL,
    iss_1 text NOT NULL,
    issdat1 date NOT NULL,
    natnum text NOT NULL,
    iss_2 text NOT NULL,
    issdat2 timestamp with time zone NOT NULL,
    pro_id integer NOT NULL,
    addresses text NOT NULL,
    nearplace text NOT NULL,
    mahala text NOT NULL,
    zuqaq text NOT NULL,
    dar text NOT NULL,
    djp text,
    numdet text,
    datedet timestamp with time zone,
    phone text NOT NULL,
    weapname_id integer NOT NULL,
    weapnum text NOT NULL,
    wea_hold_per text NOT NULL,
    margin_app text NOT NULL,
    completed smallint,
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by integer,
    updated_at timestamp with time zone,
    updated_by integer,
    prev_weapn text,
    archive_num text,
    biometric_id uuid
);


ALTER TABLE public.requests_details OWNER TO postgres;

--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN requests_details.approval_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.requests_details.approval_role IS '1- Prime_minister
2- Minister';


--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN requests_details.gender_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.requests_details.gender_type IS '1- male
2- female';


--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN requests_details.completed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.requests_details.completed IS '0- decline
1- approval
2- pending';


--
-- TOC entry 227 (class 1259 OID 18091)
-- Name: subidentity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subidentity (
    sudid smallint NOT NULL,
    sudname text,
    sudrultype smallint
);


ALTER TABLE public.subidentity OWNER TO postgres;

--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN subidentity.sudid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.subidentity.sudid IS 'التسلسل';


--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN subidentity.sudname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.subidentity.sudname IS 'اسم الجهة التابعة الى مديرية الهويات';


--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN subidentity.sudrultype; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.subidentity.sudrultype IS 'الصلاحية الخاصة بالجهة 
-غير مؤثر
-رفض
-وغيرها
0 none -> userType = 1,
1 accept suspense -> userType = 2, 
2 accept reject userType = 2,
3 supervisor userType = 2';


--
-- TOC entry 228 (class 1259 OID 18096)
-- Name: subidentity_sudid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.subidentity ALTER COLUMN sudid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.subidentity_sudid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 18097)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    approval_det_id integer,
    name text NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    user_type smallint,
    roles json,
    activation boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    first_enter boolean DEFAULT true,
    sudid smallint
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN users.user_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.user_type IS '1- iditification_managment
2- approvals_managment
3- minister office';


--
-- TOC entry 230 (class 1259 OID 18105)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 18106)
-- Name: weapon_name; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weapon_name (
    id integer NOT NULL,
    weapon_name text NOT NULL,
    weapon_size text NOT NULL
);


ALTER TABLE public.weapon_name OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 18111)
-- Name: weapon_name_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.weapon_name_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.weapon_name_id_seq OWNER TO postgres;

--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 232
-- Name: weapon_name_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.weapon_name_id_seq OWNED BY public.weapon_name.id;


--
-- TOC entry 3240 (class 2604 OID 18112)
-- Name: approval_destination id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approval_destination ALTER COLUMN id SET DEFAULT nextval('public.app_person_type_id_seq'::regclass);


--
-- TOC entry 3245 (class 2604 OID 18113)
-- Name: category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- TOC entry 3249 (class 2604 OID 18114)
-- Name: license_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license_type ALTER COLUMN id SET DEFAULT nextval('public.license_type_id_seq'::regclass);


--
-- TOC entry 3250 (class 2604 OID 18115)
-- Name: province id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.province ALTER COLUMN id SET DEFAULT nextval('public.province_id_seq'::regclass);


--
-- TOC entry 3258 (class 2604 OID 18116)
-- Name: weapon_name id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon_name ALTER COLUMN id SET DEFAULT nextval('public.weapon_name_id_seq'::regclass);


--
-- TOC entry 3436 (class 0 OID 18031)
-- Dependencies: 214
-- Data for Name: approval_destination; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.approval_destination (id, destination, role_type, approval_part) VALUES (2, 'الاستخبارات', 1, NULL);
INSERT INTO public.approval_destination (id, destination, role_type, approval_part) VALUES (3, 'البنى التحتية', 1, NULL);
INSERT INTO public.approval_destination (id, destination, role_type, approval_part) VALUES (7, 'القانونية', 3, 1);
INSERT INTO public.approval_destination (id, destination, role_type, approval_part) VALUES (4, 'الخدمات الطبية', 1, 1);
INSERT INTO public.approval_destination (id, destination, role_type, approval_part) VALUES (5, 'الادلة الجنائية', 1, 2);
INSERT INTO public.approval_destination (id, destination, role_type, approval_part) VALUES (8, 'ادلة جنائية -فحص سلاح- المرحلة الاولى', 1, 2);


--
-- TOC entry 3438 (class 0 OID 18037)
-- Dependencies: 216
-- Data for Name: approvals; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('bb02a121-8870-48d5-bc00-6d820cac3bd9', '04d005a2-7c78-4a2d-9b26-72d32112b22e', NULL, 0, 1, 'قانونية', '3', '2023-06-13 00:00:00+03', 'قانونية', '2023-06-05 12:16:24.439342+03', 2, NULL, NULL, B'0', NULL, 4);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('8f75a22d-710b-4b2e-bd0c-cf55f6bb156e', '04d005a2-7c78-4a2d-9b26-72d32112b22e', NULL, 0, 1, 'قانونية', '3', '2023-06-13 00:00:00+03', 'قانونية', '2023-06-05 12:19:58.74275+03', 2, NULL, NULL, B'0', NULL, 4);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('40c79939-db99-4563-8da7-1edee00a78a7', '04d005a2-7c78-4a2d-9b26-72d32112b22e', NULL, 0, 1, 'oo', '2', '2023-06-20 00:00:00+03', 'dd', '2023-06-06 10:11:19.846152+03', 2, NULL, NULL, B'0', NULL, 3);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('d5a7e981-febe-43bb-a3e7-bfa247bf22e7', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 0, 1, 'الاستخبارات', '3', '2023-06-13 00:00:00+03', 'الاستخبارات', '2023-06-06 10:46:49.811969+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('1292630e-1092-4710-887d-144ae96797df', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 0, 1, 'الاستخبارات3', '8', '2023-06-20 00:00:00+03', 'الاستخبارات3', '2023-06-06 11:03:56.836118+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('8da6d38c-4e57-4a5d-b43e-95b2026e8578', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 0, 0, 'الاستخبارات2', '4', '2023-06-12 00:00:00+03', 'الاستخبارات 2', '2023-06-06 10:47:53.74515+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('0c36edde-832d-4888-9f7d-51bec59e2b30', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 3, 0, 1, 'بنى تحتية', '3', '2023-06-02 00:00:00+03', 'بنى تحتية', '2023-06-07 09:45:15.185089+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('fe61dd07-afdf-4e5b-a935-ba9dbf9312e2', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 3, 0, 1, 'بنى تحتية', '4', '2023-06-20 00:00:00+03', 'بنى تحتية', '2023-06-07 09:46:08.668807+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('4c2cfac6-f387-458f-aa99-781fc016b9be', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 3, 0, 1, 'بنى تحتية', '3', '2023-06-23 00:00:00+03', 'بنى تحتية', '2023-06-07 09:45:45.893263+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('67647210-a579-477b-8502-4da7f8a00cda', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 5, 0, 0, 'لا يوجد اوليات', '5', '2023-06-08 00:00:00+03', 'لا يوجد اوليات', '2023-06-07 10:50:16.967915+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('d108b4c2-a1fd-4bfd-b65f-382f8d095ff8', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 8, 0, 1, 'لا يوجد', '4', '2023-06-08 00:00:00+03', 'تم الفحص', '2023-06-07 10:57:33.065181+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('56f997f6-13ea-484d-b2cf-ad69f6becee7', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 8, 0, 1, 'لا يوجد', 'لا يوجد', '2023-06-10 00:00:00+03', 'لا يوجد', '2023-06-07 11:03:31.860489+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('610c1b9a-e309-43a4-9194-44d946a62950', '04d005a2-7c78-4a2d-9b26-72d32112b22e', NULL, 1, 0, 'noooo', '44', '2023-06-06 00:00:00+03', 'dd', '2023-06-06 10:21:23.53104+03', 2, NULL, NULL, B'0', NULL, 3);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('2ab8f7c1-7257-4b3f-af5f-34ec22d2e3f0', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 0, 1, 'j', '9', '2023-06-21 00:00:00+03', 'k', '2023-06-10 10:54:19.723353+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('9785d47b-21f1-4615-b825-baf7beeaea25', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 1, 1, 'j', '4', '2023-06-19 00:00:00+03', 'd', '2023-06-10 11:13:18.16896+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('0ca0b404-7beb-45ce-94f2-926998dee928', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 1, 0, 'd', '3', '2023-06-22 00:00:00+03', 'k', '2023-06-10 11:23:22.213141+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('f6d48510-fa16-4729-a1e3-9cde5e1d70e5', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 1, 1, 'oo', '3', '2023-06-21 00:00:00+03', 'd', '2023-06-10 11:28:22.070101+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('d4728171-34e6-4fb8-8110-7fe2fca43091', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 0, NULL, 'rr', '1', '2023-06-13 00:00:00+03', 'rr', '2023-06-10 11:29:48.061325+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('0a92fd41-b574-4827-901f-5ec537a24e93', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 1, 1, 'rr2', '22', '2023-06-21 00:00:00+03', '2rr', '2023-06-10 11:30:49.659656+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('c8a90440-8bc6-416f-88fc-7eb814f8bc46', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 0, 1, 'tt2', '6', '2023-06-21 00:00:00+03', 'tt2', '2023-06-10 11:35:06.86416+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('8069504b-fbbd-4f6e-b86b-48b6cad7a920', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 0, 1, 'sio', '3', '2023-06-20 00:00:00+03', 's', '2023-06-10 12:17:16.344662+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('54d039fd-d218-40a7-91bb-d8dbe1e47f29', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 0, 1, 'as', '3', '2023-06-26 00:00:00+03', 'jj', '2023-06-10 12:19:27.258555+03', 2, NULL, NULL, B'0', NULL, NULL);
INSERT INTO public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity) VALUES ('86e8f1e0-0aba-4680-940f-e2c21e60d4c4', '04d005a2-7c78-4a2d-9b26-72d32112b22e', 2, 0, 1, 'oo', 'j', '2023-06-20 00:00:00+03', '748', '2023-06-10 12:21:08.075846+03', 2, NULL, NULL, B'0', NULL, NULL);


--
-- TOC entry 3439 (class 0 OID 18044)
-- Dependencies: 217
-- Data for Name: biometric; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3440 (class 0 OID 18051)
-- Dependencies: 218
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.category (id, cat) VALUES (1, 'محامي');
INSERT INTO public.category (id, cat) VALUES (2, 'طبيب');
INSERT INTO public.category (id, cat) VALUES (3, 'رجل اعمال');


--
-- TOC entry 3442 (class 0 OID 18057)
-- Dependencies: 220
-- Data for Name: identification; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3443 (class 0 OID 18065)
-- Dependencies: 221
-- Data for Name: license_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.license_type (id, license) VALUES (1, 'اصدار جديد');
INSERT INTO public.license_type (id, license) VALUES (2, 'تجديد الهوية');


--
-- TOC entry 3445 (class 0 OID 18071)
-- Dependencies: 223
-- Data for Name: province; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.province (id, pro_name) VALUES (1, 'بغداد');
INSERT INTO public.province (id, pro_name) VALUES (2, 'اربيل');
INSERT INTO public.province (id, pro_name) VALUES (3, 'البصرة');
INSERT INTO public.province (id, pro_name) VALUES (4, 'النجف الاشرف');


--
-- TOC entry 3447 (class 0 OID 18077)
-- Dependencies: 225
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.requests (id, name1, name2, name3, name4, surname, profession, birdate, gender_type, cat_id, monam1, monam2, monam3, idnum, pro_id, addresses, phone, note, created_at, created_by, updated_at, updated_by, approv_num, approv_date) VALUES ('e0f99a44-90c9-43da-8ef5-64d928a741d2', 'n1', 'n2', 'n3', 'n4', 'sn', 'pn', '1990-01-01 00:00:00+03', 1, 1, 'mn', 'mn2', 'mn3', '121212', 1, 'adddd1', '07770', NULL, '2023-05-02 10:10:55.348577+03', 1, NULL, NULL, '12333', '2023-05-27');
INSERT INTO public.requests (id, name1, name2, name3, name4, surname, profession, birdate, gender_type, cat_id, monam1, monam2, monam3, idnum, pro_id, addresses, phone, note, created_at, created_by, updated_at, updated_by, approv_num, approv_date) VALUES ('e0e3c23b-4fbd-4e52-924d-060b2c28664f', 'test', 'test', 'test', 'test', 'test', 'test', '2023-05-22 00:00:00+03', 2, 1, 'test', 'test', 'test', '99', 1, 'بغداد', '0780123', 'لاتوجد ملاحظات', '2023-05-27 13:26:01.965252+03', NULL, NULL, NULL, '1212', '2023-05-04');
INSERT INTO public.requests (id, name1, name2, name3, name4, surname, profession, birdate, gender_type, cat_id, monam1, monam2, monam3, idnum, pro_id, addresses, phone, note, created_at, created_by, updated_at, updated_by, approv_num, approv_date) VALUES ('1e203947-57b5-489c-ab2b-4a4f744a0daa', 'mmmmm', 'B', 'C', 'D', 'E', 'F', '1988-01-01 00:00:00+03', 1, 1, 'A', 'A', 'A', '9999', 1, 'Baagdhad', '07701234', 'ddddddddddd', '2023-05-28 09:58:13.67741+03', NULL, NULL, NULL, '1212', '2023-05-29');
INSERT INTO public.requests (id, name1, name2, name3, name4, surname, profession, birdate, gender_type, cat_id, monam1, monam2, monam3, idnum, pro_id, addresses, phone, note, created_at, created_by, updated_at, updated_by, approv_num, approv_date) VALUES ('7c74cd68-f710-44f0-a0c3-89376bb5d118', 'احمد', 'غانم', 'حميد', 'حسين', 'الشمري', 'F', '1988-01-01 00:00:00+03', 2, 1, 'A', 'A', 'A', '9999', 1, 'شارع 20, قرب التقاطع', '07701234', 'not exists', '2023-05-29 21:20:21.005686+03', NULL, NULL, NULL, '2323', '2023-06-17');


--
-- TOC entry 3448 (class 0 OID 18084)
-- Dependencies: 226
-- Data for Name: requests_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.requests_details (id, req_id, license_id, approval_role, name1, name2, name3, name4, surname, gender_type, cat_id, birdate, monam1, monam2, monam3, idnum, iss_1, issdat1, natnum, iss_2, issdat2, pro_id, addresses, nearplace, mahala, zuqaq, dar, djp, numdet, datedet, phone, weapname_id, weapnum, wea_hold_per, margin_app, completed, note, created_at, created_by, updated_at, updated_by, prev_weapn, archive_num, biometric_id) VALUES ('89f2c5ef-1573-4423-96e2-e874336bdfb8', '7c74cd68-f710-44f0-a0c3-89376bb5d118', 1, 1, 'n1', 'n2', 'n3', 'n4', 'n5', 1, 1, '1998-01-01 00:00:00+03', 'm1
', 'm2', 'm3', '12', '1', '2023-05-23', 'bnv', '1', '2022-01-01 00:00:00+03', 1, 'rrr', '22w', 'dkjdf', 'frfe', 'eef', 'wdwf', 'wdwd', '2020-01-01 00:00:00+03', 'wdw', 1, 'fe', '36', 'sfsf', 0, 'رفض مكتب الوزير: سلسة', '2023-05-29 21:20:21.032+03', 1, NULL, 7, NULL, NULL, NULL);
INSERT INTO public.requests_details (id, req_id, license_id, approval_role, name1, name2, name3, name4, surname, gender_type, cat_id, birdate, monam1, monam2, monam3, idnum, iss_1, issdat1, natnum, iss_2, issdat2, pro_id, addresses, nearplace, mahala, zuqaq, dar, djp, numdet, datedet, phone, weapname_id, weapnum, wea_hold_per, margin_app, completed, note, created_at, created_by, updated_at, updated_by, prev_weapn, archive_num, biometric_id) VALUES ('5e2cf466-e2c4-486a-bd0e-01e1c358f23b', '7c74cd68-f710-44f0-a0c3-89376bb5d118', 1, 1, 'حسين', 'حمادي', 'راضي', 'محمد', 'الخفاجي', 1, 1, '1998-01-01 00:00:00+03', 'm1
', 'm2', 'm3', '12', '1', '2023-05-24', 'bnv', '1', '2022-01-01 00:00:00+03', 1, 'rrr', '22w', 'dkjdf', 'frfe', 'eef', 'wdwf', 'wdwd', '2020-01-01 00:00:00+03', 'wdw', 1, 'fe', 'sf', 'sfsf', NULL, 'null', '2023-05-29 21:20:21.05+03', 1, NULL, 8, 'لا يوجد', NULL, NULL);
INSERT INTO public.requests_details (id, req_id, license_id, approval_role, name1, name2, name3, name4, surname, gender_type, cat_id, birdate, monam1, monam2, monam3, idnum, iss_1, issdat1, natnum, iss_2, issdat2, pro_id, addresses, nearplace, mahala, zuqaq, dar, djp, numdet, datedet, phone, weapname_id, weapnum, wea_hold_per, margin_app, completed, note, created_at, created_by, updated_at, updated_by, prev_weapn, archive_num, biometric_id) VALUES ('04d005a2-7c78-4a2d-9b26-72d32112b22e', 'e0f99a44-90c9-43da-8ef5-64d928a741d2', 1, 2, 'n1', 'n2', 'n3', 'n4', 'sn', 2, 1, '1990-01-01 00:00:00+03', 'mn1', 'mn2', 'mn3', '1', 'ggg', '2020-01-01', 'nnwwe', 'wewe', '2020-02-01 00:00:00+03', 1, 'adad', 'adad', 'adad', 'adad', 'ad', 'adad', '1dad', '2021-01-01 00:00:00+03', '0770', 1, '1212', '60', 'حسب الضوابط خمس سنوات', NULL, 'wwe', '2023-05-02 10:15:57.967784+03', 1, NULL, NULL, 'مسدس كلوك', '12', NULL);


--
-- TOC entry 3449 (class 0 OID 18091)
-- Dependencies: 227
-- Data for Name: subidentity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subidentity (sudid, sudname, sudrultype) OVERRIDING SYSTEM VALUE VALUES (2, 'مصرح هويات', 3);
INSERT INTO public.subidentity (sudid, sudname, sudrultype) OVERRIDING SYSTEM VALUE VALUES (3, 'مدقق هويات', 2);
INSERT INTO public.subidentity (sudid, sudname, sudrultype) OVERRIDING SYSTEM VALUE VALUES (4, 'قانونية الهويات', 2);
INSERT INTO public.subidentity (sudid, sudname, sudrultype) OVERRIDING SYSTEM VALUE VALUES (1, 'مفرزة الكرخ', 0);
INSERT INTO public.subidentity (sudid, sudname, sudrultype) OVERRIDING SYSTEM VALUE VALUES (5, 'ادارة الهويات', 0);
INSERT INTO public.subidentity (sudid, sudname, sudrultype) OVERRIDING SYSTEM VALUE VALUES (6, 'مفرزة الرصافة', 0);


--
-- TOC entry 3451 (class 0 OID 18097)
-- Dependencies: 229
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (13, NULL, 'admin7', 'admin7', '$2a$10$vIFD4Voi4541vplZSmeC9e1G9loJm6z/VwMNdf35Vx95t3A0W2g/2', 1, '{"admin":true,"create":true,"update":true,"delete":false,"print":false,"report":false}', true, '2023-06-01 12:48:41.882079+03', true, 1);
INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (14, NULL, 'admin8', 'admin8', '$2a$10$zzY5dsncFkLglFaGXn.I4OyD0EcMsRwQtlqGpWm6K6RwmAVedhHNe', 1, '{"admin":true,"create":true,"update":false,"delete":false,"print":false,"report":false}', true, '2023-06-01 12:49:20.212369+03', true, 2);
INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (10, NULL, 'Audit', 'admin4', '$2a$10$95O5pzQjBqmVAmwDXyxpWea7NGwkLERprMSVDln0Shq8FcI3O9z32', 2, '{"admin":true,"create":true,"update":true,"delete":true,"print":true,"report":false}', true, '2023-05-28 09:25:30.264926+03', false, 3);
INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (15, NULL, 'admin9', 'admin9', '$2a$10$LOK993V65uHiTyPINFeva.OY.IUAbBQRm2nOopp94nZ6HQUj7GcuW', 1, '{"admin":true,"create":true,"update":false,"delete":false,"print":false,"report":false}', true, '2023-06-01 13:10:02.504556+03', true, 6);
INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (16, 5, 'admin10', 'admin10', '$2a$10$Ku.pDbEvmVZggRhGz4KF1e3HMk1VZTeO1jkjO209VTN.tuAHcpjBm', 2, '{"admin":true,"create":true,"update":false,"delete":false,"print":false,"report":false}', true, '2023-06-01 13:10:24.948056+03', true, NULL);
INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (7, 3, 'Ayham Akeel', 'admin3', '$2a$10$euahTAFyTI2hUUxdmU6zZOZEXoBMMIYGlEHCiJuufTiXboezylNve', 3, '{"admin":true,"create":true,"update":true,"delete":true,"print":false,"report":false}', true, '2023-05-08 14:09:25.945852+03', false, NULL);
INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (9, 5, 'Admin user2', 'admin2', '$2a$10$TUZEvqbeuvMD6XHuheXNCuQ71cD7ikRugkbKIOkbINvXAJPmhBcDC', 2, '{"admin":true,"create":true,"update":true,"delete":true,"print":false,"report":false}', true, '2023-05-24 09:28:45.710406+03', false, NULL);
INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (11, 2, 'استخبارات', 'admin5', '$2a$10$T2pjHmwDv3FZ9CtfrPulZ..nrP8s776EahzNfpe737Dn5G2au042G', 2, '{"admin":true,"create":true,"update":false,"delete":false,"print":true,"report":false}', true, '2023-05-28 09:25:50.596505+03', false, NULL);
INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (12, 3, 'البنى التحتية', 'admin6', '$2a$10$98y3WCGrbyrC6.u88O6NnuUbbOmb6JUYiobmj0vkAyr0FWu6WqlcW', 2, '{"admin":true,"create":true,"update":true,"delete":false,"print":false,"report":false}', true, '2023-05-28 13:13:13.158523+03', false, NULL);
INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (21, NULL, 'قانونية', 'admin11', '$2a$10$RjORIT1dJNAgphTE/gpBUumn9Kl9DxkiBtg6vdsk0HZ06L6Tv6eNS', 1, '{"admin":false,"create":false,"update":false,"delete":false,"print":false,"report":false}', true, '2023-06-05 10:41:43.93954+03', false, 4);
INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (22, 8, 'فحص سلاح', 'admin20', '$2a$10$hBERYQXtWPlezdCY1x54oeEWaotdak0i6FSoRmY.ekgq75oJqL7i6', 2, '{"admin":true,"create":false,"update":false,"delete":false,"print":false,"report":false}', true, '2023-06-07 10:56:04.743375+03', false, NULL);
INSERT INTO public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) OVERRIDING SYSTEM VALUE VALUES (8, 4, 'Admin user1', 'admin1', '$2a$10$CTTPW4BH1Xn5C0QcYS9WMuh39vRdR1V3QvayoqKyjMW5qtkZmuBn.', 1, '{"admin":true,"create":true,"update":true,"delete":true,"print":false,"report":false}', true, '2023-05-24 09:27:28.590498+03', false, 5);


--
-- TOC entry 3453 (class 0 OID 18106)
-- Dependencies: 231
-- Data for Name: weapon_name; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.weapon_name (id, weapon_name, weapon_size) VALUES (1, 'p1', '9mm');


--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 215
-- Name: app_person_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.app_person_type_id_seq', 8, true);


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 219
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 3, true);


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 222
-- Name: license_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.license_type_id_seq', 2, true);


--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 224
-- Name: province_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.province_id_seq', 4, true);


--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 228
-- Name: subidentity_sudid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subidentity_sudid_seq', 6, true);


--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 230
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 22, true);


--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 232
-- Name: weapon_name_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.weapon_name_id_seq', 1, true);


--
-- TOC entry 3260 (class 2606 OID 18118)
-- Name: approval_destination app_person_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approval_destination
    ADD CONSTRAINT app_person_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3264 (class 2606 OID 18120)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 3266 (class 2606 OID 18122)
-- Name: identification identification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identification
    ADD CONSTRAINT identification_pkey PRIMARY KEY (id);


--
-- TOC entry 3268 (class 2606 OID 18124)
-- Name: license_type license_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license_type
    ADD CONSTRAINT license_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2606 OID 18126)
-- Name: province province_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (id);


--
-- TOC entry 3274 (class 2606 OID 18128)
-- Name: requests_details requests_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_pkey PRIMARY KEY (id);


--
-- TOC entry 3272 (class 2606 OID 18130)
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- TOC entry 3276 (class 2606 OID 18132)
-- Name: subidentity subidentity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subidentity
    ADD CONSTRAINT subidentity_pkey PRIMARY KEY (sudid);


--
-- TOC entry 3278 (class 2606 OID 18134)
-- Name: users users_namen_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_namen_key UNIQUE (name);


--
-- TOC entry 3280 (class 2606 OID 18136)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3282 (class 2606 OID 18138)
-- Name: users users_usernamen_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_usernamen_key UNIQUE (username);


--
-- TOC entry 3262 (class 2606 OID 18140)
-- Name: approvals weapon_approvalsn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT weapon_approvalsn_pkey PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2606 OID 18142)
-- Name: weapon_name weapon_name_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon_name
    ADD CONSTRAINT weapon_name_pkey PRIMARY KEY (id);


--
-- TOC entry 3286 (class 2606 OID 18143)
-- Name: requests requests_cat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES public.category(id);


--
-- TOC entry 3288 (class 2606 OID 18148)
-- Name: requests_details requests_details_cat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES public.category(id);


--
-- TOC entry 3289 (class 2606 OID 18153)
-- Name: requests_details requests_details_license_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_license_id_fkey FOREIGN KEY (license_id) REFERENCES public.license_type(id);


--
-- TOC entry 3290 (class 2606 OID 18158)
-- Name: requests_details requests_details_pro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_pro_id_fkey FOREIGN KEY (pro_id) REFERENCES public.province(id);


--
-- TOC entry 3291 (class 2606 OID 18163)
-- Name: requests_details requests_details_req_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_req_id_fkey FOREIGN KEY (req_id) REFERENCES public.requests(id);


--
-- TOC entry 3292 (class 2606 OID 18168)
-- Name: requests_details requests_details_weapname_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_weapname_id_fkey FOREIGN KEY (weapname_id) REFERENCES public.weapon_name(id);


--
-- TOC entry 3287 (class 2606 OID 18173)
-- Name: requests requests_pro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pro_id_fkey FOREIGN KEY (pro_id) REFERENCES public.province(id);


--
-- TOC entry 3285 (class 2606 OID 18184)
-- Name: approvals sub_sudid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT sub_sudid FOREIGN KEY (sub_identity) REFERENCES public.subidentity(sudid) NOT VALID;


--
-- TOC entry 3293 (class 2606 OID 18178)
-- Name: users users_approval_det; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_approval_det FOREIGN KEY (approval_det_id) REFERENCES public.approval_destination(id);


-- Completed on 2023-06-10 12:59:12

--
-- PostgreSQL database dump complete
--

