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
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, 'Departemental 559', null, 'LES ISSAMBRES', '83380', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '515 rue de lindustrie', null, 'MONTPELIER', '34070', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '13 Rue Marx Dormoy 13', null, 'VENISSIEUX', '69200', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '26 Route de Paris', null, 'Pontault-Combault', '77340', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '480 Allée Des Cabedans', null, 'CAVAILLON', '84300', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '51 Boulevard de Strasbourg', null, 'PARIS', '75010', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '20 Route de la Justice', null, 'GAP', '05000', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '12, RUE ANSELME', null, 'SEINE-SAINT-DENIS', '93400', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, 'Zone de la houssoye', null, 'BOIS-GRENIER', '59280', 'France');
insert into Adresse(idAdresse, ligneAdresse1, ligneAdresse2, ville, codePostal, pays) 
	values(S_ADRESSE.nextval, '201, Avenue De LOrmea', null, 'MENTON', '06500', 'France');


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

REM Insertion des rayons

insert into Rayon(idRayon, nomRayon, descriptionRayon) 
	values(S_RAYON.nextval, 'Produit Frais', 'Cremerie, Charcuterie, Fromages, Yaourts et traiteur');
insert into Rayon(idRayon, nomRayon, descriptionRayon) 
	values(S_RAYON.nextval, 'Fruits et Legumes', 'Fruits et legumes frais/sec, Salades, Jus de fruits frais et plantes');
insert into Rayon(idRayon, nomRayon, descriptionRayon) 
	values(S_RAYON.nextval, 'Surgeles', 'Legumes, viandes, poissons, plat cuisines, desserts');
insert into Rayon(idRayon, nomRayon, descriptionRayon) 
	values(S_RAYON.nextval, 'Boissons', 'Eaux, Jus de fruits, Softs, Vins, Bieres, Alcools');
insert into Rayon(idRayon, nomRayon, descriptionRayon) 
	values(S_RAYON.nextval, 'Marche', 'Pains, Patisseries, Boucherie, Poissons, Volailles');
insert into Rayon(idRayon, nomRayon, descriptionRayon) 
	values(S_RAYON.nextval, 'Epicerie salee', 'Aperitif, Conserves, Pates, Feculents, Condiments sauces');
insert into Rayon(idRayon, nomRayon, descriptionRayon) 
	values(S_RAYON.nextval,'Epicerie sucree', 'Boisson chaudes, Petit Dejeuner, Biscuits, Chocolats, Desserts');
insert into Rayon(idRayon, nomRayon, descriptionRayon) 
	values(S_RAYON.nextval, 'Hygiene', 'Dentaire, Corps, Cheveux, Visage, parapharmacie');
insert into Rayon(idRayon, nomRayon, descriptionRayon) 
	values(S_RAYON.nextval, 'Entretien', 'Papiers, Vaisselles, Nettoyage, Linge');
insert into Rayon(idRayon, nomRayon, descriptionRayon) 
	values(S_RAYON.nextval, 'Animalerie', 'Chats, Chiens, Autres animaux');

REM Insertion des categories de produits

insert into CategorieProduit(idCategorie, idRayon, nomCategorie, descriptionCategorie) 
	values(S_CATEGORIEPRODUIT.nextval, 1, 'Cremerie', 'Laits, Oeufs, Beurres, Cremes');
insert into CategorieProduit(idCategorie, idRayon, nomCategorie, descriptionCategorie) 
	values(S_CATEGORIEPRODUIT.nextval, 2, 'Fruits et legumes sec', 'Amandes, Noix, Baies, Dattes, Raisins sec, etc');
insert into CategorieProduit(idCategorie, idRayon, nomCategorie, descriptionCategorie) 
	values(S_CATEGORIEPRODUIT.nextval, 3, 'Viandes et Poissons', 'Steaks, Nuggets, Volailles, Poissons panes, etc');
insert into CategorieProduit(idCategorie, idRayon, nomCategorie, descriptionCategorie) 
	values(S_CATEGORIEPRODUIT.nextval, 4, 'Softs et colas', 'Colas, Soda, Limonades, Thés glacés, Sirop, etc');
insert into CategorieProduit(idCategorie, idRayon, nomCategorie, descriptionCategorie) 
	values(S_CATEGORIEPRODUIT.nextval, 5, 'Boulangerie', 'Pains, viennoiseries, Brioches, Patisseries, Gateaux');
insert into CategorieProduit(idCategorie, idRayon, nomCategorie, descriptionCategorie) 
	values(S_CATEGORIEPRODUIT.nextval, 6, 'Aperitif', 'Chips, Biscuits sales, Cacahuetes, Amuse-bouches, etc');
insert into CategorieProduit(idCategorie, idRayon, nomCategorie, descriptionCategorie) 
	values(S_CATEGORIEPRODUIT.nextval, 7, 'Petit dejeuner', 'Cereales, Confitures, Miels, Biscottes, Pates à tartiner, etc');
insert into CategorieProduit(idCategorie, idRayon, nomCategorie, descriptionCategorie) 
	values(S_CATEGORIEPRODUIT.nextval, 8, 'Corps', 'Savons, Gels douche, Deodorants, Epilation, Solaires, etc');
insert into CategorieProduit(idCategorie, idRayon, nomCategorie, descriptionCategorie) 
	values(S_CATEGORIEPRODUIT.nextval, 9, 'Papiers', 'Papier-toilette, Essuie-tout, Mouchoirs');
insert into CategorieProduit(idCategorie, idRayon, nomCategorie, descriptionCategorie) 
	values(S_CATEGORIEPRODUIT.nextval, 10, 'Chats', 'Laits, Friandises, Sachets repas, Barquettes, Croquettes, etc');

REM Insertion des fournisseurs

insert into Fournisseur(idFournisseur, idAdresse, nomFournisseur, mail, telephone, descriptionFournisseur) 
	values(S_FOURNISSEUR.nextval, 11, 'NSDAfrance','nsda.france@orange.fr', '0494969455', 'Grossiste animalerie');
insert into Fournisseur(idFournisseur, idAdresse, nomFournisseur, mail, telephone, descriptionFournisseur) 
	values(S_FOURNISSEUR.nextval, 12, 'Hygiene Depot','contact@hygiene-depot.com', '0467578290', 'Grossiste hygiene et entretien');
insert into Fournisseur(idFournisseur, idAdresse, nomFournisseur, mail, telephone, descriptionFournisseur) 
	values(S_FOURNISSEUR.nextval, 13, 'AGIDRA','contact@agidra.com', '0478765656', 'Grossiste alimentaire');
insert into Fournisseur(idFournisseur, idAdresse, nomFournisseur, mail, telephone, descriptionFournisseur) 
	values(S_FOURNISSEUR.nextval, 14, 'MIAMLAND','contact@miamland.com', '0672409024', 'Grossiste alimentaire');
insert into Fournisseur(idFournisseur, idAdresse, nomFournisseur, mail, telephone, descriptionFournisseur) 
	values(S_FOURNISSEUR.nextval, 15, 'BERARD','contact@berard.com', '0490715574', 'Grossiste alimentaire');
insert into Fournisseur(idFournisseur, idAdresse, nomFournisseur, mail, telephone, descriptionFournisseur) 
	values(S_FOURNISSEUR.nextval, 16, 'DestockPlus','contact@destockplus.com', '0446952300', 'Grossiste general');
insert into Fournisseur(idFournisseur, idAdresse, nomFournisseur, mail, telephone, descriptionFournisseur) 
	values(S_FOURNISSEUR.nextval, 17, 'TRANSGOURMET','contact@dtransgouret.com', '0811656588', 'Grossiste alimentaire');
insert into Fournisseur(idFournisseur, idAdresse, nomFournisseur, mail, telephone, descriptionFournisseur) 
	values(S_FOURNISSEUR.nextval, 18, 'GRUPAK','contact@grupak.com', '0811656588', 'Grossiste non-alimentaire');
insert into Fournisseur(idFournisseur, idAdresse, nomFournisseur, mail, telephone, descriptionFournisseur) 
	values(S_FOURNISSEUR.nextval, 19, 'CHARLET','contact@charlet.com', '0411656588', 'Grossiste fruit et legumes');
insert into Fournisseur(idFournisseur, idAdresse, nomFournisseur, mail, telephone, descriptionFournisseur) 
	values(S_FOURNISSEUR.nextval, 20, 'LES PECHERIES','contact@lespecheries.com', '0493357138', 'Grossiste poissonnerie');


REM Insertion des produits

insert into Produit(idProduit, nomProduit, poidsProduit, descriptionProduit, prixHT, tauxTVA, prixTTC, stock, stockMini, stockMax) 
	values(S_PRODUIT.nextval,);


REM Insertion des employees

insert into Employe(idEmploye, nom, prenom, mail, telephone, salaire, genre, dateNaissance) 
	values(S_EMPLOYE.nextval,);


REM Insertion des commandes

insert into Commande(idCommande, dateCommande, statutCommande) 
	values(S_COMMANDE.nextval,);

REM Insertion des lignes de commandes

insert into LigneCommande(quantite, prixVente) 
	values();