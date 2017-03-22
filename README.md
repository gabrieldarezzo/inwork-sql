# Exercicios em Banco de Dados



## Previa leitura antes de tudo:
[Wiki Banco de dados relacional](https://pt.wikipedia.org/wiki/Banco_de_dados_relacional)

:memo: Vamos utilizar Mysql como Server/Client

Durante os exemplos utilizei no client utilizei o [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)  

E como Server do Mysql utilizei o [WampServer](http://www.wampserver.com/en/)

Caso você esteja com **zero** vontade de baixar toda essa caralhada de coisas e configurar. 
Você pode simplemente usar um site como esse:
http://sqlfiddle.com/


## Eplicação de como criar um Banco, Tabela

Mysql 
Maneira simplista...
-> O Banco armazena tabelas
-> Tabelas armazena Registros.

Então pela lógica, armazenar registros (nome, email, telefone, data de nascimento, etc precisamos de um banco...)

o SQL-Statment é:
```sql
CREATE DATABASE nome_do_banco
```

Vamos criar o banco 'exemplo'.... 
```sql
CREATE DATABASE exemplo;
```

E criar uma tabela chamada 'produto' que contem o nome do produto.
```sql
CREATE TABLE produto(
	 id 			INT(8) PRIMARY KEY AUTO_INCREMENT
	,nome_produto	VARCHAR(50) NOT NULL
);
```

OUWWWWW! É coisa pra caramba nova aqui hehe.

Basicamente informamos que a tabela produto tem dois campos **(id, nome_produto)**
E cada um desses campos possui um data_type/tipo primitivo (INT/VARCHAR).
 
No caso o **id** possui um INT (inteiro)
  -> uma CONSTRAINT de **PRIMARY KEY** :key:.  
  -> PRIMARY KEY é unica e não pode ser inserido nenhum registro na tabela se não tiver o mesmo preenchido.  

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
  - (2) Crie uma tabela com o nome **pessoa** que possa registrar um **nome**, **e-mail**, e que cada registro possua um número de indentificação unico  
  - (3) Crie uma tabela com o nome **modelo_celular** que possa registrar um **nome**, **modelo**, **descrição**, **Data de Fabricação** 