-- Package regroupe les fonctions our procedures necessaires
-- pour gerer des Employes.

create or replace package pack_employe is

TYPE refCursorTyp IS REF CURSOR;

no_data_updated EXCEPTION;
pragma exception_init(no_data_updated, -20001);

mess  varchar2(1000);

-- Cette fonction permet de rechercher un Employe connaissant 
-- son numero.
-- Si ce Employe existe l'enregistrement le concernant est retourne.
-- Si ce Employe n'existe pas une erreur No_data_found est 
-- attrapee et relevee. Le programme appelant cette fonction 
-- la traitera au final l'erreur
function getEmployeByID(idemp IN number) return Employe%rowtype;

-- Cette fonction permet de rechercher un Employe connaissant 
-- en cherchant par un idCommande.
-- Si ce Employe existe l'enregistrement le concernant est retourne.
-- Si ce Employe n'existe pas une erreur No_data_found est 
-- attrapee et relevee. Le programme appelant cette fonction 
-- la traitera au final l'erreur
function getEmployeByIDComm(idCom IN number) return Employe%rowtype;

-- Cette fonction permet de rechercher tout les employes
function getAllEmploye return pack_employe.refCursorTyp;

-- Cette fonction permet de compter les employes
function getEmployeTotal return number;

-- Cette procedure permet d'inserer un nouveau Employe dans la
-- table Employe. 
-- En cas de non respect des contraintes d'integrite :
-- Primary key, unique key, check, not null
-- Une exception sera attrapee et relevee
-- Le programme appelant la traitera au final
procedure insertEmploye(lp IN Employe%rowtype) ;

-- Cette procedure permet de modifier le salaire de tous les 
-- habitant la meme adresse.
-- L'erreur employe.no_data_updated sera levee et propagee
-- Le traitement final se fera dans le programme appelant.
procedure updateEmployeSalaireByAdr(adresse IN number, sal IN number) ;

-- Cette procedure permet de modifier le telephone de  
-- l'employe numero x
-- L'erreur employe.no_data_updated sera levee et propagee
-- Le traitement final se fera dans le programme appelant.
procedure updateEmployeTelephoneById(id in number, tel IN varchar2) ;

-- Cette fonction permet de rechercher les Employes qui 
-- habite a la meme adresse et trié par salaire. 
-- Elle renvoit la reference vers le curseur
-- contenant les informations sur les Employes qui habitent
-- a cette adresse.
function getEmployeByAdr(adresse IN number) return pack_employe.refCursorTyp ;

-- Cette procedure permet de supprimer un employe en fonction de son id
procedure deleteEmployeById(id IN number);

end pack_employe;
/


-- Codage des fonction.
-- Package body
create or replace package body pack_employe is

function getEmployeByID(idemp IN number) return Employe%rowtype IS

ligneEmploye Employe%rowtype;

begin
-- select qui ramene 1 ligne
select * INTO ligneEmploye
from Employe
where idEmploye=idemp;

return ligneEmploye;

EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		raise;

	WHEN OTHERS THEN
		raise;
end getEmployeByID;

--fonction getEmployeByIDComm qui permet de connaitre un employe en fonction de la commande
function getEmployeByIDComm(idCom IN number) return Employe%rowtype IS

ligneEmploye Employe%rowtype;

begin
-- select qui ramene 1 ligne
select employe.* INTO ligneEmploye
from Employe, commande
where employe.idemploye = commande.idemploye
and idcommande=idCom;

return ligneEmploye;

EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		raise;

	WHEN OTHERS THEN
		raise;
end getEmployeByIDComm;


--get All occurence
function getAllEmploye return pack_employe.refCursorTyp  IS

cursEmp pack_employe.refCursorTyp;

begin

	open cursEmp for
	
	select * 
	FROM Employe; 

	return 	cursEmp ;
	
end getAllEmploye;

--get total des employes
function getEmployeTotal return number  IS

total number;

begin
	
	select count(*) into total
	FROM Employe; 

	return 	total ;
	
end getEmployeTotal;



-- insert
procedure insertEmploye(lp IN Employe%rowtype) IS


begin

insert into Employe
values (lp.idEmploye,lp.idadresse, lp.nom, lp.prenom, lp.mail, lp.telephone, lp.salaire, lp.genre, lp.datenaissance);

EXCEPTION 

	WHEN DUP_VAL_ON_INDEX THEN
		raise;	
	WHEN OTHERS THEN
		raise;
end;



-- update
procedure updateEmployeSalaireByAdr(adresse IN number, sal IN number) is

begin
	update Employe
	set salaire=sal
	where idadresse=adresse;

	IF SQL%ROWCOUNT = 0 THEN
		pack_employe.mess:='Aucune ligne modifie';
		raise_application_error(-20001, mess);
		
	END IF;

EXCEPTION
	WHEN pack_employe.no_data_updated THEN
		raise;
	WHEN OTHERS THEN
		raise;
end;

--update tel by id
procedure updateEmployeTelephoneById(id IN number, tel IN varchar2) is

begin
	update Employe
	set telephone=tel
	where idEmploye=id;

	IF SQL%ROWCOUNT = 0 THEN
		pack_employe.mess:='Aucune ligne modifie';
		raise_application_error(-20001, mess);
		
	END IF;

EXCEPTION
	WHEN pack_employe.no_data_updated THEN
		raise;
	WHEN OTHERS THEN
		raise;
end;

function getEmployeByAdr(adresse IN number) return pack_employe.refCursorTyp  IS

cursEmp pack_employe.refCursorTyp;

begin

	open cursEmp for
	
	select * 
	FROM Employe
	where idadresse=adresse order by Employe.salaire; 

	return 	cursEmp ;
	
end getEmployeByAdr;


-- delete
procedure deleteEmployeById(id IN number) is

begin
	delete Employe
	where idEmploye=id;

	IF SQL%ROWCOUNT = 0 THEN
		pack_employe.mess:='Aucune ligne supprimee';
		raise_application_error(-20001, mess);
		
	END IF;

EXCEPTION
	WHEN pack_employe.no_data_updated THEN
		raise;
	WHEN OTHERS THEN
		raise;
end;

end pack_employe; 
/

commit;


-- test de la fonction pack_employe.getEmployeByID

declare
idem Employe.idEmploye%type:=1; -- 1
lp    Employe%rowtype;
begin
	lp:=pack_employe.getEmployeByID(idem);

	-- Affichier les informations sur le Employe extrait du curseur
	DBMS_OUTPUT.PUT_LINE('TEST GETEMPLOYEBYID');
	DBMS_OUTPUT.PUT_LINE('Numero Employe           ='||lp.idEmploye);
    DBMS_OUTPUT.PUT_LINE('numero adresse Employe   ='||lp.idadresse); 
	DBMS_OUTPUT.PUT_LINE('Nom Employe              ='||lp.nom); 
	DBMS_OUTPUT.PUT_LINE('Prenom                   ='||lp.prenom); 
	DBMS_OUTPUT.PUT_LINE('Mail Employe             ='||lp.mail);	
    DBMS_OUTPUT.PUT_LINE('Telephone Employe        ='||lp.telephone);
	DBMS_OUTPUT.PUT_LINE('Salaire Employe          ='||lp.salaire);
    DBMS_OUTPUT.PUT_LINE('Genre Employe            ='||lp.genre);
    DBMS_OUTPUT.PUT_LINE('Date Naissance Employe   ='||lp.dateNaissance);


	
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Le Employe nr  ' || idem || ' n''existe pas');		
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

		WHEN OTHERS THEN
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/



-- test de la fonction pack_employe.getEmployeByIDComm

declare
idcom Commande.idCommande%type:=1; -- 1
lp    Employe%rowtype;
begin
	lp:=pack_employe.getEmployeByIDComm(idcom);

	-- Affichier les informations sur le Employe extrait du curseur
	DBMS_OUTPUT.PUT_LINE('TEST GETEMPLOYEBYIDCOMM');
	DBMS_OUTPUT.PUT_LINE('Numero Employe           ='||lp.idEmploye);
    DBMS_OUTPUT.PUT_LINE('numero adresse Employe   ='||lp.idadresse); 
	DBMS_OUTPUT.PUT_LINE('Nom Employe              ='||lp.nom); 
	DBMS_OUTPUT.PUT_LINE('Prenom                   ='||lp.prenom); 
	DBMS_OUTPUT.PUT_LINE('Mail Employe             ='||lp.mail);	
    DBMS_OUTPUT.PUT_LINE('Telephone Employe        ='||lp.telephone);
	DBMS_OUTPUT.PUT_LINE('Salaire Employe          ='||lp.salaire);
    DBMS_OUTPUT.PUT_LINE('Genre Employe            ='||lp.genre);
    DBMS_OUTPUT.PUT_LINE('Date Naissance Employe   ='||lp.dateNaissance);


	
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('La commande nr  ' || idcom || ' n''existe pas');		
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

		WHEN OTHERS THEN
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/




-- test de la procedure pack_employe.getAllEmploye ...

declare
	

	empAll pack_employe.refCursorTyp;
	ligneEmployes 	Employe%rowtype;
	nbEmploye number:=0;
begin


	empAll:= pack_employe.getAllEmploye ;
	DBMS_OUTPUT.PUT_LINE('TEST getAllEmploye');		

	loop 
		fetch empAll INTO ligneEmployes;
		EXIT WHEN empAll%notfound;
		nbEmploye:=nbEmploye+1;

    	DBMS_OUTPUT.PUT_LINE('Employe Num = '||ligneEmployes.idEmploye || 
        ' / numero adresse = '||ligneEmployes.idadresse ||
        ' / Nom Employe = '||ligneEmployes.nom ||
        ' / Prenom = '||ligneEmployes.prenom||
        ' / Mail = '||ligneEmployes.mail||
        ' / Telephone = '||ligneEmployes.telephone ||
        ' / Salaire = '||ligneEmployes.salaire ||
        ' / Genre = '||ligneEmployes.genre||
        ' / Date Naissance = '||ligneEmployes.dateNaissance);
	end loop;
	
	-- Si le curseur est vide
	if nbEmploye=0 then
		raise no_data_found;
	end if;

	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('AUCUN Employe TROUVE DANS LA BASE');		
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

		WHEN OTHERS THEN
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/ 

-- test de la procedure pack_employe.getEmployeTotal ...

declare
	nbEmploye number:=0;
begin


	nbEmploye:= pack_employe.getEmployeTotal ;


    DBMS_OUTPUT.PUT_LINE('test getEmployeTotal');
    DBMS_OUTPUT.PUT_LINE('total employe = ' ||nbEmploye );
	
	-- Si le total est vide
	if nbEmploye=0 then
		raise no_data_found;
	end if;

	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('AUCUN Employe TROUVE DANS LA BASE');		
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

		WHEN OTHERS THEN
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/ 





-- Test de la procedure pack_employe.InsertEmploye

declare
lp  Employe%rowtype;

begin

 lp.idEmploye    := S_EMPLOYE.nextVal;
 lp.idadresse    :=1;
 lp.nom  :='Casse';
 lp.prenom :='Tete';
 lp.mail    :='casse.tete@gmail.com';
 lp.telephone    :='0715253453';
 lp.salaire    :=30500;
 lp.genre    :='Homme';
 lp.datenaissance :='11-09-1969';
 pack_employe.insertEmploye(lp);
  DBMS_OUTPUT.PUT_LINE('TEST InsertEmploye');
 DBMS_OUTPUT.PUT_LINE('le Employe avec le nr '||lp.idEmploye || ' a ete insere');
 
 
EXCEPTION 

	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE('Numero ou mail de Employe deje existant');		
		dbms_output.put_line('sqlcode='|| sqlcode);
		dbms_output.put_line('sqlerrm='|| sqlerrm);

	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Erreur dans le programme');		
		dbms_output.put_line('sqlcode='|| sqlcode);
		dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/
 
-- test de la procedure pack_employe.updateEmployeByadr ...

-- autorise l'affichage a l'ecran
set serveroutput on ;
-- verifier les anciens salaires
select * from Employe where idadresse=22;
declare
adresse Employe.idadresse%type:= 23;  -- '1'; -- '2'
newSalaire Employe.salaire%type:=13200;
begin

	pack_employe.updateEmployeSalaireByAdr(adresse, newSalaire);

	dbms_output.put_line('TEST updateEmployeSalaireByAdr');
	dbms_output.put_line('Mise a jour du salaire effectuee avec succes');
EXCEPTION
	WHEN pack_employe.no_data_updated THEN
	dbms_output.put_line('Aucune mise a jour effectuee');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);

	WHEN OTHERS THEN
	dbms_output.put_line('Probleme grave');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);
end;
/

-- test de la procedure pack_employe.updateEmployeTelephoneById ...

-- autorise l'affichage a l'ecran
set serveroutput on ;
-- verifier les anciens salaires
select * from Employe where idemploye=4;

declare
idEm Employe.idemploye%type:= 4;  
newTel Employe.telephone%type:='0645451412';
begin

	pack_employe.updateEmployeTelephoneById(idem, newTel);

	dbms_output.put_line('Test updateEmployeTelephoneById');
	dbms_output.put_line('Mise a jour du telephone effectuee avec succes');
EXCEPTION
	WHEN pack_employe.no_data_updated THEN
	dbms_output.put_line('Aucune mise a jour effectuee');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);

	WHEN OTHERS THEN
	dbms_output.put_line('Probleme grave');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);
end;
/

select * from Employe where idemploye=4;


-- test de la procedure pack_employe.getEmployeByAdr ...

declare
	

	empByAdr pack_employe.refCursorTyp;
	ligneEmploye 	Employe%rowtype;
	adresse Employe.idadresse%type:=21; -- '21'
	nbEmploye number:=0;
begin


	empByAdr:= pack_employe.getEmployeByAdr(adresse) ;

    DBMS_OUTPUT.PUT_LINE('Test getEmployeByAdr');

	loop 
		fetch empByAdr INTO ligneEmploye;
		EXIT WHEN empByAdr%notfound;
		nbEmploye:=nbEmploye+1;

    	DBMS_OUTPUT.PUT_LINE('Numero Employe    ='||ligneEmploye.idEmploye);
        DBMS_OUTPUT.PUT_LINE('numero adresse Employe   ='||ligneEmploye.idadresse); 
    	DBMS_OUTPUT.PUT_LINE('Nom Employe       ='||ligneEmploye.nom); 
	    DBMS_OUTPUT.PUT_LINE('Prenom   ='||ligneEmploye.prenom); 
    	DBMS_OUTPUT.PUT_LINE('Mail Employe ='||ligneEmploye.mail);	
        DBMS_OUTPUT.PUT_LINE('Telephone Employe ='||ligneEmploye.telephone);
    	DBMS_OUTPUT.PUT_LINE('Salaire Employe   ='||ligneEmploye.salaire);
        DBMS_OUTPUT.PUT_LINE('Genre Employe ='||ligneEmploye.genre);
        DBMS_OUTPUT.PUT_LINE('Date Naissance Employe ='||ligneEmploye.dateNaissance);
	end loop;
	
	-- Si le curseur est vide
	if nbEmploye=0 then
		raise no_data_found;
	end if;

	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('AUCUN Employe TROUVE A CETTE ADRESSE');		
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

		WHEN OTHERS THEN
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/ 


-- test de la procedure pack_employe.deleteEmployeById ...

-- autorise l'affichage a l'ecran
set serveroutput on ;
-- verifier l'ancien employe
select * from Employe where idEmploye=2;
declare
idE Employe.idEmploye%type:= 2;  -- '2'

begin
	pack_employe.deleteEmployeById(idE);

	dbms_output.put_line('test deleteEmployeById');
	dbms_output.put_line('Suppression effectuee avec succes');
EXCEPTION
	WHEN pack_employe.no_data_updated THEN
	dbms_output.put_line('Aucune suppression effectuee');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);

	WHEN OTHERS THEN
	dbms_output.put_line('Probleme grave');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);
end;
/

select * from Employe where idEmploye=2;
rollback;



-- Package regroupe les fonctions our procedures necessaires
-- pour gerer des Commandes.

create or replace package pack_Commande is

TYPE refCursorTyp IS REF CURSOR;

no_data_updated EXCEPTION;
pragma exception_init(no_data_updated, -20001);

mess  varchar2(1000);

-- Cette fonction permet de rechercher une commande connaissant 
-- son numero.
-- Si cette commande existe l'enregistrement le concernant est retourne.
-- Si cette commande n'existe pas une erreur No_data_found est 
-- attrapee et relevee. Le programme appelant cette fonction 
-- la traitera au final l'erreur
function getCommandeByID(idcom IN number) return commande%rowtype;

-- Cette fonction permet de rechercher une commande connaissant 
-- en cherchant par un idCom.
-- Si cette commande existe l'enregistrement le concernant est retourne.
-- Si cette commande n'existe pas une erreur No_data_found est 
-- attrapee et relevee. Le programme appelant cette fonction 
-- la traitera au final l'erreur
function getCommandeByidCmp(idCmp IN number) return commande%rowtype;

-- Cette fonction permet de rechercher toutes les commandes
function getAllCommade return pack_Commande.refCursorTyp;

-- Cette fonction permet de compter les commandes
function getCommandeTotal return number;

-- Cette procedure permet d'inserer une nouvelle commande dans la
-- table Commande.
-- En cas de non respect des contraintes d'integrite :
-- Primary key, unique key, check, not null
-- Une exception sera attrapee et relevee
-- Le programme appelant la traitera au final
procedure insertCommande(lp IN Commande%rowtype) ;

-- Cette procedure permet de modifier l'état d'une commande
-- L'erreur commande.no_data_updated sera levee et propagee
-- Le traitement final se fera dans le programme appelant.
procedure updateCommandeEtatById(id in number, etat IN varchar2) ;

-- Cette procedure permet de modifier la date de  
-- la commande
-- L'erreur commande.no_data_updated sera levee et propagee
-- Le traitement final se fera dans le programme appelant.
procedure updateCommandeDateById(id in number, dateC IN date) ;

-- Cette fonction permet de rechercher les Commandes qui ont  
-- pour etat livree. 
-- Elle renvoit la reference vers le curseur
-- contenant les informations sur les Commandes
function getCommandeByEtat(etat IN varchar2) return pack_Commande.refCursorTyp ;

-- Cette procedure permet de supprimer une commande en fonction de son id
procedure deleteCommandeById(id IN number);

end pack_Commande;
/

-- Codage des fonction.
-- Package body
create or replace package body pack_Commande is


function getCommandeByID(idcom IN number) return commande%rowtype IS

ligneCommande Commande%rowtype;

begin
-- select qui ramene 1 ligne
select * INTO ligneCommande
from Commande
where idCommande=idcom;

return ligneCommande;

EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		raise;

	WHEN OTHERS THEN
		raise;
end getCommandeByID;



--fonction getEmployeByIDComm qui permet de connaitre un employe en fonction de la commande
function getCommandeByidCmp(idCmp IN number) return commande%rowtype IS

ligneCommande Commande%rowtype;

begin
-- select qui ramene 1 ligne
select commande.* INTO ligneCommande
from Employe, commande
where employe.idemploye = commande.idemploye
and employe.idemploye=idCmp;

return ligneCommande;

EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		raise;

	WHEN OTHERS THEN
		raise;
end getCommandeByidCmp;



--get All occurence
function getAllCommade return pack_Commande.refCursorTyp  IS

cursComm pack_Commande.refCursorTyp;

begin

	open cursComm for
	
	select * 
	FROM Commande; 

	return 	cursComm ;
	
end getAllCommade;




--get total des commandes
function getCommandeTotal return number  IS

total number;

begin
	
	select count(*) into total
	FROM Commande; 

	return 	total ;
	
end getCommandeTotal;




-- insert
procedure insertCommande(lp IN Commande%rowtype) IS

begin

insert into Commande
values (lp.idCommande,lp.idemploye, lp.idClient, lp.dateCommande, lp.statutCommande);

EXCEPTION 

	WHEN DUP_VAL_ON_INDEX THEN
		raise;	
	WHEN OTHERS THEN
		raise;
end;




-- update
procedure updateCommandeEtatById(id in number, etat IN varchar2) is

begin
	update Commande
	set statutCommande=etat
	where idCommande=id;

	IF SQL%ROWCOUNT = 0 THEN
		pack_Commande.mess:='Aucune ligne modifie';
		raise_application_error(-20001, mess);
		
	END IF;

EXCEPTION
	WHEN pack_Commande.no_data_updated THEN
		raise;
	WHEN OTHERS THEN
		raise;
end;



--update date by id
procedure updateCommandeDateById(id in number, dateC IN date) is

begin
	update Commande
	set dateCommande=dateC
	where idCommande=id;

	IF SQL%ROWCOUNT = 0 THEN
		pack_Commande.mess:='Aucune ligne modifie';
		raise_application_error(-20001, mess);
		
	END IF;

EXCEPTION
	WHEN pack_Commande.no_data_updated THEN
		raise;
	WHEN OTHERS THEN
		raise;
end;




function getCommandeByEtat(etat IN varchar2) return pack_Commande.refCursorTyp  IS

cursCom pack_Commande.refCursorTyp;

begin

	open cursCom for
	
	select * 
	FROM Commande
	where statutCommande=etat order by Commande.idCommande; 

	return 	cursCom ;
	
end getCommandeByEtat;



-- delete
procedure deleteCommandeById(id IN number) is

begin
	delete Commande
	where idCommande=id;

	IF SQL%ROWCOUNT = 0 THEN
		pack_Commande.mess:='Aucune ligne supprimee';
		raise_application_error(-20001, mess);
		
	END IF;

EXCEPTION
	WHEN pack_Commande.no_data_updated THEN
		raise;
	WHEN OTHERS THEN
		raise;
end;

end pack_Commande; 
/

commit;



-- test de la fonction pack_commande.getCommandeByID

declare
idcom Commande.idCommande%type:=1; -- 1
lp    Commande%rowtype;
begin
	lp:=pack_Commande.getCommandeByID(idcom);

	-- Affichier les informations sur la commande extrait du curseur
	DBMS_OUTPUT.PUT_LINE('TEST getCommandeByID');
	DBMS_OUTPUT.PUT_LINE('Numero Commande          ='||lp.idCommande);
    DBMS_OUTPUT.PUT_LINE('numero Emp COmmande      ='||lp.idemploye); 
	DBMS_OUTPUT.PUT_LINE('Numero Client Commande   ='||lp.idClient); 
	DBMS_OUTPUT.PUT_LINE('date Commande            ='||lp.dateCommande); 
	DBMS_OUTPUT.PUT_LINE('Statut Commande          ='||lp.statutCommande);	


	
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('La commande nr  ' || idcom || ' n''existe pas');		
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

		WHEN OTHERS THEN
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/





-- test de la fonction pack_commande.getCommandeByidCmp

declare
idCmp Commande.idemploye%type:=1; -- 1
lp    Commande%rowtype;
begin
	lp:=pack_Commande.getCommandeByidCmp(idCmp);

	-- Affichier les informations sur la commande extrait du curseur
	DBMS_OUTPUT.PUT_LINE('TEST getCommandeByidCmp');
	DBMS_OUTPUT.PUT_LINE('Numero Commande          ='||lp.idCommande);
    DBMS_OUTPUT.PUT_LINE('numero Emp Commande      ='||lp.idemploye); 
	DBMS_OUTPUT.PUT_LINE('Numero Client Commande   ='||lp.idClient); 
	DBMS_OUTPUT.PUT_LINE('date Commande            ='||lp.dateCommande); 
	DBMS_OUTPUT.PUT_LINE('Statut Commande          ='||lp.statutCommande);	


	
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('L employe nr  ' || idCmp || ' n''existe pas');		
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

		WHEN OTHERS THEN
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/



-- test de la procedure pack_commande.getAllCommade ...

declare
	

	comAll pack_Commande.refCursorTyp;
	ligneCommandes 	Commande%rowtype;
	nbCommande number:=0;
begin


	comAll:= pack_Commande.getAllCommade ;
    	DBMS_OUTPUT.PUT_LINE('test de getAllCommade ');

	loop 
		fetch comAll INTO ligneCommandes;
		EXIT WHEN comAll%notfound;
		nbCommande:=nbCommande+1;

    	DBMS_OUTPUT.PUT_LINE('Commande Num = '||ligneCommandes.IDCOMMANDE || 
        ' / numero Emp Commande = '||ligneCommandes.idemploye ||
        ' / Numero Client Commande = '||ligneCommandes.IDCLIENT ||
        ' / date Commande = '||ligneCommandes.dateCommande||
        ' / Statut Commande = '||ligneCommandes.statutCommande);
	end loop;
	
	-- Si le curseur est vidC
	if nbCommande=0 then
		raise no_data_found;
	end if;

	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('AUCUNE COMMANDE TROUVEE DANS LA BASE');		
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

		WHEN OTHERS THEN
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/ 



-- test de la procedure pack_commande.getCommandeTotal ...

declare
	nbCommande number:=0;
begin


	nbCommande:= pack_Commande.getCommandeTotal;


    DBMS_OUTPUT.PUT_LINE('test getCommandeTotal');
    DBMS_OUTPUT.PUT_LINE('total commande = ' || nbCommande );
	
	-- Si le total est vidC
	if nbCommande=0 then
		raise no_data_found;
	end if;

	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('AUCUNE COMMANDE TROUVE DANS LA BASE');		
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

		WHEN OTHERS THEN
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/ 




-- Test de la procedure InsertCommande

declare
lp  Commande%rowtype;

begin

 lp.idCommande    := S_Commande.nextVal;
 lp.idemploye    :=1;
 lp.idClient  :=3;
 lp.dateCommande :='14-04-2020';
 lp.statutCommande    :='Livree';
 pack_Commande.insertCommande(lp);
  DBMS_OUTPUT.PUT_LINE('test de InsertCommande');

 DBMS_OUTPUT.PUT_LINE('la commande avec le nr '||lp.idCommande || ' a ete insere');
 
 
EXCEPTION 

	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE('Numero de Commande deje existant');		
		dbms_output.put_line('sqlcode='|| sqlcode);
		dbms_output.put_line('sqlerrm='|| sqlerrm);

	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Erreur dans le programme');		
		dbms_output.put_line('sqlcode='|| sqlcode);
		dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/


-- test de la procedure pack_commande.updateCommandeEtatById ...

-- autorise l'affichage a l'ecran
set serveroutput on ;
-- verifier l'ancien etat
select * from Commande where idCommande = 2;
declare
newetat Commande.statutCommande%type:= 'Annulee';  -- '1'; -- '2'
idCommande Commande.idCommande%type:=2;
begin

	pack_Commande.updateCommandeEtatById(idCommande, newetat);

	dbms_output.put_line('test de updateCommandeEtatById');
	dbms_output.put_line('Mise a jour de letat effectuee avec succes');
EXCEPTION
	WHEN pack_Commande.no_data_updated THEN
	dbms_output.put_line('Aucune mise a jour effectuee');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);

	WHEN OTHERS THEN
	dbms_output.put_line('Probleme grave');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);
end;
/

select * from Commande where idCommande = 2;




-- test de la procedure pack_commande.updateCommandeDateById ...

-- autorise l'affichage a l'ecran
set serveroutput on ;
-- verifier les anciens salaires
select * from commande where idCommande=4;

declare
idCo commande.idCommande%type:= 4;  
newDate commande.dateCommande%type:='15-05-2020';
begin

	pack_Commande.updateCommandeDateById(idCo, newDate);

	dbms_output.put_line('test updateCommandeDateById');
	dbms_output.put_line('Mise a jour de la date effectuee avec succes');
EXCEPTION
	WHEN pack_Commande.no_data_updated THEN
	dbms_output.put_line('Aucune mise a jour effectuee');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);

	WHEN OTHERS THEN
	dbms_output.put_line('Probleme grave');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);
end;
/

select * from commande where idCommande=4;





-- test de la procedure pack_commande.getCommandeByEtat ...

declare
	

	comByEtat pack_Commande.refCursorTyp;
	ligneCommande 	Commande%rowtype;
	etat commande.statutCommande%type:='Livree'; -- '21'
	nbCommande number:=0;
begin


	comByEtat:= pack_Commande.getCommandeByEtat(etat) ;
    DBMS_OUTPUT.PUT_LINE('test de getCommandeByEtat');

	loop 
		fetch comByEtat INTO ligneCommande;
		EXIT WHEN comByEtat%notfound;
		nbCommande:=nbCommande+1;

        DBMS_OUTPUT.PUT_LINE(ligneCommande.IDCOMMANDE);
    	DBMS_OUTPUT.PUT_LINE('Commande Num = '||ligneCommande.IDCOMMANDE || 
        ' / numero Emp Commande = '||ligneCommande.idemploye ||
        ' / Numero Client Commande = '||ligneCommande.IDCLIENT ||
        ' / date Commande = '||ligneCommande.dateCommande||
        ' / Statut Commande = '||ligneCommande.statutCommande);
	end loop;
	
	-- Si le curseur est vide
	if nbCommande=0 then
		raise no_data_found;
	end if;

	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('AUCUNE COMMANDE TROUVE POUR CET ETAT');		
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

		WHEN OTHERS THEN
			dbms_output.put_line('sqlcode='|| sqlcode);
			dbms_output.put_line('sqlerrm='|| sqlerrm);

end;
/ 


-- test de la procedure pack_commande.deleteEmployeById ...

-- autorise l'affichage a l'ecran
set serveroutput on ;
-- verifier l'ancienne commande
select * from commande where idCommande=7;
declare
idC Commande.idCommande%type:= 7;  

begin
	pack_Commande.deleteCommandeById(idC);

	dbms_output.put_line('test de deleteCommandeById');
	dbms_output.put_line('Suppression effectuee avec succes');
EXCEPTION
	WHEN pack_Commande.no_data_updated THEN
	dbms_output.put_line('Aucune suppression effectuee');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);

	WHEN OTHERS THEN
	dbms_output.put_line('Probleme grave');
	dbms_output.put_line('sqlcode='|| sqlcode);
	dbms_output.put_line('sqlerrm='|| sqlerrm);
end;
/

select * from commande where idCommande=7;




rollback;