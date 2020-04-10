SELECT utilisateurs.nom, comptes.login, commandes.id as numero_commande, DATE(commandes.date_ajout) as date_commande, GROUP_CONCAT(DISTINCT produits.nom) as panier
FROM utilisateurs, commandes, tbl_commande_produits, produits, comptes
WHERE utilisateurs.id = commandes.id_utilisateur
AND commandes.id = tbl_commande_produits.id_commande
AND tbl_commande_produits.id_produit = produits.id
AND utilisateurs.id_compte = comptes.id
GROUP BY commandes.id;