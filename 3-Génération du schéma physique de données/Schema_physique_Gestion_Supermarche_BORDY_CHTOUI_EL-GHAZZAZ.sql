/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de création :  30/04/2020 15:21:16                      */
/*==============================================================*/

REM SUPPRESSION GLOBALE AVANT CREATION

alter table CARTEFIDELITE
   drop constraint FK_CARTEFID_DETENIR2_CLIENT;

alter table CATEGORIEPRODUIT
   drop constraint FK_CATEGORI_POSSEDER_RAYON;

alter table CLIENT
   drop constraint FK_CLIENT_DETENIR_CARTEFID;

alter table CLIENT
   drop constraint FK_CLIENT_HABITER_ADRESSE;

alter table COMMANDE
   drop constraint FK_COMMANDE_ATTRIBUER_EMPLOYE;

alter table COMMANDE
   drop constraint FK_COMMANDE_PASSER_CLIENT;

alter table EMPLOYE
   drop constraint FK_EMPLOYE_LOGER_ADRESSE;

alter table FOURNISSEUR
   drop constraint FK_FOURNISS_LOCALISER_ADRESSE;

alter table LIGNECOMMANDE
   drop constraint FK_LIGNECOM_LIGNECOMM_PRODUIT;

alter table LIGNECOMMANDE
   drop constraint FK_LIGNECOM_LIGNECOMM_COMMANDE;

alter table PRODUIT
   drop constraint FK_PRODUIT_CONTENIR_CATEGORI;

alter table PRODUIT
   drop constraint FK_PRODUIT_VENDRE_FOURNISS;

drop table ADRESSE cascade constraints;

drop index DETENIR2_FK;

drop table CARTEFIDELITE cascade constraints;

drop index POSSEDER_FK;

drop table CATEGORIEPRODUIT cascade constraints;

drop index DETENIR_FK;

drop index HABITER_FK;

drop table CLIENT cascade constraints;

drop index ATTRIBUER_FK;

drop index PASSER_FK;

drop table COMMANDE cascade constraints;

drop index LOGER_FK;

drop table EMPLOYE cascade constraints;

drop index LOCALISER_FK;

drop table FOURNISSEUR cascade constraints;

drop index LIGNECOMMANDE2_FK;

drop index LIGNECOMMANDE_FK;

drop table LIGNECOMMANDE cascade constraints;

drop index VENDRE_FK;

drop index CONTENIR_FK;

drop table PRODUIT cascade constraints;

drop table RAYON cascade constraints;

drop sequence S_ADRESSE;

drop sequence S_CARTEFIDELITE;

drop sequence S_CATEGORIEPRODUIT;

drop sequence S_CLIENT;

drop sequence S_COMMANDE;

drop sequence S_EMPLOYE;

drop sequence S_FOURNISSEUR;

drop sequence S_PRODUIT;

drop sequence S_RAYON;

REM CREATION TABLE, SEQUENCE, CONTRAINTE

create sequence S_ADRESSE
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

create sequence S_CARTEFIDELITE
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

create sequence S_CATEGORIEPRODUIT
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

create sequence S_CLIENT
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

create sequence S_COMMANDE
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

create sequence S_EMPLOYE
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

create sequence S_FOURNISSEUR
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

create sequence S_PRODUIT
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

create sequence S_RAYON
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

/*==============================================================*/
/* Table : ADRESSE                                              */
/*==============================================================*/
create table ADRESSE 
(
   IDADRESSE            INTEGER               not null,
   LIGNEADRESSE1        VARCHAR2(50)            not null,
   LIGNEADRESSE2        VARCHAR2(50),
   VILLE                VARCHAR2(30)            not null,
   CODEPOSTAL           VARCHAR2(5)             not null,
   PAYS                 VARCHAR2(25),
   constraint PK_ADRESSE primary key (IDADRESSE)
);

/*==============================================================*/
/* Table : CARTEFIDELITE                                        */
/*==============================================================*/
create table CARTEFIDELITE 
(
   IDCARTEFIDELITE      INTEGER            not null,
   IDCLIENT             INTEGER            not null,
   NBPOINTSFIDELITE     INTEGER              not null,
   constraint PK_CARTEFIDELITE primary key (IDCARTEFIDELITE)
);

/*==============================================================*/
/* Index : DETENIR2_FK                                          */
/*==============================================================*/
create index DETENIR2_FK on CARTEFIDELITE (
   IDCLIENT ASC
);

/*==============================================================*/
/* Table : CATEGORIEPRODUIT                                     */
/*==============================================================*/
create table CATEGORIEPRODUIT 
(
   IDCATEGORIE          INTEGER            not null,
   IDRAYON              INTEGER,
   NOMCATEGORIE         VARCHAR2(25)         not null,
   DESCRIPTIONCATEGORIE VARCHAR2(75)         not null,
   constraint PK_CATEGORIEPRODUIT primary key (IDCATEGORIE)
);

/*==============================================================*/
/* Index : POSSEDER_FK                                          */
/*==============================================================*/
create index POSSEDER_FK on CATEGORIEPRODUIT (
   IDRAYON ASC
);

/*==============================================================*/
/* Table : CLIENT                                               */
/*==============================================================*/
create table CLIENT 
(
   IDCLIENT             INTEGER            not null,
   IDADRESSE            INTEGER,
   IDCARTEFIDELITE      INTEGER,
   NOM                  VARCHAR2(25)         not null,
   PRENOM               VARCHAR2(25)         not null,
   MAIL                 VARCHAR2(50)         not null,
   TELEPHONE            VARCHAR2(10),
   MOTDEPASSE           VARCHAR2(25)         not null,
   GENRE                VARCHAR2(5)          not null,
   DATENAISSANCE        DATE,
   constraint CLIENT_MOTDEPASSE check (LENGTH(MOTDEPASSE) > 8),
   constraint CLIENT_TELEPHONE check (LENGTH(TELEPHONE) = 10),
   constraint CLIENT_MAIL_UNIQUE UNIQUE(MAIL),
   constraint CLIENT_GENRE_CHECK check (GENRE IN('Homme','Femme','Autre')),
   constraint PK_CLIENT primary key (IDCLIENT)
);

/*==============================================================*/
/* Index : HABITER_FK                                           */
/*==============================================================*/
create index HABITER_FK on CLIENT (
   IDADRESSE ASC
);

/*==============================================================*/
/* Index : DETENIR_FK                                           */
/*==============================================================*/
create index DETENIR_FK on CLIENT (
   IDCARTEFIDELITE ASC
);

/*==============================================================*/
/* Table : COMMANDE                                             */
/*==============================================================*/
create table COMMANDE 
(
   IDCOMMANDE           INTEGER            not null,
   IDEMPLOYE            INTEGER            not null,
   IDCLIENT             INTEGER            not null,
   DATECOMMANDE         DATE                 not null,
   STATUTCOMMANDE       VARCHAR2(30),
   constraint STATUTCOMMANDE_CHECK check (STATUTCOMMANDE in ('En attente de traitement','En cours de traitement','En attente de recuperation','Livree','Annulee')),
   constraint PK_COMMANDE primary key (IDCOMMANDE)
);

/*==============================================================*/
/* Index : PASSER_FK                                            */
/*==============================================================*/
create index PASSER_FK on COMMANDE (
   IDCLIENT ASC
);

/*==============================================================*/
/* Index : ATTRIBUER_FK                                         */
/*==============================================================*/
create index ATTRIBUER_FK on COMMANDE (
   IDEMPLOYE ASC
);

/*==============================================================*/
/* Table : EMPLOYE                                              */
/*==============================================================*/

create table EMPLOYE 
(
   IDEMPLOYE            INTEGER            not null,
   IDADRESSE            INTEGER,
   NOM                  VARCHAR2(25)         not null,
   PRENOM               VARCHAR2(25)         not null,
   MAIL                 VARCHAR2(50)         not null,
   TELEPHONE            VARCHAR2(10),
   SALAIRE              FLOAT,
   GENRE                VARCHAR2(5)          not null,
   DATENAISSANCE        DATE,
   constraint EMPLOYE_TELEPHONE check (LENGTH(TELEPHONE) = 10),
   constraint EMPLOYE_MAIL_UNIQUE UNIQUE(MAIL),
   constraint EMPLOYE_GENRE_CHECK check (GENRE IN('Homme','Femme','Autre')),
   constraint PK_EMPLOYE primary key (IDEMPLOYE)
);

/*==============================================================*/
/* Index : LOGER_FK                                             */
/*==============================================================*/
create index LOGER_FK on EMPLOYE (
   IDADRESSE ASC
);

/*==============================================================*/
/* Table : FOURNISSEUR                                          */
/*==============================================================*/
create table FOURNISSEUR 
(
   IDFOURNISSEUR        INTEGER            not null,
   IDADRESSE            INTEGER,
   NOMFOURNISSEUR       VARCHAR2(25)         not null,
   MAIL                 VARCHAR2(50)         not null,
   TELEPHONE            VARCHAR2(10),
   DESCRIPTIONFOURNISSEUR VARCHAR2(75),
   constraint FOURNISSEUR_TELEPHONE check (LENGTH(TELEPHONE) = 10),
   constraint FOURNISSEUR_MAIL_UNIQUE UNIQUE(MAIL),
   constraint PK_FOURNISSEUR primary key (IDFOURNISSEUR)
);

/*==============================================================*/
/* Index : LOCALISER_FK                                         */
/*==============================================================*/
create index LOCALISER_FK on FOURNISSEUR (
   IDADRESSE ASC
);

/*==============================================================*/
/* Table : LIGNECOMMANDE                                        */
/*==============================================================*/
create table LIGNECOMMANDE 
(
   IDPRODUIT            INTEGER            not null,
   IDCOMMANDE           INTEGER            not null,
   QUANTITE             INTEGER              not null,
   PRIXVENTE            FLOAT,
   constraint PK_LIGNECOMMANDE primary key (IDPRODUIT, IDCOMMANDE)
);

/*==============================================================*/
/* Index : LIGNECOMMANDE_FK                                     */
/*==============================================================*/
create index LIGNECOMMANDE_FK on LIGNECOMMANDE (
   IDPRODUIT ASC
);

/*==============================================================*/
/* Index : LIGNECOMMANDE2_FK                                    */
/*==============================================================*/
create index LIGNECOMMANDE2_FK on LIGNECOMMANDE (
   IDCOMMANDE ASC
);

/*==============================================================*/
/* Table : PRODUIT                                              */
/*==============================================================*/
create table PRODUIT 
(
   IDPRODUIT            INTEGER            not null,
   IDFOURNISSEUR        INTEGER,
   IDCATEGORIE          INTEGER,
   NOMPRODUIT           VARCHAR2(50)         not null,
   POIDSPRODUIT         FLOAT,
   DESCRIPTIONPRODUIT   VARCHAR2(75),
   PRIXHT               FLOAT,
   TAUXTVA              FLOAT,
   PRIXTTC              FLOAT,
   STOCK                INTEGER              not null,
   STOCKMINI            INTEGER              not null,
   STOCKMAX             INTEGER              not null,
   constraint TAUXTVA_CHECK check (TAUXTVA IN (0.055,0.20)),
   constraint PK_PRODUIT primary key (IDPRODUIT)
);

/*==============================================================*/
/* Index : CONTENIR_FK                                          */
/*==============================================================*/
create index CONTENIR_FK on PRODUIT (
   IDCATEGORIE ASC
);

/*==============================================================*/
/* Index : VENDRE_FK                                            */
/*==============================================================*/
create index VENDRE_FK on PRODUIT (
   IDFOURNISSEUR ASC
);

/*==============================================================*/
/* Table : RAYON                                                */
/*==============================================================*/
create table RAYON 
(
   IDRAYON              INTEGER            not null,
   NOMRAYON             VARCHAR2(25)         not null,
   DESCRIPTIONRAYON     VARCHAR2(75),
   constraint PK_RAYON primary key (IDRAYON)
);

alter table CARTEFIDELITE
   add constraint FK_CARTEFID_DETENIR2_CLIENT foreign key (IDCLIENT)
      references CLIENT (IDCLIENT) ON DELETE CASCADE;

alter table CATEGORIEPRODUIT
   add constraint FK_CATEGORI_POSSEDER_RAYON foreign key (IDRAYON)
      references RAYON (IDRAYON) ON DELETE CASCADE;

alter table CLIENT
   add constraint FK_CLIENT_DETENIR_CARTEFID foreign key (IDCARTEFIDELITE)
      references CARTEFIDELITE (IDCARTEFIDELITE) ON DELETE CASCADE;

alter table CLIENT
   add constraint FK_CLIENT_HABITER_ADRESSE foreign key (IDADRESSE)
      references ADRESSE (IDADRESSE) ON DELETE CASCADE;

alter table COMMANDE
   add constraint FK_COMMANDE_ATTRIBUER_EMPLOYE foreign key (IDEMPLOYE)
      references EMPLOYE (IDEMPLOYE) ON DELETE CASCADE;

alter table COMMANDE
   add constraint FK_COMMANDE_PASSER_CLIENT foreign key (IDCLIENT)
      references CLIENT (IDCLIENT) ON DELETE CASCADE;

alter table EMPLOYE
   add constraint FK_EMPLOYE_LOGER_ADRESSE foreign key (IDADRESSE)
      references ADRESSE (IDADRESSE) ON DELETE CASCADE;

alter table FOURNISSEUR
   add constraint FK_FOURNISS_LOCALISER_ADRESSE foreign key (IDADRESSE)
      references ADRESSE (IDADRESSE) ON DELETE CASCADE;

alter table LIGNECOMMANDE
   add constraint FK_LIGNECOM_LIGNECOMM_PRODUIT foreign key (IDPRODUIT)
      references PRODUIT (IDPRODUIT) ON DELETE CASCADE;

alter table LIGNECOMMANDE
   add constraint FK_LIGNECOM_LIGNECOMM_COMMANDE foreign key (IDCOMMANDE)
      references COMMANDE (IDCOMMANDE) ON DELETE CASCADE;

alter table PRODUIT
   add constraint FK_PRODUIT_CONTENIR_CATEGORI foreign key (IDCATEGORIE)
      references CATEGORIEPRODUIT (IDCATEGORIE) ON DELETE CASCADE;

alter table PRODUIT
   add constraint FK_PRODUIT_VENDRE_FOURNISS foreign key (IDFOURNISSEUR)
      references FOURNISSEUR (IDFOURNISSEUR) ON DELETE CASCADE;
      


      
/*==============================================================*/
/* Trigger : Produit                                            */
/*==============================================================*/
CREATE OR REPLACE TRIGGER trig_PrixTTC
 BEFORE INSERT OR UPDATE ON PRODUIT
 
FOR EACH ROW
 BEGIN
     :new.prixTTC := round((:new.prixHT + (:new.prixHT * :new.TAUXTVA)),2);
 END;
/

/*==============================================================*/
/* Trigger : LigneDeCommande                                    */
/*==============================================================*/
CREATE OR REPLACE TRIGGER trig_PrixVente
BEFORE INSERT OR UPDATE ON LIGNECOMMANDE
FOR EACH ROW
DECLARE 
    prixTTC FLOAT;
 BEGIN
    SELECT PRIXTTC INTO PrixTTC FROM PRODUIT WHERE IDPRODUIT = :new.idproduit;  
    :new.prixVente := round((:new.quantite * prixTTC),2);
 END;
/

/*==============================================================*/
/* Trigger : CarteFidelite                                      */
/*==============================================================*/
CREATE OR REPLACE TRIGGER trig_CarteFidelite
AFTER INSERT ON CARTEFIDELITE

FOR EACH ROW
 BEGIN
    update CLIENT SET IDCARTEFIDELITE = :new.idcartefidelite where IdClient = :new.IdClient;
 END;
/




