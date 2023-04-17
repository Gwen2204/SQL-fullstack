/*Rechercher le prénom des employés et le numéro de la région de leur
département.*/

SELECT prenom, noregion
FROM employe
JOIN dept ON noregion;


/*Rechercher le numéro du département, le nom du département, le
nom des employés classés par numéro de département (renommer les
tables utilisées).*/

SELECT nodept, employe.nom AS 'nom employé', dept.nom AS 'nom département'
FROM dept
JOIN employe ON dept.nodept = employe.nodep;

/*Rechercher le nom des employés du département Distribution */

SELECT employe.nom AS 'nom employé', dept.nom AS 'nom département', nodep 
FROM dept
JOIN employe ON dept.nodept = employe.nodep
WHERE dept.nom LIKE 'distribution';



/* Rechercher le nom et le salaire des employés qui gagnent plus que
leur patron, et le nom et le salaire de leur patron */


SELECT employe.nom AS 'Nom employé', employe.salaire AS 'Salaire employé', patron.nom AS 'Nom patron'; patron.salaire AS 'Salaire patron'
FROM employe
JOIN employe AS patron ON employe.nosup = patron.noemp
WHERE employe.salaire > patron.salaire; 



/* Rechercher le nom et le titre des employés qui ont le même titre que
Amartakaldire.*/

SELECT nom, titre 
FROM employe
WHERE titre IN 
    (SELECT titre FROM employe WHERE nom = 'Amartakaldire');


/* Rechercher le nom, le salaire et le numéro de département des
employés qui gagnent plus qu'un seul employé du département 31,
classés par numéro de département et salaire. */  

SELECT nom, salaire, nodep
FROM employe
WHERE salaire > ANY 
    (SELECT salaire FROM employe WHERE nodep=31);

/*Rechercher le nom, le salaire et le numéro de département des
employés qui gagnent plus que tous les employés du département 31,
classés par numéro de département et salaire.*/

SELECT nom, salaire, nodep
FROM employe
WHERE salaire > ALL 
    (SELECT salaire FROM employe WHERE nodep=31);


/*Rechercher le nom et le titre des employés du service 31 qui ont un
titre que l'on trouve dans le département 32.*/

SELECT nom, titre
FROM employe
WHERE nodep=31 AND titre NOT IN
    (SELECT titre FROM employe WHERE nodep=32);

/* Rechercher le nom, le salaire et le numéro de département des
employés qui gagnent plus qu'un seul employé du département 31,
classés par numéro de département et salaire. */


SELECT nom, titre
FROM employe
WHERE nodep=31 AND titre NOT IN
    (SELECT titre FROM employe WHERE nodep=32);


/*Rechercher le nom et le titre des employés du service 31 qui ont un
titre l'on ne trouve pas dans le département 32.*/

SELECT nom, titre
FROM employe
WHERE nodep=31 AND titre IN
    (SELECT titre FROM employe WHERE nodep=32);

/*Rechercher le nom et le titre des employés du service 31 qui ont un
titre l'on ne trouve pas dans le département 32.*/

SELECT nom, titre
FROM employe
WHERE nodep=31 AND titre NOT IN
    (SELECT titre FROM employe WHERE nodep=32);

/* Rechercher le nom, le titre et le salaire des employés qui ont le même
titre et le même salaire que Fairent. */

SELECT nom, titre, salaire
FROM employe
WHERE titre IN (SELECT titre FROM employe WHERE nom = 'Fairent')
AND salaire IN (SELECT nom FROM employe WHERE nom='Fairent');

/* Rechercher le numéro de département, le nom du département, le
nom des employés, en affichant aussi les départements dans lesquels
il n'y a personne, classés par numéro de département.*/

SELECT nodep, dept.nom, employe.nom
FROM dept
LEFT JOIN employe ON employe.nodep=dept.nodept
ORDER BY nodept;





/* Les groupes */

/* 1. Calculer le nombre d'employés de chaque titre. */ 

SELECT COUNT(nom) AS 'nombre.employé', titre 
FROM employe
GROUP BY titre;

/* 2. Calculer la moyenne des salaires et leur somme, par région. */

SELECT AVG(salaire) AS'moyenne des salaires', SUM(salaire) AS'somme des salaires', nodep
FROM employe
GROUP BY nodep;

/*3. Afficher les numéros des départements ayant au moins 3 employés.*/

SELECT nodep, COUNT(nom) AS'nombre.employé'
FROM employe
GROUP BY nodep
HAVING COUNT(nom) >=3;

/*4. Afficher les lettres qui sont l'initiale d'au moins trois employés. */

SELECT LEFT(nom, 1) AS 'initial', COUNT(*)
FROM employe
GROUP BY 'initial' HAVING COUNT(*) >=3;

/* 5. Rechercher le salaire maximum et le salaire minimum parmi tous les
salariés et l'écart entre les deux. */





/* 6.Rechercher le nombre de titres différents. */

SELECT DISTINCT COUNT(titre) AS 'nombre de titre différents'
FROM employe;

/* 7. Pour chaque titre, compter le nombre d'employés possédant ce titre.*/

SELECT COUNT(nom) AS 'nombre employés', titre 
FROM employe
GROUP BY titre;

8/* .Pour chaque nom de département, afficher le nom du département et
le nombre d'employés. */

SELECT COUNT(employe.nom) AS 'nom employé', dept.nom
FROM employe
JOIN dept ON employe.nodep=dept.nodept
GROUP BY dept.nom


/* 9. Rechercher les titres et la moyenne des salaires par titre dont la
moyenne est supérieure à la moyenne des salaires des Représentants. */


SELECT AVG(salaire) AS moyenne_salaire, titre
FROM employe
GROUP BY titre
HAVING moyenne_salaire > (SELECT AVG(salaire) moyenne_salaire FROM employe WHERE titre='représentants');


/* 10.Rechercher le nombre de salaires renseignés et le nombre de taux de
commission renseignés.*/

SELECT COUNT(salaire) AS 'nombre de salaires', COUNT(tauxcom) AS 'nombre de taux de commission'
FROM employe
WHERE tauxcom AND salaire IS NOT NULL;