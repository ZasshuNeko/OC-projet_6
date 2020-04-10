DELIMITER ;

CREATE TABLE IF NOT EXISTS `type_compte` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	nom TEXT NOT NULL, 
	PRIMARY KEY (id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO type_compte(id,nom) VALUES (1,"client");
INSERT INTO type_compte(id,nom) VALUES (2,"employé");
INSERT INTO type_compte(id,nom) VALUES (3,"administrateur");

CREATE TABLE IF NOT EXISTS `statut_paiement` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	nom TEXT NOT NULL,
	PRIMARY KEY (id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO statut_paiement(id,nom) VALUES (1,"Payé");
INSERT INTO statut_paiement(id,nom) VALUES (2,"Non payé");

CREATE TABLE IF NOT EXISTS `ref_adresse_statut` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	nom TEXT NOT NULL,
	PRIMARY KEY (id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ref_adresse_statut(id,nom) VALUES (1,"sélectionné");
INSERT INTO ref_adresse_statut(id,nom) VALUES (2,"non_sélectionné");

CREATE TABLE IF NOT EXISTS `ref_commande_statut` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	nom TEXT NOT NULL,
	PRIMARY KEY (id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ref_commande_statut(id,nom) VALUES (1,"En Attente");
INSERT INTO ref_commande_statut(id,nom) VALUES (2,"En préparation");
INSERT INTO ref_commande_statut(id,nom) VALUES (3,"En livraison");
INSERT INTO ref_commande_statut(id,nom) VALUES (4,"Finalisée");
INSERT INTO ref_commande_statut(id,nom) VALUES (5,"Annulé");
INSERT INTO ref_commande_statut(id,nom) VALUES (6,"Refusée");

CREATE TABLE IF NOT EXISTS `comptes` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT, 
	login TEXT NOT NULL,
	password TEXT NOT NULL,
	mail TEXT NOT NULL,
	date_ajout DATE NOT NULL,
	id_type SMALLINT UNSIGNED, 
	PRIMARY KEY (id),
	CONSTRAINT fk_type_id FOREIGN KEY (id_type) REFERENCES type_compte(id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO comptes(id,login,password,mail,date_ajout,id_type) VALUES (1,"Utilisateur 1","1234","util@gmail.com",03/04/2020,1);
INSERT INTO comptes(id,login,password,mail,date_ajout,id_type) VALUES (2,"Utilisateur 2","1234","util2@gmail.com",03/04/2020,1);
INSERT INTO comptes(id,login,password,mail,date_ajout,id_type) VALUES (3,"Utilisateur 3","1234","util3@gmail.com",03/04/2020,2);
INSERT INTO comptes(id,login,password,mail,date_ajout,id_type) VALUES (4,"Utilisateur 4","1234","util4@gmail.com",03/04/2020,2);
INSERT INTO comptes(id,login,password,mail,date_ajout,id_type) VALUES (5,"Utilisateur 5","1234","util5@gmail.com",03/04/2020,3);

CREATE TABLE IF NOT EXISTS `utilisateurs` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	nom TEXT NOT NULL,
	prenom TEXT NOT NULL,
	id_compte SMALLINT UNSIGNED, 
	PRIMARY KEY (id),
	CONSTRAINT fk_compte_id FOREIGN KEY (id_compte) REFERENCES comptes(id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO utilisateurs(id,nom,prenom,id_compte) VALUES (1,"Nom1","Prenom1",1);
INSERT INTO utilisateurs(id,nom,prenom,id_compte) VALUES (2,"Nom2","Prenom2",2);
INSERT INTO utilisateurs(id,nom,prenom,id_compte) VALUES (3,"Nom3","Prenom3",3);
INSERT INTO utilisateurs(id,nom,prenom,id_compte) VALUES (4,"Nom4","Prenom4",4);
INSERT INTO utilisateurs(id,nom,prenom,id_compte) VALUES (5,"Nom5","Prenom5",5);

CREATE TABLE IF NOT EXISTS `pizzeria` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	nom TEXT NOT NULL,
	adresse TEXT NOT NULL,
	telephone TEXT NOT NULL, 
	PRIMARY KEY (id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO pizzeria(id,nom,adresse,telephone) VALUES (1,"Pizzeria1","5 rue truc machin","01 42 55 78 98");
INSERT INTO pizzeria(id,nom,adresse,telephone) VALUES (2,"Pizzeria2","10 rue truc machin","01 42 55 78 89");
INSERT INTO pizzeria(id,nom,adresse,telephone) VALUES (3,"Pizzeria3","71 rue truc machin","01 42 55 78 52");

CREATE TABLE IF NOT EXISTS `commandes` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	date_ajout DATETIME NOT NULL,
	id_statut SMALLINT UNSIGNED,
	id_utilisateur SMALLINT UNSIGNED,
	statut_paiement BOOLEAN NOT NULL,
	id_pizzeria SMALLINT UNSIGNED NOT NULL, 
	PRIMARY KEY (id),
	CONSTRAINT fk_statut_id FOREIGN KEY (id_statut) REFERENCES ref_commande_statut(id),
	CONSTRAINT fk_utilisateur_commandes_id FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (1,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),1,1,1,2);
INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (2,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),2,1,2,1);
INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (3,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),3,2,1,3);
INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (4,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),4,3,1,1);
INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (5,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),5,5,2,2);
INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (6,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),3,2,1,3);
INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (7,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),3,1,1,1);
INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (8,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),4,1,1,2);
INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (9,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),4,2,1,3);
INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (10,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),4,3,1,1);
INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (11,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),3,5,1,2);
INSERT INTO commandes(id,date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (12,STR_TO_DATE('07-04-2014 00:00:00','%m-%d-%Y %H:%i:%s'),3,2,1,3);

CREATE TABLE IF NOT EXISTS `livraison` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	id_commande SMALLINT NOT NULL,
	statut_livraison BOOLEAN, 
	PRIMARY KEY (id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO livraison(id,id_commande,statut_livraison) VALUES (1,3,0);
INSERT INTO livraison(id,id_commande,statut_livraison) VALUES (2,6,1);

CREATE TABLE IF NOT EXISTS `produits` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	nom TEXT NOT NULL,
	description TEXT NOT NULL,
	prix DECIMAL(5,2) UNSIGNED NOT NULL,
	date_ajout DATETIME NOT NULL, 
	PRIMARY KEY (id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO produits(id,nom,description,prix,date_ajout) VALUES (1,"Pizza1","Description Pizza1",7.50,STR_TO_DATE('07-04-2020 00:00:00','%m-%d-%Y %H:%i:%s'));
INSERT INTO produits(id,nom,description,prix,date_ajout) VALUES (2,"Pizza2","Description Pizza2",9.50,STR_TO_DATE('07-04-2020 00:00:00','%m-%d-%Y %H:%i:%s'));
INSERT INTO produits(id,nom,description,prix,date_ajout) VALUES (3,"Pizza3","Description Pizza3",15.50,STR_TO_DATE('07-04-2020 00:00:00','%m-%d-%Y %H:%i:%s'));
INSERT INTO produits(id,nom,description,prix,date_ajout) VALUES (4,"Pizza4","Description Pizza4",10.50,STR_TO_DATE('07-04-2020 00:00:00','%m-%d-%Y %H:%i:%s'));

CREATE TABLE IF NOT EXISTS `localisations` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	piece TEXT NOT NULL,
	rayon TEXT NOT NULL,
	PRIMARY KEY (id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO localisations(id,piece,rayon) VALUES (1,"Stockage1","Rayon 5");
INSERT INTO localisations(id,piece,rayon) VALUES (2,"Stockage2","Rayon légume");
INSERT INTO localisations(id,piece,rayon) VALUES (3,"Stockage3","Rayon fruits");

CREATE TABLE IF NOT EXISTS `stock` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT, 
	nom TEXT NOT NULL,
	quantite SMALLINT NOT NULL,
	date_ajout DATE NOT NULL,
	date_peremption DATE NOT NULL,
	id_localisation SMALLINT UNSIGNED,
	prix SMALLINT UNSIGNED,
	id_pizzeria SMALLINT UNSIGNED, 
	PRIMARY KEY (id),
	CONSTRAINT fk_localisation_stock_id FOREIGN KEY (id_localisation) REFERENCES localisations(id),
	CONSTRAINT fk_localisation_pizzeria_id FOREIGN KEY (id_pizzeria) REFERENCES pizzeria(id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (1,"Concentré de tomate",3,STR_TO_DATE('07-03-2020','%m-%d-%Y'),STR_TO_DATE('04-07-2020','%m-%d-%Y'),1,5.25,1);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (2,"Concentré de tomate",6,STR_TO_DATE('07-03-2020','%m-%d-%Y'),STR_TO_DATE('07-04-2020','%m-%d-%Y'),1,4.25,2);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (3,"Concentré de tomate",12,STR_TO_DATE('07-03-2020','%m-%d-%Y'),STR_TO_DATE('07-04-2020','%m-%d-%Y'),1,6.25,3);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (4,"Champignons",20,STR_TO_DATE('07-03-2020','%m-%d-%Y'),STR_TO_DATE('07-04-2020','%m-%d-%Y'),2,3.75,1);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (5,"Champignons",10,STR_TO_DATE('07-03-2020','%m-%d-%Y'),STR_TO_DATE('04-07-2020','%m-%d-%Y'),2,3.75,2);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (6,"Champignons",15,STR_TO_DATE('07-03-2020','%m-%d-%Y'),STR_TO_DATE('07-04-2020','%m-%d-%Y'),2,3.75,3);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (7,"Ananas",5,STR_TO_DATE('07-03-2020','%m-%d-%Y'),STR_TO_DATE('07-04-2020','%m-%d-%Y'),3,1.25,1);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (8,"Ananas",10,STR_TO_DATE('07-03-2020','%m-%d-%Y'),STR_TO_DATE('07-04-2020','%m-%d-%Y'),3,1.25,2);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (9,"Ananas",15,STR_TO_DATE('07-03-2020','%m-%d-%Y'),STR_TO_DATE('04-07-2020','%m-%d-%Y'),3,1.25,3);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (10,"Pâte fraiche",50,STR_TO_DATE('07-03-2020','%m-%d-%Y'),STR_TO_DATE('04-04-2020','%m-%d-%Y'),1,1.25,1);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (11,"Pâte fraiche",0,STR_TO_DATE('08-01-2020','%m-%d-%Y'),STR_TO_DATE('01-01-2020','%m-%d-%Y'),1,1.25,2);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (12,"Pâte fraiche",10,STR_TO_DATE('08-01-2020','%m-%d-%Y'),STR_TO_DATE('10-01-2020','%m-%d-%Y'),1,1.25,3);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (13,"Jâlopenos",100,STR_TO_DATE('08-01-2020','%m-%d-%Y'),STR_TO_DATE('10-01-2020','%m-%d-%Y'),1,6.25,1);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (14,"Jâlopenos",20,STR_TO_DATE('08-01-2020','%m-%d-%Y'),STR_TO_DATE('10-01-2020','%m-%d-%Y'),1,7.25,2);
INSERT INTO stock(id,nom,quantite,date_ajout,date_peremption,id_localisation,prix,id_pizzeria) VALUES (15,"Jâlopenos",50,STR_TO_DATE('08-01-2020','%m-%d-%Y'),STR_TO_DATE('10-01-2020','%m-%d-%Y'),1,8.25,3);


CREATE TABLE IF NOT EXISTS `adresses` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	numero SMALLINT NOT NULL,
	nom_rue TEXT NOT NULL,
	code_postal INT UNSIGNED,
	id_utilisateur SMALLINT UNSIGNED NOT NULL,
	id_adresse_statut SMALLINT UNSIGNED NOT NULL, 
	PRIMARY KEY (id),
	CONSTRAINT fk_utilisateur_adresse_id FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id),
	CONSTRAINT fk_adresse_id FOREIGN KEY (id_adresse_statut) REFERENCES ref_adresse_statut(id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO adresses(id,numero,nom_rue,code_postal,id_utilisateur,id_adresse_statut) VALUES (1,5,"rue du projet",92230,2,1);
INSERT INTO adresses(id,numero,nom_rue,code_postal,id_utilisateur,id_adresse_statut) VALUES (2,5,"rue du projet 2",94000,3,2);

CREATE TABLE IF NOT EXISTS `log_commande` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	id_utilisateur SMALLINT UNSIGNED,
	id_commande SMALLINT UNSIGNED,
	date_modification DATETIME NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT fk_utilisateur_log_id FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id),
	CONSTRAINT fk_commande_id FOREIGN KEY (id_commande) REFERENCES commandes(id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `jointure_pizzeria_produit` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	id_pizzeria SMALLINT UNSIGNED,
	id_produit SMALLINT UNSIGNED,
	PRIMARY KEY (id),
	CONSTRAINT fk_pizzeria_produit_id FOREIGN KEY (id_pizzeria) REFERENCES pizzeria(id),
	CONSTRAINT fk_produit_pizzeria_id FOREIGN KEY (id_produit) REFERENCES produits(id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (1,1,1);
INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (2,1,2);
INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (3,1,3);
INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (4,1,4);
INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (5,2,1);
INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (6,2,2);
INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (7,2,3);
INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (8,2,4);
INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (9,3,1);
INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (10,3,2);
INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (11,3,3);
INSERT INTO jointure_pizzeria_produit(id,id_pizzeria,id_produit) VALUES (12,3,4);

CREATE TABLE IF NOT EXISTS `tbl_preparation` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	id_produit SMALLINT UNSIGNED,
	id_stock SMALLINT UNSIGNED,
	quantite FLOAT(2) UNSIGNED,
	prix_preparation FLOAT(2) UNSIGNED, 
	PRIMARY KEY (id),
	CONSTRAINT fk_produit_preparation_id FOREIGN KEY (id_produit) REFERENCES produits(id),
	CONSTRAINT fk_stock_preparation_id FOREIGN KEY (id_stock) REFERENCES stock(id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (1,1,1,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (2,1,2,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (3,1,3,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (4,2,1,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (5,2,2,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (6,2,3,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (7,3,1,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (8,3,2,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (9,3,3,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (10,4,1,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (11,4,2,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (12,4,3,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (13,1,10,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (14,1,11,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (15,1,12,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (16,2,10,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (17,2,11,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (18,2,12,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (19,3,10,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (20,3,11,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (21,3,12,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (22,4,10,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (23,4,11,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (24,4,12,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (25,1,4,5,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (26,1,5,5,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (27,1,6,5,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (28,2,4,5,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (29,2,5,5,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (30,2,6,5,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (31,3,4,5,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (32,3,5,5,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (33,3,6,5,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (34,3,7,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (35,3,8,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (36,3,9,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (37,4,7,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (38,4,8,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (39,4,9,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (40,2,13,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (41,2,14,1,2.25);
INSERT INTO tbl_preparation(id,id_produit,id_stock,quantite,prix_preparation) VALUES (42,2,15,1,2.25);


CREATE TABLE IF NOT EXISTS `tbl_commande_produits` (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	id_commande SMALLINT UNSIGNED,
	id_produit SMALLINT UNSIGNED,
	PRIMARY KEY (id),
	CONSTRAINT fk_produit_commande_id FOREIGN KEY (id_commande) REFERENCES commandes(id),
	CONSTRAINT fk_commande_produit_id FOREIGN KEY (id_produit) REFERENCES produits(id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (1,1,2);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (2,1,3);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (3,2,1);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (4,2,3);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (5,6,2);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (6,3,1);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (7,3,4);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (8,3,3);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (9,4,4);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (10,5,1);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (11,7,2);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (12,7,3);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (13,8,4);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (14,8,2);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (15,9,3);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (16,9,4);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (17,9,1);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (18,10,3);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (19,11,4);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (20,11,1);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (21,12,2);
INSERT INTO tbl_commande_produits(id,id_commande,id_produit) VALUES (22,12,4);