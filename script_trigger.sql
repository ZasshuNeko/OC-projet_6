DELIMITER |
CREATE TRIGGER after_insert_commandes AFTER INSERT
ON commandes FOR EACH ROW
BEGIN
	SET @commande_id = NEW.id;
	SET @nombre_produits = ROUND(RAND()*3)+1;
	WHILE @nombre_produits > 0 DO
		SET @produit_id = ROUND(RAND()*3)+1;
		INSERT INTO tbl_commande_produits(id_commande,id_produit) VALUES (@commande_id,@produit_id);
		SET @nombre_produits = @nombre_produits - 1;
	END WHILE;
	INSERT INTO log_commande(id_utilisateur,id_commande,date_modification) VALUES (NEW.id_utilisateur,NEW.id,NOW());
END|
