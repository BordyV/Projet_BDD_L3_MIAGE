REM Insertion des adresses

insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '36  rue des Chaligny', null, 'NICE', '06000', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '55  Avenue De Marlioz', null, 'ANTIBES', '06600', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '71  Rue Marie De Médicis', 'Las Palmas', 'CANNES', '06400', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '54  avenue Ferdinand de Lesseps', 'Les Jasmins', 'GRASSE', '06130', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '47  avenue du Marechal Juin', null, 'SAINT-LAURENT-DU-VAR', '06700', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '45  Chemin Du Lavarin Sud', null, 'CAGNES-SUR-MER', '06800', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '66  rue Reine Elisabeth', null, 'MENTON', '06500', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '58  avenue de Provence', null, 'VALLAURIS', '06220', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '40  boulevard Aristide Briand', null, 'LE CANNET', '06110', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '38 boulevard du General de Gaulle', null, 'SAINT-JEAN-CAP-FERRAT', '06230', 'France');


REM Insertion des clients

insert into Client(idClient, idAdresse, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 3, 'White', 'Walter', 'walter.white@unice.fr', '0657125987', 'IAmHelsenberg', 'Homme', '07-SEP-1958');
insert into Client(idClient, idAdresse, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 6, 'Bagwell', 'Theodore', 'theodore.bagwell@unice.fr', '0641658974', 'OhFateYouMysteriousBitch', 'Homme', '10-JUL-1968');
insert into Client(idClient, idAdresse, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 1, 'Lothbrok', 'Ragnar', 'ragnar.lothbrok@unice.fr', '0678456942', 'WeLiveToFightAnotherDay', 'Homme', '03-DEC-1983');
insert into Client(idClient, idAdresse, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 8, 'Targaryen', 'Daenery', 'daenerys.targaryen@unice.fr', '0632148975', 'MotherOfDragons', 'Femme', '16-JUN-1985');
insert into Client(idClient, idAdresse, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 4, 'Stark', 'Arya', 'arya.stark@unice.fr', '0667894125', 'ValarMorghulis', 'Femme', '12-JAN-1997');
insert into Client(idClient, idAdresse, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 10, 'Trager', 'Kyle', 'kyle.trager@unice.fr', '0714587962', 'Zzyzx781227', 'Homme', '17-FEB-1991');
insert into Client(idClient, idAdresse, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 7, 'Roson', 'Carla', 'carla.roson@unice.fr', '0756841235', 'EliteNetflix', 'Femme', '26-JAN-2000');
insert into Client(idClient, idAdresse, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 2, 'Winchester', 'Dean', 'dean.winchester@unice.fr', '0600324751', 'IAmBatman', 'Homme', '24-JAN-1979');
insert into Client(idClient, idAdresse, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 5, 'Effiong', 'Eric', 'eric.effiong@unice.fr', '0798412650', 'YouDettyPig', 'Autre', '15-OCT-1992');
insert into Client(idClient, idAdresse, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 9, 'Raid', 'Samourai', 'samourai.raid@unice.fr', '0667894126', 'CestSuperFraiche', 'Homme', '29-MAR-1989');


REM Insertion des cartes de fidelite

insert into CarteFidelite(idCarteFidelite, idClient, nbPointsFidelite) 
	values(S_CARTEFIDELITE.nextval, 6, 138);
insert into CarteFidelite(idCarteFidelite, idClient, nbPointsFidelite) 
	values(S_CARTEFIDELITE.nextval, 5, 45);
insert into CarteFidelite(idCarteFidelite, idClient, nbPointsFidelite) 
	values(S_CARTEFIDELITE.nextval, 7, 51);
insert into CarteFidelite(idCarteFidelite, idClient, nbPointsFidelite) 
	values(S_CARTEFIDELITE.nextval, 4, 24);
insert into CarteFidelite(idCarteFidelite, idClient, nbPointsFidelite) 
	values(S_CARTEFIDELITE.nextval, 8, 77);
insert into CarteFidelite(idCarteFidelite, idClient, nbPointsFidelite) 
	values(S_CARTEFIDELITE.nextval, 3, 112);
insert into CarteFidelite(idCarteFidelite, idClient, nbPointsFidelite) 
	values(S_CARTEFIDELITE.nextval, 9, 93);
insert into CarteFidelite(idCarteFidelite, idClient, nbPointsFidelite) 
	values(S_CARTEFIDELITE.nextval, 2, 75);
insert into CarteFidelite(idCarteFidelite, idClient, nbPointsFidelite) 
	values(S_CARTEFIDELITE.nextval, 10, 49);
insert into CarteFidelite(idCarteFidelite, idClient, nbPointsFidelite) 
	values(S_CARTEFIDELITE.nextval, 1, 177);





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