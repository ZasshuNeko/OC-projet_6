SELECT DISTINCT produits.nom
FROM produits
WHERE produits.id in (
SELECT DISTINCT tbl_preparation.id_produit 
FROM tbl_preparation, stock, produits 
WHERE tbl_preparation.quantite > stock.quantite 
AND stock.id = tbl_preparation.id_stock
);