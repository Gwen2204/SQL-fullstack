/* I. Ecrire des requêtes d'interrogation de la base de données*/

/*Afficher la liste des commandes ( la liste doit faire apparaitre la date, les informations du client, le plat et le prix )*/
SELECT date_commande, etat, nom_client, telephone_client, email_client, adresse_client, plat.libelle, total
FROM commande
JOIN plat
ON plat.id = commande.id_plat;

/* Afficher la liste des plats en spécifiant la catégorie */

SELECT plat.libelle AS 'liste des plats', categorie.libelle AS 'categorie'
FROM plat
JOIN categorie
ON plat.id_categorie = categorie.IDENTIFIED



/* Afficher les catégories et le nombre de plats actifs dans chaque catégorie*/

SELECT categorie.libelle as 'catégorie', COUNT(plat.libelle) as 'nombre plat'
FROM plat 
JOIN categorie
ON plat.id_categorie = categorie.id
GROUP BY categorie.libelle;

/* Liste des plats les plus vendus par ordre décroissant */

SELECT plat.libelle, SUM(commande.quantite) as 'plats vendus'
FROM plat
JOIN commande
ON commande.id_plat = plat.id
GROUP BY plat.libelle
ORDER BY commande.quantite DESC;

/* Le plat le plus rémunérateur */

SELECT plat.libelle, MAX(commande.quantite*plat.prix) AS 'total'
FROM plat
JOIN commande
ON commande.id_plat = plat.id;

/* Liste des clients et le chiffre d'affaire généré par client (par ordre décroissant) */

SELECT nom_client, total
FROM commande
ORDER BY total DESC; 

/* II. Ecrire des requêtes de modification de la base de données */


/*Ecrivez une requête permettant de supprimer les plats non actif de la base de données*/

DELETE FROM plat
where active = 'NO';

/* Ecrivez une requête permettant de supprimer les commandes avec le statut livré*/

DELETE FROM commande
WHERE etat = 'livrée';

/*Ecrivez un script sql permettant d'ajouter une nouvelle catégorie et un plat dans cette nouvelle catégorie.*/

INSERT INTO categoerie (libelle, image, active) VALUES ('nouveau', 'nouveau', 'nouveau');

/*Ecrivez une requête permettant d'augmenter de 10% le prix des plats de la catégorie 'Pizza' */

UPDATE plat SET prix = prix * 1.1
WHERE id_categorie = 
    (SELECT id FROM categorie WHERE libelle = 'pizza'); 

    