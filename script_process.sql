DELIMITER | 
CREATE PROCEDURE afficher_rupture_pizzeria()      

BEGIN
SELECT DISTINCT pizzeria.nom, produits.nom
FROM pizzeria, stock,tbl_preparation,produits, jointure_pizzeria_produit
WHERE stock.id_pizzeria in (
SELECT stock.id_pizzeria 
FROM tbl_preparation,stock 
WHERE tbl_preparation.quantite > stock.quantite 
AND stock.id = tbl_preparation.id_stock
)
AND stock.id_pizzeria = pizzeria.id
AND pizzeria.id = jointure_pizzeria_produit.id_pizzeria
AND jointure_pizzeria_produit.id_produit = produits.id
AND produits.id in (
SELECT DISTINCT tbl_preparation.id_produit 
FROM tbl_preparation, stock, produits 
WHERE tbl_preparation.quantite > stock.quantite 
AND stock.id = tbl_preparation.id_stock
);
END|

CREATE PROCEDURE afficher_statut_commande(IN p_statut_id INT)      

BEGIN

SELECT pizzeria.nom, commandes.id, commandes.date_ajout, utilisateurs.nom, ref_commande_statut.nom
FROM pizzeria, commandes, utilisateurs, ref_commande_statut
WHERE pizzeria.id = commandes.id_pizzeria
AND utilisateurs.id = commandes.id_utilisateur
AND ref_commande_statut.id = commandes.id_statut
AND commandes.id_statut = p_statut_id

ORDER BY ref_commande_statut.id;

END|

CREATE PROCEDURE afficher_recette_finance()

BEGIN

SELECT DISTINCT pizzeria.nom, SUM(produits.prix)
FROM pizzeria, commandes, utilisateurs, ref_commande_statut, statut_paiement, produits, tbl_commande_produits
WHERE pizzeria.id = commandes.id_pizzeria
AND commandes.id_statut = ref_commande_statut.id
AND commandes.id_statut = 4
AND commandes.id = tbl_commande_produits.id_commande
AND tbl_commande_produits.id_produit = produits.id

GROUP BY pizzeria.nom;

END|

CREATE PROCEDURE afficher_recette_ALL()

BEGIN

SELECT produits.nom, GROUP_CONCAT(DISTINCT stock.nom,' (',tbl_preparation.quantite,')')
FROM produits, stock, tbl_preparation
WHERE produits.id = tbl_preparation.id_produit
AND tbl_preparation.id_stock = stock.id

GROUP BY produits.nom;

END|

CREATE PROCEDURE afficher_recette_spe(IN p_produit_id INT)

BEGIN

SELECT produits.nom, GROUP_CONCAT(DISTINCT stock.nom,' (',tbl_preparation.quantite,')') as liste_ingredient
FROM produits, stock, tbl_preparation
WHERE produits.id = tbl_preparation.id_produit
AND tbl_preparation.id_stock = stock.id
AND produits.id = p_produit_id

GROUP BY produits.nom;

END|

CREATE PROCEDURE afficher_menu_pizzeria(IN p_pizzeria_id INT)

BEGIN

SELECT DISTINCT pizzeria.nom, produits.nom, produits.prix
FROM produits, pizzeria, jointure_pizzeria_produit,stock,tbl_preparation
WHERE pizzeria.id = jointure_pizzeria_produit.id_pizzeria
AND jointure_pizzeria_produit.id_produit = produits.id
AND produits.id NOT IN (
SELECT DISTINCT tbl_preparation.id_produit
FROM tbl_preparation, stock, pizzeria
WHERE tbl_preparation.id_stock = stock.id
AND tbl_preparation.quantite > stock.quantite
AND stock.id_pizzeria = pizzeria.id
AND stock.id_pizzeria = p_pizzeria_id
)
AND pizzeria.id = p_pizzeria_id;

END|

CREATE PROCEDURE creation_commande(IN p_paiement INT)

BEGIN
set @utilisateur_id = ROUND(RAND()*4)+1;
set @pizzeria_id = ROUND(RAND()*2)+1;
INSERT INTO commandes(date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (DATE(NOW()),1,@utilisateur_id,p_paiement,@pizzeria_id);

END|

CREATE PROCEDURE afficher_panier_commande(IN p_utilisateur INT)

BEGIN
SELECT utilisateurs.nom, comptes.login, commandes.id as numero_commande, DATE(commandes.date_ajout) as date_commande, GROUP_CONCAT(DISTINCT produits.nom) as panier
FROM utilisateurs, commandes, tbl_commande_produits, produits, comptes
WHERE utilisateurs.id = commandes.id_utilisateur
AND commandes.id = tbl_commande_produits.id_commande
AND tbl_commande_produits.id_produit = produits.id
AND utilisateurs.id_compte = comptes.id
AND utilisateurs.id = p_utilisateur
GROUP BY commandes.id
ORDER BY commandes.id;
END|

CREATE PROCEDURE afficher_panier_commande_all()

BEGIN
SELECT utilisateurs.nom, comptes.login, commandes.id as numero_commande, DATE(commandes.date_ajout) as date_commande, GROUP_CONCAT(DISTINCT produits.nom) as panier
FROM utilisateurs, commandes, tbl_commande_produits, produits, comptes
WHERE utilisateurs.id = commandes.id_utilisateur
AND commandes.id = tbl_commande_produits.id_commande
AND tbl_commande_produits.id_produit = produits.id
AND utilisateurs.id_compte = comptes.id
GROUP BY commandes.id
ORDER BY utilisateurs.id;
END|