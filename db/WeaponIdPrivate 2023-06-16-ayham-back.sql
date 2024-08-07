PGDMP     &    	                {            weaponid    15.2    15.2 E    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
          public          postgres    false    215            �            1259    49385 	   approvals    TABLE     "  CREATE TABLE public.approvals (
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
          public          postgres    false    225            �            1259    49431    requests_details    TABLE     �  CREATE TABLE public.requests_details (
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
    iss_1 text,
    issdat1 date,
    natnum text NOT NULL,
    iss_2 text,
    issdat2 timestamp with time zone,
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
    weapname_id integer,
    weapnum text,
    wea_hold_per text,
    margin_app text,
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
   TABLE DATA                 public          postgres    false    214   �Q       q          0    49385 	   approvals 
   TABLE DATA                 public          postgres    false    216   �R       r          0    49392 	   biometric 
   TABLE DATA                 public          postgres    false    217   eV       s          0    49399    category 
   TABLE DATA                 public          postgres    false    218   {X       u          0    49405    identification 
   TABLE DATA                 public          postgres    false    220   0Y       v          0    49412    license_type 
   TABLE DATA                 public          postgres    false    221   JY       x          0    49418    province 
   TABLE DATA                 public          postgres    false    223   �Y       z          0    49424    requests 
   TABLE DATA                 public          postgres    false    225   tZ       {          0    49431    requests_details 
   TABLE DATA                 public          postgres    false    226   c\       �          0    164041    subidentity 
   TABLE DATA                 public          postgres    false    231   c`       |          0    49438    users 
   TABLE DATA                 public          postgres    false    227   Ga       ~          0    49447    weapon_name 
   TABLE DATA                 public          postgres    false    229   �f       �           0    0    app_person_type_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.app_person_type_id_seq', 8, true);
          public          postgres    false    215            �           0    0    category_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.category_id_seq', 6, true);
          public          postgres    false    219            �           0    0    license_type_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.license_type_id_seq', 5, true);
          public          postgres    false    222            �           0    0    province_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.province_id_seq', 7, true);
          public          postgres    false    224            �           0    0    subidentity_sudid_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.subidentity_sudid_seq', 6, true);
          public          postgres    false    232            �           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 19, true);
          public          postgres    false    228            �           0    0    weapon_name_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.weapon_name_id_seq', 2, true);
          public          postgres    false    230            o   �   x���v
Q���W((M��L�K,((�/K̉OI-.��K,���S��L�Q@�Q(��I�/�,H�Q��(H,*�Ts�	uV�0�QP���fˍ�7�ɕ
`Κ�m@�e7�n�T�Q0"Mk.O:��U76m�ق��3�h�#Dhl:eݍ@�F ^E�`0�ٿ�f��Nh����
�s�n6��
q�v�{��@둭�����sq h`8k      q   �  x���jG��z���M����ꏚ��A ��\E̀�F�hg>ڱ�уDr�b��y���Iͮ䬜U�|��Q��=3����6�?��I����b2���4
����Oa<-��aqP����&쎧;}��1wN��=�p��i�ٴ���{�"���7�a��T�bo��&�Ty'4���ٰ�M�������ۜ�v���f����kv�g���z��q�`@U�|�� k�@�kAR�0S�Bi0,*$��xA�@+��>$a�u.���b���ְP<�{�wGݫ�������H�BZ�l!e9?��z�b��HU�+Q�����?|lq�z �=��ؼ��tt�RB�B�Lv����$������d����!�l_�~�^�yԾ>7!�u	8��Q�S���Yx`��7ID�Yd���q�5��u�)�1�����=nO�z��1���x�Ρ�A��<4��NF�p�8���>!�'��*bQ�5����%��^Sl��0�hI���b�:Z-|��/�g�U�*֐bmCvan�˸�Ml��#/����ی-F
$�.��#c>� L����ӯ�'�h�����T��&�EJf@)k����푌����!o��@	4"v �;/8Dm9�d{T2	��cm� s��� ���sx��Y{R��J����!�v'�Q����R�ȁv����Vғ��ya*���C����g��	�\�ё��;��	��U���5ؐ|X�������Բ=B���&aJ�"�,��Py+b�M�j��G
k�[�m���<e�ͥw�������$xؾ�3��+Pr:C\�I��\F��bDAg�֘�2��(�����(����g�w�{,Si��6{6�{�������牥���N������0�&_ע�V�k�����.�X�q?#�+)^�Ώ4��)�q�j��EF���7��7      r     x�͓�j1��y��%��A�mٞ�����!���e�)��h޾H�k�ma0��K���ٜ��|:6����c�Yʔ��ۺX�p��8얲��a�2m���Ҵ���ތ�����Cy�i_�j�{���8<����%�O�������pt�5��E�*؈HMѰe��p������u}�3�����[�>﮻��b��RZJ�z��%����1�jK�4����E�����3��ЫSN��V�������� 
�H3�Lvr,��;4]~��y2��g����Ϳ�T��^�[v`M��p��ɧZ���R$P��؀ � �j��$a� ��:�V�!�u��8�m� 9�ŷ���]+,�w��V�&P�`܌f�H�- Ff� \@�����V�
�Wc�U����昃iJ��jk�R
um�1�B����S��� |)��WP�A�@IU�IvM��^`�^[5@>��Ei�-��(���9�1�	�xf?s��8"�G �&�l&'�� � �;�      s   �   x���v
Q���W((M��L�KN,IM�/�T��L�Q �4�}B]�4u�ol���f׍��\�$�6��zc��7[ov���d��kn�(�X~c'Ш�7[H7�d�V�	�n�"]�)H�` �S����xc%�Ƙ��Y~c�U@r�5�@�	,\\ �<��      u   
   x���          v   ]   x���v
Q���W((M��L��Լ����ʂT�����B��O�k���������7�n,����JuMk.O��1B1G�f��z�d  �S:w      x   �   x���v
Q���W((M��L�+(�/��KNU��L�Q ���sS5�}B]�4Lt�o,��r��ƚ��
 ��7���x�Q]Ӛ˓tA&�����z�A��4��,�A[ol���Lc��� Xq��f����ܲhH��v��l�rc��dar�-�h��� ����      z   �  x���N�0�����dd;�m���H��T��Q.����Tb��ċ�"��*<I�6;���b]�9�ϱ�,���������-*��c�K���U]��4qQ�4��ߧ�EUS墢̗���<sQ��IXC�Hg�.�qqX/��*�2d:dpL��YY#{,L�u�yYn<�R�w��::vQS$����?/�����.z�fv���vI5�T���8�PG���bD��;.r����ݴ?��vۮ����V/��;����vk�/s�;����A<�.{ҼS���#a<�땝D�s��|�g� �v�݉�(ɸ�J:Ck�ߐ���X���l:7�	��c�@������it%�i���z4����D1�ȓ2&^ H�IN!H�X���_j�M��˞�-�o�}���KC�K��6��1�G?殁K,c�K!��}�k\�`�,H�bB脲	�@b/�d4��L�      {   �  x��V�n�F��)xS�j��%w���z����M�+��PMJ.�[Z��=�-���	�6�]J��:��c��G��ͮ�����G?<���|�3]�~�Ng��֙uS5,�����#�f^���.�,�ə*�jR�~4V#G:A;w"�G���Z?:vc�l�����!�VVM�0��YK��ehǳ���H���[;��A�����\]�\���B�NT���ϳSuڏ���������-S��d2�?9U��C���AA�N&��JW����p�����&��pBN��L�|�LMou���J��oto/+w� �CeN�g.�z8�i54�������>z=�i!��@����D:$��+�L�z��G�d�p��Ԁ� ���-��`��$�'��k�U{�\�������m	��k�
�U{�E{���^�s�����i�0G�E�������溝7��7�0� �i�:c�%Ґ}o'��(v%�#L���&1�R
y���.^����B���]������B��Ɵ�����'돔�g�8�K:��% �h�'�v{h<"t@ـ�}�Ewp�������(�! k8����ᑐ�4�K�EX�%�A)��!��N��������|e��~�L�K��XͱE:U�aMNc��R�1	�q����H9EB%#R*L6�E?b$P�����|͛�w���r�'<�Vͥ_�� >_�-O������>��]n����u��2T�aw�r�?6��� ����K���A$�Λ�ɏ�^�{�ަ�oƓOfL8D�ǜޗ�'���暡$6Ib8��� �9C�2�Ka|*�Ԝp�
���8�R��w"	�4�8���K`��3=�oe�a��s���+��}�e.�k>��r�C����.V�X�oױ��{CW�\�gw�w���=G>����[��k ^n��
p7C?��jw��?$/�� >1�o�H�� ��W@l,ʡP"q����[ӄZ-}������      �   �   x���v
Q���W((M��L�+.M�LI�+�,�T�(.M�L�Q Ry���`FQiNIeA����kP������Bpdp���B��O�+�V�0�QP��zc덍7�*�l��q������u�5��<ih�1���7�n6��lDc�M@67�X~�hi�ڕ
@N]�`���F`�o�����m@c�M�v���7b�;��7��;��H7�X	��� s!      |   \  x�՗�n�H���VU���83���
��`���&20$�������^���<ȶ�ڮڪ�W����Tmw��6B�0��32��}�oT��T딪�u�{c�O�S�O�� E�绑1>��p9�6NQ�;�#ϘNO\��;b�L��O��~`FF`�N�������R�����!v짨i80)��T���j�֩Օ2���7��{�z ��5��S��ųţ�����kj�r�t���/��m:�rt�1�Ap/R�2�tMq0��ݚ�s�i�l~��<)k�!���
�h1G�Y���]mw7�!N�]?�ez�D5�c����xJJ�7�`S��s���W��ju��� )Ȥ91�AZ H?vs|��uK�o"�O������������I��QX4���qd�z�V�^�R�Gw=O�._�4FB���C���Ħ!H�F�C�Ob�HQ̗�����w�Wd�~~���%(IHGެ2�N�f�>�����N�}����ZS;�v<�}�ե��s3-��F�����#R@J3(���9��@�&��on&1!���������=�\<� �	@�z���e������;5�U�Y)����V"#v'{��B����a֡onvW �+B܊��fDI���+����#$��	ϫ5��KV@l��z&�U��8�~�ջJ�͖�j�0V�9��ú��x���������+��D�l�� ���W��9q�7����u�f�����Ϫ	j���rm�G'��W`5�<mAe�'�􇥣�R�g�6r�ƾ����ڝ�p�f�R��ȏ[�yI���%��D��|V�i|�<��AuO3g:�bA�,��%���|藆]������RV���ú �#iADA1̀4h��Yq�aI#�hO/�/�EQ;kS��L�p���`Vot�h��aT��v1<�m-VؗӪ�GVoOխ��E�L��>���ܭ�-��-@�������ǋ��b$&[�"ZF^(�:��X����Qh7�;T�!��2����I���팠O0-_+[�($')��?Ȱ�t��E��ڒ��I:(� �I$��|W�C� wi��ĩ ��q<ӆXAvP�1B�1��zנs�p� �~<h�M2�T�jJ����~�,��ϯt�ds�Ęm�
~/�s<���kN���t�Ǘ���#Y���Vȷ&�~��'�hh�i$�/.��͘HJ.;�#����_�Y"�%O�ݲ�1�Y^�ȕ8�Ny�[AȖ4�&mV�f]UՎ<��R��DO%�n���QW\��������3��ݙ�iȮoͪ�ӽ�Q72jxO�mz�F$O�S�-��U���ho�"ڷ��$�!V��Q�Ν��=f      ~   `   x���v
Q���W((M��L�+OM,�ϋ�K�MU��L�Q@�s�3�R5�}B]�4u�Ձ�en���5�'U�5x��f��f�� ��� O�9B     