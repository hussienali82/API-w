
--done
CREATE TABLE if not exists users(
     id                          SERIAL PRIMARY KEY,
     name                        text NOT NULL UNIQUE,
     username                    text NOT NULL UNIQUE,
     password                    text NOT NULL,
     roles                       text  DEFAULT '[]' NOT NULL,
     status                      BOOLEAN DEFAULT true NOT NULL ,
     created_at                  timestamptz DEFAULT now()  NOT NULL ,
     created_by                  INT ,
     FOREIGN KEY (created_by) REFERENCES users(id)
)
;
--done
create table if not exists approval_type (
    id                           SERIAL PRIMARY KEY,
    apptype                      text not null,
    created_at                   timestamptz  DEFAULT now()  NOT NULL ,
    created_by                   INT,
    updated_at                   timestamptz  DEFAULT  NULL ,
    updated_by                   INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id)
)
;
--done
create table if not exists app_weapon_type (
    id                           SERIAL PRIMARY KEY,
    appweap                      text not null,
    created_at                   timestamptz  DEFAULT now()  NOT NULL ,
    created_by                   INT,
    updated_at                   timestamptz  DEFAULT NULL ,
    updated_by                   INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id)
)
;
--done
create table if not exists app_person_type (
    id                            SERIAL PRIMARY KEY,
    app_person                    text not null,
    created_at                    timestamptz  DEFAULT now()  NOT NULL ,
    created_by                    INT,
    updated_at                    timestamptz  DEFAULT NULL ,
    updated_by                    INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id)
)
;
--done
create table if not exists category  (
    id                            SERIAL PRIMARY KEY,
    cat                           text not null,
    created_at                    timestamptz  DEFAULT now()  NOT NULL ,
    created_by                    INT,
    updated_at                    timestamptz  DEFAULT  NULL ,
    updated_by                    INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id)
)
;

--done
create table if not exists possession (
    id                           SERIAL PRIMARY KEY,
    poss                         text not null,
    created_at                   timestamptz  DEFAULT now()  NOT NULL ,
    created_by                   INT,
    updated_at                   timestamptz  DEFAULT NULL ,
    updated_by                   INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id)
)
;
--done
create table if not exists  license_type (
    id                        SERIAL PRIMARY KEY,
    license                   text not null,
    created_at                timestamptz  DEFAULT now()  NOT NULL ,
    created_by                INT,
    updated_at                timestamptz  DEFAULT NULL ,
    updated_by                INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id)
)
;
--done
create table if not exists province (
    id                         SERIAL PRIMARY KEY,
    pro                        text not null,
    created_at                 timestamptz  DEFAULT now()  NOT NULL ,
    created_by                 INT,
    updated_at                 timestamptz  DEFAULT NULL ,
    updated_by                 INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id)
)
;
-- done
create table if not exists gender (
    id                             SERIAL PRIMARY KEY,
    gen                            text not null,
    created_at                     timestamptz  DEFAULT now()  NOT NULL ,
    created_by                     INT,
    updated_at                     timestamptz  DEFAULT null  ,
    updated_by                     INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id)
)
;
--done
create table if not exists weapon_name (
    id                           SERIAL PRIMARY KEY,
    weapon_name                  text not null,
    weapon_size                  text not null,
    created_at                   timestamptz  DEFAULT now()  NOT NULL ,
    created_by                   INT,
    updated_at                   timestamptz  DEFAULT null  ,
    updated_by                   INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id)
)
;
--done
create table if not exists issuer (
    id                         SERIAL PRIMARY KEY,
    iss                        text not null,
    created_at                 timestamptz  DEFAULT now()  NOT NULL ,
    created_by                 INT,
    updated_at                 timestamptz  DEFAULT null ,
    updated_by                 INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id)
)
;

create table if not exists issuer_nat (
    id                         SERIAL PRIMARY KEY,
    iss                        text not null,
    created_at                 timestamptz  DEFAULT now()  NOT NULL ,
    created_by                 INT,
    updated_at                 timestamptz  DEFAULT null ,
    updated_by                 INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id)
)
;

CREATE TYPE status AS ENUM ('PENDING', 'APPROVED', 'DECLINED');
-----------------------------------------------------------------------------------------------
create table if not exists requests (
    id                    uuid DEFAULT gen_random_uuid() PRIMARY KEY ,
    name1                 text Not Null,
    name2                 text Not Null,
    name3                 text Not Null,
    name4                 text Not Null,
    surname               text,
    profession            text Not Null,
    birdate               timestamptz Not Null,
    gen_id                INT not Null,
    monam1                text Not Null,
    monam2                text Not Null,
    monam3                text Not Null,
    idnum                 text Not Null,
    pro_id                INT Not Null,
    addresses             text Not Null,
    phone                 text Not Null,
    note                  text,
    created_at            timestamptz  DEFAULT now()  NOT NULL ,
    created_by            INT DEFAULT null,
    updated_at            timestamptz DEFAULT null  ,
    updated_by            INT DEFAULT null,
    FOREIGN KEY (cat_id) REFERENCES category(id),
    FOREIGN KEY (gen_id) REFERENCES gender(id),
    FOREIGN KEY (pro_id) REFERENCES province(id)
)
;


--done
create table if not exists requests_details (
    id                    uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    req_id                uuid not null,
    license_id            INT Not Null,
    name1                 text Not Null,
    name2                 text Not Null,
    name3                 text Not Null,
    name4                 text Not Null,
    surname               text,
    cat_id                INT Not Null,
    birdate               timestamptz Not Null,
    gen_id                INT Not Null,
    monam1                text Not Null,
    monam2                text Not Null,
    monam3                text Not Null,
    idnum                 text Not Null,
    iss_id1               INT Not Null,
    issdat1               date Not Null,
    natnum                text Not Null,
    iss_id2               INT Not Null,
    issdat2               timestamptz Not Null,
    pro_id                INT Not Null,
    addresses             text Not Null,
    nearplace             text Not Null,
    mahala                text Not Null,
    zuqaq                 text Not Null,
    dar                   text Not Null,
    djp                   text,
    numdet                text,
    datedet               timestamptz,
    phone                 text Not Null,
    weapname_id           INT Not Null,
    weapnum               text Not Null,
    weapsize_id           INT Not Null,
    apptype_Id            INT Not Null,
    appnum                text Not Null,
    appdate               text Not Null,
    wea_hold_per          text Not Null,
    margin_app            text Not Null,
    note                  text,
    created_at            timestamptz  DEFAULT now()  NOT NULL ,
    created_by            INT,
    updated_at            timestamptz  DEFAULT null,
    updated_by            INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (req_id) REFERENCES requests(id),
    FOREIGN KEY (cat_id) REFERENCES category(id),
    FOREIGN KEY (gen_id) REFERENCES gender(id),
    FOREIGN KEY (iss_id1) REFERENCES issuer(id),
    FOREIGN KEY (iss_id2) REFERENCES issuer_nat(id),
    FOREIGN KEY (pro_id) REFERENCES province(id),
    FOREIGN KEY (apptype_Id) REFERENCES approval_type(id),
    FOREIGN KEY (license_id) REFERENCES license_type(id),
    FOREIGN KEY (weapname_id) REFERENCES weapon_name(id),
    FOREIGN KEY (weapsize_id) REFERENCES weapon_name(id)
)
;
create table if not exists prev_weapons (
    id                             SERIAL PRIMARY KEY,
    req_det_id                     uuid not null,
    weapname_prev_id               INT Not Null,                  
    weapnum_prev                   text Not Null, 
    weapsize_prev_id               INT Not Null,
    ident_prev_num                 INT Not Null,
    note                           text,
    created_at                     timestamptz  DEFAULT now()  NOT NULL ,
    created_by                     INT  DEFAULT null,
    updated_at                     timestamptz  DEFAULT null,
    updated_by                     INT  DEFAULT null,
    FOREIGN KEY (req_det_id) REFERENCES requests_details(id),
    FOREIGN KEY (weapname_prev_id) REFERENCES weapon_name(id),
    FOREIGN KEY (weapsize_prev_id) REFERENCES weapon_name(id)

)
;
--------------------------------------------------------------------------------
--done
create table if not exists information_person (
    id                        uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name1                     text Not Null,
    name2                     text Not Null,
    name3                     text Not Null,
    name4                     text Not Null,
    surname                   text,
    papernum                  INT Not Null,
    birdate                   timestamptz Not Null,
    gen_id                    INT Not Null,
    monam1                    text Not Null,
    monam2                    text Not Null,
    monam3                    text Not Null,
    idnum                     text Not Null,
    iss_id1                   INT Not Null,
    issdat1                   timestamptz Not Null,
    natnum                    text Not Null,
    iss_id2                   INT Not Null,
    issdat2                   timestamptz Not Null,
    note                      text,
    created_at                timestamptz  DEFAULT now()  NOT NULL ,
    created_by                INT,
    updated_at                timestamptz DEFAULT null ,
    updated_by                INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (gen_id) REFERENCES gender(id),
    FOREIGN KEY (iss_id1) REFERENCES issuer(id),
    FOREIGN KEY (iss_id2) REFERENCES issuer_nat(id)
)
;

--done
create table if not exists addresses (
    id                        uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    info_id                   uuid Not Null,             
    pro_id                    INT Not Null,
    addresses                 text Not Null,
    nearplace                 text Not Null,
    mahala                    text Not Null,
    zuqaq                     text Not Null,
    dar                       text Not Null,
    phone                     text Not Null,
    created_at                timestamptz  DEFAULT now()  NOT NULL ,
    created_by                INT,
    updated_at                timestamptz DEFAULT null ,
    updated_by                INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (info_id) REFERENCES information_person(id),
    FOREIGN KEY (pro_id) REFERENCES province(id)
)
;
--done
create table if not exists jobs (
    id                         uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    info_id                    uuid Not Null,             
    cat_id                     INT Not Null,
    djp                        text Not Null,
    numdet                     text Not Null,
    datedet                    timestamptz Not Null,
    created_at                 timestamptz  DEFAULT now()  NOT NULL ,
    created_by                 INT,
    updated_at                 timestamptz DEFAULT null ,
    updated_by                 INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (info_id) REFERENCES information_person(id),
    FOREIGN KEY (cat_id) REFERENCES category(id)
)
;
--done
create table if not exists biometric (
    id                        uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    info_id                   uuid Not Null,
    pict                      text,
    iris                      text,
    fing_right                text Not Null,
    fing_left                 text Not Null,
    note                      text,
    created_at                timestamptz  DEFAULT now()  NOT NULL ,
    created_by                INT,
    updated_at                timestamptz DEFAULT null ,
    updated_by                INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (info_id) REFERENCES information_person(id)

)
;
--done
create table if not exists person_approvals (
    id                       uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    info_id                  uuid not null,
    app_id                   INT not null,
    status                   status not null DEFAULT 'PENDING',
    reason                   text,
    created_at               timestamptz  DEFAULT now()  NOT NULL ,
    created_by               INT,
    updated_at               timestamptz DEFAULT null ,
    updated_by               INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (info_id) REFERENCES information_person(id),
    FOREIGN KEY (app_id) REFERENCES app_person_type(id)
)
;

--------------------------------------------------------------------------
--done
create table if not exists weapon (
    id                       uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    info_id                  uuid Not Null,
    req_det_id               uuid Not Null,
    license_id               INT Not Null,
    poss_id                  INT Not Null,
    weapname_id              INT Not Null,
    weapnum                  text Not Null,
    weapsize_id              INT Not Null,
    datedet                  timestamptz Not Null,
    note                     text,
    created_at               timestamptz  DEFAULT now()  NOT NULL ,
    created_by               INT,
    updated_at               timestamptz DEFAULT null ,
    updated_by               INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (info_id) REFERENCES information_person(id),
    FOREIGN KEY (req_det_id) REFERENCES requests_details(id),
    FOREIGN KEY (poss_id) REFERENCES possession(id),
    FOREIGN KEY (license_id) REFERENCES license_type(id), 
    FOREIGN KEY (weapname_id) REFERENCES weapon_name(id),
    FOREIGN KEY (weapsize_id) REFERENCES weapon_name(id) 

)
;

--done
create table if not exists identification (
    id                         uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    info_id                    uuid not null,
    weapon_id                  uuid not null,
    req_det_id                 uuid not null,
    printtime                  date not null,
    idnum                      INT not null,
    expdate                    timestamptz not null,
    permdate                   timestamptz,
    note                       text not null,
    created_at                 timestamptz  DEFAULT now()  NOT NULL ,
    created_by                 INT,
    updated_at                 timestamptz DEFAULT null ,
    updated_by                 INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (info_id) REFERENCES information_person(id),
    FOREIGN KEY (weapon_id) REFERENCES weapon(id),
    FOREIGN KEY (req_det_id) REFERENCES requests_details(id)
)
;

--done
create table if not exists weapon_approvals (
    id                         uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    info_id                    uuid not null,
    weapon_id                  uuid not null,
    approval_id                INT not null,
    status                     status not null DEFAULT 'PENDING',
    reason                     text,
    booknum                    text,
    bookdate                   timestamptz,
    note                       text,
    created_at                 timestamptz  DEFAULT now()  NOT NULL ,
    created_by                 INT,
    updated_at                 timestamptz DEFAULT null ,
    updated_by                 INT,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (info_id) REFERENCES information_person(id),
    FOREIGN KEY (weapon_id) REFERENCES weapon(id),
    FOREIGN KEY (approval_id) REFERENCES app_weapon_type(id)
)
;

