/*Referencia: https://forum.imasters.com.br/topic/556862-busca-com-multiplas-sele%C3%A7%C3%B5es/?do=findComment&comment=2223385*/
CREATE DATABASE imasters;
USE imasters;

CREATE TABLE pessoa(
	 id		INT (8) PRIMARY KEY AUTO_INCREMENT
	,nome	VARCHAR(250)
);
INSERT INTO pessoa(nome) VALUES ('Ronaldo');
INSERT INTO pessoa(nome) VALUES ('Hipster');
INSERT INTO pessoa(nome) VALUES ('Penelope');


CREATE TABLE fruta(
	 id		INT (8) PRIMARY KEY AUTO_INCREMENT
	,nome	VARCHAR(250)
);
INSERT INTO fruta(nome) VALUES ('Banana');
INSERT INTO fruta(nome) VALUES ('Morango');
INSERT INTO fruta(nome) VALUES ('Tomate');

 
CREATE TABLE pessoa_fruta(
	  frutas_id	INT (8)
	 ,pessoa_id	INT (8)	 
);
INSERT INTO pessoa_fruta(pessoa_id, frutas_id) VALUES (1,1); /* Ronaldo comeu uma banana  ( ͡° ͜ʖ ͡°)  */
INSERT INTO pessoa_fruta(pessoa_id, frutas_id) VALUES (2,2); 
INSERT INTO pessoa_fruta(pessoa_id, frutas_id) VALUES (2,3);
INSERT INTO pessoa_fruta(pessoa_id, frutas_id) VALUES (3,3);


SELECT
	 pessoa.nome
	,fruta.nome 	 
FROM 
pessoa_fruta
INNER JOIN pessoa ON(
		pessoa_fruta.pessoa_id = pessoa.id
)
INNER JOIN fruta ON(
		pessoa_fruta.frutas_id = fruta.id
)
ORDER BY pessoa.nome

/*
nome      nome     
--------  ---------
Hipster   Tomate   
Hipster   Morango  
Penelope  Tomate   
Ronaldo   Banana    ( ͡° ͜ʖ ͡°) 
*/


SELECT
	 pessoa.nome
	,fruta.nome 	 
FROM 
pessoa_fruta
INNER JOIN pessoa ON(
		pessoa_fruta.pessoa_id = pessoa.id
)
INNER JOIN fruta ON(
		pessoa_fruta.frutas_id = fruta.id
)
WHERE 
	    fruta.nome LIKE '%Tomate%'
	OR fruta.nome LIKE '%Morango%'
ORDER BY pessoa.nome

/*
nome      nome     
--------  ---------
Hipster   Tomate   
Hipster   Morango  
Penelope  Tomate   

*/


