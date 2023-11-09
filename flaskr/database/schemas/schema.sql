DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS user_class;
DROP TABLE if EXISTS dtf_municipios;
DROP TABLE if EXISTS ufs;
DROP TABLE if EXISTS municipios;

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username VARCHAR(200) UNIQUE NOT NULL,
  email VARCHAR(200) UNIQUE NOT NULL,
  email_verified_at DATETIME NULL DEFAULT NULL,
  email_confirmed VARCHAR(1) NULL DEFAULT '0',
  password VARCHAR(30) NOT NULL,
  remember_token TEXT NULL DEFAULT NULL,
  created_at DATETIME NULL DEFAULT NULL,
  updated_at DATETIME NULL DEFAULT NULL
);

CREATE TABLE user_class (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_class_name VARCHAR(30) UNIQUE NOT NULL,
	created_at DATETIME NULL DEFAULT NULL,
	updated_at DATETIME NULL DEFAULT NULL
);

CREATE TABLE dtf_municipios (
	uf_codigo VARCHAR(2) NULL DEFAULT NULL,
	uf_nome VARCHAR(150) NULL DEFAULT NULL,
	rgint_codigo VARCHAR(4) NULL DEFAULT NULL,
	rgint_nome VARCHAR(150) NULL DEFAULT NULL,
	rgimed_codigo VARCHAR(6) NULL DEFAULT NULL,
	rgimed_nome VARCHAR(150) NULL DEFAULT NULL,
	mesoreg_codigo VARCHAR(2) NULL DEFAULT NULL,
	mesoreg_nome VARCHAR(150) NULL DEFAULT NULL,
	microreg_codigo VARCHAR(3) NULL DEFAULT NULL,
	microreg_nome VARCHAR(150) NULL DEFAULT NULL,
	municipio_codigo VARCHAR(5) NULL DEFAULT NULL,
	municipio_codigo_amplo VARCHAR(7) NULL DEFAULT NULL,
	municipio_nome VARCHAR(150) NULL DEFAULT NULL 
);

CREATE TABLE ufs (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	uf_codigo VARCHAR(2) NULL DEFAULT NULL,
	uf_nome VARCHAR(150) NULL DEFAULT NULL
);

CREATE TABLE municipios (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	ufs_id INTEGER NOT NULL DEFAULT '0',
	municipio_codigo VARCHAR(5) NULL DEFAULT NULL,
	municipio_codigo_amplo VARCHAR(7) NULL DEFAULT NULL,
	municipio_nome VARCHAR(150) NULL DEFAULT NULL,
	FOREIGN KEY (ufs_id) REFERENCES ufs (id) ON UPDATE CASCADE ON DELETE CASCADE
);

/*INSERT INTO user_class (user_class_name,created_at,updated_at) VALUES ('administrador');*/ 
