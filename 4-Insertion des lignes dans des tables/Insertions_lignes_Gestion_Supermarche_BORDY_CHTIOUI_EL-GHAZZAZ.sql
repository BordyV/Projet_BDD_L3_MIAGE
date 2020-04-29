REM Insertion des clients

insert into Client(nom, prenom, mail, telephone, motDePasse, genre, dateNaissance) values();

REM Insertion des adresses

insert into Adresse(ligneAdresse1, ligneAdresse2, ville, codePostal, pays) values();

REM Insertion des cartes de fidelite

insert into CarteFidelite(nbPointsFidelite) values();

REM Insertion des produits

insert into Produit(nomProduit, poidsProduit, descriptionProduit, prixHT, tauxTVA, prixTTC, stock, stockMini, stockMax) 
values();

REM Insertion des categories de produits

insert into CategorieProduit(nomCategorie, descriptionCategorie) values();

REM Insertion des employees

insert into Employe(nom, prenom, mail, telephone, salaire, genre, dateNaissance) values();

REM Insertion des rayons

insert into Rayon(nomRayon, descriptionRayon) values();

REM Insertion des fournisseurs

insert into Fournisseur(nomFournisseur, mail, telephone, descriptionFournisseur) values();

REM Insertion des commandes

insert into Commande(dateCommande, statutCommande) values();

REM Insertion des lignes de commandes

insert into LigneCommande(quantite, prixVente) values();