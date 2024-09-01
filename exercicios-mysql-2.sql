create database gerenciar_projetos
default character set utf8
default collate utf8_general_ci;

use gerenciar_projetos;

create table if not exists funcionarios (
	id int primary key auto_increment,
    nome varchar(100)
) default charset = utf8;

create table if not exists projetos(
	id int primary key auto_increment,
    nome varchar(100)
) default charset = utf8;

create table if not exists funcionarios_projetos(
	funcionario_id int,
    projeto_id int,
    horas_trabalhadas int unsigned,
    primary key (funcionario_id, projeto_id)
) default charset = utf8;

RENAME TABLE funcionario_projetos TO funcionarios_projetos;

alter table funcionarios_projetos
add constraint fk_funcionario
foreign key (funcionario_id)
references funcionarios(id);

alter table funcionarios_projetos
add constraint fk_projeto
foreign key (projeto_id)
references projetos(id);

# Exercício 1 - Fácil: Inserção de Dados
# Insira 3 funcionários e 3 projetos nas tabelas funcionarios e projetos.
insert into funcionarios (nome) values 
("Toninho"),
("Roberval"),
("Arthur");

insert into funcionarios (nome) values 
("Ricardo"),
("Josué"),
("Davi");

insert into projetos (nome) values
("Criação do banco de dados"),
("Projeto de estruturação de dados"),
("Sistema de aviação");

# Exercício 2 - Fácil: Inserção em Tabela de Associação
# Atribua funcionários a projetos na tabela funcionarios_projetos com o número de horas trabalhadas.
insert into funcionarios_projetos (funcionario_id, projeto_id, horas_trabalhadas) values
(1, 3, 20),
(1, 2, 100),
(2, 1, 120),
(3, 1, 150),
(1, 1, 80);

insert into funcionarios_projetos (funcionario_id, projeto_id, horas_trabalhadas) values
(5, 2, 180);

# Exercício 3 - Fácil: Consulta Simples com JOIN
# Liste todos os funcionários junto com os projetos nos quais estão trabalhando, exibindo também as horas trabalhadas.
select f.nome, p.nome, fp.horas_trabalhadas from funcionarios f
left join funcionarios_projetos fp on fp.funcionario_id = f.id
left join projetos p on fp.projeto_id = p.id;

# Exercício 4 - Médio: Funções de Agregação
# Calcule o total de horas trabalhadas por cada funcionário em todos os projetos.
select f.nome, sum(fp.horas_trabalhadas) as horas_trabalhadas from funcionarios f
inner join funcionarios_projetos fp on fp.funcionario_id = f.id
group by f.id
order by horas_trabalhadas desc;

# Exercício 5 - Médio: HAVING
# Liste os funcionários que trabalharam mais de 160 horas no total em todos os projetos combinados.
select f.nome, sum(fp.horas_trabalhadas) as horas_trabalhadas from funcionarios f
inner join funcionarios_projetos fp on fp.funcionario_id = f.id
group by f.id
having horas_trabalhadas > 160
order by horas_trabalhadas desc;

# Exercício 6 - Médio: UPDATE
# Atualize o número de horas trabalhadas para um funcionário específico em um determinado projeto.
update funcionarios_projetos
set horas_trabalhadas = 60
where funcionario_id = 1 and projeto_id = 3;

# Exercício 7 - Difícil: ALTER TABLE
# Adicione uma coluna data_inicio na tabela projetos e defina uma restrição NOT NULL.
alter table projetos
add column data_inicio date not null default '2024-01-01';

update projetos
set data_inicio = curdate()
where data_inicio = '2024-01-01';

# Exercício 8 - Difícil: INSERT INTO com Subquery
# Insira dados na tabela funcionarios_projetos usando uma subquery que selecione um funcionário e um projeto aleatórios.
insert into funcionarios_projetos 
select 
	(select id from funcionarios order by rand() limit 1), -- Pegando um funcionário aleatório
    (select id from projetos order by rand() limit 1), -- Pegando um projeto aleatório
    10; -- Definindo 10 para as horas_trabalhadas

# Exercício 9 - Difícil: CONSTRAINTS
# Adicione uma constraint na tabela funcionarios_projetos para garantir que um funcionário não pode ser atribuído ao mesmo projeto mais de uma vez.
alter table funcionarios_projetos
add constraint uq_funcionario_projeto unique (funcionario_id, projeto_id);

# Exercício 10 - Muito Difícil: Função de Agregação com Condição
# Liste os projetos que têm mais de 100 horas trabalhadas no total, mas apenas para projetos iniciados após uma certa data.
select p.nome, sum(fp.horas_trabalhadas) as horas_trabalhadas from projetos p
inner join funcionarios_projetos fp on fp.projeto_id = p.id
where p.data_inicio > '2024-01-01'
group by p.nome
having horas_trabalhadas > 100
order by horas_trabalhadas desc;