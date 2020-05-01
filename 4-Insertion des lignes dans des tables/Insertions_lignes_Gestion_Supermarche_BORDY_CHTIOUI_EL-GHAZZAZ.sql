REM Insertion des clients

insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'White', 'Walter', 'walter.white@unice.fr', '0657125987', 'IAmHelsenberg', 'Homme', '07-SEP-1958');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Bagwell', 'Theodore', 'theodore.bagwell@unice.fr', '0641658974', 'OhFateYouMysteriousBitch', 'Homme', '10-JUL-1968');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Lothbrok', 'Ragnar', 'ragnar.lothbrok@unice.fr', '0678456942', 'WeLiveToFightAnotherDay', 'Homme', '03-DEC-1983');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Targaryen', 'Daenery', 'daenerys.targaryen@unice.fr', '0632148975', 'MotherOfDragons', 'Femme', '16-JUN-1985');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Stark', 'Arya', 'arya.stark@unice.fr', '0667894125', 'ValarMorghulis', 'Femme', '12-JAN-1997');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Trager', 'Kyle', 'kyle.trager@unice.fr', '0714587962', 'Zzyzx781227', 'Homme', '17-FEB-1991');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Roson', 'Carla', 'carla.roson@unice.fr', '0756841235', 'EliteNetflix', 'Femme', '26-JAN-2000');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Winchester', 'Dean', 'dean.winchester@unice.fr', '0600324751', 'IAmBatman', 'Homme', '24-JAN-1979');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Effiong', 'Eric', 'eric.effiong@unice.fr', '0798412650', 'YouDettyPig', 'Autre', '15-OCT-1992');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Raid', 'Samourai', 'samourai.raid@unice.fr', '0667894126', 'CestSuperFraiche', 'Homme', '29-MAR-1989');

REM Insertion des adresses

insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval,);

REM Insertion des cartes de fidelite

insert into CarteFidelite(idCarteFidelite, nbPointsFidelite) 
	values(S_CARTEFIDELITE.nextval,);

REM Insertion des produits

insert into Produit(idProduit, nomProduit, poidsProduit, descriptionProduit, prixHT, tauxTVA, prixTTC, stock, stockMini, stockMax) 
	values(S_PRODUIT.nextval,);

REM Insertion des categories de produits

insert into CategorieProduit(idCategorie, nomCategorie, descriptionCategorie) 
	values(S_CATEGORIEPRODUIT.nextval,);

REM Insertion des employees

insert into Employe(idEmploye, nom, prenom, mail, telephone, salaire, genre, dateNaissance) 
	values(S_EMPLOYE.nextval,);

REM Insertion des rayons

insert into Rayon(idRayon, nomRayon, descriptionRayon) 
	values(S_RAYON.nextval,);

REM Insertion des fournisseurs

insert into Fournisseur(idFournisseur, nomFournisseur, mail, telephone, descriptionFournisseur) 
	values(S_FOURNISSEUR.nextval,);

REM Insertion des commandes

insert into Commande(idCommande, dateCommande, statutCommande) 
	values(S_COMMANDE.nextval,);

REM Insertion des lignes de commandes

insert into LigneCommande(quantite, prixVente) 
	values();