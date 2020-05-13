REM UPDATE

-- 2 requetes impliquant 1 table

UPDATE client
SET genre = 'Autre', dateNaissance= '12-12-1958'
WHERE idClient = 1;

UPDATE commandes
SET statutCommande = 'Livree'
WHERE idCommande = 2;

-- 2 requetes impliquant 2 tables
            
update (select p.* 
             from produit p 
             inner join categorieProduit cp on p.idCategorie = cp.idCategorie
             where cp.nomCategorie = 'Cremerie') t
       set t.tauxTVA = 0.2;
       
update (select p.* 
             from produit p
             inner join fournisseur f on p.idFournisseur = f.idFournisseur
             where f.nomFournisseur = 'AGIDRA') x
       set x.idFournisseur = 4;  

-- 2 requetes impliquant plus de 2 tables

UPDATE carteFidelite cf
 SET cf.nbPointsFidelite = cf.nbPointsFidelite + 10
 WHERE EXISTS 
       (SELECT lc.*
         FROM ligneCommande lc
         INNER JOIN commande c ON lc.idCommande = c.idCommande
         INNER JOIN client cli ON c.idClient = cli.idClient
         WHERE cf.idClient = cli.idClient
         AND lc.prixVente > 10);
         
UPDATE (SELECT cf.*
        FROM carteFidelite cf
        WHERE EXISTS 
               (SELECT lc.*
                 FROM ligneCommande lc
                 INNER JOIN commande c ON lc.idCommande = c.idCommande
                 INNER JOIN client cli ON c.idClient = cli.idClient
                 WHERE cf.idClient = cli.idClient
                 AND lc.prixVente > 10)) y
        SET y.nbPointsFidelite = y.nbPointsFidelite + 10;

rollback;


REM DELETE



REM CONSULTATION
REM Requête impliquant une table:
--Sélectionne le nom du produit et son prix TTC et le tri par ordre croissant. (order by)
select nomProduit, prixTTC from produit order by(prixTTC) ASC;


--Sélectionne l’id de la commande, la date de la commande et le statut des commandes qui sont livrées.
select IDCOMMANDE, DATECOMMANDE, STATUTCOMMANDE from COMMANDE where statutCommande = 'Livree';


--Sélectionne les informations du client(nom, prenom, telephone, mail, genre et date de Naissance).
select nom,prenom, telephone, mail, genre, dateNaissance FROM CLIENT;

--Sélectionne le nombre d’employé en fonction du salaire. (group by)
select count(idemploye) as nbEmploye , salaire from employe group by salaire;

--Sélectionne le nombre de rayon que nous avons dans le drive.
select count(idrayon)as nbRayon from rayon;

REM Requête impliquant deux tables:
--Sélectionne toutes les commandes passés(id de la commande et la date), ainsi que l’id du client, le nom et le prénom trié par date décroissante. (order by)
select client.idclient, client.nom,client.prenom,commande.IDCOMMANDE, commande.DATECOMMANDE from client, commande where CLIENT.IDCLIENT = COMMANDE.IDCLIENT order by dateCommande DESC;

--Sélectionne le nom et le prénom de tous les employés et leurs nombres de commandes assignés. (outer join)
Select e.nom,e.prenom, count(c.idcommande) From commande c  right outer join Employe e on e.idemploye = c.idemploye group by e.nom, e.prenom;

--Sélectionne les catégories des produits qui ont un total de produits > 3.
Select cp.idCategorie, cp.nomCategorie, count(p.idproduit) as NbProduit from CATEGORIEPRODUIT cp, produit p where p.idcategorie = cp.idcategorie 
group by cp.idCategorie, cp.nomCategorie having count(p.idproduit) > 3;

--Sélectionne les noms des catégories et leurs descriptions pour le rayon "Epicerie salee".
Select nomCategorie, descriptionCategorie from categorieproduit, rayon where rayon.idrayon = categorieproduit.idrayon and rayon.nomRayon='Epicerie salee';

--Sélectionne le nom, prixHT et la description produits vendus par le fournisseur "BERARD"
Select p.nomproduit, p.prixHT, p.descriptionProduit, f.nomfournisseur from produit p, fournisseur f where f.idfournisseur = p.idfournisseur and f.nomfournisseur = 'BERARD';

REM Requête impliquant plus de deux tables:
--Sélectionne le nom, prénom du client ainsi que le prix total de la commande numéro qui a l'id numéro 1.
Select CLIENT.nom, prenom, (Select sum(PrixVente) from LIGNECOMMANDE L group by L.idcommande HAVING IDCOMMANDE='1') as prixCommande from client, COMMANDE
WHERE COMMANDE.IDCLIENT = CLIENT.IDCLIENT AND COMMANDE.IDCOMMANDE='1' GROUP BY CLIENT.NOM, CLIENT.PRENOM, prenom;

--Selectionne les produits( nom, description, prixHT) et leurs rayons(nom, description) comprenant aussi les produits qui n'ont pas de rayon. (jointure externe)
SELECT PRODUIT.NOMPRODUIT, PRODUIT.DESCRIPTIONPRODUIT, PRODUIT.PRIXHT, RAYON.NOMRAYON, RAYON.DESCRIPTIONRAYON FROM PRODUIT, CATEGORIEPRODUIT, RAYON 
WHERE PRODUIT.IDCATEGORIE = CATEGORIEPRODUIT.IDCATEGORIE(+) AND CATEGORIEPRODUIT.IDRAYON = RAYON.IDRAYON(+);

--Sélectionne le nombre de commande, l’adresse et le nom et prénom des employes qui se sont occupés de 2 commande ou plus et le trier par le nombre de commande de façon croissante.
select a.ligneadresse1, a.ligneadresse2, a.ville, a.codepostal, a.pays, e.nom as nomEmploye, e.prenom as PrenomEmploye, count(c.IDCOMMANDE) as NbCommandeTraitee from adresse a, commande c, employe e
where a.idadresse = e.idadresse and c.idemploye = e.idemploye GROUP BY e.nom, e.prenom, a.ligneadresse1, a.ligneadresse2, a.ville, 
a.codepostal, a.pays HAVING count(c.IDCOMMANDE) >= 2 ORDER BY COUNT(c.IDCOMMANDE) ASC; 

--Sélectionne le nom et prénom des clients qui ont réalisés une commande de 2 produits ou plus ainsi que leurs nombres de points de fidélité.
select cl.nom,cl.prenom, cf.nbpointsfidelite from client cl , cartefidelite cf, commande c, lignecommande lc 
WHERE cl.idcartefidelite = cf.idcartefidelite AND
cl.idclient = c.idclient AND
c.idcommande = lc.idcommande GROUP BY cl.nom, cl.prenom, cf.nbpointsfidelite HAVING COUNT(lc.idcommande) >=2;

--Sélectionne les noms, la quantité acheté ainsi que le prix de vente des produits de la commande numéro 1.
Select p.NOMPRODUIT, p.DESCRIPTIONPRODUIT, lc.quantite, lc.prixvente FROM PRODUIT p , COMMANDE c , LIGNECOMMANDE lc
WHERE p.IDPRODUIT = lc.idproduit AND lc.idcommande = c.idcommande AND c.idcommande = 1;

