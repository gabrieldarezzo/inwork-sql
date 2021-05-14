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

Vamos criar o banco 'exemplo'... com o nome de `exemplo` (Inception Feelings)
```sql
CREATE DATABASE exemplo;
```

E criar uma tabela chamada `produto` que contem um número indentificador incremental (id) e nome do produto (nome_produto).
```sql
USE exemplo;
CREATE TABLE produto(
	 id             INT(8) PRIMARY KEY AUTO_INCREMENT
	,nome_produto   VARCHAR(50) NOT NULL
);
```

OUWWWWW! É coisa pra caramba nova aqui hehe.

Basicamente informamos que a tabela produto tem dois campos **(id, nome_produto)**  
E cada um desses campos possui um data_type/tipo primitivo (INT/DOUBLE/CHAR/VARCHAR).   
 
No caso o tipo/data_type da coluna **id** é um INT (inteiro)  <del>Inteligencia +8 tipo RPG :( </del>  
  - ->Uma CONSTRAINT de **PRIMARY KEY** :key:.    
  - ->PRIMARY KEY significa que é uma chave única (impossivel de ter 2x o mesmo número) e automaticamente obrigatório (NOT NULL).    

Leia mais:   
https://pt.wikipedia.org/wiki/Chave_prim%C3%A1ria  


NOT NULL é exatamente a tradução fala.... :exclamation:NÃO PODE SER NULO AQUI NÃO TIOZÃO:exclamation:   

Já no caso do **nome_produto** temos VARCHAR(50), que recebe um texto até 50 caracteres (caso exceda, ele ignora o restante)


Entenda mais sobre INT,VARCHAR, CHAR, TEXT, DATE, DATETIME  
http://www.rcoli.com.br/2012/08/tipos-de-campos-no-mysql-saiba-como-escolher-o-tipo-correto/  


Mais informação a respeito do CREATE aqui:  
https://dev.mysql.com/doc/refman/5.7/en/create-table.html  


 ------
## Exemplo de Cursos x Pré-requisito.  
### Um curso pode ter vários cursos como pré-requisito.  

Veja o exemplo abaixo:

Pra fazer `Cálculo 1` precisa de conhecimentos em `Matemática`   
Pra fazer `Cálculo 2` precisa de conhecimentos em `Matemática` e `Cálculo 1`  


------------------------------------------
Pensando em um modelo de dados, só ai precisamos de:
- Uma tabela cursos para armazenar um ID + Nome (`Matemática`, `Cálculo 1`, `Cálculo 2`)
- Uma tabela auxiliar para armazenar as dependências de cada curso. (`Cálculo 1` precisa de conhecimentos em `Matemática`)

 
Bora criar uma base e as tabelas, afinal... Talk is cheap, show me the code....
```sql
CREATE DATABASE minhabase;
USE minhabase;

CREATE TABLE cursos (
     cur_id     INT(8) PRIMARY KEY AUTO_INCREMENT 
    ,cur_nome   VARCHAR(50) NOT NULL
);


INSERT cursos (cur_nome) VALUES ('Matemática Básica');
INSERT cursos (cur_nome) VALUES ('Cálculo 1');
INSERT cursos (cur_nome) VALUES ('Cálculo 2');

CREATE TABLE curso_req (
     cur_id INT(8) NOT NULL
    ,cur_id_req INT(8) NOT NULL
    ,CONSTRAINT `fk_curso_req` FOREIGN KEY (`cur_id`) REFERENCES `cursos` (`cur_id`)
    ,CONSTRAINT `fk_cursos_0` FOREIGN KEY (`cur_id_req`) REFERENCES `cursos` (`cur_id`)
);

```   

Show, agora vamos popular alguns dados pra testar:

```sql   
INSERT curso_req (cur_id, cur_id_req) VALUES (2, 1); /* Pra fazer Cálculo 1 precisa de Matemática Básica */
INSERT curso_req (cur_id, cur_id_req) VALUES (3, 1); /* Pra fazer Cálculo 2 precisa de Matemática Básica */
INSERT curso_req (cur_id, cur_id_req) VALUES (3, 2); /* Pra fazer Cálculo 2 precisa de Cálculo 1 */

```     
Agora vamos testar...    
```sql   
SELECT * FROM cursos_req WHERE cursos_req.cur_id = 3;
/*
cur_id  cur_id_req  
------  ------------
     3             1
     3             2
*/
```   
LEGAL!!!   
Funcionou certinho, Calculo 2: precisa de ( Mat + Calculo 1)  
Mas seria massa se desse pra colocar o nome de cada curso certo?.

  
#### JOINS
Nesse caso é só usar um `JOIN`.... Ex:   
```sql   
SELECT 
    cursos.cur_nome As Curso_Desejado,
    curso_pre.cur_nome AS Pre_requisito
FROM curso_req
INNER JOIN cursos AS curso_pre ON (
    curso_req.cur_id_req = curso_pre.cur_id
)
INNER JOIN cursos ON (  
    curso_req.cur_id = cursos.cur_id   
);
/*
Curso_Desejado    Pre_requisito        
----------  ---------------------
Cálculo 1   Matemática Básica  
Cálculo 2   Matemática Básica  
Cálculo 2   Cálculo 1           
*/
```   

desas forma com apenas 1 Query, retornamos todos os cursos refernciando as F.K. (foreign key) com as P.K. (priamary key),
No caso 
```sql curso_req.cur_id_req = curso_pre.cur_id```

## O problema do N+1
Vamos utilizar um exemplo de código em `<?php` para exemplificar o erro de N+1:
```php
<?php

// Retorna informação de um curso.
function getClassFromId(int $id): array {
    $stmt = $db->prepare("SELECT cur_id, cur_nome from cursos where cur_id = ?");
    $stmt->execute($id);
    return $stmt->fetch(PDO::FETCH_OBJ);
}

// Retorna todos os cursos obrigatorios
function getAllRequiredClassFromClassId(int $curId): array {
    $stmt = $db->prepare("SELECT cur_id, cur_id_req from curso_req where cur_id = ?");
	$stmt->execute($curId);
	return $stmt->fetchAll(PDO::FETCH_OBJ);
}

// Vamos retornar todos os cursos obrigatorios para Cálculo 2 (Vai retornar: Matemática + Cálculo 1s).
$getAllRequiredClass = getAllRequiredClassFromClassId(3);
foreach($getAllRequiredClass as $requiredClass) {
    print getClassFromId($requiredClass->cur_id)->cur_nome . "\n";
}
```

Legal, o trecho acima vai imprimir:
```
Matemática
Cálculo 1
```

Porem no total fizemos 3 Querys, sendo:
1 - Para pegar todos requisitos dos cursos `SELECT cur_id, cur_id_req from curso_req where cur_id = 3`,
2x Pois durante o laço de repetição `foreach` batemos 2x vezes no banco:
```sql
SELECT cur_id, cur_id_req from curso_req where cur_id = 1
SELECT cur_id, cur_id_req from curso_req where cur_id = 2
```

Para evitar isso, poderiamos ter simplesmente feito apenas 1 query, que retorna todos os requisitos e informações dos cursos.
Podemos deixar a aplicação muito mais performatica e evitando um stress para o banco desnecessario e/ou diminuir brutalmente o tempo de processamento.

Imagine uma rotina onde temos 200 mil registros, e cada loop vai bater novamente no banco.

Para mais informações a respeito do problema do `N+1`:
https://pt.stackoverflow.com/questions/307264/o-que-%C3%A9-o-problema-das-queries-n1






 
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

(Pra entender melhor o funcionamento do INNER join, troca ali pra (RIGHT|LEFT)  
  
Caso não conheça alguma das clausulas SQL no exemplo estude elas individualmente.



Exercicios extras:
## Just.... DO IT:
- (1) Crie um banco de dados com o nome de **no_trabalho**
- (2) Crie uma tabela com o nome **pessoa** que possa registrar um **nome**, **e-mail**, e que cada registro possua um número de identificação único
- (3) Crie uma tabela com o nome **modelo_celular** que possa registrar um **nome**, **modelo**, **descrição**, **Data de Fabricação**





Bons estudos.  
 
