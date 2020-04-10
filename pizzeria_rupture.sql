SET @statut_indique = 2

IF @statut_indique != 5 THEN 
	SET @utilisateur_id = 3;
END IF;
IF @statut_indique = 5 THEN
	SET @utilisateur_id = 1;
END IF; 

DROP TEMPORARY TABLE IF EXISTS tempo_commandes;
CREATE TEMPORARY TABLE tempo_commandes (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	id_utilisateur SMALLINT NOT NULL,
	id_commandes SMALLINT NOT NULL,
	date_modification DATETIME NOT NULL
	);

INSERT INTO tempo_commandes(id_utilisateur,id_commandes,date_modification) VALUES (@utilisateur_id,13,NOW());

UPDATE commandes
SET id_statut = @statut_indique
WHERE id = 13

