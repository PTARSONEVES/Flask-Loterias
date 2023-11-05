#
# ATENÇÃO: Antes de fazer a conversão do arquivo ".xlsx" do site da caixa para "lotofacil_caixa.csv" nos campos monetários devem ser eliminados o "R$" e sunstituidas a vigulas
# por ponto. Nos campos de localidade e observações substituir os caracteres ";" para não serem confundidos com delimitadores de campo. 
#
USE flask_loterias;
UPDATE lotofacil_resultado SET sit='S' WHERE (s1+s2+s3+s4+s5+s6+s7+s8+s9+s10+s11+s12+s13+s14+sr11+sr12+sr13+sr14)=18;
DROP TABLE if EXISTS lotofaciltxt;
DROP TABLE if EXISTS prov;
CREATE TABLE `lotofaciltxt` (
	`concurso` INT(11) NULL DEFAULT NULL,
	`data` VARCHAR(10) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola1` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola2` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola3` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola4` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola5` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola6` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola7` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola8` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola9` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola10` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola11` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola12` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola13` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola14` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`bola15` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`g15` INT(11) NULL DEFAULT 0,
	`localidade` VARCHAR(300) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`rateiog15` DECIMAL(21,2) DEFAULT 0.00,
	`g14` INT(11) NULL DEFAULT 0,
	`rateiog14` DECIMAL(21,2) DEFAULT 0.00,
	`g13` INT(11) NULL DEFAULT 0,
	`rateiog13` DECIMAL(21,2) DEFAULT 0.00,
	`g12` INT(11) NULL DEFAULT 0,
	`rateiog12` DECIMAL(21,2) DEFAULT 0.00,
	`g11` INT(11) NULL DEFAULT 0,
	`rateiog11` DECIMAL(21,2) DEFAULT 0.00,
	`acumuladog15` DECIMAL(21,2) DEFAULT 0.00,
	`arrecadacaototal` DECIMAL(21,2) DEFAULT 0.00,
	`estimativapremio` DECIMAL(21,2) DEFAULT 0.00,
	`acumulado_lfindependencia` DECIMAL(21,2) DEFAULT 0.00,
	`observacao` VARCHAR(500) NULL DEFAULT NULL COLLATE 'utf8_general_ci'	
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
LOAD DATA INFILE 'C:/Users/ptars/OneDrive/LOTERIAS/ARQUIVOS_CSV/lotofacil_caixa.csv' INTO TABLE lotofaciltxt FIELDS TERMINATED BY '|';
DELETE FROM lotofaciltxt WHERE bola1='bo';
CREATE TABLE prov SELECT *,'N' AS sit,0 AS s1,0 AS s2,0 AS s3,0 AS s4,0 AS s5,0 AS s6,0 AS s7,0 AS s8,0 AS s9,0 AS s10,0 AS s11,0 AS s12,0 AS s13,0 AS s14,0 AS sr11,0 AS sr12,0 AS sr13, 0 AS sr14 
FROM lotofaciltxt;
DROP TABLE lotofaciltxt;
ALTER TABLE `prov`
	CHANGE COLUMN `concurso` `concurso` INT(11) NOT NULL FIRST,
	ADD PRIMARY KEY (`concurso`);
REPLACE prov SELECT a.numconcurso,b.`data`,a.bola1,a.bola2,a.bola3,a.bola4,a.bola5,a.bola6,a.bola7,a.bola8,a.bola9,a.bola10,a.bola11,a.bola12,a.bola13,a.bola14,a.bola15,b.g15,b.localidade,b.rateiog15,b.g14,b.rateiog14,b.g13,b.rateiog13,b.g12,b.rateiog12,b.g11,b.rateiog11,b.acumuladog15,b.arrecadacaototal,b.estimativapremio,b.acumulado_lfindependencia,b.observacao,a.sit,a.s1,a.s2,a.s3,a.s4,a.s5,a.s6,a.s7,a.s8,a.s9,a.s10,a.s11,a.s12,a.s13,a.s14,a.sr11,a.sr12,a.sr13,a.sr14 FROM lotofacil_resultado a,prov b WHERE a.numconcurso=b.concurso;
DELETE FROM prov WHERE sit='S';
UPDATE prov SET bola1=CONCAT('0',bola1) WHERE LENGTH(bola1)<2;
UPDATE prov SET bola2=CONCAT('0',bola2) WHERE LENGTH(bola2)<2;
UPDATE prov SET bola3=CONCAT('0',bola3) WHERE LENGTH(bola3)<2;
UPDATE prov SET bola4=CONCAT('0',bola4) WHERE LENGTH(bola4)<2;
UPDATE prov SET bola5=CONCAT('0',bola5) WHERE LENGTH(bola5)<2;
UPDATE prov SET bola6=CONCAT('0',bola6) WHERE LENGTH(bola6)<2;
UPDATE prov SET bola7=CONCAT('0',bola7) WHERE LENGTH(bola7)<2;
UPDATE prov SET bola8=CONCAT('0',bola8) WHERE LENGTH(bola8)<2;
UPDATE prov SET bola9=CONCAT('0',bola9) WHERE LENGTH(bola9)<2;
UPDATE prov SET bola10=CONCAT('0',bola10) WHERE LENGTH(bola10)<2;
UPDATE prov SET bola11=CONCAT('0',bola11) WHERE LENGTH(bola11)<2;
UPDATE prov SET bola12=CONCAT('0',bola12) WHERE LENGTH(bola12)<2;
UPDATE prov SET bola13=CONCAT('0',bola13) WHERE LENGTH(bola13)<2;
UPDATE prov SET bola14=CONCAT('0',bola14) WHERE LENGTH(bola14)<2;
UPDATE prov SET bola15=CONCAT('0',bola15) WHERE LENGTH(bola15)<2;
UPDATE prov SET data=CONCAT(SUBSTR(DATA,7,4),'-',SUBSTR(DATA,4,2),'-',SUBSTR(DATA,1,2));
UPDATE prov SET rateiog15=g15*rateiog15 WHERE g15>0;
UPDATE prov SET rateiog15=acumuladog15 WHERE g15=0;
UPDATE prov SET rateiog14=g14*rateiog14;
UPDATE prov SET rateiog13=g13*rateiog13;
UPDATE prov SET rateiog12=g12*rateiog12;
UPDATE prov SET rateiog11=g11*rateiog11;
ALTER TABLE `prov`
	CHANGE COLUMN `data` `data` DATE NULL DEFAULT NULL COLLATE 'utf8_general_ci' AFTER `concurso`;

REPLACE lotofacil_resultado SELECT concurso,`data`,bola1,bola2,bola3,bola4,bola5,bola6,bola7,bola8,bola9,bola10,bola11,bola12,bola13,bola14,bola15,
CONCAT(bola1,bola2,bola3,bola4,bola5,bola6,bola7,bola8,bola9,bola10,bola11,bola12,bola13,bola14,bola15) AS numero,g15,localidade,rateiog15,g14,rateiog14,g13,rateiog13,g12,rateiog12,g11,rateiog11,
acumuladog15,arrecadacaototal,estimativapremio,acumulado_lfindependencia,observacao,sit,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,sr11,sr12,sr13,sr14 FROM prov;
DROP TABLE prov;

SELECT * FROM lotofacil_resultado;

CALL LF_OBTEM_01;
#CALL LF_OBTEM_02;
#CALL LF_OBTEM_03;
#CALL LF_OBTEM_04;
CALL LF_ESTATISTICA('atualiza',0,0);

SELECT * FROM lotofacil_resultado;