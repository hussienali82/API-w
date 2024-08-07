PGDMP                         |            MD10301    15.4    15.4 ,    <           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            =           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            >           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    58365    MD10301    DATABASE     �   CREATE DATABASE "MD10301" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "MD10301";
                postgres    false            �            1259    58413 	   TblCommit    TABLE     c   CREATE TABLE public."TblCommit" (
    "comSeg" integer NOT NULL,
    "comTyp" character varying
);
    DROP TABLE public."TblCommit";
       public         heap    postgres    false            �            1259    58451    TblCommit_comSeg_seq    SEQUENCE     �   ALTER TABLE public."TblCommit" ALTER COLUMN "comSeg" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."TblCommit_comSeg_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    58420    TblDir    TABLE     `   CREATE TABLE public."TblDir" (
    "dirSeg" integer NOT NULL,
    "dirTyp" character varying
);
    DROP TABLE public."TblDir";
       public         heap    postgres    false            �            1259    58450    TblDir_dirSeg_seq    SEQUENCE     �   ALTER TABLE public."TblDir" ALTER COLUMN "dirSeg" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."TblDir_dirSeg_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220            �            1259    58434    TblHospital    TABLE     f   CREATE TABLE public."TblHospital" (
    "hosSeq" integer NOT NULL,
    "hosName" character varying
);
 !   DROP TABLE public."TblHospital";
       public         heap    postgres    false            �            1259    58449    TblHospital_hosSeq_seq    SEQUENCE     �   ALTER TABLE public."TblHospital" ALTER COLUMN "hosSeq" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."TblHospital_hosSeq_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    222            �            1259    58375    TblInformation    TABLE     =  CREATE TABLE public."TblInformation" (
    "InfSeg" integer,
    "InfRnk" integer,
    "InfNam" character varying,
    "InfYear" character varying,
    "InfDir" integer,
    "		InfPhone" character varying,
    "InfId" character varying,
    "InfDateCome" date,
    "InfNo" character varying,
    "InfBokDate" date
);
 $   DROP TABLE public."TblInformation";
       public         heap    postgres    false            �            1259    58401    TblRank    TABLE     b   CREATE TABLE public."TblRank" (
    "rnkSeg" integer NOT NULL,
    "rnkRank" character varying
);
    DROP TABLE public."TblRank";
       public         heap    postgres    false            �            1259    58448    TblRank_rnkSeg_seq    SEQUENCE     �   ALTER TABLE public."TblRank" ALTER COLUMN "rnkSeg" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."TblRank_rnkSeg_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    58427    TblTest    TABLE     d   CREATE TABLE public."TblTest" (
    "testSeg" integer NOT NULL,
    "testName" character varying
);
    DROP TABLE public."TblTest";
       public         heap    postgres    false            �            1259    58447    TblTest_testSeg_seq    SEQUENCE     �   ALTER TABLE public."TblTest" ALTER COLUMN "testSeg" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."TblTest_testSeg_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221            �            1259    58366    TblTransmit    TABLE     ?  CREATE TABLE public."TblTransmit" (
    "trSeg" integer NOT NULL,
    "trNo" integer,
    "trTypComm" integer,
    "trDateCom" date,
    "trHospital" integer,
    "trTests" integer,
    "trParcode" character varying,
    "trPatint" character varying,
    "trConnct" integer,
    "trDate" date DEFAULT now() NOT NULL
);
 !   DROP TABLE public."TblTransmit";
       public         heap    postgres    false            �            1259    58369    TblTransmit_trSeg_seq    SEQUENCE     �   ALTER TABLE public."TblTransmit" ALTER COLUMN "trSeg" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."TblTransmit_trSeg_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    214            �            1259    58441    hospitalmid    TABLE     i   CREATE TABLE public.hospitalmid (
    id integer NOT NULL,
    "Hospital" integer,
    result integer
);
    DROP TABLE public.hospitalmid;
       public         heap    postgres    false            �            1259    58446    hospitalmid_id_seq    SEQUENCE     �   ALTER TABLE public.hospitalmid ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.hospitalmid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    223            �            1259    58406    users    TABLE     %  CREATE TABLE public.users (
    id integer NOT NULL,
    name text,
    username text,
    passward text,
    roles text,
    "commandID" integer,
    "departmentID" integer,
    "stationID" integer,
    "userLevel" integer,
    created_at date,
    deleted_at date,
    created_by integer
);
    DROP TABLE public.users;
       public         heap    postgres    false            /          0    58413 	   TblCommit 
   TABLE DATA           9   COPY public."TblCommit" ("comSeg", "comTyp") FROM stdin;
    public          postgres    false    219   %1       0          0    58420    TblDir 
   TABLE DATA           6   COPY public."TblDir" ("dirSeg", "dirTyp") FROM stdin;
    public          postgres    false    220   Z1       2          0    58434    TblHospital 
   TABLE DATA           <   COPY public."TblHospital" ("hosSeq", "hosName") FROM stdin;
    public          postgres    false    222   �1       ,          0    58375    TblInformation 
   TABLE DATA           �   COPY public."TblInformation" ("InfSeg", "InfRnk", "InfNam", "InfYear", "InfDir", "		InfPhone", "InfId", "InfDateCome", "InfNo", "InfBokDate") FROM stdin;
    public          postgres    false    216   2       -          0    58401    TblRank 
   TABLE DATA           8   COPY public."TblRank" ("rnkSeg", "rnkRank") FROM stdin;
    public          postgres    false    217   .2       1          0    58427    TblTest 
   TABLE DATA           :   COPY public."TblTest" ("testSeg", "testName") FROM stdin;
    public          postgres    false    221   e2       *          0    58366    TblTransmit 
   TABLE DATA           �   COPY public."TblTransmit" ("trSeg", "trNo", "trTypComm", "trDateCom", "trHospital", "trTests", "trParcode", "trPatint", "trConnct", "trDate") FROM stdin;
    public          postgres    false    214   �2       3          0    58441    hospitalmid 
   TABLE DATA           =   COPY public.hospitalmid (id, "Hospital", result) FROM stdin;
    public          postgres    false    223   �2       .          0    58406    users 
   TABLE DATA           �   COPY public.users (id, name, username, passward, roles, "commandID", "departmentID", "stationID", "userLevel", created_at, deleted_at, created_by) FROM stdin;
    public          postgres    false    218   �2       @           0    0    TblCommit_comSeg_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."TblCommit_comSeg_seq"', 2, true);
          public          postgres    false    229            A           0    0    TblDir_dirSeg_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."TblDir_dirSeg_seq"', 2, true);
          public          postgres    false    228            B           0    0    TblHospital_hosSeq_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."TblHospital_hosSeq_seq"', 2, true);
          public          postgres    false    227            C           0    0    TblRank_rnkSeg_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."TblRank_rnkSeg_seq"', 2, true);
          public          postgres    false    226            D           0    0    TblTest_testSeg_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."TblTest_testSeg_seq"', 2, true);
          public          postgres    false    225            E           0    0    TblTransmit_trSeg_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."TblTransmit_trSeg_seq"', 1, false);
          public          postgres    false    215            F           0    0    hospitalmid_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.hospitalmid_id_seq', 1, false);
          public          postgres    false    224            �           2606    58419    TblCommit TblCommit_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."TblCommit"
    ADD CONSTRAINT "TblCommit_pkey" PRIMARY KEY ("comSeg");
 F   ALTER TABLE ONLY public."TblCommit" DROP CONSTRAINT "TblCommit_pkey";
       public            postgres    false    219            �           2606    58426    TblDir TblDir_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."TblDir"
    ADD CONSTRAINT "TblDir_pkey" PRIMARY KEY ("dirSeg");
 @   ALTER TABLE ONLY public."TblDir" DROP CONSTRAINT "TblDir_pkey";
       public            postgres    false    220            �           2606    58440    TblHospital TblHospital_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public."TblHospital"
    ADD CONSTRAINT "TblHospital_pkey" PRIMARY KEY ("hosSeq");
 J   ALTER TABLE ONLY public."TblHospital" DROP CONSTRAINT "TblHospital_pkey";
       public            postgres    false    222            �           2606    58453    TblRank TblRank_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."TblRank"
    ADD CONSTRAINT "TblRank_pkey" PRIMARY KEY ("rnkSeg");
 B   ALTER TABLE ONLY public."TblRank" DROP CONSTRAINT "TblRank_pkey";
       public            postgres    false    217            �           2606    58433    TblTest TblTest_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public."TblTest"
    ADD CONSTRAINT "TblTest_pkey" PRIMARY KEY ("testSeg");
 B   ALTER TABLE ONLY public."TblTest" DROP CONSTRAINT "TblTest_pkey";
       public            postgres    false    221            �           2606    58381    TblTransmit TblTransmit_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public."TblTransmit"
    ADD CONSTRAINT "TblTransmit_pkey" PRIMARY KEY ("trSeg");
 J   ALTER TABLE ONLY public."TblTransmit" DROP CONSTRAINT "TblTransmit_pkey";
       public            postgres    false    214            �           2606    58445    hospitalmid hospitalmid_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.hospitalmid
    ADD CONSTRAINT hospitalmid_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.hospitalmid DROP CONSTRAINT hospitalmid_pkey;
       public            postgres    false    223            �           2606    58412    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    218            /   %   x�3伱��ƛ]7�rq�l�����+�b���� ن1      0   Q   x�3��zc�ͮ�x��7[n,����VK�f�y��Ǝ��`y���@�H�Aڸ�����f��NsՍ�P�1z\\\ ��J?      2   F   x�3��zc�U7��l�٩pc�͖kn�ɕ��[o���uc%����@�pe�o��l������� 8�4v      ,      x������ � �      -   '   x�3��zcō�@r��7�n����e�2c���� ���      1   J   x�3��xc퍭
7��l��t���
�+@ ��|��ˈ���7�n,��Q��(�r���*�|W� �)z      *      x������ � �      3      x������ � �      .   �   x�3��zc�ͮ���7�ol�LL����T1JT14P�7�N,/,�((I+�q,.���wʉ4�O1,M�t+3�(K�J�H
�ˮ2O��vt����4�4�4B##c]C]##�? �24��&)�.4�5j�!�.K]#K�]1z\\\ b�H�     