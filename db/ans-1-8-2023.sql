PGDMP         *                {            weaponidprivate    14.5    14.5 v    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    82227    weaponidprivate    DATABASE     s   CREATE DATABASE weaponidprivate WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1256';
    DROP DATABASE weaponidprivate;
                postgres    false            Q           1247    82229    approval_part    TYPE     I   CREATE TYPE public.approval_part AS ENUM (
    'person',
    'weapon'
);
     DROP TYPE public.approval_part;
       public          postgres    false            T           1247    82234    approval_role    TYPE     S   CREATE TYPE public.approval_role AS ENUM (
    'Prime_mimister',
    'Minister'
);
     DROP TYPE public.approval_role;
       public          postgres    false            W           1247    82240    gender_type    TYPE     E   CREATE TYPE public.gender_type AS ENUM (
    'male',
    'female'
);
    DROP TYPE public.gender_type;
       public          postgres    false            Z           1247    82246    status    TYPE     U   CREATE TYPE public.status AS ENUM (
    'PENDING',
    'APPROVED',
    'DECLINED'
);
    DROP TYPE public.status;
       public          postgres    false            ]           1247    82254 	   user_type    TYPE     e   CREATE TYPE public.user_type AS ENUM (
    'identification_managment',
    'approval_destination'
);
    DROP TYPE public.user_type;
       public          postgres    false            �            1255    82259    fn_status1(integer)    FUNCTION     C  CREATE FUNCTION public.fn_status1(approval_dest_id_par integer) RETURNS TABLE(status integer)
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
       public          postgres    false            �            1255    82260    fn_status2(integer)    FUNCTION     K  CREATE FUNCTION public.fn_status2(sub_identity_par integer) RETURNS TABLE(status integer)
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
       public          postgres    false            �            1259    82261    approval_destination    TABLE     �   CREATE TABLE public.approval_destination (
    id integer NOT NULL,
    destination text NOT NULL,
    role_type smallint NOT NULL,
    approval_part smallint,
    precedence smallint,
    send_sms boolean
);
 (   DROP TABLE public.approval_destination;
       public         heap    postgres    false            �           0    0 %   COLUMN approval_destination.role_type    COMMENT     �   COMMENT ON COLUMN public.approval_destination.role_type IS '0 none -> userType = 1,
1 accept suspense -> userType = 2, 
2 accept reject userType = 2,
3 supervisor userType = 2';
          public          postgres    false    209            �           0    0 &   COLUMN approval_destination.precedence    COMMENT     �   COMMENT ON COLUMN public.approval_destination.precedence IS 'هذا الحقل يبين تسلسل المفارز في منح الموافقات';
          public          postgres    false    209            �           0    0 $   COLUMN approval_destination.send_sms    COMMENT     �   COMMENT ON COLUMN public.approval_destination.send_sms IS 'هل ان هذه المفرزة لديها صلاحية ارسال الرسائل النصية';
          public          postgres    false    209            �            1259    82266    app_person_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.app_person_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.app_person_type_id_seq;
       public          postgres    false    209            �           0    0    app_person_type_id_seq    SEQUENCE OWNED BY     V   ALTER SEQUENCE public.app_person_type_id_seq OWNED BY public.approval_destination.id;
          public          postgres    false    210            �            1259    82267 	   approvals    TABLE     >  CREATE TABLE public.approvals (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    req_details_id uuid NOT NULL,
    approval_dest_id integer,
    approval_part smallint,
    status smallint,
    reason text,
    booknum text,
    bookdate timestamp with time zone,
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by integer,
    updated_at timestamp with time zone DEFAULT now(),
    updated_by integer,
    audit bit(1) DEFAULT (0)::bit(1),
    audit_updated timestamp with time zone,
    sub_identity smallint,
    sms text
);
    DROP TABLE public.approvals;
       public         heap    postgres    false            �            1259    82276 	   biometric    TABLE     C  CREATE TABLE public.biometric (
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
       public         heap    postgres    false            �            1259    82284    cardCLP    SEQUENCE     x   CREATE SEQUENCE public."cardCLP"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;
     DROP SEQUENCE public."cardCLP";
       public          postgres    false            �            1259    82285    cardCLP1    SEQUENCE     s   CREATE SEQUENCE public."cardCLP1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public."cardCLP1";
       public          postgres    false            �            1259    82286    category    TABLE     Q   CREATE TABLE public.category (
    id integer NOT NULL,
    cat text NOT NULL
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    82291    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          postgres    false    215            �           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    216            �            1259    82292    financial_accounts    TABLE     W  CREATE TABLE public.financial_accounts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    req_id uuid,
    note text,
    created_at timestamp with time zone DEFAULT now(),
    created_by integer,
    updated_at timestamp with time zone DEFAULT now(),
    updated_by integer,
    check_num text,
    check_date date,
    id_payment uuid
);
 &   DROP TABLE public.financial_accounts;
       public         heap    postgres    false            �            1259    82300    identification    TABLE     O  CREATE TABLE public.identification (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    req_det_id uuid,
    printtime date,
    idnum text,
    expdate timestamp with time zone,
    permdate timestamp with time zone,
    note text,
    created_at timestamp with time zone DEFAULT now(),
    created_by integer,
    updated_at timestamp with time zone DEFAULT now(),
    updated_by integer,
    is_print smallint DEFAULT 0,
    qr_code text,
    quality bit(1),
    accountant integer,
    is_receive bit(1) DEFAULT (0)::bit(1),
    quality_note text,
    flg bigint,
    img_print text
);
 "   DROP TABLE public.identification;
       public         heap    postgres    false            �           0    0    COLUMN identification.is_print    COMMENT     �  COMMENT ON COLUMN public.identification.is_print IS 'null - print view - الظهور في واجهة الطباعة
0 - ready to print - جاهزة للطباعة ولا تظهر في واجهة الطباعة
1- printed - طبعت بنجاح
2- Error print - خطأ اثناء الطباعة
3- reject quality - تم رفض الجودة بعد الطباعة
4- in print machine - ارسلت الى جهاز الطبع
5- was ignnored - كانت خطأ في الطباعة';
          public          postgres    false    218            �           0    0    COLUMN identification.quality    COMMENT     U   COMMENT ON COLUMN public.identification.quality IS 'false -> error
true -> success';
          public          postgres    false    218            �            1259    82310    information_office    TABLE     S   CREATE TABLE public.information_office (
    id integer NOT NULL,
    name text
);
 &   DROP TABLE public.information_office;
       public         heap    postgres    false            �           0    0    COLUMN information_office.id    COMMENT     D   COMMENT ON COLUMN public.information_office.id IS 'التسلسل';
          public          postgres    false    219            �           0    0    COLUMN information_office.name    COMMENT     �   COMMENT ON COLUMN public.information_office.name IS 'اسم مكتب المعلومات الذي صدرت منه بطاقة السكن';
          public          postgres    false    219            �            1259    82315    informationOffice_id_seq    SEQUENCE     �   ALTER TABLE public.information_office ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."informationOffice_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    82316    license_type    TABLE     w   CREATE TABLE public.license_type (
    id integer NOT NULL,
    license text NOT NULL,
    approving_party smallint
);
     DROP TABLE public.license_type;
       public         heap    postgres    false            �           0    0 #   COLUMN license_type.approving_party    COMMENT        COMMENT ON COLUMN public.license_type.approving_party IS 'جهة الموافقة على الاصدار ويحتوي على ثلاث جهات: 
1- موافقة وزير
2-موافقة مدير الهويات
3-موافقة مدير قسم التسليح';
          public          postgres    false    221            �            1259    82321    license_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.license_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.license_type_id_seq;
       public          postgres    false    221            �           0    0    license_type_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.license_type_id_seq OWNED BY public.license_type.id;
          public          postgres    false    222            �            1259    82322    payment_amount    TABLE     �   CREATE TABLE public.payment_amount (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    payment_text text,
    payment_amount numeric
);
 "   DROP TABLE public.payment_amount;
       public         heap    postgres    false            �            1259    82328    province    TABLE     V   CREATE TABLE public.province (
    id integer NOT NULL,
    pro_name text NOT NULL
);
    DROP TABLE public.province;
       public         heap    postgres    false            �            1259    82333    requests    TABLE     �  CREATE TABLE public.requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name1 text NOT NULL,
    name2 text NOT NULL,
    name3 text NOT NULL,
    name4 text NOT NULL,
    surname text,
    profession text,
    birdate timestamp with time zone NOT NULL,
    gender_type smallint NOT NULL,
    cat_id integer,
    monam1 text NOT NULL,
    monam2 text NOT NULL,
    monam3 text NOT NULL,
    idnum text NOT NULL,
    pro_id integer,
    addresses text NOT NULL,
    phone text NOT NULL,
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by integer,
    updated_at timestamp with time zone DEFAULT now(),
    updated_by integer,
    approv_num text,
    approv_date date
);
    DROP TABLE public.requests;
       public         heap    postgres    false            �           0    0    COLUMN requests.gender_type    COMMENT     F   COMMENT ON COLUMN public.requests.gender_type IS '1- male
2- female';
          public          postgres    false    225            �            1259    82341    requests_details    TABLE       CREATE TABLE public.requests_details (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    req_id uuid NOT NULL,
    license_id integer,
    approval_role smallint,
    name1 text NOT NULL,
    name2 text NOT NULL,
    name3 text NOT NULL,
    name4 text NOT NULL,
    surname text,
    gender_type smallint,
    cat_id integer,
    birdate timestamp with time zone NOT NULL,
    monam1 text NOT NULL,
    monam2 text NOT NULL,
    monam3 text NOT NULL,
    idnum text NOT NULL,
    iss_1 text,
    issdat1 date,
    natnum text,
    iss_2 integer,
    issdat2 timestamp with time zone,
    pro_id integer,
    addresses text NOT NULL,
    nearplace text NOT NULL,
    mahala text NOT NULL,
    zuqaq text NOT NULL,
    dar text NOT NULL,
    djp text,
    numdet text,
    datedet timestamp with time zone,
    phone text NOT NULL,
    weapname_id integer,
    weapnum text,
    wea_hold_per text,
    margin_app text,
    completed smallint,
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by integer,
    updated_at timestamp with time zone DEFAULT now(),
    updated_by integer,
    prev_weapn text,
    archive_num text,
    biometric_id uuid,
    e_fullname text,
    is_entry smallint DEFAULT 0,
    entry_note text,
    identity_type smallint DEFAULT 2
);
 $   DROP TABLE public.requests_details;
       public         heap    postgres    false            �           0    0 %   COLUMN requests_details.approval_role    COMMENT     \   COMMENT ON COLUMN public.requests_details.approval_role IS '1- Prime_minister
2- Minister';
          public          postgres    false    226            �           0    0 #   COLUMN requests_details.gender_type    COMMENT     N   COMMENT ON COLUMN public.requests_details.gender_type IS '1- male
2- female';
          public          postgres    false    226            �           0    0 !   COLUMN requests_details.completed    COMMENT     \   COMMENT ON COLUMN public.requests_details.completed IS '0- decline
1- approval
2- pending';
          public          postgres    false    226            �           0    0     COLUMN requests_details.is_entry    COMMENT     Z   COMMENT ON COLUMN public.requests_details.is_entry IS '1- اصادق
2- لا اصادق';
          public          postgres    false    226            �           0    0 %   COLUMN requests_details.identity_type    COMMENT     e   COMMENT ON COLUMN public.requests_details.identity_type IS '1 - حيازة
2-  حيازة وحمل';
          public          postgres    false    226            �            1259    82351    weapon_name    TABLE     {   CREATE TABLE public.weapon_name (
    id integer NOT NULL,
    weapon_name text NOT NULL,
    weapon_size text NOT NULL
);
    DROP TABLE public.weapon_name;
       public         heap    postgres    false            �            1259    82356    printer    VIEW     �  CREATE VIEW public.printer AS
 SELECT f.id,
    f.req_id,
    f.license_id,
    f.approval_role,
    f.name1,
    f.name2,
    f.name3,
    f.name4,
    f.surname,
    f.gender_type,
    f.cat_id,
    f.birdate,
    f.monam1,
    f.monam2,
    f.monam3,
    f.idnum,
    f.iss_1,
    f.issdat1,
    f.natnum,
    f.issdat2,
    f.pro_id,
    f.addresses,
    f.nearplace,
    f.mahala,
    f.zuqaq,
    f.dar,
    f.djp,
    f.numdet,
    f.datedet,
    f.phone,
    f.weapname_id,
    f.weapnum,
    f.wea_hold_per,
    f.margin_app,
    f.completed,
    f.note,
    f.created_at,
    f.created_by,
    f.updated_at,
    f.updated_by,
    f.prev_weapn,
    f.archive_num,
    f.biometric_id,
    f.e_fullname,
    f.is_entry,
    f.entry_note,
    f.identity_type,
    f.fullname,
    f.fullmonam,
    f.weapon_name_num,
    f.weapon_size,
    f.cat,
    f.pro_name,
    f.license,
    f.approv_num,
    f.approv_date,
    f.pict,
    f.id_identification,
    f.req_det_id,
    f.printtime,
    f.expdate,
    f.permdate,
    f.note1,
    f.creat_identification,
    f.creatby_identification,
    f.update_identification,
    f.update_by_identification,
    f.is_print,
    f.qr_code,
    f.quality,
    f.accountant,
    f.idnum1,
    f.is_receive,
    f.quality_note,
    f.flg,
    f.img_print
   FROM ( SELECT requests_details.id,
            requests_details.req_id,
            requests_details.license_id,
            requests_details.approval_role,
            requests_details.name1,
            requests_details.name2,
            requests_details.name3,
            requests_details.name4,
            requests_details.surname,
            requests_details.gender_type,
            requests_details.cat_id,
            requests_details.birdate,
            requests_details.monam1,
            requests_details.monam2,
            requests_details.monam3,
            requests_details.idnum,
            requests_details.iss_1,
            requests_details.issdat1,
            requests_details.natnum,
            requests_details.issdat2,
            requests_details.pro_id,
            requests_details.addresses,
            requests_details.nearplace,
            requests_details.mahala,
            requests_details.zuqaq,
            requests_details.dar,
            requests_details.djp,
            requests_details.numdet,
            requests_details.datedet,
            requests_details.phone,
            requests_details.weapname_id,
            requests_details.weapnum,
            requests_details.wea_hold_per,
            requests_details.margin_app,
            requests_details.completed,
            requests_details.note,
            requests_details.created_at,
            requests_details.created_by,
            requests_details.updated_at,
            requests_details.updated_by,
            requests_details.prev_weapn,
            requests_details.archive_num,
            requests_details.biometric_id,
            requests_details.e_fullname,
            requests_details.is_entry,
            requests_details.entry_note,
            requests_details.identity_type,
            ((((((requests_details.name1 || ' '::text) || requests_details.name2) || ' '::text) || requests_details.name3) || ' '::text) || requests_details.name4) AS fullname,
            ((((requests_details.monam1 || ' '::text) || requests_details.monam2) || ' '::text) || requests_details.monam3) AS fullmonam,
            ((weapon_name.weapon_name || ' '::text) || requests_details.weapnum) AS weapon_name_num,
            weapon_name.weapon_size,
            category.cat,
            province.pro_name,
            license_type.license,
            requests.approv_num,
            requests.approv_date,
            biometric.pict,
            identification.id AS id_identification,
            identification.req_det_id,
            identification.printtime,
            identification.expdate,
            identification.permdate,
            identification.note AS note1,
            identification.created_at AS creat_identification,
            identification.created_by AS creatby_identification,
            identification.updated_at AS update_identification,
            identification.updated_by AS update_by_identification,
            identification.is_print,
            identification.qr_code,
            identification.quality,
            identification.accountant,
            identification.idnum AS idnum1,
            identification.is_receive,
            identification.quality_note,
            identification.flg,
            identification.img_print
           FROM (((((((public.requests_details
             JOIN public.biometric ON ((biometric.id = requests_details.biometric_id)))
             LEFT JOIN public.identification ON ((requests_details.id = identification.req_det_id)))
             JOIN public.requests ON ((requests_details.req_id = requests.id)))
             LEFT JOIN public.weapon_name ON ((requests_details.weapname_id = weapon_name.id)))
             JOIN public.province ON ((requests_details.pro_id = province.id)))
             JOIN public.category ON ((requests_details.cat_id = category.id)))
             JOIN public.license_type ON ((requests_details.license_id = license_type.id)))) f
  WHERE ((f.completed = 1) AND ((f.is_print <> 1) OR (f.is_print IS NULL)));
    DROP VIEW public.printer;
       public          postgres    false    218    227    227    227    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    226    225    225    225    224    224    221    221    218    218    218    218    218    218    218    218    218    218    218    218    218    218    218    218    218    218    215    215    212    212            �            1259    82361    province_id_seq    SEQUENCE     �   CREATE SEQUENCE public.province_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.province_id_seq;
       public          postgres    false    224            �           0    0    province_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.province_id_seq OWNED BY public.province.id;
          public          postgres    false    229            �            1259    82362    subidentity    TABLE     �   CREATE TABLE public.subidentity (
    sudid smallint NOT NULL,
    sudname text,
    sudrultype smallint,
    validity smallint,
    send_sms boolean
);
    DROP TABLE public.subidentity;
       public         heap    postgres    false            �           0    0    COLUMN subidentity.sudid    COMMENT     @   COMMENT ON COLUMN public.subidentity.sudid IS 'التسلسل';
          public          postgres    false    230            �           0    0    COLUMN subidentity.sudname    COMMENT     w   COMMENT ON COLUMN public.subidentity.sudname IS 'اسم الجهة التابعة الى مديرية الهويات';
          public          postgres    false    230            �           0    0    COLUMN subidentity.sudrultype    COMMENT     �   COMMENT ON COLUMN public.subidentity.sudrultype IS 'الصلاحية الخاصة بالجهة 
-غير مؤثر
-رفض
-وغيرها
0 none -> userType = 1,
1 accept suspense -> userType = 2, 
2 accept reject userType = 1,2
3 supervisor userType = 1';
          public          postgres    false    230            �           0    0    COLUMN subidentity.validity    COMMENT     �   COMMENT ON COLUMN public.subidentity.validity IS ': الصلاحية وتحتوي على ثلاثة انواع
1- مدقق
2-قانونية
3-مصرح
4- مدير هويات';
          public          postgres    false    230            �           0    0    COLUMN subidentity.send_sms    COMMENT        COMMENT ON COLUMN public.subidentity.send_sms IS 'هل توجد لدية صلاحية ارسال الرسائل النصية';
          public          postgres    false    230            �            1259    82367    subidentity_sudid_seq    SEQUENCE     �   ALTER TABLE public.subidentity ALTER COLUMN sudid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.subidentity_sudid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    230            �            1259    82368    users    TABLE     t  CREATE TABLE public.users (
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
          public          postgres    false    232            �            1259    82376    users_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    232            �            1259    82377    weapon_name_id_seq    SEQUENCE     �   CREATE SEQUENCE public.weapon_name_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.weapon_name_id_seq;
       public          postgres    false    227            �           0    0    weapon_name_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.weapon_name_id_seq OWNED BY public.weapon_name.id;
          public          postgres    false    234            �           2604    82378    approval_destination id    DEFAULT     }   ALTER TABLE ONLY public.approval_destination ALTER COLUMN id SET DEFAULT nextval('public.app_person_type_id_seq'::regclass);
 F   ALTER TABLE public.approval_destination ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    209            �           2604    82379    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215            �           2604    82380    license_type id    DEFAULT     r   ALTER TABLE ONLY public.license_type ALTER COLUMN id SET DEFAULT nextval('public.license_type_id_seq'::regclass);
 >   ALTER TABLE public.license_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221            �           2604    82381    province id    DEFAULT     j   ALTER TABLE ONLY public.province ALTER COLUMN id SET DEFAULT nextval('public.province_id_seq'::regclass);
 :   ALTER TABLE public.province ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    224            �           2604    82382    weapon_name id    DEFAULT     p   ALTER TABLE ONLY public.weapon_name ALTER COLUMN id SET DEFAULT nextval('public.weapon_name_id_seq'::regclass);
 =   ALTER TABLE public.weapon_name ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    227            �          0    82261    approval_destination 
   TABLE DATA           o   COPY public.approval_destination (id, destination, role_type, approval_part, precedence, send_sms) FROM stdin;
    public          postgres    false    209   )�       �          0    82267 	   approvals 
   TABLE DATA           �   COPY public.approvals (id, req_details_id, approval_dest_id, approval_part, status, reason, booknum, bookdate, note, created_at, created_by, updated_at, updated_by, audit, audit_updated, sub_identity, sms) FROM stdin;
    public          postgres    false    211   ı       �          0    82276 	   biometric 
   TABLE DATA           }   COPY public.biometric (id, pict, iris, fing_dat, fing_xml, note, created_at, created_by, updated_at, updated_by) FROM stdin;
    public          postgres    false    212   ��       �          0    82286    category 
   TABLE DATA           +   COPY public.category (id, cat) FROM stdin;
    public          postgres    false    215   /�       �          0    82292    financial_accounts 
   TABLE DATA           �   COPY public.financial_accounts (id, req_id, note, created_at, created_by, updated_at, updated_by, check_num, check_date, id_payment) FROM stdin;
    public          postgres    false    217   ��       �          0    82300    identification 
   TABLE DATA           �   COPY public.identification (id, req_det_id, printtime, idnum, expdate, permdate, note, created_at, created_by, updated_at, updated_by, is_print, qr_code, quality, accountant, is_receive, quality_note, flg, img_print) FROM stdin;
    public          postgres    false    218   	�       �          0    82310    information_office 
   TABLE DATA           6   COPY public.information_office (id, name) FROM stdin;
    public          postgres    false    219   u�      �          0    82316    license_type 
   TABLE DATA           D   COPY public.license_type (id, license, approving_party) FROM stdin;
    public          postgres    false    221   �      �          0    82322    payment_amount 
   TABLE DATA           J   COPY public.payment_amount (id, payment_text, payment_amount) FROM stdin;
    public          postgres    false    223   O�      �          0    82328    province 
   TABLE DATA           0   COPY public.province (id, pro_name) FROM stdin;
    public          postgres    false    224   ��      �          0    82333    requests 
   TABLE DATA           �   COPY public.requests (id, name1, name2, name3, name4, surname, profession, birdate, gender_type, cat_id, monam1, monam2, monam3, idnum, pro_id, addresses, phone, note, created_at, created_by, updated_at, updated_by, approv_num, approv_date) FROM stdin;
    public          postgres    false    225   w�      �          0    82341    requests_details 
   TABLE DATA           �  COPY public.requests_details (id, req_id, license_id, approval_role, name1, name2, name3, name4, surname, gender_type, cat_id, birdate, monam1, monam2, monam3, idnum, iss_1, issdat1, natnum, iss_2, issdat2, pro_id, addresses, nearplace, mahala, zuqaq, dar, djp, numdet, datedet, phone, weapname_id, weapnum, wea_hold_per, margin_app, completed, note, created_at, created_by, updated_at, updated_by, prev_weapn, archive_num, biometric_id, e_fullname, is_entry, entry_note, identity_type) FROM stdin;
    public          postgres    false    226   ��      �          0    82362    subidentity 
   TABLE DATA           U   COPY public.subidentity (sudid, sudname, sudrultype, validity, send_sms) FROM stdin;
    public          postgres    false    230   g�      �          0    82368    users 
   TABLE DATA           �   COPY public.users (id, approval_det_id, name, username, password, user_type, roles, activation, created_at, first_enter, sudid) FROM stdin;
    public          postgres    false    232   �      �          0    82351    weapon_name 
   TABLE DATA           C   COPY public.weapon_name (id, weapon_name, weapon_size) FROM stdin;
    public          postgres    false    227   ��      �           0    0    app_person_type_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.app_person_type_id_seq', 8, true);
          public          postgres    false    210            �           0    0    cardCLP    SEQUENCE SET     8   SELECT pg_catalog.setval('public."cardCLP"', 42, true);
          public          postgres    false    213            �           0    0    cardCLP1    SEQUENCE SET     9   SELECT pg_catalog.setval('public."cardCLP1"', 1, false);
          public          postgres    false    214            �           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 11, true);
          public          postgres    false    216            �           0    0    informationOffice_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."informationOffice_id_seq"', 4, true);
          public          postgres    false    220            �           0    0    license_type_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.license_type_id_seq', 5, true);
          public          postgres    false    222            �           0    0    province_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.province_id_seq', 19, true);
          public          postgres    false    229            �           0    0    subidentity_sudid_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.subidentity_sudid_seq', 9, true);
          public          postgres    false    231            �           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 25, true);
          public          postgres    false    233            �           0    0    weapon_name_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.weapon_name_id_seq', 4, true);
          public          postgres    false    234            �           2606    82385 )   approval_destination app_person_type_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.approval_destination
    ADD CONSTRAINT app_person_type_pkey PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.approval_destination DROP CONSTRAINT app_person_type_pkey;
       public            postgres    false    209            �           2606    82387    biometric biometric_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.biometric
    ADD CONSTRAINT biometric_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.biometric DROP CONSTRAINT biometric_pkey;
       public            postgres    false    212            �           2606    82389    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    215            �           2606    82391 *   financial_accounts financial_accounts_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.financial_accounts
    ADD CONSTRAINT financial_accounts_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.financial_accounts DROP CONSTRAINT financial_accounts_pkey;
       public            postgres    false    217            �           2606    82393 "   identification identification_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.identification
    ADD CONSTRAINT identification_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.identification DROP CONSTRAINT identification_pkey;
       public            postgres    false    218            �           2606    82395    license_type license_type_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.license_type
    ADD CONSTRAINT license_type_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.license_type DROP CONSTRAINT license_type_pkey;
       public            postgres    false    221            �           2606    82397 "   payment_amount payment_amount_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.payment_amount
    ADD CONSTRAINT payment_amount_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.payment_amount DROP CONSTRAINT payment_amount_pkey;
       public            postgres    false    223            �           2606    82399    province province_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.province DROP CONSTRAINT province_pkey;
       public            postgres    false    224            �           2606    82401 &   requests_details requests_details_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_pkey;
       public            postgres    false    226            �           2606    82403    requests requests_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.requests DROP CONSTRAINT requests_pkey;
       public            postgres    false    225            �           2606    82405    subidentity subidentity_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.subidentity
    ADD CONSTRAINT subidentity_pkey PRIMARY KEY (sudid);
 F   ALTER TABLE ONLY public.subidentity DROP CONSTRAINT subidentity_pkey;
       public            postgres    false    230            �           2606    82407    users users_namen_key 
   CONSTRAINT     P   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_namen_key UNIQUE (name);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_namen_key;
       public            postgres    false    232            �           2606    82409    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    232            �           2606    82411    users users_usernamen_key 
   CONSTRAINT     X   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_usernamen_key UNIQUE (username);
 C   ALTER TABLE ONLY public.users DROP CONSTRAINT users_usernamen_key;
       public            postgres    false    232            �           2606    82413     approvals weapon_approvalsn_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT weapon_approvalsn_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.approvals DROP CONSTRAINT weapon_approvalsn_pkey;
       public            postgres    false    211            �           2606    82415    weapon_name weapon_name_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.weapon_name
    ADD CONSTRAINT weapon_name_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.weapon_name DROP CONSTRAINT weapon_name_pkey;
       public            postgres    false    227            �           2606    82416    financial_accounts payment_key    FK CONSTRAINT     �   ALTER TABLE ONLY public.financial_accounts
    ADD CONSTRAINT payment_key FOREIGN KEY (id_payment) REFERENCES public.payment_amount(id);
 H   ALTER TABLE ONLY public.financial_accounts DROP CONSTRAINT payment_key;
       public          postgres    false    3297    217    223            �           2606    82421    requests requests_cat_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES public.category(id);
 G   ALTER TABLE ONLY public.requests DROP CONSTRAINT requests_cat_id_fkey;
       public          postgres    false    225    215    3289            �           2606    82426 -   requests_details requests_details_cat_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES public.category(id);
 W   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_cat_id_fkey;
       public          postgres    false    215    3289    226            �           2606    82431 1   requests_details requests_details_license_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_license_id_fkey FOREIGN KEY (license_id) REFERENCES public.license_type(id);
 [   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_license_id_fkey;
       public          postgres    false    226    3295    221            �           2606    82436 -   requests_details requests_details_pro_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_pro_id_fkey FOREIGN KEY (pro_id) REFERENCES public.province(id);
 W   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_pro_id_fkey;
       public          postgres    false    3299    224    226            �           2606    82441 -   requests_details requests_details_req_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_req_id_fkey FOREIGN KEY (req_id) REFERENCES public.requests(id);
 W   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_req_id_fkey;
       public          postgres    false    3301    225    226            �           2606    82446 2   requests_details requests_details_weapname_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.requests_details
    ADD CONSTRAINT requests_details_weapname_id_fkey FOREIGN KEY (weapname_id) REFERENCES public.weapon_name(id);
 \   ALTER TABLE ONLY public.requests_details DROP CONSTRAINT requests_details_weapname_id_fkey;
       public          postgres    false    3305    227    226            �           2606    82451    requests requests_pro_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pro_id_fkey FOREIGN KEY (pro_id) REFERENCES public.province(id);
 G   ALTER TABLE ONLY public.requests DROP CONSTRAINT requests_pro_id_fkey;
       public          postgres    false    224    3299    225            �           2606    82456    approvals sub_sudid    FK CONSTRAINT     �   ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT sub_sudid FOREIGN KEY (sub_identity) REFERENCES public.subidentity(sudid) NOT VALID;
 =   ALTER TABLE ONLY public.approvals DROP CONSTRAINT sub_sudid;
       public          postgres    false    230    3307    211            �           2606    82461    users users_approval_det    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_approval_det FOREIGN KEY (approval_det_id) REFERENCES public.approval_destination(id);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_approval_det;
       public          postgres    false    209    3283    232            �   �   x�]NA
�0<g_�Ɗ>Ƴ/��Rhb��(į���IREd�e�������	�:훲.:���l�eur4zAĳ���_��.w���3u�:�]��&N":��`�A�fMVK��P4�q^<p��ONyߔpF      �   �  x��ZK�#�]sN�{#�����h�ߕ o�h�����7�$h<��M���%�{��*vW� �D�D�|�2�ŋ����D	J��0�
���r�m��1�))j��$T�w�S�JI���8~h��_��z��!ޱf��UF�i}8��A��+�1����p`:P܋7�ø�>N�>���h]�(�V�4���U9k���N۠�	�V��l�l��v?g������$���Z7՛ש��bl�@�w���:~w���Kh�>��ct��F�{�]w��Pѽ�d�()�ؓ���uֱ mR4���)).d��s��0l����R7����yg����)7Z*ͳw�yPb��9{մ����6��qq����;h�6�US|^"Uj��U�7դR7F�b)6�
�a�/�q������{̎���=/ִ�U��6�����j�pi���BdR�-�RV�ƪ:V�K�%��{��)mX�n��>��?�|��t��#��`�^��֯D���K�#���B\��LT�Gi�[v�o�A��Ӈ�F���=�xwz�?�;}�ߏ�o����'�e��_�k�Iw� �(cU0FkcB��[�h��Ͼ�q-<d�)�{��Iڛ��U2S|�&)1E�7����R��a���1�,��K9��IǟN��l?�{�۟�z�0��Wh�/V��[�*��Dk(�\BT��H��j�wѷ���5�pԕ�6���+�N���<��Z��̘�`#nF�$q+>}�l�c%��ٱ���-�X�:�7p`~�q[j�`��ڽA�[�0�9�M�c�J�������+�IJݥm��ߙ�0�(��&�f�2��s*��(x�T �X�J��b����6
�j�`�
�����������%�X��t�����l[2"2�Bo�`���i^�`�'��V+�::��w���A�C|bA'F��X+��|�߯���I��D������L!�NlW\�~z���S�K�쬋�m� �}�?$S;�9�R��3���
��Gx���^�Q0�V�T��cP h�>�(�*��D9癚��y%G�̳`�4��ߓXYQԕ��F����o�`�H0�1�AI)��6������;�FCh�*�)�H�<���[.��Ì���(f�H1-x��6�����b�G(�L���o0��/Ơ\9F��
�T����(��S�6W��6
�޳��Dื�F��k+����j��ќEņa"�Zr��s�oH��8����#�gX��)>��H��E�G5��b�QU���Nk೫���*��a�H��i�T�ᢼnA�V��v��~:�v�y�_�8q���/�#�{fr2�_�/D
Zk�*�Q��&,���)�j8�md���F��3^�����;��?�t��?����*�)>S��=�E+��U��t��9�	E��
ߦ���'�?�_����L�/^���z5���Mr4,BƔ�q"�L����N��$�3	�����K�4D�=����V�3v�P�	��7H�%iϊ�H݅��i��z�G�hm ����W��~�O}͈�١��υ ��,+k��]2�7~u?s���������@��ȝ���
��J��SK��D�C:���Ô�j����+o���o��Ow���ߞ��n�{{��h�2w�����A �|��;�SAOS��1���������ߗ1E&���f4Y��FS|��T{��)�w�����ON��į��͟�|%BSM�����JOfEJ��<�r/͡1���`�s����R_�K��7+z����!�y`X�O,R�-S���d�Xb��U�Elu޷����.��}pV���2>��V�Vl!Np�E�ѥMḦ́ZDg�c�XS��c5LR�X0\�船	�wx���2�rޣ�؅U]��DK�QŸ1�����V��J�P�����wY�	��#�j|�	�#j}�ۑM֎-�}E�$7�+�b�6�Y��;T��>��&fߡ��$�N�|��o�}��5K��/&���j�Z����V��1��Rݥ`�� 4F%Q*2(�L+�'?�~-���6�͍��MJ\6����vg�X�{���p	��/sG�)[ƭ�y��gގ�1cgܐCQ�PTVJ�
�FG̴���7�^�G@cCղ�s����Ijv�#{�h~�0d�*g��pJ��6�v#`t;�{b��p�Y��rKX�iJ��-��16�66+�%�M�+73kePz&��(t
�Ѽ��_��pY�Ҫl0(I���;�X'��4�z�9cm�dtk��y5��N̐'����8�ð�t�ʴ7�$q�+kKg�g(/~]�����,ī�E[7�}L��yt
�	���9�h�o�7���P� ca���9v�%4�'מC���M�7R�`5(tJ�ҢOmc�?��D���@��U1�'��J+��9����x��WhJ)��ثޑ�� |bt"=F�2���\B�u�N'�t��n�bϖ�\���q\�/:G��u��E�^��*�q��\�$k7���0A�-d�h�4�\.���OdJV��H��ő��"���F�����[Ȍ'<x���b}5���I5���yl1�l�Zs�ٺ��F�R{��l5�!cy?l���%��E�o�5&��P3ɢՇ�a)���}�����<�7��=?��2��es|�|e�-�nhR-x�U)%��ťm\��.|�#�7n������0�EH�ߥ���t�ޛ�5�آ�����|{����}�������V��xO�8\F��-C�q ;L�oY6|���H�q�!�[�����}ϸԜ�ǘ ����`�$���
X��W�h<U�90��q׌�����7��xD�4�SV�ӘVc5�����9)�|X|Tɸ��bR��Fjm$r?D>��;��(���i�9~W+� +@{��ͧ���U�tk�ǃũJT�H�G�L|��oY"4D��F��V�L�
FF1Y�؊8Ki���p��ipҲ�ʕ�1F�@�htw4W����W�w���f      �   l
  x���Knd�D�W�����L�"�
ބ_�x����C��V����T�-�yէ^�77�L.M�FHn��̹�:����V��۶K�׶����RV,q��������?��|���7_���eM9����>_����ն۳l�Wװ�4��1W^�X�^Cs�F�Ҟ�ٶ�tKkcJˡ?V�I�K���bѧs��/6�-�&��ѵ�K%w�V*΋�"�����k��pٔM�{g��sx�cm�kl1߬����O��K�A���d�Ф��U����۵��U]k��� h��\zY}r������Y*2�ph#��ˢ[^�K-��=�I�D����c�%����w�	[�����~Vk?��[6
E�A{��:�H#j���R�MIM��l�kS��r(��f������t���fKq���p��4I}��:�J�K[3��;Q��[&*%t��W�5ˈt�.t��DB��Vz�Gk�_&��˭��	���Zm�=��c�����c˖0��W�3���K��%������l*�gi�w���9�j�@��~jm�^H	u���tg����"�	�p���I!?�c�N��n�:ྺ	�oB���gо��j�%��`4g�h�mï�-H�J^�f�.�J����7xw���J�~�޼e)�������8����_���ڧhJAǾj'.#f���5X��CKD�7/��oB+9<M��u��$SMP&B@@ ���jJ:è1���B���DA6~�^�"�c��}��%��<M���5A�4
gm�cȫ�:���5��.-ϵ"Y���t54a�y���U~Z���~^>�T`���qZ�"�1��3����U8�4W����ܣH��y����b�$d����yw��o�uR��îI{�cq�) �'(�@egU瑷��Aj�X*�nQ|����~�p�3-O�qrl(�����:%�V�2�z���lR[�'e�3\��O�q��M��rOr+���O؞m8��iK*!ۈt�)
~�l���kF4Wg�*a٨L�/N�S/4�@�=��7I����5|��xش#TP�[��w����-hYU�������4HkTd�NB�%�#/߾c+2Bq�.c�Z4�Q���L!�4�N���uQM#5uQ�����/Ű �w~���������o��=aR�@��i߼�}�'��I,o=��$I�$$=�j�T�C�Rھ*�t�Q+�:R�&���Ψ5�.��I^�Q�%�N�C��[���S�p$ǽ]3��� �v%�S�,:�/�D5���k��"���7���_�Ɇ��~'������p����(��%���[K����B�]�?6�R���x�~4�^��N��m�0=����} 4�ҎMjj�&�_Fr�����y�����]��ἇ�l���w��]�E���,�J�㠮Q)"�Vn�v�#=��^�^8���p_��eIB�z��#w<���#����5�C���ݎ�ık�vT@@���\`�m�B�٘t�홀�S���"�fj!ǟ��xh��E5:��!���l�5|�ղ�'v(W�NmP�:��q ̠����#���R,�>��qh���@�i^�v���ӂ㏩� ���1@����p���
N��f@�)}5�)ջ�[IP]�ڃ�W�1��*�☙b�~9���fm_��d�(7�6�8��c���_e>s�oGC��G����Q��|C_�_g���ǚw�����؟Ic�Z 7���0nJ��1']K�}�ؠ�׏�4��FU�v^,賞JҾఝu�@EǨ�
�N��n�i����~سa����By��W�ˎKn�� �IG��a,vH�����Bo"�8��U��(#�R�J����W�y�z�~��$���.!)Å�4�M�D�7��e���#y?�}����M��>��)�|��`�����_ׁ6[���P���F��4t�-�v���+bx6}�!(�i�ي��6��>wj"�`y�O����5b������͢'�������1]��t�n����e2R�hN�}\?s�sh�7���2���/��x�+�Օ#S���2�ɒ�/_q�x�z�`���`���af�Ἵ�ll�lR#�[<1�#݌#U�C����𭝌B�꡴Ԗ{�=[f��Wx��)����pϹy�U���������b¾��}����vc䭈��eRG2�Ť��P3N�a�Z�N��� �`Lʘؐ�	s����D���q,x���G��E;���R�fvl�G5WĚ_tb�[�1k�ztv F?���a���N$�3����M$"�y��I��mPN&�O�)������l�ٓ�
�>Z+�M��n#����^0Z�NX�3Mt�:�4�J�%�ɗr��G%���+�5�IH�l�1��=�2 ը^?B{���/{歓gz����>�.��_�_[sP�Xr&��1c�%s-����y;Z��T�cl6��İS���N�L^�SsA
���溬Y�}"���X�����%B�3��vt8ô�B���}� 6�U��'��N���i��MCa����X\|{��R�n)4r���wl�%@W����_!�� [�g&9��z�8�j9/dlM��)�S���Ԙ_UN�7fF���T:̖��-gQy3s/�^^^�����      �   �   x�E���@D��*����I�D�����B%�n���w��4�i���e��F��l\5�1��Lv�>�'�)Ӓ��1��}x\MF&���I��c^��~�����Đ�f5���c��5�f<��V�b4��x�N�	'����4Ղ��s��L[��D�Y��      �      x������ � �      �      x������J������=��j�h�5l6����'������H���y=����F��5F��Ĉ�'�#�?���j<�k�*��4B�H�O
F�bD��*��XA�Ud��@ �'D���A!��S0�c����� �_��n�O��_�?^���Ŀ`��Pȟ��z����7�!����?x[W�)8�U���Q�����ֻ4`;�P�(K�E��W8Nn
7U���#��Nh�R|�|����� T��1����ߣV��b���B!�o��Tܙ#B�=���ECv�"�;�ԛ�҇��2�B�+)f����C��1��g����_�7k*�����ɳ�"���;c��S�m�q����exk��L>�YχR������ +�_�s2��{}�)�'�ZF~�{����a?	j�������ޓ�~���������6�ilv��?_�{G����W���������������Rf�?{���w(�������>�9n��qW��_���	��s9��W���'#��0�k��?_#Lа2#�INͿ�Ήw����R��|�ύm��|�X��Mٟ1(���y��?�׾�����4�1�)����_'���^����7���@�9=������~<��x���O��H�/��{{0����;h^a��>��}����Fy?���i�,�����Fb�@�F�^�^�������^�]���Qp���Kq���1�wێ���5�r�g��������u9FQ������{�X�r���r����?̞clS�foX�F��;�/�2��^W����S���'�'���dO��s7���8��
!v!Ry�mf��j��6%VӟH�R;v%�ip��7�đ0�͘����R���1���qk�?}���?r���m���6��}�˿��b��M��9�1��=��ᙷ}Fq�ya쓟V�5�a�kd��C*�Y>��Fk��y��"$�F��%_�$��l�̕߉�����KB��j4�C�{����Y�^S�ň���dd��x�����f<Ї����i)P�K"���$܌�4�0�����.(Zl�p��Ύ &T�y���3�Te!�u�ڋװi��K~f�Ԁ���%�'5���s�8Y�(��*"��,�4��FB�6W�u�NhC�
��9��P��'{j.,���m���Ҝ	���(�plթ�ם��A�u]$ G�k�}u��	a�2@	��\�B�֊q�6��Y��,���3y�:������Y��m��t�u�wh��bi)�Ԣ���v�=붃U8�_�.�i}�,���ߺCa �uʜ��5�,I��ٵh���{M���Cg�7̣�㙵S9�'<�t��k�csY���w��8��;�[w_�*�i(��2Z|_hx-�����d���̺!�g�����)��CE��J�&��\��N�NO;_,�ywBS�Tyd���С��}*x�F�O�we���Fu�P̒���CҬf�Q��ѿS�㢡[O�a�WKs��i�４v�g�$]{9��<�!8�6�]���j�=\�M;�r�A��=�:jY��p�9S}#�	��)�!�e�Q0��H/�j�����f����&���X?���h����+&�G�I�NX���X���_" ��?�$�)�ڻ(
�$��^b2�%jRr�2G<WQ���:H��;������W#�R��j���V�q���Ҍz&�='`��t��pJ�8°���5[_[v]��y~�9w�~�qLu�| A�&�U��a.A����Y�#<H��� ݥuu.�)D�c��`���P��of ��/��ʁ���)�浾��OX{9y��SD��b�0�2�+ʪ1˰%8N��n�uk¡���L&�����\�A%�#9ܪ�'��s���� }�������D�,Y�����*	�̵VF�$d"�95���F}��d�'g��Qr�+T�2��lT�ͬ3��&�׸P̪0V~&~�z�2q�T$nU��� ��fh�h�S;r���>��� ��#��M����?����r��{`cԘt�<Χ�:uj��/�uWI
�ҍh�g�g��L��l�(��_�i�����U��&f�j��p�wF�����4��`w�0W���S�hC���$�	��/���.ѕ���.!*���i"Z}��3��S;t�d_����nC��n��QG���8U�^�7�$w����|S��+�7�0<S�p����� cdR��L{݇@�95O�u�rO;�+7�!C3x�J�V���"�܉.�:��$	km�x���	�zb�dcQQ�﫾�{Th���K�AZ裘��gM�r$�b"vE����$fE������,��!�Z/��G��fs�ϐ���Q�:Ц���R�~�c���������-V��㫗�N�| DG�w�*���x�h�Z��t8�x�P��=h)��*U�����G���h���!r���Z�sj�i���g+�#[W���kH��S��4ne���Tn���>D�ƻ�c�h�*�oĿ_��^�.��G�W�(͚��W�Q������7᚝���n������Sß8�l��V�Ǒ�R=���uo�&|��-�=�R�^�p���ֲ=��1C���2+����I���_i�mzݫ�#����;��9U�}ۀ�x���+j��~�� W-�Q�C�B[��<p<��$g�$�&����;�d��S�h�K<؅t��m9��~ʌj��&�ywjv��t��"��;I)�����cST[
*�M����	0S0�(�<���(�:�$ą�f ��^��6�=6"��Q�ʎ�dM��˒.��t�T�uϾ���I��y��%b�AI����/�o_��2A��b�29��7_o��9�'DP����sQ��U5]��F �G�	�N"�se# �%������h�S^��]�? �mHb���?'�n�F,�C]���&��h�:�s�C��U'n�ѷ���Y)7�4��i���z��xǫO;��dJ��T��D������}�� ��[��Vܟ������K/&z�UE\�h_�p��Hy:��Ԝ�>=0|5�;ڙ��.�1��$
�!d(���~���R�	���.̳u&}��z�-��� ��t�D��B)B�^�����K�9�bhu�f�!f��蛒�=�(j�c���Y}?��ܸO1�Kb��BL�+d�ۍ�T�S��G��;��\��+��t��	{��]2{5ҧ0�K�4Ь�����5f�*x^�\X<"�@��V8��ɚn^-�*_�m�	:�����Q��e����n�{;�l�:�,�yY/�!B ��X�,k�<]>��sчE3C��_:;"��9!ی��Ӏ�d��T�`@��� "���Q�&o�T��Mh���|����*����R������Ҹ�xy��X�2��0~}~Ԟ.���=�tM:����#ؾ�ЭO�x��e����]|BŢ
���~�b��<]����|=*�etr>BKL������ɣ{�����ԨyY���v=~g���|#?������"�L�ԹҚ2h�^�i��Xݸ���[�b)�M�ՠ�]�n��|Y��O��Y������%�[�Yc��j ��\�x�*5�:����(R���s=A�K[��	u�3��g��'�'U� )���$�����Xǋ������}�<����;�zz��eY���~[p���K��MnOU� �I�ۓ����S��Q^猝R�&��-w��G{|����w�i��8{v���׷/I{9�GP���gA�E�KX����,P2+��FDB�A�^����;,��'�2��!1��� ��]?pu�n�oVH�^���o����P,~+��Ǒ���uWxk޽���lcJ[ܷ?_x�$��0���ښ͹��J���Sg�ʅ"	���2�Dr�<��i-u�WD~����l�Ԧ�7���f�2QR;�ӱ�I��
G��n��IZ2�z���ݍ�`��o�͌����nI����8tKU��ԙS��ʟ�ȿǉ�Ҁ^vb3!D�W�f��M`�m����    O'|g��-�B{��eR�'�Jn��H�G
}�@L~E|��}Qh>z����yV���4O�׉r���&ύ���q����+��{���H_��\�74�� `,?ԥ��!�S��`�zKy�_�N�ђlIt
M)t��2)X��7�oaÒp�/��☯����$�$�O_�H���N>�K�?�W�]� �WÈ�T��"�ž�S��r��a;x�+�"�*vQr��1@����Bڡ�>	M����W�*�9���������Ϸyaj[��f�I���ġ������z�����9��i�F��fl �3�T�<��SbH�A���]�}�!�ܰ�y�h6dg�ֻқ�1%U����*D�*U�fʨ& D�$��� r���ʙU��%���N�^����xo{��ÖKJm�[���puX�u]
��A��r�U�?���]ū;;��Բ�E��-��'u>`�9��u�.�a�U���DE-;�M{��+cn꨹��uz����\o�DD^>-:�0��Hb���T׍&apS��,�~2�h� ��yek|�@<\�f�k��y���ꯓ�8"{�J���F�c��R���
$I�_�~qs��@=*�7L#ր��X�1�4��=���w�����Ո���qT0��u^DB!����ce����O�2��l�؆\)@<�\I���gr�Mr������!��f��sy>�4 � �!��w�i�rL� '�*˲a�=(#��F �V�d�`�)!�Î���Qu��W���D�fq�HeF$�umH����jggnT��}Tu�6��o���P�a�PI��Ř{c�f_�v|:���n�{Зo�����d�宙����x'1d״�teg»M	���Z- ����[t��ԟx?#��9����"K��PW���ʪY�>��;$'c��\ݔ�X�*8GacǺf4���P��'{�,r�������	�=�b`��E�;��)�e���Y�sC�����X8�B�ÐaD��9�J+z���W����l*��1�5��W�n�ө��!�p0_��%�p��:�"=X�������~8��vۯ�qQ�]��m��&,N~���H y�M�>È�"O\1�,gF���O�l��-��s��$��;��w��MHo��d�l`�����k��������t�y@A���D���S���r0ƾ���/�<�̐}��B8�EX�ONM��;/ ��B5���p�k
Y��}��E�O��lr�tm �Zƛ?�wH"�����{��t�l�W�SiV�M�cͯ�U֒#��S <㰻=��2 ���R�਺���QyP[��(B_����p�6ױA�=��dB���wX�R��u��r�޻c:��?:)��S��K}ѻu�WM��I�d����^��a�2}N���Q~9R{~,�[�@
���H�̪j'�kGh�˶:A�d����'���Fy�Ssu��P���6*��9��>�w��H8̑M�����ɮ� 
�>@	�����# �w�gݺ!�н�s{+d˽EF�ۏ�����H����jC�v9�#�2�Q3)W��Y�x�50�cX�}�՞�Y
Ɉ�9�?2�]��,#��ԾV^9��l��W�}���2�!������:ҳ��װ��m�)K�𩐇�i���F�љ��F��5���&ۢl�oe�a"�Z�	oq߷��=u^��gRB���B����"*z���D���3���Fe��7<i�+m~�v����@�ů���{Q*v��ӁuxӼ8V��]}r��8��P�zȰ(j�E�S08�[�$���(vP��;C8~���!7cA�̝=���xa�.�	���rX�F�1כUhc��W���V��]�O�> ��%F=��/�~}E��jl����g��"�N1]  ��s@�.�u�xeP»��Z�HI?a7���������
":��v�7�k"�3���j�W$�﮲���cn�㊱��� �U���\:�f��,0�#��X[��\��h�8���DM?t��^?�l������\b�S��9��Ѵ�۽`�>���ک�-�H�h/	�U���2N���gR��ɵ�fiL�/V�Q�o��������m�*�e����S<�'��-��9�ui����r���i��tHw�Y���c�]�h\��Y������Ԏ���7D{���PZ6�W�S{!�zsFZ����Hg��F.�r��=d�~N��x��/�*y�\�2��_�N|J��ޙ�$`L���Z�.E6V��Q�/�Z;.YE�n4��UZ�v�^�9�_���m��y�������9:wڈT�gY�+\���˝ �\5�]v���2~��3����fv�Ink�O�ӽ<8�k�ӷ���f�:�]�&�Hr0SP+�8�<��Ͳ�q8G�_�l���g�
���b�P	��B#O|CU� R�;�}h�C�^�2�Vn�!���������Qz/��/�!��� z�F�+r���3�L�I"Y��gW����|�� �v�ո���!�R�Hs������e�!}~i�|��}ךt�tۉ�f��P�Ykng#<�������%��$���6,0��-~x�JoK�K�WA
R������B�脎��E<�=q�g	�ٷ�c����U����W;x�v�*��{�sm����	����+�z{Y%��ܣ�nEc.����Є�I�s��Kū�j_�b����yEQN�>I[����E��J�d�U3ʛH�~D�\���qcN.O�KQ
�R���= �xp��'q��V�{]
�}%�v�fY�qjȴ����dDu��+z�[�ԵUBc{�܂Ʌ���R<�xu O��6�OT�M� 3&���o�
rm3��s�[G�Y���ڶ��;�.pdd/���p	��+����m^����\`
��8?�=�_[])�}���W8=N�FA�z�B�޽�]�?�ńrEP맷ّ_vc���|��v8Q��<�6�)=� ��3��8�_r�,���J=�WKnõ�?>�$=��]%��B�e74�����&��H(_���0XDz�;[������yހ۲���>��ƏV�`l�u�%�6r�NK���	-��v�>�W�V���P���)݅�@�ܿ���%La���e�X����g��cd�t�Ծ�d���}��w��Ͼ�K��1���S�z,��7�p9�Rr��o���d�r!>�䭣��}G(�ca7A��4?I4v&�Y�W<�dY�{��4'sa�v��1�WTJ�=�����7��i�Oǐ����i�8x� ��H��=D��}��'x8VYz�צ�&G�χ�E����ݫ�<;��Uw��E������F�iWg���p;9I�o*e��pR6�I3�I:u��o��/�q*���or�	�F�ᱯ��:���Y���T�ws3��h���~	�j��P�=�pP ����.?�+�/���QD��n�)H��z*�����ak�~�1v�3.�n��z�u40���z�p�9B��밉��^0��f�A���E+1���uf�}w�����qW�[6�����{�����n3��*��<�TU�v�%� sϽ��[{�r}5��Ȟ{�'}�������"�}�y�~e��ӣ�����B����b�-���޲�ªr��6ۭo�O�l쫴�k1Qe��@��?����ESZ���~ׄ`)�4(GG��v&"v2��'�p-v�X��f�u�j0+x:�WD�U�hG�y���1�!(?���H���/�g�t���ꕡ_���	�'S�̜uN99��8/�0�5����k?����IӢ����pt�orQ���{�
v��߬�=oL?&��^�Ê���:���?�s�߮��1o�I���X�8�����M{�nQscRH�]�e�e&�x$ݧ�cXt���1��˸��*DOeL��U�	��7�p˹����de�"4�A���-j�K�������c��q�hx>u�b��K���s��?r�r��ڢ^H𔮈���Ji�f�jgIt� !شSKR��H.    �/��zō�@i�k\}cY�_�ъ����� P�.��r�&.U�9j� ���r��N�0���^_q�.v)��7Hn�Q#m+��܎�
�����Q1K�Y�A��t�-���1�&���O�^3�|p��{�W���H�S绢�y$�MKv_�x(�/`��aCuo�!kk׆;�0���z�3b��&,'���k 6r��k������C������g;��o��[�~��nK*��W�*�ɡK��X���O`KT	rǚXN�}�m���]�`�x~�U���g�ӥ��T�Z���8wb�'�l�����ߩ�?+^=���Ľ�t�������(�χ�G�7��������4�R'4xr���],�[�Jq��8]qDtam�d��@lu����ZT���FN�D����ؔb2>[Q��O<�� ���(Fy�<H-�g�OJn�z�􋼪7��J�a� T�]uיiF�սN��FCi�Þ�k��f��[Q����(�!3t�m��Y&�̂Gu��n�#ΐ^M]^�#x`�E�,)$R�g�%-�u���_M��Zí:k�Ӷ��e�7楥�x�v�6�yS��#�s̊��tvG�/�Y��#2?DK�����h�h:%厯wehb�{�������W�յ03����3a�RP^Ȧ��B��(
���	}����Q��.��'�J�̓?H�6����Yi�9���[���G.��=ji�'�M��t��i'�^U =3ߤ(�?:�5�})�R�O��b5<�+ݧ�d������������W�J��?��&]Ay��b��.ЀB��������wR�W�P��,6�U�l��\8S1%�'w
��b%	��6�h6����ELת��{�*�W�����q����9 A%�
�ц�G���	�ZuKg٣$�
�m`�pP�*S����D��xW 2s�1�P=�_WDFA�� ߐ�?��Y/nōʭ�E�.�!�b9���.�XÝ�sD�ɒ1܌w�ŷG���6�Z)%�7����:9���M����R����6}&����w�3��	�Um#	02�^�%Eܑc�����L&�)�c�G%αl�3`�sZa#4s��~Gt@�SyXV5�
<�����h�nP6�;��d�:�~��u,��6Z�7���٧�����o���%�\��Ie�S�T%�i5��tQg]����|a��؝̴�{�,�u�Vq4EBqz���?n���$�����+����>8��)� �i$jm�(�:v����UN+���VI4*IM�oc]�F�,x�j��CEc�:?�lN�G~���GT�g�,9|r�`�����p�ڡ5T�i6��2�a�!F�4�����Ne.`S�z+Ct�Ʒ��%(?�H֫[M���sM���V�$ox�"��ˋ޳Y6���q>�J��(�Fnɦ�붇�5qk7Ӎ�g �w݂�/7�Q��(�?/-Sqnɒ�*s�D�Ɠ<w�A�!�f�o /c����ħ��h�u������n��Oz&!n�
��Ć-�D��zr��9u�b��We1F����+��՜�;��M��, ~�|ۛ�?��Dۦ����X i�D��
�L�~�T/��{f-��"����򀋒s"�#��><�Sa�	ޮ��w�:ۤ���xq�⠓���`��[q��}�	���_������U.ɒ��9�5L� =��T0?$�CL/9���10sUJ�T?�\�X����p���,�CВս��o"��)��^��=���WI�P`�hx�yF���Mϫ��B�!��f>Bz�a v[/�ئ!0p;���/G�?U�_g�b�{�30|��I��Զy����=D�/b���UD ��޶�KЎ���~��f@Y3P�e�G�A��4a��ot���1�ٯ�X�\2+U�S��<�x?HR�i�?SǢj&˅(;���" �w�����*_@�a�4|9}T�)mz.�p��;�u�(��IL���e0�U���
.}$���>�<1�F'@l$��b�R��B�@����|���߆!�i�y+9�蝬�oU�MQ_���=�=~S5KH�H5�J�?�"�{%<vz���9�����m|���!�7C7P#���9G�'
W��O,�dw���*M�nLSGG7�昡�/�����a
Q�G�`e��qyO��g�ER:��=֞��:�S�94UL���n�p�">6I{d��N9�ԯ��\�~����7�B�'�Q~��	R=K�7ߙ�H-j��[x83C�8u&d^����,�}�v�J�C]c�,��2�@^�,�^Ԏ7Y��>�ܸ�h�9��>*�`Sd�L"y^=𰭞ஶ�k?5�)d��_��$�ZV��2_����,�����3o����º5���28�S�~�kG��&�ӆ�y`���?o!���|��K�_G2�ʵ�����]+�X��纐5"��f�p2� %3�!��>�!�M��ц&���b��*���FG# ���%�(�P��̟CQ��cR��
g��ĉWc����O�E�OQ�]j�[�2Ze��R=箔�ր�5H��Zq����nD�������|�����W����~_�,���ҳ�^��f��l���Ss�%z���0;	�
!�ZI��S]�Ŧ�Z��˛_�T"o�ej�0'Ƅ�|�,��(Ԅ��\v��h]�����O�r�z�!���7)�&� �@:�49~3�ݠ�D�����a3��O���uzI,)��Gv�{�F��>,޿�7�0�'����9bK���3+�{��E�j5B�l��f�.E���Q^DMq�
�x�uh�3}�΄�+-�=�ˍD�1;:��3/j�"�
<��O{�caj2}�����,N}b.FAX��e9��$�+�mz�0D창 �-��sx��oE��L���.3��H/h����0�)�l�r`\�]y��������>�l����E�J�˝�9��x��U1\��!�Jðw��מC�)�(I���.���q���J;����N|��B�u�fY�i}f�;y����aJ�����C!��d�7H�Yjƃ6�ʵ?�@��33<�0�.���VqDV�U��QO=⥜�Df59~��i�uЬ����D���X�zy�H$6/���z:|1�lR�$t���"�.����m�pp0_:CNZ�UU�uP+s Y� ��>�,�~;��*�M1ȧv/��>��l�2T�5�Cx�fW� �꺿��2AX����qǍCk`�R����(�[�G�~����l����ŀN�Y��~�8���=b|��!so/�Հ�Ķ[����zX�G5�Q�=H��B��~gD2d����Mj3O7�BKI4��4�QdӨ�K+q� ��u�7Z���GP��}b��q	�'�������t���&���<�]P�>������P�c�h�@y��{۩��TU���L��$�E=��p������<�������^�� �r��L�'Hς�\�Ά�\A u+3�, �f��H��}�t�%p�u�r]�� 3[�:Z���ض<ⴀer��g�T���6�5}���\�~�}:}t�3\,6~����eQ��*��_�o�;�����<���ȡ��V~�^=��r����L�*��}���ݘAPVFu	�ʓ���x��ߌ@����C�4}c�[:ޒ�o�#���������]��_��b�̕m�_d�(6��mj��n�3��V�XoN�3tPt!�&��ĪD��:S�8��=����Ã,��tp�̯���Ȳb���|[���-|_�]�{J�֐4������6+�&�}���{��/��E2����iwAN�[��:0��8oJ�[��h���xF�^�[r$C����O�-C������s���}���!���/S_f���jJ
H� {9Uz��q��%�"����(a���=����Fc�K�o0z�b��a����}�U��Ma���ZVu��,Բ'1���@�|Qci���P"�,:�KJg�:	+ �.���姶*��qo�����LU�h)<��*^�
_��8��3�D ���!�jso�vc�f^R���	��<�C��2��    l��o���#����҄�	߈�4��n��'L)2�%{t���n�^�޵oɩ�ê�CT2]K��l�I�g���L���%�~$7�j�	���$�ګ�HI��AдH�����t���ش_���g�:n�U�,�c�I��j)j/��tE�)���/�4^���ҟC8^��xA�2����=$��Z.z���W������X�6s��q�!Ɗ"�]ϟ𻣀�r�5/蓵$R�4����|�1����-MGc��`��T�Q&�T���~�/�o��`�P�cR{Y{�$q� /�fI]�S��@�>�_�Ǧ��Ri!�;d$#�33�e|o�o�Jv}������W���tFN,�߆�n#�b��+Xَ��%��$F����+���d�����?���Ix��Y��}y�:T�Y{g�Z�i�؅��O �d&��"�e$��%�;٘�fr�����G�:���?�F-�k��Q�?��'��H��_���}�=<�d�U�\%��h�!�AG�<������Y�'�㥴��x}S�.�T������iBv����A۸4S@������;3�S��"�;����g������}Cj+�^ �%�s��"�d�\���}�h?7���fM���������>]d���
�/�H��jOa��e�#��ˡP�_�A�խ��x"�y|5m`�4a�쟨�qF�7O� �ݚ�s����?}�+�|ٲ�49�|�IM�L���rk�qض��������Z��:U�?�"�rKe��<�J�����N�j ȩ"��gWUz�a�b�\���@f��=���P.���WH�*�������<�[�(� �4��93#����?�#��Ȓ�_�[��xrQ[6.�&��#�^S|�u����	=M�碑C-|��\��C>]I��F��%nLV�+�� h�����ߨ)��1��QNn@�ҳ��emH->�2D��0�Ҁ��C�7+ p�" �50�p�S$'���tR���2�o�zu�Q�A�^�܈\�h+	?#��9�����v�Y�t�o�6�_�
��B��Ap9������b$�����Ɗ�A�ss?�\�`?�C�s�\c���V��=�x���D�A�G|V�։�G�]�fBO�	�{{����Q��"�~E��Ր�5g�)�����*����lU��َ>d�:�Y;���j<��m��"F��2fM'�������7z�,n�HbB��YN 9L:t�	}u���e������Ҵ�M�bGTLc��J#��<և�;�m�f`��|O������1 {��PI��w�4WX�_s��,q3#Y�᜞n��&%�����9o�jo���׵{f���kZ޶�q�61g[����+��e��y� ���9����i(�u�!A�;��&6=�Y�>� ����q��0���3�'��O�F�+ C�f��~l��5w�[Lwd.�p	�C���/d0�\<��K�c/HC+hI��T�W��9��j�=U�,|H�=e������9�1�o�x�_&�d��f-�ʓaW=n|�;+���L�S�Z�h�u�E���$U(K�������=T�ۻ�"p��E�.�ʘq�$�Y�䘼�8?�E�����]CI�����S}*Q���s�3��]�҉��I��Ϗa�bl�q'Y�[��A�{������B�y1ÏF�̭���]��N�:�[fd����5P��'?P@�v�ء�V�X�(�My���������q���q�9g޶�1�âK�'�\]��n����/Q�C��T w�K��������N�ڇd~:\��Z�R�h���9������ �GG,}����� �b=�%آD��<pEiJ~l���C�LM퇋�Hz���Ʈ�0����)���fP�	�g���?��w[���fo9���]�΄�����qkd�W�n���5��]m��l�7�_+�:�:6��^zH70���hI����, %H���0KV�*~��:?^����ҕ���?�x�0{�}5v�w\3��(���`�úD�Ó�K�^_��,�����y>�6F�du+�;\}�'�b���y�6�u6u�X\�@��z��i3�fΉ�(x��$܏ Z=�_f~�	�5���p���2_*UN���G�rUv�T���d>�Zص�,�Y��l�6N�L�oZ��]Ϯ��rveՈ��i[�a�|�2Ylaҙ���[���#ʼ�Xa�M���K hҥț�R
v�-&�◧�Z�n��SN柆�5����T�.�tA���sd�O���n5&'���ٮ�h�	N�̛��)G3���xs�{t%+c3(�uHe�=k%{���EIbE!��n;�vL���!<-|�F���Rٔ��) �7��~.:}���D���Ώ�Mx�#���W�� �It@|��ï�[�n�3��JRn"�����źj]�r�'g���Uȡ�+ r�_�O3_|Q����=+	���޴�h�"Qu�ٌle�j{䫋��(����.��mt(�'�''��::�x���/�e�l�;t�6ç��5}\�S!���M
��p,�d��j�|WRk;:�;;�D龞�a��>H�RN�ٹ3�Lz ,�&��֗���Gs�B���:�̀�ڤ�!28��ls���W�v�ю��3��F`��^l���ѫ��d�����a�.Nq��`��A�������"�d߈�N[��v��wW��-@*��_�ZS~���*�|7�L�5��^%�=@�;o^1��l�/c5
<�yY�6�/]���ĝ� V*'�tޱ��$$�q�g�Z�|��(�/ɵ��1渤�M�#e�8�1������yZ�����Y�Y>�����d�@m�ƈh;��Lr˯t�Gȯ�,|-�PF�gq/`� �n��U,Ɇ才"K>u�2�n����7Mm� �}�|n�P�7�����W$��������a6Q[�
n��p�uBZ�ϰ&�����ĚW���FX��_��w���X�ߊ}���`�rW.������
6ZS\$���׮�?��pr8]ʹ�����,a@�����w��"gw�����|�Gp�D�⇄�|�<����� S�
R_������QH&��|�i�\��)��[��ro2f'�����v9��)T���|!�Ǉg�����L)�g�ώԨ��Q��,-/�E�#A4�d�0?�dKU���_E��L��vm��s�V�%���a�O�K�M��<K*��,���Nd��)	j����+�\��c��v�oJ��ǖ��y���#։�p��B��MJW�h�����Z젽(����ծ��$�$��^��|C���N��Fz��mdшƀ�Ί�����%��o]!�`��a$"��$&���\�G|��b�}��e$x<b2�d�6��>hv�^ G��rX�l_{M��%<5'a�:���ZV�
$�dƅw��z��]�臘��7�d�n�_-�����24'I�F����R��RyC�t},�,=;�,��x9�a�t` �=��i�l1��nC`�X���d;hH���-�*�C6�7.vֽh(�q�>�o����d�ڹ2�s��VRߦ��ܽX�M�4�^Wnۭ���R*!l���K}=�d<�1����u����}m��86��R��I���i����^�N���5�i��݆`b��}�I[��q^��c�m_�F��dS�V��V�*�Gb���Y^~����wB��q�i��I�}Z���|��V��	dU��0&���o�&D)��Q��e�,���ŷ��;ߔw�&�5�R�*��#^BY҅�j�����9��v
�P]��0:�w>�CڢS���.ٔ	�E_���(w�!=��kh^6�C���j�u��o<U�-E ��373�c�S
PǊ��fLft	��i�a�0�*���v��m�B�|g���NEy���K� ˚��D1��~*�oV�yՖ%���ٳY�~�,1��]"GSiq�p��PG�L��^o��ft�n"������    ��VG@��/?s�.Q
���y¦Z;��j��~�6�s�6s_�ڽ��N���x`���3���Sabd@�v�5�7��w/�L����.sG"�3\��'�^M�>ҡ{)F�K��� �0~����W�`�wppt��`�C�b�G|�l�8�Y4θ��pbN��ʀA3�(�;�"�k�X��6���jkY۹�ʗ�He��7�5L~9�GP�3��,��D��p����7Vp�|���B��޹�V��ѷ��oţ_��M;�|0���.��_�ЍΏ��c�	�,�0`��h+ASlw��z��ȡ���}s�d߯��oWj�w/��hù�3ZDf��d��>�����7�&ք��6����h/�i���s��!��"`ѲTbP��#a��FBv3h�Ja��_K��_aT�鲵"IF����֎H|T5���\��5K��E���1z�i��#�Ä�k��.�B���qQ@" ��G�����A�|�TY{����_sb�0U?0e������C�g�|{h��Ft�da�'���=&��4�_��^u���7�sIB��(��*ه�Bk�A��k_fr�Yjг�8�+�@�ed�r��0�qL�/Q'�t�*P��I��̔.M&�B�5��߶CV���]&[�Yq�X�qb�հ�5�po�P�8_���{y�ȓ�#;|���3!u �=���I����*_���OJq�,c�wC��c�˘�;o�p��(�����#rS߳$�z��-�[�iR����8��-tцUEK�,5֙&�PH�m�_���e�2�9��D��s��gg�3�O#�m�{���o��Y:>������5��d&�Ս��k+х�%�z��3�$t^ɞ��F�W ���M��[;.G��W�D�_�e%�R�X�%%C��)_����B9�B�{�	MY7��5]T0%������t@WE%&���&�Z��o�F���!5(3U�e�*�l]%��f��xm�盍?RX��-U"��C�h��4 �,$?�K���f����]+��8�$��ٌ�Ӡ�"8�YQ�D;ģ��V����|Qd$�H6���ptx�CC�R��s�,a-
i�y*Rbg� R.L�G)���sVٛA�������4-��5#>��5����_�Ge���������?d�G�@6t����Z�8m�_��� _�G�0*Ƒ�tqow�/Tԧ�dQ'��R͵}ڊ>]�|TgG�-7t��y
���V��b�(0XF�Df
��A��y�Oq�4�E�ͲTt+�D��{F7z��4u�JO���V��b�:Ƭ��QI�Lk�����y�;�c�,����)��^֮��pnF�
�$��3�B��˒6��z4�ѐӉ7l�˥�nX��_;4�V]b�\'��9�}@��Z?m�K6�FA�1��]����~݊���(���+=���ѿuk������8�/�(����5���@]�t��U(Yb.�o�-q����`��� 
\��4��8=�.(;��^Q#K�i��c��$]��J"1��l�
+��1��fݙ�ⱶ	!���qs٦��' �E��5s"�ƛ(��m��
.�ɠ����4��x���9�6��o�3�Y1"#y<J�Tbe�o�%�=��΃��ܷۯ6R,y.�K�������kh퍙�L*�m��� ��d��PVV�ם�w(� 
E�G�����WH���g�z���)?�q�g$g�=T诳1i,��%���,�>i8�O���d�ON��v��떢�>��34=�&��|}Xo^���p��;�1�V�ԾIE)�$O3'~T$��'�����/1Q�b�����LA�H��������}�7�*ob Yd��~���*ߚ-?�)88�2Z2k�P+��0~H��{.�TqP�V�&�l 1�v�кp\��l]�t"��v�]C�/��_w��@�_.�v�C�!x6I�$���4�q!��π��,�:���ǔ�ޱ�;�����~���&g���q�l� �.M�����2����)�÷[9o��v٘m��K͒㫒����+um�_��.��
�a��#�|��M��ŁC�/�FU�H�ݍld�8C^��b���.IyΨ(خl��#��)�]������,Q��DE*N�L&e�>C���� ��NɊJ҅9A��5Kh��Ƅ%��n�LqBKdi�ni���7�Il�0������H�q��L/��V��ҧϊC�]���BVt�=A�8���<-��iY�D>�x��L�:!E�hj+��#�<4���U11؋�-�H��u��L|�e�yvZ�*��q$G��+�Ø�Q�<Cl�2�jH�(�QAWUX��� ��s��2��[z�hГ��>����
T���"���V�ws#.�ӎ�M�bh8I��\G� �
|�e�^��%����Ve�^+���OݤN�&��/��ӱ4������+�
����&����	+گ���c���Y��[ J�q۴M�l���")��Vĩzv�q��}M9%�w*eRf���;>k`�P�`0�x%O��ܱ�:�k��I��#g��b�F�@0�HZqtB�{U��)�� �����
nAW���J%���2�l�;R�J0��hA�}T��Z��bP��O�緣�"rgqM[�k�����q�d�Ld�2�R,�E˅%f�R�>!��Y�/�R[j�b�gؑ���+����o��4�VS��G����%�� ���n���=>�l�Wom�qܰj��2��µ�6>�r�V��i<�oJ�O���oۼ����5&~��G���A��r/�wI�i�k��;:?N����Cj�S+��ajo�y?���9��HO�p���|���E����j���cX���b,���	�c�Z>4��@=��I�e홗�#�q��G�K�k��E6̦W|h�A�|HW���2[md�E]zAx�{1��77	5E[��S^ܕOhZTF����D����i�����N]�,�c)����4nk䫟ԥt_j[��Jç��iB' 0����3�R>F�!;�\�m����k/�E,ᯯ]��7W�����6�9�����҅�$�\0Ҟ�g sF!j*{��ί>�����#Z2�N�orM��@���?3o����J(�+�y�Q� �D��o��%#/	ȋB���=���w�hbP@|~�/k#}0��2�1�d����X^د96S�lg
���z6L�H��L�Vl�#H18��W�_�V�2���>z|���ZD�sgL�Y��/<���4�X1��e_�����hy&cn����I'g�~�Qݶ^�3�TE���*�G��T-�@
a��gGlq&miQ�����:�(��w�Ti}�jۼ��A&9����u�e#��~"
B��Sob�K��ҬBڵ?�����#�,2]LgkV���j�ip�Er�򷨻����o�٢�۶\�u�M3߃��9y
�KZ!�!��ňPuş|w
�nB�#�4i�) Fi��r��MDSE��Kt=�gq���#g�3I�lX	���{�Fx�k���'m��(�%/����Q>�@�\�Q�d&	������EB���h�|��۾����m����W\H��fv�y3����Ŵy��w�b�>�&�U�)�/gh��%0��D ��%�N@�HA�"�s^Ma�,"ff���"RfQs�#�F�~Ю�ZGC��\����F�D�^��T�ӕx�.ɢXuɆ�@��j �n)����^'|X�1ީKr>m��U�`���:��dZ;���h��:ji�(���m� #֜��gFE�y�'��b	�ˍv -�T0�'}��������ҳL�	fG����B�q|Ȑ*&�K#� �0~š�&Ҍ����s����i�u���b{t�T����m� ��G�2nG�?J��B}R�b�Q��ua%�I�nd��Ⱦ��|�8���]?x��F������+PJ�����g�(�K���u�r�Af�q�h�;�V"�Mߵ���]�� z�S����}$	��Գ��19	��]�=�{��6�g��o޼x������Q�M4o|dcF6[�0�zb    wT�\6r��&�	�T�)�
)�Z��vWi�c������S���SV���B���`|i���DNo�e��;^wԒ�j
���jߵ^ۍ�0מ��ts���v��N���@Uw&�76	����GM���~�,�T����R���M�,����]��v6�2�:2����?D�w�Ԅ�-�|D	�A��#{b�ա�T^jۖ�H��Z	BGA�8[L��}�qu�&w00��!�F"˭���/P-��t+#6@۔Ck�m��lO⏧2D�"�c6-_�Y�փNJG'0��냹��t�Q�7F�T�1#��H��^��o���������
l3W�J�`3䟛ה�(������@��e�2Sqħ͋������{�/�*O��ߴ��Ԍ�����x���o��[m�Z�m��,@C���#LNI��7k�i���7�vw(A(}�X4B9�t�O��q4JO��&�l.�8�)�j����wPLg9���'���o# c6�@@����ֿ &����$�8q5�C>��ZfԂ�G�ud�(@��C��)}�����̩�sF���G^$��\�U������f����g��(��_��M�<5 z��7]��_��<�%s��3����e:�$U6��s�D���'!���� v�w�)"���8�K�rq����۲���#F��s*�7�ϫa~���O�z�\�H�aS-���@�C�R��V'�#��Ē�W��NQ+\��~EaI@��Ҥ��qRz�|P?�m���1��n�ȏTn%�߰ض��@�a3�ftv7-�}yu~q���tv^L�c�X�ʝ�0�����+~X��7^�N���tEf-N>�l��}�A��DC�<�>�ʜ�I'1Iv����[�U�&G
�)��(��h��DҝZ{��+�e	"}}J;O�e�����"�������`�r��y�C�6I��:-5�9r�B�P"B�x������mOu������1�b����]��;=Ow�5/EA(QX�\�(�H��Ɣ�ƕ�9����~>ho�x6��*�qV�������148��]lvw�B �� k;��)Y�ap�g�rqm�߫y�gfX��8�����8M��1,:y'���r��v�;٧�)<1��yQ�Q�	�>�ۧrS�X~a�]4��C_�C)�5��#��_UuZ=�݌R�Z��5�f�d�k�r+������]�T�t�-���BM|�O|�hF ��з�T/�����옴���燠o4��~��;w9���*D-�OT�gF~��`�Z/mj�N؃	��\���Nq+?��F���+��q�mi�$�tW�a��b�GЉ��Y�����2�𿷣9Tڍ�MAbb����%�{Zk1�Z�o-SC�l}���zk&j?�)�o�,�M����aGĔ
7���6��6dn�"��nHH���Nmp�X���OC'J��X�Z
�/�W?�AH���W�;�s1a�>F^�-6��wYӴ�}}ml�M�h��:�}����\��X�6�ے[q��B! F�>6B��7��/*�8^����E�9���	�'p���;8���6��AA;���`��Y��.�
EHK���V��[K���OQn�+I���&W�«L
F��m�BV�H,��fr6���Y&�0�̓��P�5$�$�=�TD���� g�Q[��.�Rc��f�(aoҖi&��6��q�5q�H��%�A$��aQb���%�z<�%��`�r��4&{���6	���~��c��gBV����s���\�(��0/��I�1/C��mi�C^9ʖA�*3��4A9J���9^�7s��X%��6�rV�y��oo�c�� �4uD.��U&%,��3�pD<:˙��������o����C�1
2��N�\U>�v�����[��p�bռN�S	)���8JS^wW�c�m���;�EK�"CY���)OA��.���n�u�%�����<���>2�iv!����j[����>9�q�c}��.k��\>g]'~ł��<�x�vx%\0�]�G Χ$��e�_�Nk�2�,.���tp��kK�Q���\��T�2b`�i�X RV�
u�"\����U���b�ͫy��/�:�p�e�
��N��/Zl����rk
�f@���%�`{^N�>�?k�`t"̈����j���]�����WX��<�����{ms�&Z�v���H!:Is�պ-?Q+@��Zb+�3�faO�z���q���ʢ�JWVo/^ll��wKs27��T�
Y�抅����9p^CðNMz���w*z�o>�f܉��**T�2���r_�ݹ@�Z�����e0Fz��e3�d�����SE__l���A@�p�g�'ﰛܟ��ĕ�9h�Y#�v� ~l��m�c�7�J�}�J1�+��|��!�r����#����
3�#�me;�6���f��������^��|��,�x����P�\��W�v���F�r�¬���^��3!�������>㛵'��V��]�㱫I�~��!]��5���Ƿ�y�~�:"K�x_�j� W�S`��ש���f;w��d�Z�i���/���$l��V�������=&��F��Ҳ�	�C�W�5���k���)�C��� 9�|�LJ�(�Y$%����q��2�����o�]?��H:��17ގJr�5`���%�qs"�|���-��e��W61��4��aʼE��|��S6o�BDn���`�����$�� � ��fdp&��/Z�_���~d��Q�-S��bg"�Q�V؛ۿ������o�Y��V�e!�`e�="��KH]MΙ��I����$��;���� 7rn��k�⎷��Ι�~����_�f*��`KQ����yIh����&h�N[�X�梲���nyi,Q�R�����}p�aƄ綞A	&6�.���J��-�
Uez�Jv�(
5��}���	d��8�<�bে��`������glWo�k}�B	�����j��>B���-�&BT�j��J�l��bo���=�b�����$��V��ܧ����C�=�k��r,����'�H�;��t��E��]��.A�"��备x����^���K{�,�t����ֻ	��t�M��d���~J��$b4��UV�"�n�?�mXA���2����snAZ�IYvi�˥��sȂN���k|?���m�e�R�%���{��߆a��C���bS���}Z�s�'��8�gD@�O�Q�~>��9��<dӍUuжϡ�>?�I�����գ�Z�qSL�;�p�{�]Z�7���Ng�7�B�w25����5���\걋��Zp8��.,���K%2ƧB��Ee�>� 6�Bf�p�\a+�#��+^o�0�e��C�*?���_��0�ye�̓|���o�fkԨ[�)/(/OPt,N ��������9�c�9�Z�ⷡ�᳟�t8��X�k-=��� �m�o������#��:�2N{��@7t�?�.s�]��G/��U�K�8,���侮��I�.]���!��m-%���w�v�Z�uԭ�<{��R쪧y���'%m����	U.������{ȅ1�π1���hIA;�7����zNs�t��VU���
_�� ��{}�����.�{T V�`�kM�}|I���r&����w�_<E�u]�A��k%@Ŧ�S��݆LDR�n��P���8h=��q���C\3B�%+��O��v�!E�z��lUɞ.�0U���(�^ӑ��w*n�+_��j,���E�3R��|Ӕ+//Ή�߷���'Fon���y�3��0�?@_���إ"���ZT�uK��̶�����l&�.娜�˸���0�OWji����+����> �m�<�KŪ��n����ј�%�:�h**��)`�u�y(t�D�
�+ሉN@��`�r@�m�����{�wL�`��mc�ggH�ț�)g�>)���T,�K��'�D/_=F�h�8��q�$_�= mr��wSQ�7�YuL�ك���|�\�\��i�O    �Е��,_?܉�_�Z���N�R�fgد������n�#���`)2�c��IwN�/�����ߞ����Bh��$�ߒ�]Ļ�g��ItS
��~3����sC�AE��~��ڶ+�V��mIk(K��=5�U��w[��Bz޵��A9��&5pU��n���A�o����,	>^fL���c<�!"�;J�d|�m�cfP�����U����t6��_�>H]�\9fiR�QLV���K�ɞ��{.��%F��X{�[��%<�JA�g����������;�����"��;, ,OJ�yx��Lg�i�{vB�}���� ��e��gY���a=�gG�H�	hU��wy>��!d�����9Z����Җ�^,"���s)��i,]Uq[S��7A����";���M�P�+h�0H�DĈgm�p/3S�0�ƃ�V�����`�U��sdUȴ1r26>�9;���t�&��޴��#=��*G������J��6�&$h��kW��\ӟ��=����d�W0lt���T]&��ȓ��*����
����=�p�K������RJ�L7k�ئ�D�4����e^M
����p�j^�h)3�[#[�����@>�"��|2om(=B�sH쀃�^lkp�J!�rq���ňޥ�)���v;��ρ0��6�^��5v�f�s�}�cDS]�acO���(�0�Y �6�-���!#`Y��&İ/+�Y�v��c�}�\��_2'����C��Ɖ��ص6r�^��d/0׿�g�W0!3�y��t+f���z�dZ���*�����}�@����oA{��wb���� ��S�sҵQ�Гs��B���q��kPz�@�Ջ�I [�
�x&)��S�C�,\b�B�#�V�)5S0�H�'��1��wt�˛���s۾��L�]<��N�W�(!j��0�g�������a��i߆������_.Y��Fq&�	(߲������n=�N�]�[c��C�}���M!y~:��>�3?`|'Ey�ݱ��+���S�JY4���\V���-޴5��~:;�u#�kځ���<���I����'�o9PMO���`�����W���s�����؊�p}�A��QC忪�2���\� �X��&Dz�Rsjm� ��~a@φB��� ��u<c Lƃ� /K�� ���MeD�
�l�����o�ju������q�f�Y�9��]ar���d��Z��wn����8��S��\f$�.����Ϧ�e���B��#����˚?rk��q5CS��v.���s��q��5�c��-�Z!�Z��&x�V� V詖�ư�v���l5�3�L��+"�*})��W&����2XZ���2�F8�2P�jf�Cʽ���j�6����K�BC����o�0�!**fe���g�HR�̙������¶I"T�#�
{l,���u�W���*�)�$�I����'��-3eA&��|�q��\.��(�?	2P��.C�,��E1;@�5�D��]��'6�k����#�͌��2�:�7 �;�R�����<��b(�A,�i	M�9��Mhr�z3��ϱ�TKz�%�\��2��T`�$z�X��x,ڥGӬ#���K}�o��@5�8�WZ�U����n�e\��<��zf�����;���OPk�BcYxΎ�5��C]����>B��r��"��p�G�ظ����^�h���3���/=������"��51�9o.�G ��k6!7�Ƿ�X�#A�����6(����� ���&P�b*�ͦ��|����=����u�����V��cd+ԕő1��T+� ڟ\���D���t��� mx��*���@Ir$+�	?+�H��u���j{�b��%B7k;���ţ��؇�B��LƾN���8��m(-
FK94���+:�e����Ð3��k�61�3�4G�|x��X4S��-��=��S�  "{y[k��W�$Evڣ÷ޅ[yy�f�o#���G�[�/�t�-�_��ni}ø�iZ���՗i'�e���ЬrH�șƕ�,l��f�{�BI�^Uc���`��vddL/��F�-{�$ײk·˒��7��#�F��pa�����fHmv�+¢�":^7�J�������dG`�؄�`�<Hv�CnA���Pt�ï�O�n9��� �ޡR�;?Ƹ�C��*�b���뚖��m�P�S_d�����!����>�
ǿ]����e	�:�(�ٵ��<CfS�F�1ػ��$,������-�R��2��64U����Ȑn�>�� Q�P���$�)?���� �G�R �쵙���Y8�$3�ҕ9A5��i��G���>� S�j�a9�V>:r���qs���i-�뛡� 	���'�]����*2t��o��l8M۹�\?��|j&���(����%"g�R}�����t@\��:+D����x#�=�{:���=i�sm�vB�j�E��x��Ţ�����}��*"+��Jd�zv�r}��B�i�w0����a^�,i2�W�ï�)����u�g����JFE��2:�2FRo����v�n�l;��
 ���-Y�|�Vb�Jp��&bx�f����Q��N���tc>�53@����F4���-��Xd�a���uX�	�m��|Ld�e(Ɯ)HW�59o>�Sw�y�^yΓ��"�lk��>�,B��נ#a��چ�؏K�33%��:�K�9b�=p�'�tb]Y��ie�etmR �Kj �¬%DsQ��P�
w�>��v�z6�y�nK���0�R��]�c�ui(�+�m�6�7ڷ&�)F�h+u�
�}!t,Y�'˂r���������m͸������KC�����Rl�Ǚ?�؅��]5���IY�GZ��x�Nq�=�o	�:&�\��W��s���RyK�q�g��k?̵
EJ�4�R��n�������fPo�}gZ�&{�e���B|ަO�ZZ�[����C���� T��[w���E�9�5/*.�x݌P���C�U�F!����|m���԰Jڲx�����y"���2nu=@a��＿w8yŝL~ȞD"��|�{H߂q�q���:A
��'}���P��)��X��k)Н[#�mnZb
�sGu�;:(�g����MA����F�_�0���ˋ�x�6�?�,�X,$Y@6FUt�Q}| [�:.��C��EXR���D����t��ea]��_Y�ΔL��92�թюi�����Qd�2��i����W�?�@�sZ�l*:1'���D3���(�Ve�}JL���;�r���5i�zM����ՒkP�ex��h�ϜOg�d_d~�C�z#=��5��ì"�&
�T�+�~��#O���bs�����ĦH��l-��ԥ�"S��
)����$;Ya%��N���%��l�a��=okhPʞrv�~����z��$��'M4�t[�r�aiMX���V�Z"%�8�0��u�_[��/�m#���s��ȁ޲�!iY�����¯�-�s�~���b1 �_�%��ٜ�+�E1ѫ�`�Z?����̛~/�J�{�
�8�Mkl�t]Ne�$�ڛ��G��Y�ؒ�շ���o�'G����'j��]7yY��?`!�(��L��BГ��,�=��n ��$�Dr�F���}�>��셺���s��<~Zi��ƫkη��ΕG����|w:�����j���a �/�� 菙�j=d4E~^w������ �I@��o6��MM}�{QT��V�qT*P�.��oQ�����-�/)Fnr�o)�4L�m.*��0��������=��,~з$����¡�o=I<�$Td���	O����`����|�:���_iO^U�'���rGzy� q�GS�e������C�S�����H/��Ϊk�;P/d�:j�B��y]��l#"bz.�AG�Gm�xN�O�қ��I�t���1UIv�mo���*9w�6���,y�sj�׳C�q�!�f��%�K�n��Gz��|*
���Kj��i:�2���N�6�����}4���}    ��Z;�\"M����~�p�y�lb����V���h �!�������3�]�P>�Sd�p�e�W��CNM
B���/ê�.�B=���W�5I����9��.Ѽ\�m����5��3D��ѻ�rj>K{�;���\S0�u���QD� j�����|�n�?�R���2�+}�{dfr��4�x0�;��/�Sl�xෑ��<F!�h��~ �����d�<vL��<�bq&<�8{\'�doш�z�:`��"E��^8Ŝg�T5U���}q�^e�_^I_^i�U&X�ȇ�@�����u�������׫k��cJT��H��`�D�.`��h�B��u`��Lڿ\f���%3�+�T5ݴ|�H8x��/R�f�ݭ�A��U�(�dy���t�� 	2�P$%?|%��
�S@^���<V
i"$�� O���~\�|��TQ��o��F�=J�ҹL�kg*��+��� ��w<��FZ��r-�vڐS�
AX�ا�x��P�f�$�(��b�ʰl�14�\�����V#K�d�	:Q�u�%��x�,c�+��g|�^���:���b%፺�<qC��DFȊD�{�>@43Z�:���t�����{"Et�AFV��s��j᧱�PQ�o?
n��h.�S��3h�[��%c�Z�5-Z��uAf���� �bb���?h��@���=!,V�"�!ҷ~�H��8�0:��^H���>3U�=̜��kJ�j���R:<oxc.	V�r�/,�<QB?���+���!5�K���/�%^�b���o&l+�DN�{g�mHǸ����\Ha��z���W���uU���ǈ	�Q�R����pL3�@�w����ӄ�,}���.��&��4Xt���Yo�T|v��!�I֛?Ǆl���`Y1,]r��!���kB$����<�H��*z�pB�������O�ܤF�<<_^�t����̿+��d�7=���T��r8��Htl���n孔�BDB>M��&�F.�Ro%�/�%�<��I��鿱�S��>�Zy���F�4'A�q���$+K5��|{F=o�q�Y�@�N)�sێ������V�����s�Y���R%�_�ӯ[z%��[��/�����r��M�f��	��eϰ5�)�]O�❊E-<u>D
`/��	��Gç٠`&�w���8��c����9�L�	"�ٽ>�����D��9��^�~yZ��0��������{5�$Ҁ��_�Z�HZKS�5���mc����0����Pu�,0��9�5ì9S%3²62c��LrkW�խ�pC��8�ژm�S������_�@���n�ASV6�R����7"C-|�
�:d΅G�$VL������۵�OJ�Tv^�?�;���d�LV��q���S�g�Z��۳�v�
�B]��$/�W7�@2�	��n�����0�h:�LS��2�%\���L4ٯ�����ȄF�q˪c�Ś3�/ A@WZsBF�͒�>s�o��,ޖ�ӭ�)I��A�a6�e�5��F�hUbwef�j%��w������2|���m�R��R!_��H'����N�5>ӷ���y��U7�~���?�D�D��g7�ɿG�w}�}��2���ؕ���vˍ�G��l��uɿad�<,:��9�MP�,V�û!XZ�ݗ�?Y�$J�Iڀ����ji�k�M{����!l#�4�%I�,l��Ӱ��`i|��9W��V?�u���i�]3�W�43PN�c��._XC �����)C�ڝ<=-t�M�L;��r
�״�K�qtG̨�xG����+zɀ����-dK0I�>��Z	󵈭��6��*�	H%�6%���V��1�A��*+�ܭ�[�9�XlĽ�%<K�7�<Yr@�d$��/K���tɼ��L�g�䜏/������Ũ
{h?X�!L�3l L����U5��>���~	���!�-x��%r�U1�Z*<mZ1.~�]fNw�o�3�@���'-�P��k_k�R��| 2�v�~�ń �Z��{쨡�3���TD,��h*��-@��B +(�&���+0�qT�F>v^N���Z)����7~���Z/K��}�Ԩ�T��F"F��&��.���F��I�q!����l�[ )�p��pt�h��M 4C��{"��j����O�U�&'j����?q(�`��.g���$"�uO?3����K�TmL3�ȼ�}�xU�_��Q����OPa��LF�V�1����|����Co��9���� ��7�sSr�;�\�
��yE~c���:���J0��gz-�sxuE]�W�s�D-��Es�RTU�D=��I�ߴ�2P�U#=��yHح��L�0���Y�������(�hq�|H&*��u�ο�6���@h;�˫�-<�UC��ؒ��h�bv+L�g@Z}L�t���2r�h�<�V��Ņfk�7xB$3���F��3*RęruL<Uo�)O��j��� A�����
,( Mw�A�?H��n�q��͠g�������TVeGK��M���y-/�H�����ʑfw�Z����R�h¸�fD�K#9r���^�.9f�V�e�#�עb�&�+,��8���+����EP�LHKWL�9���s�B �Am!�j�n��/�'����v[6��Q�iS�,e��h�-eEN˴|�l9X�o��ʑ�f}��]\m$�A̙����������W	aC��3����͟y��ub��Ĕ��~|ʯ=���-�`��b#��B��,���� ��y�u�y����j�D�T��
��-�8X�[��|�k�ڭ�W(@aL��L�m�y��i^��EL�"~��k9�#���i�z�]6�]�A� K�\�F{�G	8�s�c,���p����+iVO�,�h�s*$'~�G)vs_�o�b����,̧���7@+H�&Mw�ƪXH]E1�i�N�fZO�4˭�0� ��D���� C�~Wۮ:.Y���s���[AGD��0FF�$�?�h��Z��L�wȏ�*Ӥ�2D}��A�� ��.�-۔nD�/���'�]��Yiq���L�!�S+!
|���=6��@�z!�4�礙�Q�D�w�A�wl �E� �3B#RB}9�ʪ�KN�Q��}�+���q)\��U�S Q��n�W�(YZ|�h׬/_�l�Ï�F/L���jYAw���sܞ(lE&UԣB��:%�h~��L��\�^|.d���>���ù�5��?��%_!&���&T��*�r���WG^�9(�v���P�:<)X�*{���B�_X(��Wؿ�c���(ŗ ���q���%��7pE���8d���K�<��$�]�칩f�`y�6�yt�y|��e�,"�DN�Q��W@[�~Ү�{��ώ����1�Y�r��<3�/J�j��&���5k�_]k�}�e\4�U7���扢�9�)�?�1�\�:���j�y�$�:k�s��Ou��_�Tt.K_�^����XW(+�jm�-��pi�}�i�\7|�T����S��ķ���߼��`a�_��%�]�l�R@4��e|��)�&���g!&+���c���|�WdV�����R�=��&��g��#����5���t��QU�}�烐�+�%k&n3�A�ׁ?v�>Gf^�4Cfr*U�<�4��+ۼ9N�=&T���x*9$�k��ugp���	G�[\e��:�������ˬ��¾����L�z����xf���p����5�ܺ�����-�G����krm����ƵЃ ��OأQ�+%o:�ъLӓA6ϵ�k����Ɗ�t��!�R�hp�]Jw$=F g(��)A�w|X�Y�H��ݕ��Fqs9k��� �c�4k߳�S�������̅�eLS�+[�u�r��ꄝ��s�
Z�.�V��j3�{8�������|e����az��y�2��:��#|9Ի�0n�x�[���9j^&�gK%BD��v<�u~\���1�)���X��&��4���Z����ui��]��ϒ_�5p�*2@L�סhsvC_4    PK�ÆNd�s�X?d�`�c��0��Ӭ������q�|&]BH����ͯ*�ɶ�|�`�5_��Ng;�X���EX=[ǋ�ʉN�i<X��If�"�]�`e/dv�����F�$�٘>+%nE0��*CMK��51�S��9�+�	�����ӝ�Y�U���>�M��:�G� �Lfg.��}K��H�2d	�nq�^M�΄$k;�R��B�5"[��l�U��A���!�J��ɿ�|x��_ii.���g#P�/�����[��i�e�J4��ˇ������_U�֕����W�Z�wN"$��rr᝶C]]�,S���7����?���9��7(�;��*4���-�4a-�V^^����@�#��A3�>"ۊbr�OGi��D���]���<[vd�[D�.�����5�e�m=^�?�`��jU+H$tC;�w��`���_j�$ oV��U���k�����-��5�K1%4Lȳɬ� �"+[�va�r���?���{<���u�XxAz����%h�W�D��� �7>��d�M=�>�_�`�N�Lל��ɴ�x�� ��
#��?�+������_�f�~Y�	�j�a^�����ɻ��9�P�k*�l�{
ڹ��b�2�d�Л�jI��$�%�݈��]�#�?_M)Ni)��w����Q���޵1׭�<�E��T��w�=���j���P��YHCA�(�N1Bfo!Ÿ��]�E��xrܖ�\4y����o�G)�P"���t�*$���,^ ��x7��R빴$cD���t|�z�Ûq��!*�~39��w������3�C+U��ٴ���h��؞�a��_r(�b-q�-�S�E�S,�M.�u��E�]�5��./��loy��2������ڮ��˶�,r��z��v�;�����1����� ^�DDw6�Q��'�Ds/!W�u�v��|I�5����>�<��d]�x?������{�ÁL�6�-�mSq��@��&P������h�J0um�L�>rߘ��H�F�;�n�}�m�k͕ޛ����]����G�n�HX�v�Ef�:�+)�_qO��&�} vQ�L;b�P�n�������0�w��Qmɱ���3&N��D��2�tHšD��dL�ƹ�AY��0`J �5h:��`W,�^���:ܼ��́�W���Ğ���IU���_䎙(��@,�ى}��sR���n8oG�`��:Q3�n�ܔһ����~���W1�B�/��e捉4&�9;���J��`ar��*�Zn�JHmҴ2��'.��*�h��a�,I�
�}ϧ:����F#G(��C1�d�_��O�kUvW��Ez��&��S��jYñ|���ԗV.����-{Ho��|f�&�Qt�r�4�'T�Օx�IK$�s��1P���Qm,�Il��|?��IGp�,� �ᮕ���-��z��Pp���1\'���g��7�cM�q�/`���g����gH���q��2`K�A�$HU�����Q�mo����|zR_z�E�Zg,M�+���}�>\�����}�uǐ���s��Q�&�+�'� ۈ����鱿>
���2����|7`��ؿ�i]J�fψI<�d�)8�?�ċ��v������>��x��`<a=�!��hJ�!�Q��Xw9���"�B`ߍѧZ��~T��� ���dhz�ʲ�OC
B��8NK��Ԡd��ꋉ�����C�\H2.��qr��<~��Z������Y_�U�VP�[�(�W:���e����!��des��k�$~k������@�,ä��rLb�( O5i})����a��F�	"�S�W,b@�W:��#UU����q�М��n�Fd^4v(��@C�,��8H\���+�`nꛈ��<q���]�JP���F��mG����үAO�7���>��	�&�^��ߗ��4=ox�=�T�Bns�c������"�cs��AkH�rV�=c��[=�<ħ�G�e��J׺��Qra��c����� ��ӷ���o0T����7���Z��h�|1O4�wQf�9�>��	�
w.�s\��@�V9ˍ�H�� k����˃��\[�3sѦCdE=����K�Q������w����t	�k�{�������i+�6��]�k�CNe>�cd�^ï��A����dڟ�N�_j�͗����3�!_IV?U:P%�c��g�s�o?ù���d�S�[�
a�h��BW�c3G[e�U�Mp#����j��|4�؆M��
�-��f��Uh�����A(�K��p����*�A}�ыܷb$�*΢B��bҀn�So�
���	�ojJ��=8N�B>.{���Q�[+Z67�nk�﭅yE���%I�0�}���f��-��.�^�[_���⤩�p)��+(.o<�/	�
O�;��p�+#}z��ɶ���fڰv�\�^�.���7�h0(nz����I;���8L*0A��ڳ��dD��(���XnP~������"��K+B�A	\\� � �E��_�_� PZ�}�R"�@�0���2�ט4�5��)2Ʈ���E��ŭ���cG
�%����8c�ѭw��?�UM��2�s�O[�eĴ$:f�N��p��o��������L��>��^�K~��u����fSFLp
������v/1ef}��:�l�q����t�蟣"|G��A���܅غ�ȩw]׸����+nf$"��«����W2��\K��	�L՟��*cf����L��c�*m���1�$��E��h݅I�@���}�Pތ��b��^�g����Ɍ,�&����7�/�����������{sS'�0S޿�H���7�d�u���w�w�����5�u�-P������oԼ���G��i� к�Ϭ,LсB����^=s^W%�T�����ƽ�N{�e. _�`�oY�/R���h�	�B����L�%ŭ;��'��X��w�+�E�ւ��B�3A�(�&��6�y������`�[]�� �ŗj�v��ZKq�T�B�Rgȯ�P���Oj����	\׼���-�o�^�+�l�Q��+�q��� ���%��3�I&)����p<�f�*~�Y�\���O�fM����סE8�*�_[��wz*�D}-�?W#-u���h*/�hY�4PD�fZ�����!_?DC?�U�*O�͡����R�0��t��=I������W�@����}79͘to@>-(�칢*L��A��Y�n�=����Ɛ�����7O�n4��{/#�,�|�\�s�vM�}���yH�%��Tx�.��z+��R��֮w&�X�$ب����Jd���PX~�v�����F��Z����>��]!$��Յ0h^t<�@�EL�7>J�Z�st�b{�N3S6����>���~��z.q��x�� �[�Q=��3S$��ж_	���Y��Ӊ����U�Ќ_=���,L%~�vGQ�2�wuw7����-Cǅ@f~�W�:`Se�w��o
<hd�U�
���������9�"�>�-�;����C-KՉN����#��y\��b�U,��r
��T^? �rK,�: eK8؞�0$w#�r��
����v���2�Ͱ�[�v�?�譯�k�K�&f=,6���*�)����kh�nGȢ@Q2�N���Z��n�:O���&�Ŀ��	�h�益� (����Ψ޾�ε=�{"���\y�u9?��o�^v5�(�";Z�Wa�c�4:�
b��a}U��M��A��"������&������*sb-�@r]:�{�X!���.o/��1&V~y�����ʼ��)t]L�UY���mz\6����AR�t��tZ�2V��}�u���&ΫE�<�w�P6��K(b%3g�sh����p(*�%T����7�B���ƥ=#jȨ�M#��(��`.���2��?�3�T���g3��Vn��LL_�K�\�����Rs�X2����M=�S����S3�
6-�1U�c�w�g��I��.�I x$�«�H�    jоa�^����\�woNF��d}�.iqɞ��cv�D�0�WT�x^�5�A�;:5��4ua���}�.?�+|W���A���[��?2��7�����pū�i�
�L�*D~!�t;y�V�z������'l��������X�x�)�e���
�3K�����3����6Z50 M�eJ��"e%��x���WC�X��ޥ�(|����\���7Q���xZE_2��ɇ0
y�pm6������0e�%�����l@�y؀A饙��@��W�f�JDFD����%���v��G���Y�m�ҏ���S�O�F��!����{Po��Y�^Q����ȼ�ų��[��[���ȑ"z�f�[�%A!�2���(���(Ed���U�z�]da�dL$g��֙�_�h��C���*�����A3u09�LHq@}5�-������8�G��HA�~"�l"ژv�P����'��n;�Մ���Ĵ�Rŷu�X�l�ڵ�� 4�6ZHD�愇ő�0���͝,�a}�����ѾO���I $*��~�6�鼙�n��9�>�ɘU��W?y���*�s'�Q>k����C�rNV���]�������B�cc;ٟ޽$�y�EV����R�vE��]9H�����ct��%h�^��]�_G�>���(���-�&�1c3���p����_�d1���@�¡�5�����C�%�o\L$&�L�ͱlb�h�����ȼ1��ja���@��%����W=�A�~�ã����.� �<������܏�*��M������.-�P�ˌt����	���hN��N��ǜ�V���J�>�vzx~^s�	����9Ւ�kb#�ܺ~2&�:0Xbt����H�r���-@B*���=~�B²V�z�_�7 Peʿ�\q<`/��𗩭�-_��}E$�4��%��/Z0�(��aZ'�Jʛ�e�����<�M��]7	��o}���?��ee���84Ҕʹk�m���w?���\,,xz ���w�J��L��+�<G�b[`����7-���v�s��20��줽�y�pm5]�^ Y�c+�ċ2a��a��Kb.ў<��(\y��˥q���k�?�ρa{��҉Pd�I�������1�g��o�N5��n�I�-$�hm'3�L���&A�Y�����akL�S�Y�����%�܍�`#@�@�N��m�1IJ;#�8?
Q�Óa�9UY�����zC��2|�u�y�5ּf�}�����T2�Y?�����A�KW)����T��3E��:�5����3U!>��?ᓕ2�l�Cg�Ƣ��,~���Y��$~}���`-][H�a0�,, 5�$���Lf��˰O�G.-	l���z�.����kcePq������<���)?�Q�E��\�~�_"�êzԹ}�|���O��1$7	��!Q��k/���޲�uO0�1��K,��1'=��B��4ł��q1:�˥��WIqG�B^��P����/V��\����w���c�|���p��ifڠ�KtV��}p��ȶ�37'R���H��Z�v_�(����H��{�;�����j~�����)�Љ����:��Cl�jҒ��H G� ���̓��������>����k3f7&=9��������,+���M��8|/�����Y��i2&���9�P�5�=�J|*1�Ǿ��ٚ&������z묮e�e��
�5gXk#��nV�/]�ޜ��E�\W�5	�%5��R��#�R�����$VD ��ʥ�=���!�%T`&`�����٪�M�I!��𗙼��%�k&�K��}NPIF�Yt,���3�Hw��Rζ��ވz1Ʀ���x�Ĝi�\�������z���$ω��z�1M&�W^O�C�@j_��7�1[�`ʻ��ڲ�)�~�`?y�G-�5�#.b{Y=���!�g�u�S[��Do9)�S+�F-��{�rZ.����N6�h��*=t,�%@�`��hIr�E-�m[�'�(G�c�M�:f���O1���_������@�lL#�:;}
�� ���"Z��c����?6�}�Z��$�vß�	��^�^��tU�3:����h�Y����W�4N��O)$6ʖ��}�E�zkO��Fo�1���GN���p%^�����9�-����M._����5���ژ�P����u��	�Gܢ��;���yїX��I���`�ʲ/B%V�ًE�u#؛��cq\�ܔw8���a	Kwґx��)M������'�Ɛ"��;�y���Cڶ5�P�LJ��>����~�ޱ��R\e8ن�g@k�8d�&�Zl�!I�FO·)ћ�18�ۡ�uwzC�*�,��c�Z�H:�%9� �~�;��������׋ٽ(1uQ���P��ׯsȱ�(�5U��	o������������>�'�y]�T�wӝ�c�7�vx�kd6�D�F�Y	�9��p�y?Æ�_�Ik=�����G��j��fs���7߼�6Xy�r�~U1�0��R�h$J�e��l����]=[�ٿ߱"���
}ڧ�^���N"�Ԗ�?�~���0�0UI7������������ۖЪ,�n�U�
KR�P�IZxV����>��~Ep� �����d���y:�J^6ʿA�-7o�?�|�-�I�0��*g{�=L�I��$�w��M-��_��;+�M5-tv�3�S���̬j�-%�B�����zm=�(w�O�:wB$ YL�_�і�v���G�g'��6��6�5=M�%?��2�dv�ޖxA�A`T>I�g���VSN[/y���*�o��x��x���*	�Q��j����ߋ��=���X�V;�Z#TCq�
����yGj�FҔo�_�����cȢ��X�I'lX� bJ���	�^frAϊEyP-S���:��k*�G�.��M��JQE`�/��>�-�E��S��Ϣ�xY	�Nԋ+</���XA�7t��rm����@�.���>mʓ=�6�]�V���z�/Y�`b�p��{��1��\G����rX�If�-f��1���W0=qR�Rf'!X�@i[J��|,����bC"�WM��YJ��Z?��\.�����0U�ş��|m�+F���n�px�7p�P�_�=�m_0-���j��ȉRBo6�r�Y{%YTrF 6�g���'�s;���]��P������^3����ઓI�r�m�Q��w�j�Կ���*M g���.���$�6���L���H+�M�ꯙ�n�x\�l��Y}�X�m//�re~����K���h��~�ؒM�-8�O�6t`hL.4:��3�*L�w��w��^�~��򢋟�L䟝a���@���Io��r�h�[��;=u*&���x���L� �� �[�tlv��<m0�d�"2,&��Ԓ(��7O���M�g@Hmh��ܘ��)�NL@DE	��i�w��~&�^?�h?����>��<�t���.��mG=�P�b�fzi<�ǯ�+�oDe-62������+�q	���	������Q۔���{w����h7t���Z�1|�WHf�z�"��D��t��X3nb_�Y� q,~�߻��E�m�5�؀z�*I&��D`���Z�ȳ6�[�Ѐ���L�Kbۯ|����9j��MX�|F]C�����L7Wl��_z��$|�;Q��S�|��o0��=�2|X�߽_4�#����>��p=���|�������X��*�:p�ӑ˚�*�2k�gxrcI���m��]JqJt#��>���ҡH�~�������jo�.,��ip�\T8����7"���7�V��w"y��h[x��}(r��ʉ��=�&��:��[����û����fn��ErJ�2� c_+lM�t�F�>|1`���{kg>Q�0 ��������{��۳4]������x������J$^�2���"�b}�/misԉ+d��i�[�+<}>�~uD���^��������v]��80�s)�i_ OU�,�¡�F0?g��Uu�Տ���o!e*#��    "�)+�:���Bo4�����O�ǩ"�������V"�'��M=E+�!I���a~���R|!b�ؕI�H����A�\�o�*n��/,�I�+|��(���]50�፴�.JQP�ɔ"��g#8�6Ji��5�{�׆���r�_����+�{��яQ��ʷ(�{~�UL 4d��X��*;���N �>�ѩw��X�x�hDK�a������XfS��;:f�
�i��c䤚b~Rݑo���y1σ����V���$��Ӣ�Kg!{�	�����μ8�����Eu0�z��ui� ��U�/'�k{��RU�gZY���u�%���T�S/O�/��s�d!>%T��r��R1��!e&`��ǖ�)H^uC}�������?&�պ���>0�6#,&��I�T��l��+��	�v8X\G�0�����|1x),�,�<ȹh������1����;L~�|:�3�2�������${ӛ��P~�����B5��{�_������W:������|8��<*��u.i�s��o�wBw_���Hgh�EjZ�q����DDir{<5�BT�X��_�ȉ��I�(�x�^'����\�K�_���u��\UF��A�@��}&[/�!�-w<�Z��CJϨޏ�;��r�s�2t����&t������rx��(���O�Y6�ƃ�5'\�S���E�|P���ܮ�K}���x�L*�u���F�/��7�O�!�+�wV�H�ֻ�)���(�
0Y.��X~U�X>W
��Og��ͳ��+Q�̠F�\=�>�iѯQ�t�1����s� �l��bhNL<�o���	8��u8�������Ō������FB?��I�3ڡ�N�3E]q��H�-�	M[�It���^D���[b�jO���74��������Gj�L���"X㠻���DAƊ�����{9�c�&��zL���,�z?�raYﰚZ�O`���b}@�l�@����|�~��O�c�y�[VA�����DnK�Ω�>�~,�K퐕�MҝIhMΚM(�:fv�nÓ�* ��W��c����|��KCK�y�璚���k��,��TLh⛷��;~7����lg�sir�^��Pr���*}�I!���oމ,���-��i�o����J�H)&��%'",Bob�t�|����a7�Y��VQ�����q?��f9�sƁ�ZS�nKW|��-��K���;�������Va�%E�;�F9��FLat�`�9�#��X**��:����� H\���,?�`�cE�v^b������bp��z����L�M���G���5�@v}St�M���T6��F�e��g�����������U�D`D cfl��z��S���(-?r��8P�۹z�3�+XX���jGȢ]�-���%�;�0��M-21�;]���!�^��加�wz`6�-��k5���!(,������s���0�3M}\%�Ƶ�a�Pe���t\�M��E������h���F�)��.~��G�_���xt�L��3������x�H��^�ͮ���E�qN����į�q�2G�����U��J�aeC��S_����"�v�a��O��BS&������yy�(��Y	�_�횏�*�zl�6�1�^��3���㸐+��U3E�j���0B���Z����M ~����pm�2�0�(�ɗ�@[��F��nޜ�rV��A��%���zQ�xpg����
������`k�R�}�%��c�e�6M�`?��P�����h�&�0'����rj��"l�� mj��Yώ��5,�D9��R�=�p���{1'���[m���d��:@	I�u�qТr��Q�&�^>�
#��n�9�_c�)&:?�VY���]@�鵣�z��E�\�8h{�eH���=O�>�d�پ�㿱߰�PW7���������@(L��+��q3���f��Mk0Te��ї�1�K����s����rd��d4��[�Wx��T��+��Wn)R�@Ǿ���G���S��b�p�i�V��Ĕ�>V)�Lycf_���0�����y�Q�s`��PM�}�m�\6n�M����d�w�������A�,��<�E���2tdN7��U�i0[�����u����\!L�
���9�->�*�N�-�;�����[�/�.���P.x
uG��W�ν�0<�fWڊ>��>{�;�c�=ݞ���l�r���~�߻g��;������3��{oo���{���`�s�Q�*�s>�z�\x��ҒX���ߺ�I��D�u,c�T�Ni��d`�-�T��w��v4ГX�D��OL��m;_��8�j�D^V5ǵQ�v�����w����_.!�x��X��B����x��o'�� �ad���2HUQs��!�i<hs+��d���F�\��u|DA'�y��Ȧ)��k��I�4lQ�S[$�Z��e��d��jχC�]��r����!Y}9�}��	�i���u8��ԇ'W�v7�z���5X�\Ab��D8RdB�u�q�i�����N����9_�v�Q�-�Z~^�x�����
O��~�\Ĝ�HϪt�L���u�%�"=���4���5�/�JU_K��K:Pϴ��v�A��sH(�R1��>�����z$�\�u{�F$�ͽ&M�T]�o��5������u�o"5���N��a�)&�+m��7�[��Z?�rl��e���;�ǎ��(��_���
o�]`(*d �a{fCsFX���}����dc�{/kq��>�����<�"�pJ���R�<bڝ*C�S������O�\�C�J@�M���G�Zz�`���2�k�5rM'���/X�Gd�UӦ��R�~�d�r&dp��/������ד�t��?�3wź�c�GI4FF�K@��_��2H^P�����嫝{&;X~f.�$ �,�B�03�b���7:� �D����/Cdl�7a0_rWxl�\���}��F�aQ�`M����FT� ��
��r�JA��o#J�y4/�L�M���݉���"@(�S-�J޽�����i�J��?�a����@��j@�e���8\�i8���8�Y�X�;ja�+�� �
�qi_F?0E��v4���o1e�������5����$��Ӯ+����+��;˩�M?n�L����2��߶��T(|y��lxQ��Y{�*�p"�[z}�����㳴��NEP�C�,��~�
��rE�2���?�UKN04��3j�4ҏ���-s*K�[XS�gEͥl�2�`{W �<�|�����A���!4"������������#0���|s�r���|B#��#x�N 9��o�Tu��w�풡�\s���@�j���}�ol0�$��Q�j��+�u.�H��k[?)�	�]ϧw��iF��rC+|�-G�B/����_ؘ/leGt/~:�����iꅇ޺���أy{�3�Ds��q�*�׳�{8�ֻ�5���H���"|�b��\��F``uFI�d�|.�}�W� ��;&��J,��.��ƒ̫�(��WM"h���(Y�;���Ȍly��n�Ǥ;K|��Ap8,{�F���:���4$��5P�!����u�kd��[t�8Ӫ?�y*� 6_� �RZ�}�<��yx�'A�������:�.KpF�c6���-f��m�M핿�>t;�8�L�H�M�KD>#�<�97(�.��v���[��Z"0>ǯ����׿�yϿz�( c�(��i~��9��L#��E9G���i�N��m�+V&���/�t1$�U��Х�U7	[�C��o/�(^_z jS�*y�>R��j�y�u3���QOU`t�h>��}Ժ`�J��wL�/P�5�9�2�õ_|��/yUư�Z��6v���r�|���^�	I)&��\Z�`��{ȨܳU�t�D���0=�t��gm3���h{��J`K�DH&���e�ʷ<	)C��)*�}�e8ɮ����k��E�%��    ��Cω��sR��[�y>c �X@XǗ�T<�䗟ͣK&���E���G]��c0���r>�n64����P�����w�����:�z�cQ2����^8v�j~�;�.�P�4�%�XE�@���[�eg:��V`��ʴ�y��L���L!w�W߳�9�U��n'�Q�b|c~�&䀧�yR��W0�O���
������	ɀ�}�QP	�8�v2R�ҟ>�Ѫ��R����Hw�Ҿ�K�� R�Ň܎>-j����Mv�;��� e�V^}�Ecl�����T��D�����cD�b}P��}{ ty�'9�y��l!V�#P���]!����^���A1�]+d5�3Q�@ʡ����/}��i��>�pE�<ޖ���@.R�C������QEV�I�����3�Z���j����:�ʀ����u�lq<�M�\/a����ԅ��4_���g-����$88+&Bצ�úwbPUy����cDV�'��m��+��_{~��5�T;T�����HO��~�毁i�7�p��@M]4�����S����¶i��91W� �����,Y/��)&��|��(����W�A�T��r��bf�TU ���;���C��"�t=H`-ıj�|.Ǳpm����Ted	����k 9L�\��$��;Uu�P��ȩ��d�YU�m����aMR��	��6�o���H���c�Q��i�7w]��3E9a�+�~�M�yzQ��*P�f&��)��Q]Q�봫�nOoQ���\�	}"����'� �˓���ÞfN�>��>XTE�1>��X˱����DxY��3�ύx��9�g���籸���� ��u�b��[�T���uMua�5���Aс̻��������4��W*�S���EL�r?��X S�[5>d�̢?�ro���󡵚24�����QO&�mx^e��Vb�sC���eѐ����Q��{����V��,��"r�)�e�NG��)?\��y�-��(���5Q(��9�Ne�O�Z,V�P�<��Y�p��P�YuقT�m��&[�����#1���ؐ;s6�%�k;O($�S�*�/�a�l�U�֧k$���=u�M�sDr��\0%�H"Z'�Э!��W��_�6��o)�oѥ���r6�����F�N����,@NА��&Q���C>F���:? ��bA��kW[T��-`T�2>ϲ/�-�^�\d�0�`G_�ǃ�%��	 �2^e��F�y��+џ1�%�ȕ��8$z�M�
����]#��)_�%�� i��"ڮv���?[U9�N��QU;7�����1��=_����vJ�(^��(��ZZ���M޹��S�M�	�vaH�����7�I-c|�;�p�$z�w��-�����,������,܎bTe��0]�I���zV���d��<��>�9h5�w{�N���J�e����R��W�M�x>FX�(����4��q�w�(�<�R�P�T��Rڇ)� ��fN`{w4�Np�?��*R�MEw!7�4����u H��Q8��Y�zs7�Ѩ3rK�����r
>�mz�K���k־����EQ�ݡ:zF�<���"����K9���A*ɶ�b�1�0����MH�2�:Q�jD�#�~N2��h:^��suۺ�Aٺ�D���]�x�O���6���?�uvjw�A��	�2��ji��/�Bi�}}�$���ق��6"îs�QU�X0�E"ќJ�X/��wp��RR-������Tx�.�� K�A�oh4B'�7#�:�t���zk-8��$ K��7{^H1	���Y��-3�b�yS�9a ��0�aE
�7���^;
PB1ў���ܳM?d8Y��e^>�s��0���n���_!0!���p�����*�，�x���q��R�NJ*��ْ�� ��Y�
ݮU2vA�yܸd��>���������i��L-ʶ�%�ªC�%�^�H�@� 6��&��0�R��� !G��d�� c������#�0�̻������l�PcB�0�PVV_�»$����6/�����&���󋭂�jN.�6I�UxBh'��p����#�[ʨH?��>e<�e\�f�\s1̈ÔO�,r�m��%��h.W=^j�1c�*"�~W��T�^��:PA����mO�8�Ӌ�PG��y�^|�<��,�M��*0f�
�[`�)Ș�~��>O{~��vwΖ���K ���}�ı��'�p�k�R_	���`V�BR���V� ���B��k@1YF���l3,��+�]y!a���jԛ�]b����f_.`��؀�����#�B ]����>�na=/�m��� )wP	\�������T��)�:�ʍ.���=�ůxcS8
�R��{��Wq���Y���o��M��w����|^o�� c��'{>>���O������]3�I��������c1�C��^I����6q�]����M�,>+��s���z�'�\.�@4��WC�S~�kA��sMT�^,��m!��\T��2�%��xɗv���
��]\mh�7�8	)w�ש�H{!!�t�J�R~5���i�пJ'^�*��
��`t�ո�M0�}ය��Mi1j}�Ȑ�IU{��<�įڭJk0�e�_����o?tC�C��c! чd5����~´;9�Y�O9��3��a	�M����?��dB�����B茚4w_g�_"������E��h&�~��E��Ġ��de���X\�=dx���<ϋZ�Ǥ�pj�`E=�g��S_\�C@��=�+���	5���8H��_f�H��r�W�U���t8�c�����d�r��L;`@.r2 �I��ۚAb*��rR�U�iv��Y`[Ł�%]�?W�Ȝ�Y� �#����rOUx�1��$�������4=�%靕�wpI��4�u��"��2LU����WK^*9�m�l&���#H�b0���|v�M�aF�Dȗ��l'���@}=\/N#�Q�I�U-��+��ɛ�t�P��X����קT���_І�����CD\�R�ςK ���� �5�=+YTy�h+�I%�_8ǒ�X����p�ud�V�6�Og�ej�Z�3pWneූ���qDa�AL$'[����u~��m�:��:��w���"Tii
�J�u��g�������zk��u�V���B�uO�'����\t�`{qjB�7e�	��ndI�26`:y�q�����~D�u��)�߿�Q�����V�-m���z�
?~�g��� ��CI� g#�_F�n��ePnWq���Hs6f_6����w������0�a��$��@�UfqL��r���Ռ@��I��(��#��JRy��#b1�d���f��pόl1�2���j�Nr����R��Y-�@�@�i�ߟ�[N	�2(�0|�_��C}��j��k��f��f[�J�fkKA����~d��b-��D����ʟx��<���n���������Q�X�m.����U�)h�~A�"�O4���������D�1�_����n4Xȓ,��͞�Q��N�=I$�.�-4c��`� g�==$�0������U�U(E�p���_a�"���^6m�[FN�v,^�щ ��1~"�J}�2V��U�I&Eh��4�g�a]����'��	��2�i��e^�kXPqTj�BO%%k�K%���A���V`�����-A��P$�@�3}%d�$ׯ�ٙ�2gSWvӾ�����
b��sS�-���h^G�$r/��[ӳc)���F��*�x��]
.���DR=��R/��W����1�p{�=Q«�=U�ȃg��3a��4�b[��-��H�3��.�552-�~15�H-X�8Ίe��$FtR"��[�sl矓 [�}W�;^��[Cx:��9)�˖j+58f �V"+>��S~�?��n�F_!y2�Ҙ����C�-.�����ﰇq~�h}*jbs1.�����������g��}��^2�� �iY��ư��𹞆��c	G�Q$`Ƕ    ����ݻ����s����L��+SQ��z"��-0��͋i������9�P_R\To��Y2p�����f�Ña�k<��-:���0M[�[����C�g�E�{FPvR����d�Y�*���o6�����J�e�ow�]eWŔF�r�/����>&DR�"�c���F��4��HwG;5��uz���U�f��e����G����=�'����Ĭ��=~d�L�a8����~����8�6��⏕x*�q�b�	3��x�]'%��{3r�j6�\D����Z��r-�վ5F�ҡWρ�����sY��U���]=_]�,��0Eϴ�}�ܾ��d��]w#5o��0<E����d����G��S/�{��x\و�C�V�D�<��Ϻ�� \UG����6?�|=�V��y����&45�P��4z�Gz1�����V_�P6u\����@���ʋ_O��-a��Gm�񹛑��#ϵ�(��<��H����d\N��固DpA+������=���
�ozdk\.ߩ	VR./`HF���.��[����'�$��ǽq���)��}2}��븞����]�;�ش-������Rv����Ta��C|��Ƅ�m��P"�?m�Q)p��|-S`4��^��O�<��}�;n�A�	"����)]G���2��&B Fh�3(��ťs󫓡�~R�):j��m��CkF)��p?p��g���!��N�~�M���>�&w�vD��7ٱ7g52�Y6���'El�)f�>i�@�ު.�L ��z�2@���ocI�X��i�=�ڍN�������̈r�l��Yo+�]Aֶ�+y�y�|�p&���+�1�^>��%ag��k@�R�����y}�!�*�*(@י�a2��	s�V��G�!\�����M�.�_��o�j�:�յ�����D�%`-�X8�y/���=B>��h��F��|�Ei�o�^����%�AkBF��u��1�>Pt*�0�
llgh`��a������h�;���3M�1H���'��y��vD#�&���^���~�bE�8����D��Z>��=|V����b�h*�
�8䅄PC�|�m���('��
��h�~ϯ��<�ξ��xC���O�q� �楞�a�*@���𲻟����Q���ի�}zEI�K�4g.������m�n49mܵ G-�>��	��\�ډ�<��hŘ,/���&(�7�b���V�����b1�:�.g���V�{�X(���a���ksYyF9E|�뼭:6�q%�%�R�����v�\H�j�1V;m}]@�<���u��VBЇA���/��L�����
�j�솨�A/��a~�5�p��f�*�Nx�or�KޏDZ��}�t�|�
:������m��bѺF��y7tOup�~�Z�WN��Ȕ�oQ�^Hۢ��7����g��F��q���[�v|��N��fg^�}�2��i�|�sD�t�w�(GO1�p|dW���YU���g��Z��x#1�U?�];��|IA���� j,�6�4�v�|�A>g����:�\X9��,�A5���.�n�f�)R��NN�˞������rX�$������ጿ�)B.����m��z��hC�h�;Vn�Ƥ�;kU}s�^����ն'(���I����L�����Ǝ�$�jGJS`���/�Cq�ȩ��e9�M	Qh�)^��%6
�k��&�LC�	'ߤ�M�0��V�(<;եA�R0������Te\?����޸`�DvgƗ���6��}�R�"�rd��N�Ek�4������/PZ�s�;ZW�%�<M����ܤ��v�)?}-�6X��eQ�&�>�H�'�&*'K_�����$�,>�(//����Wf����ZͿ_�sS#���W1D3�껪��o��f�4��H���9P���q@A�IlPC�Ao����(	"� �]F\ro2@z��̡�,̃�!1��{]��l�l��Y6����Tp�/ԛ��y���t��ۛ�LuF�߄lY}2/��Րmh-=�;F�*BI_�K�:��x7yS��^��*Qx XӘ�tG������b��[�47����%����Co=�����[�_^�;����"�}�*�r������h ԝ�s�U�&e֢�Q��D�2��n�J&�}m4uB�f����E6$�L��zl�([�W��y�:3%^���B}�#�_�q�g&��v>����6/Y��.S%�����*(�T�Wt<��I������C��QX��^��ָ��ׇv�Qp]HB-�
�6.��d[��) �=�$_�� .ڹ��.�ECԵ|��|�Z,� H�#یȔ%T�I܇�d�0���!ca�ƾ��d�*���M�˹��E���+V|��H�]vݓ�&L����8&h���&��ʇg^��c�U�&�OJ9�v��eq�ښ�v_��Xɼ�󭌋ɥ�X�Ƀ�����-�'��{�w�x���7Q�x1���\�o�L0��zGQs$4>Xv1`~!1�q#"�-�����$ϼ�-ĲT��)����C�.�l�=�5���Dxzw�k8���%�s��r>������`�|o����7`�st��Ml�e'�a(�����٦�s>N5�l�����rG�	�<zK}4�q1�	:�vŎ1F�N8s�bc��ۆ��f\���-aÀ�����Ė%�(�6��	�_����ttq���l^T�횘���{.�7c/�=~����#i��3dh�NM,i~c���r�g7���X���F����D�{�Vp)�"����J���x�UJ\Up�̃�*��3�E������\�.�L�Mf��'~�$�GZ�Tƃ������Go�/_s�me��Dk�d�X��v�}V���fѹF�^�A���3��U�~�7B�`+��疨vr�G����ܜ�@��KX���'j����s�[`�Uэ1�)�U�v��4���D\ii�(Ż���6+���-����)�3������<0<y�,d����9+ؑ���Qu��ɀ»&-w3Ϻ�I(���.=]���B����T�D�H鷉U؛qڍb���ߝ�c�;{�fα�_>�#j�Ԟ��II��Z����-1�9��Ni�.71��(��-ڏ�:�*C���zM���Q�E�yA-�ZX�::�egym���W���4��S�9g0���+��PZs�钥�ȏo�P��U����೨z�o��u��H���$X�v+$e2!��ؤ/Jk5��.��l���0(K�U+@�uX.�Ve�iDɼ��EK0�'ݽ٥�O-z	���"��o'g�U�p{s"�81W��~��z�]j���CL��@����Bg.�����H����#���-�i��|i�i龨Wu[Ȼ�O���|�Ğ�ol��i��\O�p�c  mۄ�6T�}�Zx4���l��sQ�X9���ߒC��?2e��ʟ���G(�t��Fw�H�0���x���&�)�%�����+���g�Z�
>e.~L��P�F���E����=�9�B�זz���{��3����5�>�RΔ� �;o�'B��� ~�xl��P6�H��;r�:��-��h@�#�%B��#�h���"�l���5͢��ʊ)�@��7������$M�.�l�&�?vKK�1���Zr~���?�3���M�FPM�c-���`���%`��a�M�J�"	�,�4�JI�^?�崮k9UIl�+�[�>?x��!ŦӤR�����r��X���-�}_W�VN��23��_
�ߦWP~�ɿ�w/�T@�UA�h��o�q��`.�ŅQ��Z�6ƀ���Sa՝�i|�x�-&j�e|zG H�S�6�y <�`9��_�B�E��+���[�?S?�����6��(��I���z�\w�<x�o��:���FF� ��>1���蓬~�t�����ó��|�Ŝ����c�7E���,*�����wD_��<�a�G��8KX ���oȻl-�Ť'C�TLY�B9Z��[�)9Xw_7    ��e0�l.�.�Q��K��A�E�W�s��m�O
_@d�tQQ
Y�K(h=$�x�2g��������@a^�C&|a�/pjHa���_?%���5mk�m�t���<E3����L���߶5L��Iv���1Q�ȺfQ�����c��=��e���d�,?h�luׁ����^����;	��j�x�K#��&��F�������3���	 �D�;�)f���{IXbG��z�nJ��|6�.W����6S�A���O����]��&�K(`��ݑ'�#�j�Z���|�����b8�݀A�Xr��Q�|�^�-,Y�l�5g
x
L�,���(�xm�f�?�m���k��#{��}хa)*[V��k�^	#0s`1]`W�I����$�5J�m0P=�f<+��4&����_�gL��o�� CIIP���GuD�U�Ȅ�V�y�U&Mԥ�cu�C�v��s�ѳ�l��(u�Ka��&�$9���Z1r�����X��ש^�1���l��Ŏn�1�b3���W�4=_� �AC0�D�3�r�#4/����[�Q&��*S+L(���=v{Q�*-��s��p8��.ҳ� LW��-�%.��d�9v�i'��ƓA�.痯�su���*2~uv8�hg5s�'Y�c�H4�!�������u!�`���k��n�&�}h1 ��o�x���ƱsM$�'���&��F'��8D>���>��>9oHfX__@{h��&��tq�����y�� ��mG�4���)��4A|�p��&0�J߀�Ҹ��h��/SӘ��%�]o����������Zm�ޑ�w���M�������Q)V���k����+�o�^���{���W=�'�jq�\l�������/[���YsC��'���Ǆ�k��7mFd6��%I��ޟ�2�:>�WA�����4�	��U��R�/ ��y����FG8U���n��P�R��E#� %�Q(e��t�W<��6��`˴���y&4 f"W��Zs4�n	�|+�L�Y:���~]Fj �_>,TD	njd�A��M���Ny_�7C(�T?*J�|�ֈ�1;H]�]"���Sn���W�k�`����{ɺ��$���T�������ɰִ"�?��hX��ﬠ"��2?F���o�Ɨ��,A{j6S9�x�������߀F6z��F� O��~�ȱ��ib��1G �� ���c��VuBn :�c�R�b+���Q`||��g���d˅ �(��$.6�+e��F�+P9:5�8��;{�cj��%R�����/2m����,�?�ڰ���j(I �m~P����WD�Y$�mS5S�9Kv��e�:����[0�rQ��z�qm�bN#�u����6��[�S,h��?�*�l�<�lUV1ʎʨk(οd[��~���Z O�"cbMn���WfJ����V"'�����X�3@���BFm+h�*�7z'������j7W�jH����IǮ��!��u�E�au�Gd�u���l\��B����ݞ�v?�Z��o]�+�@�5::zbdq�LFb�H��~7��k�⻡�|�*P���
eCQ�K�]�����v<�A6-X��h��Тw�D߼.U��BU��/f�o7�Ռ<8��BX7J��ɉ~s1gY�ϯ�����~N&={c�,׾�r�M��9���� )�Q
����eoa=L���9�=	�g���L���QJ"P3hZ����B�>��D�������ʺ��<�$V1���u&�_Z�[�m��k�[]�����E]�������3�� �x�\L[���b�������o���Yω�xj)��.p�L�T��,��cn#�%Ԁb��dnfH)�r�t_R�	��ľ���#H.vF'U���^j���x�P��B"f%�Łd��g�k�B�
sWQ�҈7#�yYYe�`m{A�����B9湛;I-�I_y�@�$k��~JP��h��Kdi TD���`Ełx�ΜcO!�-;xD�|��=j�f�%��w���	�2&Hԗ	\}X����߻T���E&�`&R�"��2�������16��h�j���$8���M1��L@V-����"Tb7�}'A��R�]D?Cg!�|�WÁ�j��>��0�Ѕ���i�P�Μ�2��k�;л�ā�F�y�a�bJ�L~u`2�4Ӹ�,=�S�ƕG�v�
S����N���QN�����r�
��R0��k����/�~#5��[ڑ8�)UQ/qgx�ϥQ��a��a��f$�{�P�I�����'�D����jwд*��徖���뱿��v��h~P_�rʩ@R,L�®�yLEQP�k)X_i��m�|񏈥���G�}��5�y�.�G��+�76��>-�BCt�h�i���S�"� tDm�1So���6�>�h�Ӥ�cȮ.�Z;�O#���*O�2/��v`ڕv_g�Lj�T�V�DS�*���k��/�t�,V�m���]�mV]c��v�������'�_�Jw^���9�A3�0��눷t��}�x��XXW(�Z��4�U��wl�9?��A��CA�t�\�ע���I�|�Z���"N�	]_	r�1;�{(q��_��(<��*`[��-�t@{�\@T��<��aY�Z.A�wϲڥ����5�~n���P@��Y��7"Wi9$a@J?�)-��^��ΎԴ.��ۖQ[z>�V��0���_d�>��P��J��}�� y�����.w1^�z$$��u=nЪ�����ic��'�[E8)�@��.v��*��O+D%43���F�-�B��SKD㳪����Jk(�� �h-��CaF}k�y�i��a@X�!J.�pu�A����]ni��&."ﺣ$��ȟ��$Di\��+������źLn�G�HM�ɇ�AJ��Q���VΎ�[|&q�r���E�>op��0���W��ټ�䒥�]1����{k�/�"�����Z�O�\�҂.�d<ǐ$��w���"g���
���*s�V�Ec��jB��(x���o��r�p��E�03I#��[G�%�/��f}aK!������E;�}��m�\���.�C�V�蚻�F,�yz$t���j�U&�W��`��"�z���3��8ےޓ�����ёY,Ӧ��kzN�wfoe���\�t���A��(�O�C�x���ȅS".�$hc��v{\ X��\y��x�o��c��y2̂[����|�����Y�-�������ތ����VCsX[6����){R`ѵ
|CS�WZ>��O��uD�̭\Չ��ǲ=�m��z5@�-M��V�!R"�ե�aH�H�t�g�V����+W{u�!�N��J��
:	��Ξu�a�=7r>��z!�����.���Rxf�(ŋ�bp�����^q�XY�G����|n����<@�v�L���у9�P�x��om��Mq'<�'E�T���~�\�d���W��v�l��L�V!@e�yɬ�K�j��F��5�뛌�dwnɬ%H�o�.���ѣL�}��� xT��Il�ML^�
OX¤�[Dn����(��r(����r���E?sh��d<^�_?����
Y���\�~H'Z��݁��VU?x�A::�:�V>������k#a�=}�:�/�?�:(^ @�\��7˲�#ո#k��v	f0������vs�n��֕J��׆T�R�?�3�M_t�"<�ng�r�x��3.q��ޙ�ԥ����X��7~�ȏlF�H�=�8]e��ת �uǼn0ֵ}d��j	?ےi�UE�����f06�`��yُ���f27����X��=����.�q�������U?^aΗՐ��/J�Kp�Y�٩�	�Ǟ�)$~�>�h�����d�%�oV�/�
Sf׶�a9_��l�1		�e^^���D����z3��,J�ퟔ���P/��-��?IS�!'Z1k���q�O>m_>�jo�5?V�-�3�c���0(S��[�m���_�|8J�GZ�ӕ�N�X$DA�~����?��8m���s4�    "*�b���l��0�ý�������Hzf"-b��z\�=uȈ�L���TKC�\�yGE�dwm5�	��kG�k��hyy����/	�]_U<s9̄YV�<.9~��>�8���;"�y����솳eJ⑖�O}�2/�Y���=Yw����/	r!�-���Ҧޮ�{�ɪ�١���V����M>�x�yn;��
�{�����,��+'��&��\�z˨���"t�4sC�@�ij��2�/��7����� 4�M�/N{�${��<,�D ��'����\RYv���+k�4��m��*���]�;��N&����"VA��_f5�m7���۲KFN��,)���c\��$���s����PF�'}n%0�\���Z����a�3�*O͇�3,%[��IV��8�(�����r�������
��]�i?�����1�r��bPV����/��w��,N"�tfsd�C_i,���h�޶�-�; ;���ӟ��H�吷�}g�`�l���;��2�i�d�7�:=�q� ]�ϙ�/U7�4M�*h�n��wD�����=r̑k?ս� m,�h-�[�z�ǁ��ՃPM�į����Kw�/����ؾm���4U)r������ ��686���C�48}ٲw�Bk�����m�����N6=̎�mʅrnǕF�5���,9�h�q��Z3�O�Ti�4c����t��O��	���V+	*���R�x�rO��+�t9WF*��?)b�D��]�cj! �}S�qd-�G�TBK�+�떇�������{�E~`��*1{J)��Ȭ��:K2KibײN�aG�73\�Ŵ�v�l����PP�*g�u�WxU]�U�'��"�&��~���R�1V�>��3Q(Y�2�q/��6Ǆv ��}ݺb�=d�����/����Ǧ�IV'c盤纍U|Ffx/�Y�{'|s�@iA8X�C^��F9�"��`�>��x�vf��v��uj
����l1��pv��Lr#Q����)���T'�T=� ��MFu3Aߊ��3��~�>�x��t���P.YgT/�+��kxR/Q��TL��Ux�Հ7�Xq�1=�-��
�R������*�aFG����
�>y�*�h�¢Y�}��E#�50�}��&Ũܦ�0��y�c�i�"��;F͇��}���d�{s�P��R�0/�E@g�����_� �X1��|�����)����L�%�8wŚ��¼ A��w���l���u��������G!��m��`�X��֜)����FĽ��Ayu�Փqy֚�~�p��C��u�4�JBˠ�o��c���/:�sn=v������K%޹D�=}�x!M�>������)�3�q�9bS�u�{0�*M�(�l'��$���lV\��"(��F��1`�ܬ(���iWR�ޙ59� �wo��k���Aa:}sJ�uN�{c�;�b���#a,s@#(b@��;�D�ɯT�.�5�{mR��}{"qԪ�����	 ��a����hjo`�z��Ef~̌���/���s��:��>�؊��zJ�V��6Ѿ�OE���?��"���������i<&I�����v�r�o��Oi�����8�[5�ܗ���{��T|��q�뼌5��>�Z^є�p���4k����+�I�:�������@���lb�N�r�F��d��ݖ�lۚFw����*ܦ;Il0�;�h�n~j��&�VH�k�k7/͘g��}&�wW<��U�Җx�a�8�M|a��`� ,�'}DhbJ�K�聅R�CZ���l޺���"���*�̙q6�9�#�+�:ր�k�Qc���r��?�	�W�ݦ	�O��aS�|o�8�𹚺[I՟��|di�8͠�[9�2ܧ�A_+��-�ęErpDl��{#��q�z3\S7>~[�+	�4��g�jg����Lm0��*}M�,fJ>X���c�HO?"
p/;�����)����^}q��~��Q�׻�8�8��5����@����/ח��؜q|���[�*F����oS/��4���\��|���{P2A�_W��;T�R�SzYz�� Y�d\Y��0��5�����La�Ź�M��|
���r�#�S�����r>�M����#�1�y:��[|�n*�sޔ�z���x� �nC?O�N�����;s|�����u��m�X?����>�wn��y�وLx�3�����r�B�üY�]:��+ �á�,v]�
�{Zp.���6=D�[��9E�*˾-��E�f���s���T���u�6����t0���<
����szىP��%��s��2��޾��|����Au���Jh����������l���>2���x�NԙPt�1���d�t0��О�vY��O��^�(1���+G�����A�]����Y��j
$��^��hԣ�
�=oK3����6�yEJ���N;vw/�����iYi
��x��c����ҝv^��U���mU�~�wl�aSfܭO0�	���C�؁(�WU���Ѭ�^ڠ�gq]�X��������V1�,z��;�����tj!�G��ɢ!RXe�m�J z��)�jo2Y����`Qw\:M����8+���b̥#�2'Т����N��d�)>P���e��3&��o�Ơ�e���I�I	0Ϩ?%/�^_2u�_�EqO1"B���Q<b�+��>}����#��o��N����H�|/f.r�/�hq&�Hh'm����5J�r:r��/lE�2ɧ���;N��k�˵Tz���76w�P�Rv�!���K
v��A�u�E��V4�s��C�#���tm��zGq�(�{Rra��S�8tF�Yl�D~c��x�\�T�0���;!Mh"���Oy���
N�����[��������F(��)�! Az�s�m\}'qӛp���D�0�u�<R�l�4���Ӽb��p��ko�1�N>�y����v�?�8)r )��4���^�.����'L��z�L��4N�ʌ�V!�k���o�C�?��u��hd5���C7��)���J(����#�$��iwf)i��0�G�\��i�x�x��}��weuw��Ivo��t������l�델�nOH�f�8>ŊQ����@���%x�A�j�I��G4zХ��>Qw��?��Vq*��8k(G^ni!�q���K�ѧ�E�%��v|����-��'+|^���)��V'���sz�g����B�<�SB�y�9vK"��$��E��_�'�xyKպ�*k6�xUиh��V}�4���������u��L��R�6�/A2�,?`փC&����,v��������`�'xܼd�:���6�-�`#Q��<�@���K� ���]]�9`yu�� ��$ιʧ4!�k|U��0�]�aPߒcO.	��t�XO�$~��,0?�p=u}>{as���J�]��T�d����e�#N-�������ݘ�3��i��v��(��|�ר�dǉ#�x�@�U�kEs�z�c�TN���Z�"���\���@��+���B���dڌ���fO��e�3�}'��c'������ޤ���h'�^��L�
����O#!H뺘�$*��w��0�/e9lmi�m(�՛"<� H�i�}� H?U�<Ƿ4���m+�U�,d�/�!�R:Je�Lz}x�*6ß�D�M�Z<�[�������]률m<�!�:C�>�f�/��;5l�3`߯sֺ��{�@�-DQ\�-�������W��qjz����;Lu�b�����-~G]C��o���|�:"I\���a��	��L̫M&��*|x������:����k�)^�������3��(mX��[��䬕P$I�%�~��AV+���	G���.��.c�boGH�n��9Y��{`	D>E�}��R0A�Wᖯ��4o���_$�����B`� 3�΄�\�@�����4)OJ��}`>�о�p��(4������T�����WK�vN29�|���VG���?[ٹ��M:օ˝�3<�w��mK�ww�[�͝�=�Y6:E�w��^�7ז��t�ؗH_M����   /���o��IA}9��ǉ�"������*�ධ���5�����J,��ڵY�C�c���7`����I�mB�2B$�������"���y(ɕ�]�*wcI��t�	��9)�i�ǖ7sܵ˚�����>�G�z�̝2`Vmp��}�۪��l��mX���d��&���%��mm9e��Ń�TU���C�f	Po��~9x�-�0G��ޑԅ�|���.�ѦA�t~�O즮e#�����%Y�M�,���OL����$�H�Fzz���.V�V��ܔ{�������`����h{�����;�{?�˨��mo����҄^l���]�>���Q�WO���y�J�-g��"k�q�'���P�4�Ŋ�
��z:�3������4)��뮵�کw�
���;�hPد���E9:�HO 5)���ލ��N�t��p����A�]���n���, ?����O���-_{~4��a����wP2&�C��� 
����}���:Ɏ�5K ���������1'�      �   ^   x�3��z��ƪ+n���y��f�^~c��7[nl���Y�e�_ٺ�m76���q+\{��z'�l���e����@�;�*�n������ K}l�      �   \   x�M��	�0�wU�!Q���@^b4(AD�N��q����������;��6��� (?l3!9\,'���\A�d���X��pX"n�C��:�      �   ;   x�314L1216�M16L�511�ԵLIM�M3II4J1��011�,I-.�44 �=... b��      �   �   x�%N�M�@�ޭ" ��<z���Ę���Hd,!Q�L7��}��s�L�f��<�����{�(�}mq��6���$8�s�����[�-�U`g��Ɓ��C�����,�P����̫P̞R�]Df�u��I�u��m%���6v��EW��[%�!�JVs�h����TUoMlWjԮ�=�<���e=������`�-���w� .�&      �   Q
  x��Y[r۸��V��)���1+��U�j*Y@b���')'3�uV"���S�x��4!B8��OS���O�6��:/|AH�=Ւ��P��n��wۯ��a�mw��Vm�����}��Ǜﻷ��jw��k�]V�^6m���mS�� )Ȝm��R��-O�{�����wo����߶{W���_�{����y
�V/_��W��J��g�nXo�Z�n}�W��3ߙy��������+��	m�A�ZV�$���{��SFTۯe��>��ڽPc�Xz^x�6�r�
|>��Q㼛��q���1���w���Α�� 9͑Ks�\��>J~幵�N@���F�����I��Y�/��������/8����!_c�
���T.����=�~��
���ۋ��[��B��qw�Z�Ps��=�i��Im���a��߽�}�� ;���r�,b�J���/}+9�D�*��~�B�f
��u~�3������/�;�%��8��q�מ�)�>�9����5�������\?�x?3X�&[��p2	oOЁD��:��3.��������vt�$6%������	�\��L ����޹�-@ykP`Ϥ�H�Qa��y��8|�L���qk�9��q)��g�*��h�.˂�"J�
]{�5[:9�ؘ��O����{0��/H`N�>�&f�ܜ���A��E�����Y�3i�&J	�B���@� ;a�܆]�f�O�0�7d׆ E=�Y�)A
=m�H+Qw���&��$�c;E,��X�%�3���Mf`�v������T(��w�z0�ǙV�,Q��uo�=�<|��"h�>�A������`!��<��Ʈ1m�a�A�j�^�mh��"�E�)���Qu4�NH�G��6�+E��Է���$)�1&��B��1�fb�s�t�84�P�;�(RYk5��'I�(��y@D?n6��^Y�~��j��d�P�-�94�!J�j�U�۴UQ�\D����{������T˲��d� �,�e�o��ю �>���
�q���:򹔲�����X� �N�Ԓ�!�hc#tK��x��S$M�'g�!��1[͓�q�u�!��P�X�5���1e���g�}��L�Zia��Z��P�ĨZ�8Q�')=ϫ�3S���]��
	��B�1O�M1��0,M�o�t�1f�<j�Q����¦�z�%4(3�&z�1��6I��.f[�E��u������qR��X���MN�˙P���>k.���;d���K�� ؝,
�;���u�Џ���W���2��Y)#���D��*	�t,�:4urm���	�P\��:g�}?�}Ę������j�J���#;���{|",��t]3�����'�t��}��R���<7�������xք|����9��!��u���?�dkc�D�3$<|�ȡ���>�
�ȟ�B�_�##�'ja:P��;U[Ǫ����;u=�Wc���w��~:�{M?�3}H��Yy7h����� sy�}���x嘗��:+Ed#tBr�]�{3�&��if��h���'0��rDyS��!���w���]qQ���j���H
�w��HB�=Z��Ԡ숌�B���#J�Gv�9z��]2gD�(���(��Eө=�u��ֶ�-�)��������/3��W��S�6'������^��tR��I���:�q��5�6zH��m�#���:)� �
2���\kR���~�D;7��P��c&\�=y�Ƴo�����r���%�T��+�+7�U���5t�����8n 
$#0))䀍"�9
�, �kr<�,�|ա7�u�8Z�4W���sa���GN~U�vH�3d����(��a���T�~���Z���v9M��ucD�;�Ὕ��M���T{o�����lk,���w�W<��7��2�(\�	��fO�$p�w��9�L�>	���E���Q�X�Y&T��	����J�T�͗Ԫr]��:x:U�쟌�f U5AL����25�n9���b��=d�s���ɶ.�������Y�"�� j�U8�p� �ntL�p�I�h��-d9�$��J5�+�<[ry��7� �t��|��?6:h�N���a�Nv����ug��&����*�o�ǥL�n:x2�y)��d#��?�i|h��Z��"��hkۤ�21�h#���j����;�"��� ڼ� �� ��:D�Zcaռ��j�na�Mu�evI��}�]�����.\�˗�y�@���D�٠,��a+6'pF�SL����[!
�A�#:��M���|tI�� �-ׯ����C����~�R&ӴO��f�n��ѧ��<����4�S�/W�����S��f�'��||��:�lv�h��KX0U5�I0�H�j����	W��U���˳*?���e�˘= 6�֐Yp��p����d�p��V��-��:mc_j[SMj5�Eǂ�l�qbw��`H�nn=�9Uw�R��p�F�:���&��2�������t����~)��؜��+���=�]�gE��6F�F�UD��f٭^�W��� *���      �      x��[ɒǑ='���cQ�R7�h��#]�L�Xa�f �fxH �B'�@@0�Ia�/���yYKfv�BA6]��Օ����ܟ?���)�f���t��%�%��gT)���j���%�4Ӿ57���*�pZ�Ar�x�}��w��������w�o�g������w�>���%�a\*�n���?���a�z�z�	���_?xp8J��~&�I1M_={�A�淿��Bh.x0��+���A��R��p6B��3�x:���߈���(G�1��,1_ldV�´�����5��R�-�!>.�ǥ��w�t����
�(�\���T �^�:)��Nz;d^LnV�����q�é[){�^@����n 0/^^<���'��`��~�w��%�7LH��lzq�K���F;�x> �?]<�A� �~����*��;VBc$���
����Y�jw�.^��%��d����_�_9AT�xNƕ�6���J���%�UZ��r��ş0����8��G\>n	g���Jh��5Wf<v�W����~��=GS�K�%!% ��E�0#�VX��\��a�W��n|���Um�F���k\�%�xkTn*2�Ub����d���AE�&�r�4�ŦZnW��b&FU����� �nt�������ąߎ�<N����]-�an/�џiX��0�������ݔ
���LH��K��Qj�Ɛ
!�G��e2�v��FɵW�^t�z#��{)�ΑG��w�T�j3L[��ƍ�)���/�~���Q}�z�ǻ m�+y'��r�jppӑ�ƌ3>F'��z��8}b�g���y+��<e��62o�ՁW;Z}��N/�������\���(a.��\�<����k�q�;�'`q?�N�Q�������C_�;�`�`feTK�u<����5��В[��TX+%Ws9��7��^:�;���-nEI !�`^Hτ�ҥ(@�j���[��K�{�m*��PuՁ�S����^�f]�.�{
/�(Ў�^1������s��8���8�b�9���O4%�ўp"
�Yt|O��o/��0�����.�i7����Q��%��OF�]��gω��
9�?���:�����bE���0��Z�qf\����(.�^�r��F۵	K��+����F:��(�k$P��m��)��\H�D��xi" ���s|�0�U�U܋ヽ4�w�fP9�G+8n,�L��K�4X�}�0]ⵉ��6R�,�7oF
���~O�B�{7��|/�b��g�<*��x��`#a��yP&���LV�~7~��<9"\Q��u�RV��t�����C(8���2���l�����lG�zad�ۿ��淘���Y>��7��� D1AԚ�eL�A&���
V�+�Ȋ�P��m�8�ș�.�&����B +�ʾU�_��xq���r�@a�@c��v&)��4��2$�N�Y�3�a!�b������u��|�?����>��hAg��G��9�@��X�Y��2��-�C�p݆�0��,p�	��t��!p'��t8�&G`�~��[�	��S�2���n`s�<��;��ڳ�T-�!��ŏ@�H�%8�.)G��V9�`�U�t���d�DU�u餫IU_��!�����c���ȅKn�z���t%�ux�\2%�'�����G�����C���&_���^Μy��2��QHO����֊k+�Tg;���l6��.`dd���ڊ1�]�7F�����M�P�Ά ��L�A�՚&B�X���F���ȓ�

Җ�����}�Cg�OC�/;��&�Tr����?���}�_�9R9h��G	2�cN������`��w���x�#.�=)6(�U?#+q���7��P���(��V�0����E�v����.�� �� �	I蘇f��̔���1��83�z'm,P�/�7_A@�?����Vc�fB�.UZb<j�
��H=Jcr��,�t���C>M���H�$@{r���B2N���d\��F��=lmX�EqJ.ldLz���	@�\�W ?G!�0�S�`��<a�����w�i�s���͗_�ru?>������]������
��5�@��E�+�墲�ޔ�j�W�Z��KA! 7mn5�1Rt�?��)^��������?ty2Z�Jͳ1q؅�7;�2�C�g�tW�~�P~�x�p�3�P�[�K)�	���?#�El{]�n�7�|�_G��_����o������1��M\UĬ��7�3�j�.:�Ex�%s(��@�Z��B��	��)ph-�����+�����o��pW�3�u�bj	�*�<��wǜ?h��pn�TDS^���!��}>�o����f�TG���M���f҆�
P�>��䫊���@�a���o�Y#�1ףkP���mU��#{�(u�
���B�a��܅��d
�
���lH�)�C��C'sW��Sp��]� ��<��3DX��gM7�����}vO��;�^��&��v ���pe��Q�w/�w0Ĥ
~����;��:�������@�+L8f��ޱ���0x/�C�!�r����{�����߻�7�jK�T�*��
��Tz�G1�9�C")R������
������ć1��m���e��F����<�̏��5�j8`x a������>�}��O�{���U��ál��%sғ�u�E_��T^�-%ب�\��2�[�L�@�p%/1��r�㒹7�:(0�.`��ONf����>k��aq����O'�<�S�)�
b�A
�BƫҘ�q��G���I�+RM�d$")VZD����Q�L�~w�{=�Aq��_�JDb�����t{�	��e>� v.��X�v�	Mi[C	50U#L^X�R���5ZU
4����N4���%�����2%!(�8�3��a>�jPN��A&@�G�
��������n�q�L�~��i���iҐO�s(2$��!�W�J��ѡ�z���x"��,ϛ�1��l5ch8�0���Y�.HG�lf�͒�&!賐0�寓��H�����CY�.�����O����Fd�[�H%��6J���$%�U���� ���Vu.���kY�������� ���Or�(�� ɷ�BeP��iR�������d)�T�5p�E�t�+��ǧ����JiLc��u���vh�gZ�ݧ�c��۾���˧q�A�K�������>!
\H�R�ӻ������.%���ȋD�g��z�㯃3b�j0z���B�Hsk����q�a��/��%>Z�&>�5�~<�8�W��9Jʊ
���c�l�Jkąg�� �PIʊ̇�u��E@a<��r�#��*"��#Q��>e��~�IL�ٮ�f��1#g�]0���
M}!��\���N��ae��FM�Oq����hXǗZ*Z>3�xp����`��Z	���0��b�����K�y��R��h�6)�gȳ�wȦ��U�K��P���j���J'���j*��`���q�X������/�0a'��'E�C]`_���rW�ő���j�y�_�����"<��M�W��J����n� 3��Yy�/�s�|��N'�q��,鶭RWc��p�[�)'3Pk��6�9�e���d�9
J�r�)
�mh��)+G;�E��Ǉ������>���}oT�='>�^��c�w�3�_�2^?�#�y��շ��|1��ϲ5m����Ǯ��דu��P��l�c�g�:'���̫|�pvQa���^P��+)6����(���^��C�Y�@+��A`[�������}�W9�����=�V1��`o�Ж2'ŠX���кk��gn�P�`7ag	�SX*B��L`�i�"�hm�F�=�wV&B>v��#�������+���aߏ�i\�=�u��qag�n]ic��5��Q}���.���nx����p��{N8�+�H����CL��sMƝ�p:{Ep�Q'W�u%6ʯ�%�jz���(����r���*B�F+�C�Kۘ���T z  t��1��xU�Ǵ���x�Δҙ0�Y �<�h��	6�	(WȬ�{1^�$ofϡ�2aߪ���E�'�vA�A��q���b�����~�i(<��C@࢜����û
�MqX�wk����T^���/��%�/zM���˦�\���j�L�ʍ��c��S�"�x�ΚcCM�o�~u�9�as��.��v>�y���gs����.P�Z6��؁�{l���88��r:h=�ߋ���P "��
�9dǂ7�TL�st�� U����*��yĿ������kA�
w�]�ZPR
=r����}�6��W�)Ez9����)1�tI�.�Վ����U���3�����Z����n����7c`�{w���Ǔ���r�u�	x��Ż����Ư��:
2WlP2j�#a�+��BɭA��^ʈ�W�eHu����&!�c
%e$Q�4X? s�S^�6:r��G��]�*�5��pX��{2��Q�� ��xQ���j�د�����ܘŽ��RP��ks�y��N
(d(��<Whs���u�K/�����Sw���.Rc4�ɶ�!�k��6��<�kk[����U�e|��_��w��?>��VȘU(1yC���|`�h�8����`Y-�₱,
S�P0C����]�yH�h3�j�rRx��E�|���&m2�Վ^�������0@�a�����[WY�n�JL���ˮ�g��ך��n��$1���q',E���V}J��l��Hx&���;�������%']ӽ�~\�]݋�>�[��crK�gd���4��d�������79�C�FZC��k5�wrف�8\�����{����ܾ׶�=��v�[�L�X����8N�q��?Gx�H�0j�]#Po�����*��[�.Ř�S���D-��;� b���.����J&F�U��%t��5������EL������Z�韅��ztH��� �}�W��:J�`�H�
Q�L_�,&����F�u�-����^�ys��'��r��H�+����B�����7Sp�`��[�fm�N/W�&Wl��Q7�F�5R�E��i�4=�C^#��� Z��.C���Mh�8u��әƁ!~��s����!��      �   �   x�e���0��M�F(j\�	��,@U4,B0AR	��m�k�G�i������.%�k-N>�'��M�o�SJŅ�2�U��C��J'/�pP�I-Z�7���1f<v ���#�M�m& Clc�S܀��A��� à�v<����2T�y٨��b(���3� �s�]      �   z  x�͗[o�Hǟͧ����ƙ{�� s&�/�&�cC�jz�n>Ȧ�]�U�_�|�b.Q��FM����9�1s~�?�3���*�z������������3N�Lr�� ��j��!�3�i�(uZ�(x}����2���揧yPh�k�G^��9��rx��è�x�χ��\cy�k�}4qL�=����E�1;�P�=��n�`�iC�����c����~�\$|��@�H�"���T�	\�C����r�|��]��G!����ep�A[0�Z;9��7/(����FSMx%	vɴ�ޙ��EKϪ�f,w:��;J��#GE�K���`�wy�z�I򖆑�--%�*�D\.�����$?N���:D1tس'ToY�(&��|�L6�}�>=r�DQ�ex�@h�����VO���e�݋�ݺ�܄]n�֯�R~5����ywT#�v��l��B��&3	3�y��������s�����M�l�G0���]o7橈e�B�Z�x��1��=~���	^����~�[&�dYħ�zl�P����ah��^X'���)T�����TNu�B�.���L�b�fH�|-�>�H�#�l�q�)�| MF`.��4���So��y�9�g�D�Z��&�$H���H�ҷ%�Y���,0`I0�{�	z]#�Kf��_���:�Z{e����!�B#�vt�Iޓ�"Qm���őNr��9�G0�b�R�4��N�����fpg$P�^x�.a�D�Ⱦd��<a�����������j]j醝��*��R�,��}�N^���B������.<vvʺ�eic�0�'p��v���"9)�)�{��fՔ1��b���bz�T!�8�L�h�I�TH�׸-�/V��0aQ�xD��-��H��3�W����0|�z�\��������$9���
�K���v��`r8v����rg�d�Y�f{����N&c�M��!�5�.+qRx�z���C�of3[ ����+9`�e*YRJ�����F��zBNUi�� ^|�ͪg�b��<�͢�����n))nz����M��u����uӟUb5e�X�r�<�;kϵ��O7�b��D��?�y������y��$�~xX�E�z�hB91�=��(�t[G��ٚ�5 �6PI�\X^��W�eL|�hYR&rV�����$>=w�Jm���I�=�G �@K���֖+��7ҍ��:S���n����9o��O[��oh��8'�x�`Q�}�`~�a�/D�m0�H<!��Mۡw��̽1�p(u��/6��4���%��6�b�����9Z�Q�g�����:pt�(��4wj���۽�IG@8�������IT�"x�G"� d�i�      �   7   x�3��|��f��fN��\.#�+nv��xcՍ�`cN�(0Ä�#̈���� ��J     