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
AND stock.id_pizzeria = 2
)
AND pizzeria.id = 2;
