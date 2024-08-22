#Inserir um novo curso: Insira um curso com o nome "MySQL Básico", 
# descrição "Introdução ao MySQL", carga horária de 40 horas e total de 10 aulas.
INSERT INTO cursos VALUES
(DEFAULT, 'MySQL JOIN', 'Aprendendo sobre JOIN', '40', '12', DEFAULT);

ALTER TABLE cursos
MODIFY COLUMN idcurso INT AUTO_INCREMENT;

select * from cursos;

UPDATE cursos
SET idcurso = '31'
WHERE idcurso = '0';

# Inserir uma nova pessoa: Insira uma pessoa chamada "João", 
# nascida em 15 de agosto de 2000, do sexo masculino, 
# com altura 1.75m e peso 70kg.
INSERT INTO gafanhotos (nome, nascimento, sexo, altura, peso) VALUES 
('João', '2000-08-15', 'M', '1.75', '70');

select * from gafanhotos;

# Atualizar o nome do curso: 
# Atualize o nome do curso "MySQL Básico" para "MySQL para Iniciantes".
UPDATE cursos
SET nome = 'MySQL para Iniciantes'
WHERE nome like 'MySQL_B%';

select * from cursos;

desc gafanhotos;

# Verificar cursos assistidos: 
# Exiba os cursos assistidos por uma pessoa específica cujo ID é 1.
select c.nome as 'Nome_Curso', c.idcurso, gac.idcurso, gac.idgafanhoto from cursos as c
JOIN gafanhoto_assiste_curso as gac
on c.idcurso = gac.idcurso
where gac.idgafanhoto = '1';

# Contar cursos assistidos por pessoa: 
# Conte o número de cursos assistidos por uma pessoa específica cujo ID é 1.
select count(*) from gafanhoto_assiste_curso
where idgafanhoto = '1';

select * from gafanhoto_assiste_curso;

insert into gafanhoto_assiste_curso (data, idgafanhoto, idcurso) values
('2020-03-30', 2, 15),
('2020-03-30', 60, 32),
('2020-03-30', 61, 30),
('2020-03-30', 13, 22),
('2020-03-30', 22, 3),
('2020-03-30', 40, 5),
('2020-03-30', 15, 6),
('2020-03-30', 45, 9),
('2020-03-30', 55, 12),
('2020-03-30', 31, 7),
('2020-03-30', 30, 6),
('2020-03-30', 7, 5);

# Inserir uma nova associação entre pessoa e curso:
# Insira um registro na tabela gafanhoto_assiste_curso 
# para indicar que a pessoa com ID 1 assistiu ao curso com ID 2 na data de hoje.
INSERT INTO gafanhoto_assiste_curso (data, idgafanhoto, idcurso) values 
(CURDATE(), '1', '2');

# Inserir uma pessoa estrangeira: 
# Insira uma pessoa chamada "Maria", 
# nascida em 12 de janeiro de 1995, 
# do sexo feminino, 
# com altura de 1.60m, 
# peso de 55kg e nacionalidade "Portugal".
INSERT INTO gafanhotos (nome, nascimento, sexo, altura, peso, nacionalidade) VALUES 
('Maria', '1995-01-12', 'F', '1.6', '55', 'Portugal');

# Alterar a carga horária de um curso: 
# Altere a carga horária do curso "MySQL para Iniciantes" para 50 horas.
update cursos
set carga = 50
where nome like 'MySQL%Ini%';

# Exibir cursos assistidos com detalhes: 
# Faça um JOIN entre as tabelas gafanhoto_assiste_curso, cursos, e pessoas 
# para exibir o nome da pessoa, o nome do curso, 
# e a data em que assistiu ao curso.
SELECT p.nome AS pessoa, c.nome AS curso, g.data 
FROM gafanhoto_assiste_curso g 
JOIN cursos c ON g.idcurso = c.idcurso 
JOIN pessoas p ON g.idgafanhoto = p.id;

# Contar total de cursos assistidos por cada pessoa: 
# Usando funções agregadas, conte o número total de cursos assistidos por cada pessoa.
SELECT p.nome, COUNT(g.idcurso) AS total_cursos 
FROM pessoas p 
LEFT JOIN gafanhoto_assiste_curso g ON p.id = g.idgafanhoto 
GROUP BY p.id;
# OBS: está pegando todas as pessoas
# COUNT(g.ircurso) conta o número de vezes que 'idcurso' aparece para cada pessoa.

SELECT *
FROM pessoas p 
LEFT JOIN gafanhoto_assiste_curso g ON p.id = g.idgafanhoto ;

create table if not exists intervalo(
	idinterval int primary key,
    name varchar(20)
) default charset = utf8;

ALTER TABLE pessoas
ADD COLUMN idinterval int;

ALTER TABLE pessoas
ADD CONSTRAINT fk_idinterval
FOREIGN KEY (idinterval)
REFERENCES intervalo(idinterval)
ON DELETE CASCADE
ON UPDATE CASCADE;

desc intervalo;

alter table intervalo
modify column idinterval int auto_increment;

insert into intervalo (name) values 
('Manhã'),
('Tarde'),
('Noite'),
('Madrugada');

select * from intervalo;

insert into pessoas (nome, sexo, nacionalidade, idinterval) values 
('Bistecone', 'M', DEFAULT, 1),
('Misty', 'F', 'USA', 2),
('Usopp', 'M', 'África do Sul', 3),
('Nico Robin', 'F', 'Rússia', 4);

select * from pessoas
where idinterval != 'null';

desc pessoas;

select * from gafanhoto_assiste_curso
order by idcurso; 

select * from cursos c
left join gafanhoto_assiste_curso gac on c.idcurso = gac.idcurso;

use cadastro;

desc pessoas;

alter table pessoas
add column cor_preferida tinyint auto_increment;

select *
from pessoas p
join gafanhoto_assiste_curso gac on gac.idgafanhoto = p.id
join intervalo interv ON p.idinterval = interv.idinterval;

select * from pessoas
limit 1;

select * from intervalo
limit 1;

# Adicionar uma coluna 'email' na tabela pessoas: 
# Adicione uma coluna email na tabela pessoas para armazenar o e-mail das pessoas.
alter table pessoas
add column email varchar(50);

# Atualizar o email de uma pessoa: 
# Atualize o e-mail da pessoa cujo ID é 1 para "joao@example.com".
update pessoas
set email = 'joao@example.com'
where id = 1;

# Verificar cursos com mais de 30 aulas: 
# Exiba todos os cursos que possuem mais de 30 aulas.
select * from cursos
where totaulas > 30;

# Calcular a média de carga horária dos cursos: 
# Calcule a média de carga horária dos cursos cadastrados.
select avg(carga) from cursos;

# Exibir pessoas que assistiram a mais de 2 cursos: 
# Faça um JOIN para exibir as pessoas que assistiram a mais de 2 cursos.
select p.nome, count(gac.idcurso)
from pessoas p
join gafanhoto_assiste_curso gac on gac.idgafanhoto = p.id
group by p.id
having count(gac.idcurso) >= 2;

# Remover a coluna 'peso' da tabela pessoas: 
# Remova a coluna peso da tabela pessoas.
alter table pessoas
drop column peso;

# Verificar pessoas que não assistiram a nenhum curso: 
# Faça um LEFT JOIN entre pessoas e gafanhoto_assiste_curso para exibir todas as pessoas que não assistiram a nenhum curso.
select p.nome, count(gac.idcurso)
from pessoas p
left join gafanhoto_assiste_curso gac on gac.idgafanhoto = p.id
group by p.id
having count(gac.idcurso)  = '0'
order by p.nome;

# Calcular a carga horária total de cursos assistidos por cada pessoa: 
# Usando funções agregadas, calcule a carga horária total dos cursos assistidos por cada pessoa.
select p.nome, sum(c.carga) carga_total
from pessoas p
inner join gafanhoto_assiste_curso gac on gac.idgafanhoto = p.id
inner join cursos c on gac.idcurso = c.idcurso
group by p.id
order by nome;

# Exibir os cursos mais populares: 
# Exiba os cursos que foram assistidos pelo maior número de pessoas.
select c.nome, count(gac.idgafanhoto) quantidade_pessoas
from cursos c
left join gafanhoto_assiste_curso gac on gac.idcurso = c.idcurso
group by c.idcurso
order by quantidade_pessoas desc;

# Inserir um curso com ano anterior a 2024: 
# Insira um curso com o nome "História do MySQL", descrição "Evolução do MySQL", carga horária de 20 horas, total de 5 aulas e ano 2023.
insert into cursos (nome, descricao, carga, totaulas, ano) values
('História do MySQL', 'Evolução do MySQL', '20', '5', '2023');

# Adicionar uma coluna 'último_acesso' na tabela gafanhoto_assiste_curso:
# Adicione uma coluna último_acesso na tabela gafanhoto_assiste_curso para armazenar a data do último acesso ao curso.
alter table gafanhoto_assiste_curso
add column ultimo_acesso date;

# Atualizar o último acesso de uma pessoa em um curso: 
# Atualize a data de último acesso da pessoa cujo ID é 1 no curso com ID 2 para a data de hoje.
update gafanhoto_assiste_curso
set ultimo_acesso = curdate()
where idgafanhoto = 1 and idcurso = 2;

# Verificar a pessoa mais ativa: 
# Usando funções agregadas, exiba a pessoa que assistiu ao maior número de cursos.
select p.nome, count(gac.idcurso) total_cursos
from pessoas p 
inner join gafanhoto_assiste_curso gac on gac.idgafanhoto = p.id
group by p.id
order by total_cursos desc
limit 1;

# Calcular o IMC das pessoas: 
# Adicione uma coluna imc na tabela pessoas e atualize com o cálculo do Índice de Massa Corporal (IMC) de cada pessoa (IMC = peso / altura²).
alter table pessoas
add column imc decimal(5, 2);

update pessoas
set imc = peso / (altura * altura);