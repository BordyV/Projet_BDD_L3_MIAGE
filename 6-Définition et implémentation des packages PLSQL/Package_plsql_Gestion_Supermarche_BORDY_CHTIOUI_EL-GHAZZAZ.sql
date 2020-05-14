-- Package regroupe les fonctions our procedures necessaires
-- pour gerer des Employes.

create or replace package pack_employe is

TYPE refCursorTyp IS REF CURSOR;

-- bad_salaire EXCEPTION;
-- pragma exception_init(bad_salaire, -2290);
-- null_not_allowed EXCEPTION;
-- pragma exception_init(bad_salaire, -01400);

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
values (S_EMPLOYE.nextVal,lp.idadresse, lp.nom, lp.prenom, lp.mail, lp.telephone, lp.salaire, lp.genre, lp.datenaissance);

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


-- test de la fonction employe.getEmployeByID

declare
idem Employe.idEmploye%type:=1; -- 1
lp    Employe%rowtype;
begin
	lp:=pack_employe.getEmployeByID(idem);

	-- Affichier les informations sur le Employe extrait du curseur
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


-- test de la procedure employe.getAllEmploye ...

declare
	

	empAll pack_employe.refCursorTyp;
	ligneEmployes 	Employe%rowtype;
	nbEmploye number:=0;
begin


	empAll:= pack_employe.getAllEmploye ;

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

-- test de la procedure employe.getEmployeTotal ...

declare
	nbEmploye number:=0;
begin


	nbEmploye:= pack_employe.getEmployeTotal ;



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





-- Test de la procedure InsertEmploye

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
 DBMS_OUTPUT.PUT_LINE('le Employe avec le nr '||lp.idEmploye || ' a ete insere');
 
 
EXCEPTION 

	-- WHEN employe.BAD_SALAIRE THEN
	-- 	DBMS_OUTPUT.PUT_LINE('Le salaire  ' || lp.sal || ' doit etre inferieur a 70000');		
	-- 	dbms_output.put_line('sqlcode='|| sqlcode);
	-- 	dbms_output.put_line('sqlerrm='|| sqlerrm);

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
 
-- test de la procedure employe.updateEmployeByadr ...

-- autorise l'affichage a l'ecran
set serveroutput on ;
-- verifier les anciens salaires
select * from Employe where idadresse=22;
declare
adresse Employe.idadresse%type:= 23;  -- '1'; -- '2'
newSalaire Employe.salaire%type:=13200;
begin

	pack_employe.updateEmployeSalaireByAdr(adresse, newSalaire);


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

-- test de la procedure employe.updateEmployeTelephoneById ...

-- autorise l'affichage a l'ecran
set serveroutput on ;
-- verifier les anciens salaires
select * from Employe where idemploye=4;

declare
idEm Employe.idemploye%type:= 4;  -- '1'; -- '2'
newTel Employe.telephone%type:='0645451412';
begin

	pack_employe.updateEmployeTelephoneById(idem, newTel);


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


-- test de la procedure employe.getEmployeByAdr ...

declare
	

	empByAdr pack_employe.refCursorTyp;
	ligneEmploye 	Employe%rowtype;
	adresse Employe.idadresse%type:=21; -- '21'
	nbEmploye number:=0;
begin


	empByAdr:= pack_employe.getEmployeByAdr(adresse) ;

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


-- test de la procedure employe.deleteEmployeById ...

-- autorise l'affichage a l'ecran
set serveroutput on ;
-- verifier l'ancien employe
select * from Employe where idEmploye=2;
declare
idE Employe.idEmploye%type:= 2;  -- '1'; -- '2'

begin
	pack_employe.deleteEmployeById(idE);

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