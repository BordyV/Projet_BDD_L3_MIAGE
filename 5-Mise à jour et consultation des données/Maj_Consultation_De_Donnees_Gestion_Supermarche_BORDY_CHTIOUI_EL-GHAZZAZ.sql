REM Insertion des adresses

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