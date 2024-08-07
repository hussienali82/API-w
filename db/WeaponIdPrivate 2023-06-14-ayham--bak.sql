PGDMP                          {            weaponid    15.2    15.2 \    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    49347    weaponid    DATABASE     �   CREATE DATABASE weaponid WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1256';
    DROP DATABASE weaponid;
                postgres    false            Y           1247    49349    approval_part    TYPE     I   CREATE TYPE public.approval_part AS ENUM (
    'person',
    'weapon'
);
     DROP TYPE public.approval_part;
       public          postgres    false            \           1247    49354    approval_role    TYPE     S   CREATE TYPE public.approval_role AS ENUM (
    'Prime_mimister',
    'Minister'
);
     DROP TYPE public.approval_role;
       public          postgres    false            _           1247    49360    gender_type    TYPE     E   CREATE TYPE public.gender_type AS ENUM (
    'male',
    'female'
);
    DROP TYPE public.gender_type;
       public          postgres    false            b           1247    49366    status    TYPE     U   CREATE TYPE public.status AS ENUM (
    'PENDING',
    'APPROVED',
    'DECLINED'
);
    DROP TYPE public.status;
       public          postgres    false            e           1247    49374 	   user_type    TYPE     e   CREATE TYPE public.user_type AS ENUM (
    'identification_managment',
    'approval_destination'
);
    DROP TYPE public.user_type;
       public          postgres    false            �            1255    205002    fn_status1(integer)    FUNCTION     C  CREATE FUNCTION public.fn_status1(approval_dest_id_par integer) RETURNS TABLE(status integer)
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
 ?   DROP FUNCTION public.fn_status1(approval_dest_id_par integer);
       public          postgres    false            �            1255    205001    fn_status2(integer)    FUNCTION     K  CREATE FUNCTION public.fn_status2(sub_identity_par integer) RETURNS TABLE(status integer)
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
 ;   DROP FUNCTION public.fn_status2(sub_identity_par integer);
       public          postgres    false            �            1259    49379    approval_destination    TABLE     �   CREATE TABLE public.approval_destination (
    id integer NOT NULL,
    destination text NOT NULL,
    role_type smallint NOT NULL,
    approval_part smallint
);
 (   DROP TABLE public.approval_destination;
       public         heap    postgres    false            �           0    0 %   COLUMN approval_destination.role_type    COMMENT     �   COMMENT ON COLUMN public.approval_destination.role_type IS '0 none -> userType = 1,
1 accept suspense -> userType = 2, 
2 accept reject userType = 2,
3 supervisor userType = 2';
          public          postgres    false    214            �            1259    49384    app_person_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.app_person_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.app_person_type_id_seq;
       public          postgres    false    214            �           0    0    app_person_type_id_seq    SEQUENCE OWNED BY     V   ALTER SEQUENCE public.app_person_type_id_seq OWNED BY public.approval_destination.id;
          public          postgres    false    215            �            1259    49385 	   approvals    TABLE     +  CREATE TABLE public.approvals (
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
    audit bit(1) DEFAULT (0)::bit(1),
    audit_updated timestamp with time zone,
    sub_identity smallint
);
    DROP TABLE public.approvals;
       public         heap    postgres    false            �            1259    49392 	   biometric    TABLE     C  CREATE TABLE public.biometric (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    pict text,
    iris text,
    fing_dat text,
    fing_xml text,
    note text,
    created_at timestamp with time zone DEFAULT now(),
    created_by integer,
    updated_at timestamp with time zone DEFAULT now(),
    updated_by integer
);
    DROP TABLE public.biometric;
       public         heap    postgres    false            �            1259    49399    category    TABLE     Q   CREATE TABLE public.category (
    id integer NOT NULL,
    cat text NOT NULL
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    49404    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          postgres    false    218            �           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    219            �            1259    49405    identification    TABLE     �  CREATE TABLE public.identification (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    req_det_id uuid,
    printtime date,
    idnum integer,
    expdate timestamp with time zone,
    permdate timestamp with time zone,
    note text,
    created_at timestamp with time zone DEFAULT now(),
    created_by integer,
    updated_at timestamp with time zone,
    updated_by integer,
    is_print smallint
);
 "   DROP TABLE public.identification;
       public         heap    postgres    false            �           0    0    COLUMN identification.is_print    COMMENT     ]   COMMENT ON COLUMN public.identification.is_print IS '0 - not print
1- print
2- Error print';
          public          postgres    false    220            �            1259    49412    license_type    TABLE     Y   CREATE TABLE public.license_type (
    id integer NOT NULL,
    license text NOT NULL
);
     DROP TABLE public.license_type;
       public         heap    postgres    false            �            1259    49417    license_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.license_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.license_type_id_seq;
       public          postgres    false    221            �           0    0    license_type_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.license_type_id_seq OWNED BY public.license_type.id;
          public          postgres    false    222            �            1259    49418    province    TABLE     V   CREATE TABLE public.province (
    id integer NOT NULL,
    pro_name text NOT NULL
);
    DROP TABLE public.province;
       public         heap    postgres    false            �            1259    49423    province_id_seq    SEQUENCE     �   CREATE SEQUENCE public.province_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.province_id_seq;
       public          postgres    false    223            �           0    0    province_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.province_id_seq OWNED BY public.province.id;
          public          postgres    false    224            �            1259    49424    requests    TABLE     �  CREATE TABLE public.requests (
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
    DROP TABLE public.requests;
       public         heap    postgres    false            �           0    0    COLUMN requests.gender_type    COMMENT     F   COMMENT ON COLUMN public.requests.gender_type IS '1- male
2- female';
          public          postgres    false    225            �            1259    49431    requests_details    TABLE       CREATE TABLE public.requests_details (
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
 $   DROP TABLE public.requests_details;
       public         heap    postgres    false            �           0    0 %   COLUMN requests_details.approval_role    COMMENT     \   COMMENT ON COLUMN public.requests_details.approval_role IS '1- Prime_minister
2- Minister';
          public          postgres    false    226            �           0    0 #   COLUMN requests_details.gender_type    COMMENT     N   COMMENT ON COLUMN public.requests_details.gender_type IS '1- male
2- female';
          public          postgres    false    226            �           0    0 !   COLUMN requests_details.completed    COMMENT     \   COMMENT ON COLUMN public.requests_details.completed IS '0- decline
1- approval
2- pending';
          public          postgres    false    226            �            1259    164041    subidentity    TABLE     l   CREATE TABLE public.subidentity (
    sudid smallint NOT NULL,
    sudname text,
    sudrultype smallint
);
    DROP TABLE public.subidentity;
       public         heap    postgres    false            �           0    0    COLUMN subidentity.sudid    COMMENT     @   COMMENT ON COLUMN public.subidentity.sudid IS 'التسلسل';
          public          postgres    false    231            �           0    0    COLUMN subidentity.sudname    COMMENT     w   COMMENT ON COLUMN public.subidentity.sudname IS 'اسم الجهة التابعة الى مديرية الهويات';
          public          postgres    false    231            �           0    0    COLUMN subidentity.sudrultype    COMMENT     �   COMMENT ON COLUMN public.subidentity.sudrultype IS 'الصلاحية الخاصة بالجهة 
-غير مؤثر
-رفض
-وغيرها
0 none -> userType = 1,
1 accept suspense -> userType = 2, 
2 accept reject userType = 2,
3 supervisor userType = 2';
          public          postgres    false    231            �            1259    164046    subidentity_sudid_seq    SEQUENCE     �   ALTER TABLE public.subidentity ALTER COLUMN sudid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.subidentity_sudid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    231            �            1259    49438    users    TABLE     t  CREATE TABLE public.users (
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
    DROP TABLE public.users;
       public         heap    postgres    false            �           0    0    COLUMN users.user_type    COMMENT     t   COMMENT ON COLUMN public.users.user_type IS '1- iditification_managment
2- approvals_managment
3- minister office';
          public          postgres    false    227            �            1259    49446    users_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    227            �            1259    49447    weapon_name    TABLE     {   CREATE TABLE public.weapon_name (
    id integer NOT NULL,
    weapon_name text NOT NULL,
    weapon_size text NOT NULL
);
    DROP TABLE public.weapon_name;
       public         heap    postgres    false            �            1259    49452    weapon_name_id_seq    SEQUENCE     �   CREATE SEQUENCE public.weapon_name_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.weapon_name_id_seq;
       public          postgres    false    229            �           0    0    weapon_name_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.weapon_name_id_seq OWNED BY public.weapon_name.id;
          public          postgres    false    230            �           2604    49453    approval_destination id    DEFAULT     }   ALTER TABLE ONLY public.approval_destination ALTER COLUMN id SET DEFAULT nextval('public.app_person_type_id_seq'::regclass);
 F   ALTER TABLE public.approval_destination ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214            �           2604    49454    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218            �           2604    49455    license_type id    DEFAULT     r   ALTER TABLE ONLY public.license_type ALTER COLUMN id SET DEFAULT nextval('public.license_type_id_seq'::regclass);
 >   ALTER TABLE public.license_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221            �           2604    49456    province id    DEFAULT     j   ALTER TABLE ONLY public.province ALTER COLUMN id SET DEFAULT nextval('public.province_id_seq'::regclass);
 :   ALTER TABLE public.province ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            �           2604    49457    weapon_name id    DEFAULT     p   ALTER TABLE ONLY public.weapon_name ALTER COLUMN id SET DEFAULT nextval('public.weapon_name_id_seq'::regclass);
 =   ALTER TABLE public.weapon_name ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229            o          0    49379    approval_destination 
   TABLE DATA                 public          postgres    false    214   "r       q          0    49385 	   approvals 
   TABLE DATA                 public          postgres    false    216   �r       r          0    49392 	   biometric 
   TABLE DATA                 public          postgres    false    217   Sw       s          0    49399    category 
   TABLE DATA                 public          postgres    false    218   ox       u          0    49405    identification 
   TABLE DATA                 public          postgres    false    220   �x       v          0    49412    license_type 
   TABLE DATA                 public          postgres    false    221   
y       x          0    49418    province 
   TABLE DATA                 public          postgres    false    223   �y       z          0    49424    requests 
   TABLE DATA                 public          postgres    false    225   z       {          0    49431    requests_details 
   TABLE DATA                 public          postgres    false    226   �|       �          0    164041    subidentity 
   TABLE DATA                 public          postgres    false    231   C�       |          0    49438    users 
   TABLE DATA                 public          postgres    false    227   '�       ~          0    49447    weapon_name 
   TABLE DATA                 public          postgres    false    229   ��       �           0    0    app_person_type_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.app_person_type_id_seq', 6, true);
          public          postgres    false    215            �           0    0    category_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.category_id_seq', 3, true);
          public          postgres    false    219            �           0    0    license_type_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.license_type_id_seq', 2, true);
          public          postgres    false    222            �           0    0    province_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.province_id_seq', 4, true);
          public          postgres    false    224            �           0    0    subidentity_sudid_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.subidentity_sudid_seq', 6, true);
          public          postgres    false    232            �           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 16, true);
          public          postgres    false    228            �           0    0    weapon_name_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.weapon_name_id_seq', 1, true);
          public          postgres    false    230            �           2606    49459 )   approval_destination app_person_type_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.approval_destination
    ADD CONSTRAINT app_person_type_pkey PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.approval_destination DROP CONSTRAINT app_person_type_pkey;
       public            postgres    false    214            �           2606    205010    biometric biometric_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.biometric
    ADD CONSTRAINT biometric_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.biometric DROP CONSTRAINT biometric_pkey;
       public            postgres    false    217            �           2606    49461    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    218            �           2606    49463 "   identification identification_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.identification
    ADD CONSTRAINT identification_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.identification DROP CONSTRAINT identification_pkey;
       public            postgres    false    220            �           2606    49465    license_type license_type_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.license_type
    ADD CONSTRAINT license_type_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.license_type DROP CONSTRAINT license_type_pkey;
       public            postgres    false    221            �           2606    49467    province province_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.province DROP CONSTRAINT province_pkey;
       public            postgres    false    223            �           2606    49469 &   requests_details requests_details_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_pkey;
       public            postgres    false    226            �           2606    49471    requests requests_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.requests DROP CONSTRAINT requests_pkey;
       public            postgres    false    225            �           2606    164048    subidentity subidentity_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.subidentity
    ADD CONSTRAINT subidentity_pkey PRIMARY KEY (sudid);
 F   ALTER TABLE ONLY public.subidentity DROP CONSTRAINT subidentity_pkey;
       public            postgres    false    231            �           2606    49473    users users_namen_key 
   CONSTRAINT     P   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_namen_key UNIQUE (name);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_namen_key;
       public            postgres    false    227            �           2606    49475    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    227            �           2606    49477    users users_usernamen_key 
   CONSTRAINT     X   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_usernamen_key UNIQUE (username);
 C   ALTER TABLE ONLY public.users DROP CONSTRAINT users_usernamen_key;
       public            postgres    false    227            �           2606    49479     approvals weapon_approvalsn_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT weapon_approvalsn_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.approvals DROP CONSTRAINT weapon_approvalsn_pkey;
       public            postgres    false    216            �           2606    49481    weapon_name weapon_name_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.weapon_name
    ADD CONSTRAINT weapon_name_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.weapon_name DROP CONSTRAINT weapon_name_pkey;
       public            postgres    false    229            �           2606    49482    requests requests_cat_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES public.category(id);
 G   ALTER TABLE ONLY public.requests DROP CONSTRAINT requests_cat_id_fkey;
       public          postgres    false    3267    225    218            �           2606    49487 -   requests_details requests_details_cat_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES public.category(id);
 W   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_cat_id_fkey;
       public          postgres    false    3267    218    226            �           2606    49492 1   requests_details requests_details_license_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_license_id_fkey FOREIGN KEY (license_id) REFERENCES public.license_type(id);
 [   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_license_id_fkey;
       public          postgres    false    221    3271    226            �           2606    49497 -   requests_details requests_details_pro_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_pro_id_fkey FOREIGN KEY (pro_id) REFERENCES public.province(id);
 W   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_pro_id_fkey;
       public          postgres    false    223    3273    226            �           2606    49502 -   requests_details requests_details_req_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_req_id_fkey FOREIGN KEY (req_id) REFERENCES public.requests(id);
 W   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_req_id_fkey;
       public          postgres    false    3275    226    225            �           2606    49507 2   requests_details requests_details_weapname_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_weapname_id_fkey FOREIGN KEY (weapname_id) REFERENCES public.weapon_name(id);
 \   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_weapname_id_fkey;
       public          postgres    false    3285    226    229            �           2606    49512    requests requests_pro_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pro_id_fkey FOREIGN KEY (pro_id) REFERENCES public.province(id);
 G   ALTER TABLE ONLY public.requests DROP CONSTRAINT requests_pro_id_fkey;
       public          postgres    false    225    3273    223            �           2606    172233    approvals sub_sudid    FK CONSTRAINT     �   ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT sub_sudid FOREIGN KEY (sub_identity) REFERENCES public.subidentity(sudid) NOT VALID;
 =   ALTER TABLE ONLY public.approvals DROP CONSTRAINT sub_sudid;
       public          postgres    false    216    3287    231            �           2606    49517    users users_approval_det    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_approval_det FOREIGN KEY (approval_det_id) REFERENCES public.approval_destination(id);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_approval_det;
       public          postgres    false    3261    227    214            o   �   x���v
Q���W((M��L�K,((�/K̉OI-.��K,���S��L�Q@�Q(��I�/�,H�Q��(H,*�Ts�	uV�0�QP���fˍ�7�ɕ
`Κ�m@�e7�n�T�Q0"Mk.O:��U76m�ق��3�h�#Dhl:eݍ@�F ^E�`0�ٿ�f��Nh����
� �� ' ֆ      q   W  x���nG��z���F�DW�>9ŀ��\�^��.1|��Γ(���$Л�&5\"iH$�&f8K/C���������߼��_~]]���4�����?�TONS���OR����䤽_wS�d���ʏ��j2��٤��'��*\^/f�ˋ䧹_]\��H#�9����uxӯfW����u��g�t�:��:��f�~E���N�<�������Փ�7)��y#��$fM0,��C�^��{���e�\yd&ˤ��\@�&� 3����+�	���{g�(WT�y�ؿ��������Jpf9��񫣣ţ�����m�O�<8�\��K,g
��6,+�8p[@�6~E�U.��DAuJ��K����0�Os��.� �.��ϴ��~:� k�k�H���7���T,�.�����E R(]LF��0!��L�����bt�������&�;<�?$U��::f� &��̊Ru\D|$�U�C�KH�!��L7<;���0r5� �1��Q��;�����L���T���Q���ى�hxF�� �'��I(��P�D�oHډ�I)"�.i��@6�K�~F�1b��,[�yY�P��"+.!�������������Y<⎃f 7��Ƅ�X.[#!�FCɏ^���x�xg�}.�I�#�U��������j���� �����{�@=��	͟�Ǫ���5O��6w&�%�Ft{^��5��yb�#�.$s\K�1iU�����������]s���58 �Ҿ!���u������IC]��9����\���KD�Z����ZQ�2���t.�N�r/uv����w��eE=��,D״�$�� 4��
�1�����K�`�RO�	ҽ�oA'~h>tFP�m�()��&�����Ҧ���H���W���dhY���kw ̖���K��GT�j!���#�%S)�I��W�@:"�ŜMʅ��(����~���MG�_oc���k���j�!7�v,Y�p���Ȃ��*�>Ǡvb4^��c�&i����E���3JP�*�2�ە�1�9�ȴ��P$χ;1�fÅ0Z�7��٬�ZH��ą0�~*��� �7�?      r     x�E��j�0E��
�P��˲����"`Rh�0�GP�ä4_�vw��s��Zo�[�Zo�Yw�S	��9��جDκz�ʭ|q���x����������'��-a�����ݻ�7�s�kw��M���7Qjc���Y�A�|Ί�SΦ�P�'6���^��QG̵�2T��qȮwm;\�vTK����`�u�u����àƚj��i��[T���9�A��	���%RR���P�߮�� ,HÄXH�Pu��WJ�=�ܘt���d���dn      s   q   x���v
Q���W((M��L�KN,IM�/�T��L�Q �4�}B]�4u�o��X{c��֛]��\�$�7꿱�Ɗ�]7V����{�57[n,����7[@�pq �&G�      u   
   x���          v   m   x���v
Q���W((M��L��Լ����ʂT�����B��O�k���������7��X$7*�Xsc�ͮ��5��<�2�d�*�9
7��l��~��Y	2�� $�C�      x   �   x���v
Q���W((M��L�+(�/��KNU��L�Q ���sS5�}B]�4u�o�������o�W״��$�#�!�ol���f��21r�蚭@�V�i�	Ԙ�m7��lT ���Ɩo6�L�� �zn�      z   �  x��T�N�0����x��qz��JH�Jz]9�+u��d�*תT/BE��O��M�N�-H-�N֚ώ?'�>�����=����M�ٻQ>�����g5Z��zli�X�x�D��y�M�Ia�z4)C��*�g�<����pv4�I�gC7��
�{�{@�r>�@�LS��!u8)��8̼��m�z����ͧf���]^O���c���s�]����E��%�RZ�H���F����Q,�RPÂ%������ٺtv�-U�`Ba BR?�WK�ƾj܁�;�ܯ�	್�)%�`g{��0�I�	C��0�h�EI�ؠ���)����.d2X{���Ķ�9�Ef��Ê	�IL2��$�E�mG�?~q���#�o��oΚ_�es�\v�'(ta������[s��c?�h~��]~�)�SB*�Xĺ��T�B^oKM�'i�4�e�+!q$��D�Xg��E!���h��{\���g^:��̫�$ɿ��zp�(�P����P��8�&c���DT%)�XB�z4�L=q��\���	.$%X��`Mr��e�e��4q���\{��M������ǐmO��E�=i�t�pO�a�U{�,�C�h�����H��O�!��9LN���}���!�qD.Y��x�$h��h ��z���9�����E�i      {   p  x��U�n�6��)xS�.�I"�S90\�Iz(�Zo*iei׋���	�H�"�QH_Ez���u�nS�V~����!ŏ<=��'������[�����r��PX�ҋz@v��[x��.غ��啮�~Y�ju�h�G34�{o��ܵ����y�W��\�V���,!�n�mX�]7 �P� �Z��l�ʊZۻap�:�w�6~}�k=C?�/��Y�C󬃘uk���Fw�l!a�t����'��Xֶ�\�I���-`K`Y˦�p ��/���Szuo��gh�ٽg{׻�"Lk�����a�r�lܪ_(�!�񻳧���YΌ�X��a�I�5U�2M��4<Of(�M.��$�rJ������yV���TB�,lb�R�Ӳ��ЊЦ1��*%1��!BN��	�=
қ����0�I�Y`,۫OG�AF?]��!�m<؟���U_9�΅��nvhϟ���ޖ%gķӫ���vz1�rٮ�����D����D�ǂe����b��ۤʬR��_�E�E�K\fBanSU�J)I��ۣӯ�H�%$���$�Y�J��Y�(e%c�J)-V�(,��X�*ř��I�jٿph�� ���&�7� �����xoSu�ل7.bf�������~ڣ[Jz�X��dKMY�'�>��ƻ��^��T�w�h�0���x7��_�$�}��v!Q⅛��*�s)
7�d�-N/�����r[���*�BTj,Q�f�0,d���T��Ti��@�{&���N7��xZ�(�o��������~�?L/`�}�??�㭸�n�"R�����m��ήa�7���q#>�ը�����8�T�nZ����)I�8�&��GG�nM�      �   �   x���v
Q���W((M��L�+.M�LI�+�,�T�(.M�L�Q Ry���`FQiNIeA����kP������Bpdp���B��O�+�V�0�QP��zc덍7�*�l��q������u�5��<ih�1���7�n6��lDc�M@67�X~�hi�ڕ
@N]�`���F`�o�����m@c�M�v���7b�;��7��;��H7�X	��� s!      |   R  x�՗[o�F���WXQ��j�3{|�W��p>�Md�>al�zѴi��#�Fj����o:�Bծ�t�
	��yF����^�bM��)�X/Qn��F��؛R��~��\�sBͼ�c�j�`k�Q�;6��M�3��o֮��K=��S�������z�|ܿ��50���m{1j����T�UUV��֩Օ�L���F�f�Ul��1�L�[�-�T�P;e�i��e����5�5�$�d$��Y��9+�5o$�	Ђ���g�_���;��^�c'�����^��&^u͜�����uv�S�9|��:� ��?��8'�9�E�-`w�1o�z�	t�D:;��H�KIb�<
�F}^V�ijt�C�����T-h�ו8��g+������ �~���	g@@!~�	DL@�����w�o���C�3��>F�ѯ�����%n���J�]TFɉ�LX3�=�q[X���8�T]�PkʦjÉ��lIZ�+���	g�mm��#B�P���(����6��?���$��~[�GO����m�qy���J�����2m�@�שI�B0d��گ2M�jsgr9Zh⏻V���;��$"B�[�P��8I< ����g���ϻ�Ê��ڰ�H��*67}��/����v����ɘJ6e�`P7ں�s�b���� �b��ZE��!�#���c�U����w�'�w���#Y�'�����=b�FW	':̷������"0=Y0���z�_�����v"W��ɞ��_$E��p�������p��w���;F⾪q���\��J����7P����@����Xg�+�1�Bi�i�Y����ItMdy�{D���H�Sfا���Q����Mw��?�ʁ٥i�+�SA�m�(\,��l�����sR�g�<37 @�� :b�c�f`��=��i-"���q�|;L�~��l+�������@K|��^�t>���n�@8N�=�n|kb�Z/w/���*��^4�M�1c�cڥ8pvXn��
���d�iV�j�iz�(�����r�u%�-��6��F�u�/&���1��"@��_���]Q      ~   O   x���v
Q���W((M��L�+OM,�ϋ�K�MU��L�Q@�s�3�R5�}B]�4u�Ձ�en���5 ;�^     