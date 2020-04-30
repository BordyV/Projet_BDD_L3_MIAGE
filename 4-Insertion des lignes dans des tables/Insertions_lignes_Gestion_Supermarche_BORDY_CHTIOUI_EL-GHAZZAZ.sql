REM Insertion des clients

insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'White', 'Walter', 'walter.white@unice.fr', '0657125987', 'LosPollosHermanos', 'Homme', '07-SEP-1958');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Bagwell', 'Theodore', 'theodore.bagwell@unice.fr', '0641658974', 'Prisonslave', 'Homme', '10-JUL-1968');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Lothbrok', 'Ragnar', 'ragnar.lothbrok@unice.fr', '0678456942', 'Ithebestvikings', 'Homme', '03-DEC-1567');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Targaryen', 'Daenery', 'daenerys.targaryen@unice.fr', '0632148975', 'Motherofdragons', 'Femme', '16-JUN-0284');
insert into Client(idClient, nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) 
	values(S_CLIENT.nextval, 'Stark', 'Arya', 'arya.stark@unice.fr', '0667894125', 'Valarmorghulis', 'Femme', '12-JAN-0289');

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