/*==============================================================*/
/* Nom de SGBD :  Sybase SQL Anywhere 11                        */
/* Date de création :  30/04/2020 14:48:06                      */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_CARTEFID_DETENIR2_CLIENT') then
    alter table CARTEFIDELITE
       delete foreign key FK_CARTEFID_DETENIR2_CLIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CATEGORI_POSSEDER_RAYON') then
    alter table CATEGORIEPRODUIT
       delete foreign key FK_CATEGORI_POSSEDER_RAYON
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CLIENT_DETENIR_CARTEFID') then
    alter table CLIENT
       delete foreign key FK_CLIENT_DETENIR_CARTEFID
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CLIENT_HABITER_ADRESSE') then
    alter table CLIENT
       delete foreign key FK_CLIENT_HABITER_ADRESSE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_COMMANDE_ATTRIBUER_EMPLOYE') then
    alter table COMMANDE
       delete foreign key FK_COMMANDE_ATTRIBUER_EMPLOYE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_COMMANDE_PASSER_CLIENT') then
    alter table COMMANDE
       delete foreign key FK_COMMANDE_PASSER_CLIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EMPLOYE_LOGER_ADRESSE') then
    alter table EMPLOYE
       delete foreign key FK_EMPLOYE_LOGER_ADRESSE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_FOURNISS_LOCALISER_ADRESSE') then
    alter table FOURNISSEUR
       delete foreign key FK_FOURNISS_LOCALISER_ADRESSE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LIGNECOM_LIGNECOMM_PRODUIT') then
    alter table LIGNECOMMANDE
       delete foreign key FK_LIGNECOM_LIGNECOMM_PRODUIT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LIGNECOM_LIGNECOMM_COMMANDE') then
    alter table LIGNECOMMANDE
       delete foreign key FK_LIGNECOM_LIGNECOMM_COMMANDE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PRODUIT_CONTENIR_CATEGORI') then
    alter table PRODUIT
       delete foreign key FK_PRODUIT_CONTENIR_CATEGORI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PRODUIT_VENDRE_FOURNISS') then
    alter table PRODUIT
       delete foreign key FK_PRODUIT_VENDRE_FOURNISS
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ADRESSE_PK'
     and t.table_name='ADRESSE'
) then
   drop index ADRESSE.ADRESSE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='ADRESSE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table ADRESSE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_13_FK'
     and t.table_name='CARTEFIDELITE'
) then
   drop index CARTEFIDELITE.ASSOCIATION_13_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='CARTEFIDELITE_PK'
     and t.table_name='CARTEFIDELITE'
) then
   drop index CARTEFIDELITE.CARTEFIDELITE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='CARTEFIDELITE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table CARTEFIDELITE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_10_FK'
     and t.table_name='CATEGORIEPRODUIT'
) then
   drop index CATEGORIEPRODUIT.ASSOCIATION_10_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='CATEGORIEPRODUIT_PK'
     and t.table_name='CATEGORIEPRODUIT'
) then
   drop index CATEGORIEPRODUIT.CATEGORIEPRODUIT_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='CATEGORIEPRODUIT'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table CATEGORIEPRODUIT
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_12_FK'
     and t.table_name='CLIENT'
) then
   drop index CLIENT.ASSOCIATION_12_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_11_FK'
     and t.table_name='CLIENT'
) then
   drop index CLIENT.ASSOCIATION_11_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='CLIENT_PK'
     and t.table_name='CLIENT'
) then
   drop index CLIENT.CLIENT_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='CLIENT'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table CLIENT
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_8_FK'
     and t.table_name='COMMANDE'
) then
   drop index COMMANDE.ASSOCIATION_8_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='PASSER_FK'
     and t.table_name='COMMANDE'
) then
   drop index COMMANDE.PASSER_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='COMMANDE_PK'
     and t.table_name='COMMANDE'
) then
   drop index COMMANDE.COMMANDE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='COMMANDE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table COMMANDE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_14_FK'
     and t.table_name='EMPLOYE'
) then
   drop index EMPLOYE.ASSOCIATION_14_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='EMPLOYE_PK'
     and t.table_name='EMPLOYE'
) then
   drop index EMPLOYE.EMPLOYE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='EMPLOYE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table EMPLOYE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_15_FK'
     and t.table_name='FOURNISSEUR'
) then
   drop index FOURNISSEUR.ASSOCIATION_15_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='FOURNISSEUR_PK'
     and t.table_name='FOURNISSEUR'
) then
   drop index FOURNISSEUR.FOURNISSEUR_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='FOURNISSEUR'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table FOURNISSEUR
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_16_FK'
     and t.table_name='LIGNECOMMANDE'
) then
   drop index LIGNECOMMANDE.ASSOCIATION_16_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_9_FK'
     and t.table_name='LIGNECOMMANDE'
) then
   drop index LIGNECOMMANDE.ASSOCIATION_9_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_9_PK'
     and t.table_name='LIGNECOMMANDE'
) then
   drop index LIGNECOMMANDE.ASSOCIATION_9_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='LIGNECOMMANDE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table LIGNECOMMANDE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_7_FK'
     and t.table_name='PRODUIT'
) then
   drop index PRODUIT.ASSOCIATION_7_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ASSOCIATION_6_FK'
     and t.table_name='PRODUIT'
) then
   drop index PRODUIT.ASSOCIATION_6_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='PRODUIT_PK'
     and t.table_name='PRODUIT'
) then
   drop index PRODUIT.PRODUIT_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='PRODUIT'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table PRODUIT
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='RAYON_PK'
     and t.table_name='RAYON'
) then
   drop index RAYON.RAYON_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='RAYON'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table RAYON
end if;

/*==============================================================*/
/* Table : ADRESSE                                              */
/*==============================================================*/
create table ADRESSE 
(
   IDADRESSE            integer                        not null default autoincrement,
   LIGNEADRESSE1        char(10)                       not null,
   LIGNEADRESSE2        char(10)                       null,
   VILLE                char(10)                       not null,
   CODEPOSTAL           char(10)                       not null,
   PAYS                 char(10)                       null,
   constraint PK_ADRESSE primary key (IDADRESSE)
);

/*==============================================================*/
/* Index : ADRESSE_PK                                           */
/*==============================================================*/
create unique index ADRESSE_PK on ADRESSE (
IDADRESSE ASC
);

/*==============================================================*/
/* Table : CARTEFIDELITE                                        */
/*==============================================================*/
create table CARTEFIDELITE 
(
   IDCARTEFIDELITE      integer                        not null default autoincrement,
   IDCLIENT             integer                        not null,
   NBPOINTSFIDELITE     integer                        not null,
   constraint PK_CARTEFIDELITE primary key (IDCARTEFIDELITE)
);

/*==============================================================*/
/* Index : CARTEFIDELITE_PK                                     */
/*==============================================================*/
create unique index CARTEFIDELITE_PK on CARTEFIDELITE (
IDCARTEFIDELITE ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_13_FK                                    */
/*==============================================================*/
create index ASSOCIATION_13_FK on CARTEFIDELITE (
IDCLIENT ASC
);

/*==============================================================*/
/* Table : CATEGORIEPRODUIT                                     */
/*==============================================================*/
create table CATEGORIEPRODUIT 
(
   IDCATEGORIE          integer                        not null default autoincrement,
   IDRAYON              integer                        null,
   NOMCATEGORIE         varchar(25)                    not null,
   DESCRIPTIONCATEGORIE varchar(75)                    not null,
   constraint PK_CATEGORIEPRODUIT primary key (IDCATEGORIE)
);

/*==============================================================*/
/* Index : CATEGORIEPRODUIT_PK                                  */
/*==============================================================*/
create unique index CATEGORIEPRODUIT_PK on CATEGORIEPRODUIT (
IDCATEGORIE ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_10_FK                                    */
/*==============================================================*/
create index ASSOCIATION_10_FK on CATEGORIEPRODUIT (
IDRAYON ASC
);

/*==============================================================*/
/* Table : CLIENT                                               */
/*==============================================================*/
create table CLIENT 
(
   IDCLIENT             integer                        not null default autoincrement,
   IDADRESSE            integer                        null,
   IDCARTEFIDELITE      integer                        null,
   NOM                  varchar(25)                    not null,
   PRENOM               varchar(25)                    not null,
   MAIL                 varchar(50)                    not null,
   TELEPHONE            varchar(10)                    null,
   MOTDEPASSE           varchar(25)                    null,
   GENRE                long varchar                   null,
   DATENAISSANCE        date                           null,
   constraint PK_CLIENT primary key (IDCLIENT)
);

/*==============================================================*/
/* Index : CLIENT_PK                                            */
/*==============================================================*/
create unique index CLIENT_PK on CLIENT (
IDCLIENT ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_11_FK                                    */
/*==============================================================*/
create index ASSOCIATION_11_FK on CLIENT (
IDADRESSE ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_12_FK                                    */
/*==============================================================*/
create index ASSOCIATION_12_FK on CLIENT (
IDCARTEFIDELITE ASC
);

/*==============================================================*/
/* Table : COMMANDE                                             */
/*==============================================================*/
create table COMMANDE 
(
   IDCOMMANDE           integer                        not null default autoincrement,
   IDEMPLOYE            integer                        not null,
   IDCLIENT             integer                        not null,
   DATECOMMANDE         timestamp                      not null,
   STATUTCOMMANDE       varchar(30)                    null,
   constraint PK_COMMANDE primary key (IDCOMMANDE)
);

/*==============================================================*/
/* Index : COMMANDE_PK                                          */
/*==============================================================*/
create unique index COMMANDE_PK on COMMANDE (
IDCOMMANDE ASC
);

/*==============================================================*/
/* Index : PASSER_FK                                            */
/*==============================================================*/
create index PASSER_FK on COMMANDE (
IDCLIENT ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_8_FK                                     */
/*==============================================================*/
create index ASSOCIATION_8_FK on COMMANDE (
IDEMPLOYE ASC
);

/*==============================================================*/
/* Table : EMPLOYE                                              */
/*==============================================================*/
create table EMPLOYE 
(
   IDEMPLOYE            integer                        not null default autoincrement,
   IDADRESSE            integer                        null,
   NOM                  varchar(25)                    not null,
   PRENOM               varchar(25)                    not null,
   MAIL                 varchar(50)                    not null,
   TELEPHONE            varchar(10)                    null,
   SALAIRE              decimal(15,2)                  null,
   GENRE                long varchar                   null,
   DATENAISSANCE        date                           null,
   constraint PK_EMPLOYE primary key (IDEMPLOYE)
);

/*==============================================================*/
/* Index : EMPLOYE_PK                                           */
/*==============================================================*/
create unique index EMPLOYE_PK on EMPLOYE (
IDEMPLOYE ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_14_FK                                    */
/*==============================================================*/
create index ASSOCIATION_14_FK on EMPLOYE (
IDADRESSE ASC
);

/*==============================================================*/
/* Table : FOURNISSEUR                                          */
/*==============================================================*/
create table FOURNISSEUR 
(
   IDFOURNISSEUR        char(10)                       not null,
   IDADRESSE            integer                        null,
   NOMFOURNISSEUR       char(10)                       not null,
   MAIL                 varchar(50)                    not null,
   TELEPHONE            varchar(10)                    null,
   DESCRIPTIONFOURNISSEUR varchar(75)                    null,
   constraint PK_FOURNISSEUR primary key (IDFOURNISSEUR)
);

/*==============================================================*/
/* Index : FOURNISSEUR_PK                                       */
/*==============================================================*/
create unique index FOURNISSEUR_PK on FOURNISSEUR (
IDFOURNISSEUR ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_15_FK                                    */
/*==============================================================*/
create index ASSOCIATION_15_FK on FOURNISSEUR (
IDADRESSE ASC
);

/*==============================================================*/
/* Table : LIGNECOMMANDE                                        */
/*==============================================================*/
create table LIGNECOMMANDE 
(
   IDPRODUIT            integer                        not null,
   IDCOMMANDE           integer                        not null,
   QUANTITE             integer                        not null,
   PRIXVENTE            decimal(10,2)                  null,
   constraint PK_LIGNECOMMANDE primary key clustered (IDPRODUIT, IDCOMMANDE)
);

/*==============================================================*/
/* Index : ASSOCIATION_9_PK                                     */
/*==============================================================*/
create unique clustered index ASSOCIATION_9_PK on LIGNECOMMANDE (
IDPRODUIT ASC,
IDCOMMANDE ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_9_FK                                     */
/*==============================================================*/
create index ASSOCIATION_9_FK on LIGNECOMMANDE (
IDPRODUIT ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_16_FK                                    */
/*==============================================================*/
create index ASSOCIATION_16_FK on LIGNECOMMANDE (
IDCOMMANDE ASC
);

/*==============================================================*/
/* Table : PRODUIT                                              */
/*==============================================================*/
create table PRODUIT 
(
   IDPRODUIT            integer                        not null default autoincrement,
   IDFOURNISSEUR        char(10)                       null,
   IDCATEGORIE          integer                        null,
   NOMPRODUIT           varchar(25)                    not null,
   POIDSPRODUIT         decimal(6,2)                   null,
   DESCRIPTIONPRODUIT   varchar(75)                    null,
   PRIXHT               decimal(5,2)                   not null,
   TAUXTVA              decimal(1,3)                   null,
   PRIXTTC              decimal(5,2)                   null,
   STOCK                integer                        not null,
   STOCKMINI            integer                        not null,
   STOCKMAX             integer                        not null,
   constraint PK_PRODUIT primary key (IDPRODUIT)
);

/*==============================================================*/
/* Index : PRODUIT_PK                                           */
/*==============================================================*/
create unique index PRODUIT_PK on PRODUIT (
IDPRODUIT ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_6_FK                                     */
/*==============================================================*/
create index ASSOCIATION_6_FK on PRODUIT (
IDCATEGORIE ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_7_FK                                     */
/*==============================================================*/
create index ASSOCIATION_7_FK on PRODUIT (
IDFOURNISSEUR ASC
);

/*==============================================================*/
/* Table : RAYON                                                */
/*==============================================================*/
create table RAYON 
(
   IDRAYON              integer                        not null default autoincrement,
   NOMRAYON             varchar(25)                    not null,
   DESCRIPTIONRAYON     varchar(75)                    null,
   constraint PK_RAYON primary key (IDRAYON)
);

/*==============================================================*/
/* Index : RAYON_PK                                             */
/*==============================================================*/
create unique index RAYON_PK on RAYON (
IDRAYON ASC
);

alter table CARTEFIDELITE
   add constraint FK_CARTEFID_DETENIR2_CLIENT foreign key (IDCLIENT)
      references CLIENT (IDCLIENT)
      on update restrict
      on delete restrict;

alter table CATEGORIEPRODUIT
   add constraint FK_CATEGORI_POSSEDER_RAYON foreign key (IDRAYON)
      references RAYON (IDRAYON)
      on update restrict
      on delete restrict;

alter table CLIENT
   add constraint FK_CLIENT_DETENIR_CARTEFID foreign key (IDCARTEFIDELITE)
      references CARTEFIDELITE (IDCARTEFIDELITE)
      on update restrict
      on delete restrict;

alter table CLIENT
   add constraint FK_CLIENT_HABITER_ADRESSE foreign key (IDADRESSE)
      references ADRESSE (IDADRESSE)
      on update restrict
      on delete restrict;

alter table COMMANDE
   add constraint FK_COMMANDE_ATTRIBUER_EMPLOYE foreign key (IDEMPLOYE)
      references EMPLOYE (IDEMPLOYE)
      on update restrict
      on delete restrict;

alter table COMMANDE
   add constraint FK_COMMANDE_PASSER_CLIENT foreign key (IDCLIENT)
      references CLIENT (IDCLIENT)
      on update restrict
      on delete restrict;

alter table EMPLOYE
   add constraint FK_EMPLOYE_LOGER_ADRESSE foreign key (IDADRESSE)
      references ADRESSE (IDADRESSE)
      on update restrict
      on delete restrict;

alter table FOURNISSEUR
   add constraint FK_FOURNISS_LOCALISER_ADRESSE foreign key (IDADRESSE)
      references ADRESSE (IDADRESSE)
      on update restrict
      on delete restrict;

alter table LIGNECOMMANDE
   add constraint FK_LIGNECOM_LIGNECOMM_PRODUIT foreign key (IDPRODUIT)
      references PRODUIT (IDPRODUIT)
      on update restrict
      on delete restrict;

alter table LIGNECOMMANDE
   add constraint FK_LIGNECOM_LIGNECOMM_COMMANDE foreign key (IDCOMMANDE)
      references COMMANDE (IDCOMMANDE)
      on update restrict
      on delete restrict;

alter table PRODUIT
   add constraint FK_PRODUIT_CONTENIR_CATEGORI foreign key (IDCATEGORIE)
      references CATEGORIEPRODUIT (IDCATEGORIE)
      on update restrict
      on delete restrict;

alter table PRODUIT
   add constraint FK_PRODUIT_VENDRE_FOURNISS foreign key (IDFOURNISSEUR)
      references FOURNISSEUR (IDFOURNISSEUR)
      on update restrict
      on delete restrict;

