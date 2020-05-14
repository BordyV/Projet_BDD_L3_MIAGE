REM MISE A JOUR

-- 2 requetes impliquant 1 table

-- Mise a jour du genre et de la date de naissance d’un client
UPDATE client
SET genre = 'Autre', dateNaissance= '12-12-1958'
WHERE idClient = 1;

rollback;

--Mise a jour du statut (par exemple en ‘Livrée’) d’une commande
UPDATE commande
SET statutCommande = 'Livree'
WHERE idCommande = 2;

rollback;

-- 2 requetes impliquant 2 tables
   
-- Mise a jour du taux de TVA a 20% de tous les produits ayant pour une catégorie donnée     
UPDATE (SELECT p.* 
             FROM produit p 
             INNER JOIN categorieProduit cp ON p.idCategorie = cp.idCategorie
             WHERE cp.nomCategorie = 'Cremerie') t
SET t.tauxTVA = 0.2;

rollback;
       
-- Mise a jour du stock de produit par rapport aux quantités de produit des lignes de commande 
CREATE OR REPLACE VIEW quantite_produit AS       
SELECT lc.idProduit, SUM(lc.quantite) as qte
FROM ligneCommande lc
GROUP BY lc.idProduit;

UPDATE produit pdt
SET pdt.stock = pdt.stock-(SELECT quantite_produit.qte FROM quantite_produit WHERE quantite_produit.idProduit = pdt.idProduit)
WHERE EXISTS (SELECT quantite_produit.qte FROM quantite_produit WHERE quantite_produit.idProduit = pdt.idProduit);  

rollback;

-- 2 requetes impliquant plus de 2 tables
        
-- Mise a jour du nombre de points de fidélité des clients pour chaque lignes de commandes 
-- dont le prix de vente est supérieur a 10
CREATE OR REPLACE VIEW cf_client AS       
SELECT cf.idClient, COUNT(cf.idClient) as nb
FROM carteFidelite cf
INNER JOIN commande c ON cf.idClient = c.idClient
INNER JOIN ligneCommande lc ON c.idCommande = lc.idCommande
WHERE lc.prixVente > 10
GROUP BY cf.idClient;

UPDATE carteFidelite cf
SET cf.nbPointsFidelite = cf.nbPointsFidelite + (SELECT cf_client.nb FROM cf_client WHERE cf_client.idClient = cf.idClient)*10
WHERE EXISTS (SELECT cf_client.nb FROM cf_client WHERE cf_client.idClient = cf.idClient);

rollback;

-- Mise a jour du stock minimum de produits dont le nom de rayon est 'Produit Frais'
UPDATE (SELECT p.* FROM produit p
        INNER JOIN categorieproduit cp ON p.idcategorie = cp.idcategorie
        INNER JOIN rayon r ON cp.idrayon = r.idrayon
        WHERE r.nomrayon = 'Produit Frais') z
SET z.stockmini = 50;

rollback;

REM SUPPRESSION

-- 2 requetes simlples

-- Supprime un produit par rapport à son nom “Chips 3D nature”
DELETE FROM produit p
WHERE p.NOMPRODUIT='Chips 3D nature';
rollback;

-- Supprime un produit par rapport à son numéro ID
DELETE FROM produit
WHERE idproduit=12;
rollback;

-- 2 requêtes de 2 tables 

-- Supprime tous les clients habitant à Nice
delete from client
where idadresse in (select a.idadresse from adresse a where a.ville='NICE');
rollback;

-- Supprime un fournisseur fournissant un produit en particulier par rapport à son nom
delete from fournisseur
where idfournisseur in (select p.idfournisseur from produit p where p.nomproduit='3x Pile AAA');
rollback;


-- 2 requetes de  plus de 2 tables   

-- Supprime le rayon du magasin contenant le nom d’un produit qui est “Chips 3D paprika” 
delete from rayon
where idrayon in (select idrayon from categorieproduit cp INNER JOIN produit p on cp.idcategorie=p.idcategorie where p.nomproduit='Chips 3D paprika');
rollback;

-- Supprime les commandes contenant des produits qui ont un prix inférieur à 3
delete from commande
where idcommande in (select idcommande from lignecommande lc INNER JOIN produit p on lc.idproduit=p.idproduit where p.prixht < 3);
rollback;



REM CONSULTATION
--Requete impliquant une table:
--Selectionne le nom du produit et son prix TTC et le tri par ordre croissant. (order by)
select nomProduit, prixTTC from produit order by(prixTTC) ASC;


--Selectionne lâ€™id de la commande, la date de la commande et le statut des commandes qui sont livrees.
select IDCOMMANDE, DATECOMMANDE, STATUTCOMMANDE from COMMANDE where statutCommande = 'Livree';


--Selectionne les informations du client(nom, prenom, telephone, mail, genre et date de Naissance).
select nom,prenom, telephone, mail, genre, dateNaissance FROM CLIENT;

--Selectionne le nombre dâ€™employe en fonction du salaire. (group by)
select count(idemploye) as nbEmploye , salaire from employe group by salaire;

--Selectionne le nombre de rayon que nous avons dans le drive.
select count(idrayon)as nbRayon from rayon;

--Requete impliquant deux tables:
--Selectionne toutes les commandes passes(id de la commande et la date), ainsi que lâ€™id du client, le nom et le prenom trie par date decroissante. (order by)
select client.idclient, client.nom,client.prenom,commande.IDCOMMANDE, commande.DATECOMMANDE from client, commande where CLIENT.IDCLIENT = COMMANDE.IDCLIENT order by dateCommande DESC;

--Selectionne le nom et le prenom de tous les employes et leurs nombres de commandes assignes. (outer join)
Select e.nom,e.prenom, count(c.idcommande) From commande c  right outer join Employe e on e.idemploye = c.idemploye group by e.nom, e.prenom;

--Selectionne les categories des produits qui ont un total de produits > 3.
Select cp.idCategorie, cp.nomCategorie, count(p.idproduit) as NbProduit from CATEGORIEPRODUIT cp, produit p where p.idcategorie = cp.idcategorie 
group by cp.idCategorie, cp.nomCategorie having count(p.idproduit) > 3;

--Selectionne les noms des categories et leurs descriptions pour le rayon "Epicerie salee".
Select nomCategorie, descriptionCategorie from categorieproduit, rayon where rayon.idrayon = categorieproduit.idrayon and rayon.nomRayon='Epicerie salee';

--Selectionne le nom, prixHT et la description produits vendus par le fournisseur "BERARD"
Select p.nomproduit, p.prixHT, p.descriptionProduit, f.nomfournisseur from produit p, fournisseur f where f.idfournisseur = p.idfournisseur and f.nomfournisseur = 'BERARD';

--Requete impliquant plus de deux tables:
--Selectionne le nom, prenom du client ainsi que le prix total de la commande numero qui a l'id numero 1.
Select CLIENT.nom, prenom, (Select sum(PrixVente) from LIGNECOMMANDE L group by L.idcommande HAVING IDCOMMANDE='1') as prixCommande from client, COMMANDE
WHERE COMMANDE.IDCLIENT = CLIENT.IDCLIENT AND COMMANDE.IDCOMMANDE='1' GROUP BY CLIENT.NOM, CLIENT.PRENOM, prenom;

--Selectionne les produits( nom, description, prixHT) et leurs rayons(nom, description) comprenant aussi les produits qui n'ont pas de rayon. (jointure externe)
SELECT PRODUIT.NOMPRODUIT, PRODUIT.DESCRIPTIONPRODUIT, PRODUIT.PRIXHT, RAYON.NOMRAYON, RAYON.DESCRIPTIONRAYON FROM PRODUIT, CATEGORIEPRODUIT, RAYON 
WHERE PRODUIT.IDCATEGORIE = CATEGORIEPRODUIT.IDCATEGORIE(+) AND CATEGORIEPRODUIT.IDRAYON = RAYON.IDRAYON(+);

--Selectionne le nombre de commande, lâ€™adresse et le nom et prenom des employes qui se sont occupes de 2 commande ou plus et le trier par le nombre de commande de faÃ§on croissante.
select a.ligneadresse1, a.ligneadresse2, a.ville, a.codepostal, a.pays, e.nom as nomEmploye, e.prenom as PrenomEmploye, count(c.IDCOMMANDE) as NbCommandeTraitee from adresse a, commande c, employe e
where a.idadresse = e.idadresse and c.idemploye = e.idemploye GROUP BY e.nom, e.prenom, a.ligneadresse1, a.ligneadresse2, a.ville, 
a.codepostal, a.pays HAVING count(c.IDCOMMANDE) >= 2 ORDER BY COUNT(c.IDCOMMANDE) ASC; 

--Selectionne le nom et prenom des clients qui ont realises une commande de 2 produits ou plus ainsi que leurs nombres de points de fidelite.
select cl.nom,cl.prenom, cf.nbpointsfidelite from client cl , cartefidelite cf, commande c, lignecommande lc 
WHERE cl.idcartefidelite = cf.idcartefidelite AND
cl.idclient = c.idclient AND
c.idcommande = lc.idcommande GROUP BY cl.nom, cl.prenom, cf.nbpointsfidelite HAVING COUNT(lc.idcommande) >=2;

--Selectionne les noms, la quantite achete ainsi que le prix de vente des produits de la commande numero 1.
Select p.NOMPRODUIT, p.DESCRIPTIONPRODUIT, lc.quantite, lc.prixvente FROM PRODUIT p , COMMANDE c , LIGNECOMMANDE lc
WHERE p.IDPRODUIT = lc.idproduit AND lc.idcommande = c.idcommande AND c.idcommande = 1;

