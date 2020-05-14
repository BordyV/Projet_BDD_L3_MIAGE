REM MISE A JOUR

-- 2 requetes impliquant 1 table

UPDATE client
    SET genre = 'Autre', dateNaissance= '12-12-1958'
    WHERE idClient = 1;

UPDATE commande
    SET statutCommande = 'Livree'
    WHERE idCommande = 2;

-- 2 requetes impliquant 2 tables
            
UPDATE (SELECT p.* 
             FROM produit p 
             INNER JOIN categorieProduit cp ON p.idCategorie = cp.idCategorie
             WHERE cp.nomCategorie = 'Cremerie') t
SET t.tauxTVA = 0.2;
       
UPDATE (SELECT p.* 
             FROM produit p
             INNER JOIN fournisseur f ON p.idFournisseur = f.idFournisseur
             WHERE f.nomFournisseur = 'AGIDRA') x
SET x.idFournisseur = 4;  

-- 2 requetes impliquant plus de 2 tables
        
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

-- CONSULTATION pour verifier l'update precedent 
SELECT cf.*
FROM carteFidelite cf
INNER JOIN commande c ON cf.idClient = c.idClient
INNER JOIN ligneCommande lc ON c.idCommande = lc.idCommande
WHERE lc.prixVente > 10;

UPDATE (SELECT lc.* 
             FROM ligneCommande lc
             INNER JOIN commande c ON lc.idCommande = c.idCommande
             INNER JOIN client cli ON c.idClient = cli.idClient
             INNER JOIN employe emp ON c.idemploye = emp.idEmploye
             WHERE cli.mail = emp.mail)z
SET z.prixVente = z.prixVente*0.9;

-- CONSULTATION pour verifier l'update pr�cedent 
SELECT lc.* 
FROM ligneCommande lc;

rollback;


REM SUPPRESSION



REM CONSULTATION
--Requete impliquant une table:
--Selectionne le nom du produit et son prix TTC et le tri par ordre croissant. (order by)
select nomProduit, prixTTC from produit order by(prixTTC) ASC;


--Selectionne l’id de la commande, la date de la commande et le statut des commandes qui sont livrees.
select IDCOMMANDE, DATECOMMANDE, STATUTCOMMANDE from COMMANDE where statutCommande = 'Livree';


--Selectionne les informations du client(nom, prenom, telephone, mail, genre et date de Naissance).
select nom,prenom, telephone, mail, genre, dateNaissance FROM CLIENT;

--Selectionne le nombre d’employe en fonction du salaire. (group by)
select count(idemploye) as nbEmploye , salaire from employe group by salaire;

--Selectionne le nombre de rayon que nous avons dans le drive.
select count(idrayon)as nbRayon from rayon;

--Requete impliquant deux tables:
--Selectionne toutes les commandes passes(id de la commande et la date), ainsi que l’id du client, le nom et le prenom trie par date decroissante. (order by)
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

--Selectionne le nombre de commande, l’adresse et le nom et prenom des employes qui se sont occupes de 2 commande ou plus et le trier par le nombre de commande de façon croissante.
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

