# Exercícios em Banco de Dados



## Previa leitura antes de tudo:
:mag_right: -> [Wiki Banco de dados relacional](https://pt.wikipedia.org/wiki/Banco_de_dados_relacional)



## Começando....



:memo:Dos [diversos](https://pt.wikipedia.org/wiki/Lista_de_bancos_de_dados) banco de dados relacionais que existem.  
Vamos utilizar Mysql como Server/Client, pois bem [popular](http://db-engines.com/en/ranking_trend/system/Microsoft+SQL+Server%3BMySQL%3BOracle)

Durante os exemplos utilizei como server de MySql o [WampServer](http://www.wampserver.com/en/) devido a sua facil instalação (Next/Next/Finish), e como client utilizei o [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)


Caso você esteja com **zero** vontade de baixar toda essa caralhada de coisas e configurar.   
Você pode simplesmente usar um site como esse:  
http://sqlfiddle.com/


## Explicação de como criar um Banco, Tabela

Mysql   
Maneira simplista...  
-> O Banco armazena tabelas   
-> Tabelas armazena Registros.   

Então pela lógica, armazenar registros (nome, email, telefone, data de nascimento, etc precisamos de um banco...)

o SQL-Statment é:  
```sql
CREATE DATABASE nome_do_banco
```

Vamos criar o banco 'exemplo'... como Exemplo (Inception Feelings)
```sql
CREATE DATABASE exemplo;
```

E criar uma tabela chamada 'produto' que contem o nome do produto.
```sql
USE exemplo;
CREATE TABLE produto(
	 id				INT(8) PRIMARY KEY AUTO_INCREMENT
	,nome_produto	VARCHAR(50) NOT NULL
);
```

OUWWWWW! É coisa pra caramba nova aqui hehe.

Basicamente informamos que a tabela produto tem dois campos **(id, nome_produto)**  
E cada um desses campos possui um data_type/tipo primitivo (INT/VARCHAR).   
 
No caso o **id** possui um data_type INT (inteiro)  <del>Inteligencia +8 tipo RPG :( </del>  
  - ->Uma CONSTRAINT de **PRIMARY KEY** :key:.    
  - ->PRIMARY KEY é única e não pode ser inserido nenhum registro na tabela se não tiver o mesmo preenchido.    

Leia mais:   
https://pt.wikipedia.org/wiki/Chave_prim%C3%A1ria  


NOT NULL é exatamente a tradução fala.... :exclamation:NÃO PODE SER NULO AQUI NÃO TIOZÃO:exclamation:   

Já no caso do **nome_produto** temos VARCHAR(50).  


Entenda mais sobre INT,VARCHAR, CHAR, TEXT, DATE, DATETIME  
http://www.rcoli.com.br/2012/08/tipos-de-campos-no-mysql-saiba-como-escolher-o-tipo-correto/  


Mais informação a respeito do CREATE aqui:  
https://dev.mysql.com/doc/refman/5.7/en/create-table.html  




Exercicios: 
## Just.... DO IT:
  - (1) Crie um banco de dados com o nome de **no_trabalho**
  - (2) Crie uma tabela com o nome **pessoa** que possa registrar um **nome**, **e-mail**, e que cada registro possua um número de identificação único  
  - (3) Crie uma tabela com o nome **modelo_celular** que possa registrar um **nome**, **modelo**, **descrição**, **Data de Fabricação** 
  
  
  
  
  
 ------
## Exemplo de Cursos x Pré-requisito.  
### Um curso pode ter vários cursos como pré-requisito.  

Ex:  
  Citar  
Pra fazer Cálculo 1 precisa de Matemática   
Pra fazer Cálculo 2 precisa de Matemática   
------------------------------------------
Pra fazer Cálculo 2 precisa de Cálculo 1   
 
Então só ai precisamos de uma tabela cursos para armazenar um ID + Nome e uma tabela auxiliar para armazenar cara dependência.
 
 
Talk is cheap, show me te code....
 
Bora criar uma base e as tabelas:
```sql
CREATE DATABASE minhabase;
USE minhabase;

CREATE TABLE cursos (
     cur_id     INT(8) PRIMARY KEY AUTO_INCREMENT 
    ,cur_nome   VARCHAR(50) NOT NULL
    
);


INSERT cursos (cur_nome) VALUES ('Matemática Básica');
INSERT cursos (cur_nome) VALUES ('Cálculo 1');
INSERT cursos (cur_nome) VALUES ('Cálculo 2')

CREATE TABLE curso_req (
     cur_id INT(8) NOT NULL
    ,cur_id_req INT(8) NOT NULL
    ,CONSTRAINT `fk_curso_req` FOREIGN KEY (`cur_id`) REFERENCES `cursos` (`cur_id`)
    ,CONSTRAINT `fk_cursos_0` FOREIGN KEY (`cur_id_req`) REFERENCES `cursos` (`cur_id`)
);

```   

Show, agora vamos popular alguns dados pra testar:

```sql   
INSERT curso_req (cur_id, cur_id_req) VALUES (2, 1); /*Pra fazer Cálculo 1 precisa de Matemática Básica*/
INSERT curso_req (cur_id, cur_id_req) VALUES (3, 1); /*Pra fazer Cálculo 2 precisa de Matemática Básica*/
INSERT curso_req (cur_id, cur_id_req) VALUES (3, 2); /*Pra fazer Cálculo 2 precisa de Cálculo 1*/

```     
Agora vamos testar...    
```sql   
SELECT * FROM cursos_req WHERE cursos_req.cur_id = 3
/*
cur_id  cur_id_req  
------  ------------
     3             1
     3             2
*/
```   
LEGAL!!!   
Funcionou certinho, Calculo 2: precisa de ( Mat + Calculo 1)  
Mas seria massa se desse pra colocar o nome.  
  
#### JOINS
Nisso é só usar um JOIN.... Ex:   
```sql   
SELECT 
    cursos.cur_nome,
    curso_pre.cur_nome AS pre_requisito
FROM cursos_req
INNER JOIN cursos AS curso_pre ON (
    cursos_req.cur_id_req = curso_pre.cur_id
)
INNER JOIN cursos ON (  
    cursos_req.cur_id = cursos.cur_id   
)

/*
cur_nome    pre_requisito        
----------  ---------------------
Cálculo 1   Matemática Básica  
Cálculo 2   Matemática Básica  
Cálculo 2   Cálculo 1           
*/
```   
 
Como está bem estruturadinho, da pra fazer algumas brincadeiras, ex:   

```sql   
SELECT 
    cursos.cur_nome
    ,COUNT(cursos_req.cur_id) AS qnt_materias_pre    
FROM cursos
LEFT JOIN cursos_req ON (  
    cursos_req.cur_id = cursos.cur_id   
)
GROUP BY cursos.cur_id
;

/*
cur_nome             qnt_materias_pre  
-------------------  ------------------
Matemática Básica                     0
Cálculo 1                             1
Cálculo 2                             2

*/
```   
Enfim acho q deu pra pegar legal neh?  
(Pra entender melhor o funcionamento do INNER join, troca ali pra (RIGHT|LEFT)  
  
Caso não conheça alguma das clausulas SQL no exemplo estude elas individualmente pra não ficar patinando.   
 
A ideia era exemplificar com código.  
Bons estudos.  
 
