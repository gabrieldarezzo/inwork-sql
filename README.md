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