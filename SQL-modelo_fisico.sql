CREATE DATABASE db_sistema_faculdade;

USE db_sistema_faculdade;

# criando a tabela de cursos
CREATE TABLE tbl_cursos (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (100) NOT NULL,
    tempo_curso INT NOT NULL,
    descricao TEXT,
    valor FLOAT NOT NULL,
    
    UNIQUE INDEX (id)
);

# criando a tabela de matéria dos cursos
CREATE TABLE tbl_materias (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (100) NOT NULL,
    descricao TEXT,
    
    UNIQUE INDEX (id)
);

# criando a relação entre as tabelas cursos e matérias
CREATE TABLE tbl_materia_curso (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_curso_id INT NOT NULL,
    fk_materia_id INT NOT NULL,
    
    UNIQUE INDEX (id),
    
    CONSTRAINT fk_curso_materia
    FOREIGN KEY (fk_curso_id)
    REFERENCES tbl_cursos (id),
    
    CONSTRAINT fk_materia_curso
    FOREIGN KEY (fk_materia_id)
    REFERENCES tbl_materias (id)
);

# criando a tabela turmas
CREATE TABLE tbl_turmas (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    data_inicio DATE NOT NULL,
    periodo INT NOT NULL,
    
    UNIQUE INDEX (id)
);

# criando a tabela alunos e fazendo a relação com as tabelas turma e cursos.
CREATE TABLE tbl_alunos (
	ra INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (100) NOT NULL,
    cpf VARCHAR (11) NOT NULL,
    data_registro DATE NOT NULL,
    data_nascimento DATE NOT NULL,
    fk_curso_id INT NOT NULL,
    fk_turma_id INT NOT NULL,
    
    UNIQUE INDEX (ra),
    
    CONSTRAINT fk_curso_aluno
    FOREIGN KEY (fk_curso_id)
    REFERENCES tbl_cursos (id),
    
    CONSTRAINT fk_turma_aluno
    FOREIGN KEY (fk_turma_id)
    REFERENCES tbl_turmas (id)
);

/*
criando as tabelas de dados dos alunos e fazendo as relações
*/

CREATE TABLE tbl_telefones_aluno (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    numero_principal VARCHAR (15) NOT NULL,
    numero_secundario VARCHAR (15) NOT NULL,
    data_registro DATE NOT NULL,
    fk_aluno_ra INT NOT NULL,
    
    UNIQUE INDEX (id),
    
    CONSTRAINT fk_telefone_aluno
    FOREIGN KEY (fk_aluno_ra)
    REFERENCES tbl_alunos (ra)
    
);

CREATE TABLE tbl_emails_aluno (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    endereco_email VARCHAR (255) NOT NULL,
    data_registro DATE NOT NULL,
    fk_aluno_ra INT NOT NULL,
    
    UNIQUE INDEX (id),
    
    CONSTRAINT fk_email_aluno
    FOREIGN KEY (fk_aluno_ra)
    REFERENCES tbl_alunos (ra)
);

CREATE TABLE tbl_enderecos_aluno (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    data_registro DATE NOT NULL,
    cep VARCHAR (8) NOT NULL,
    logradouro VARCHAR (100) NOT NULL,
    bairro VARCHAR (45) NOT NULL,
    cidade VARCHAR (45) NOT NULL,
    estado VARCHAR (2) NOT NULL,
    pais VARCHAR (45) NOT NULL,
	fk_aluno_ra INT NOT NULL,
    
    UNIQUE INDEX (id),
    
    CONSTRAINT fk_endereco_aluno
    FOREIGN KEY (fk_aluno_ra)
    REFERENCES tbl_alunos (ra)
);

# criando a tabela dos professores
CREATE TABLE tbl_professores (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (100) NOT NULL,
    cpf VARCHAR (11) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_contratacao DATE NOT NULL,
    salario FLOAT NOT NULL,
    
    UNIQUE INDEX (id)
);

# fazendo a relação entre professores e matérias
CREATE TABLE tbl_materia_professor (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_materia_id INT NOT NULL,
    fk_professor_id INT NOT NULL,
    
    UNIQUE INDEX (id),
    
    CONSTRAINT fk_materia_professor
    FOREIGN KEY (fk_materia_id)
    REFERENCES tbl_materias (id),
    
    CONSTRAINT fk_professor_materia
    FOREIGN KEY (fk_professor_id)
    REFERENCES tbl_professores (id)
);

# criando a tabela de atividades e fazendo a relação com professor, matéria e alunos
CREATE TABLE tbl_atividades (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao TEXT,
    tipo ENUM('prova', 'trabalho', 'atividade') NOT NULL,
    nota_aluno FLOAT NOT NULL,
    nota_maxima FLOAT NOT NULL,
    data_efetuado DATE NOT NULL,
    fk_professor_id INT NOT NULL,
    fk_materia_id INT NOT NULL,
    fk_aluno_ra INT NOT NULL,
    
    UNIQUE INDEX (id),
    
    CONSTRAINT fk_atividade_professor
    FOREIGN KEY (fk_professor_id)
    REFERENCES tbl_professores (id),
    
    CONSTRAINT fk_atividade_materia
    FOREIGN KEY (fk_materia_id)
    REFERENCES tbl_materias (id),
    
    CONSTRAINT fk_atividade_aluno
    FOREIGN KEY (fk_aluno_ra)
    REFERENCES tbl_alunos (ra)
);

/*
criando as tabelas que contem os dados dos professores e fazendo a relação com a tabela dos professores
*/

CREATE TABLE tbl_telefones_professor (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    numero_principal VARCHAR (15) NOT NULL,
    numero_secundario VARCHAR (15) NOT NULL,
    data_registro DATE NOT NULL,
    fk_professor_id INT NOT NULL,
    
    UNIQUE INDEX (id),
    
    CONSTRAINT fk_telefone_professor
    FOREIGN KEY (fk_professor_id)
    REFERENCES tbl_professores (id)
    
);

CREATE TABLE tbl_emails_professor (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    endereco_email VARCHAR (255) NOT NULL,
    data_registro DATE NOT NULL,
    fk_professor_id INT NOT NULL,
    
    UNIQUE INDEX (id),
    
    CONSTRAINT fk_email_professor
    FOREIGN KEY (fk_professor_id)
    REFERENCES tbl_professores (id)
);

CREATE TABLE tbl_enderecos_professor (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    data_registro DATE NOT NULL,
    cep VARCHAR (8) NOT NULL,
    logradouro VARCHAR (100) NOT NULL,
    bairro VARCHAR (45) NOT NULL,
    cidade VARCHAR (45) NOT NULL,
    estado VARCHAR (2) NOT NULL,
    pais VARCHAR (45) NOT NULL,
	fk_professor_id INT NOT NULL,
    
    UNIQUE INDEX (id),
    
    CONSTRAINT fk_endereco_professor
    FOREIGN KEY (fk_professor_id)
    REFERENCES tbl_professores (id)
);

#criando a tabela pra presencas dos alunos e fazendo a relação com professores e alunos
CREATE TABLE tbl_presencas (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	data DATE NOT NULL,
    status ENUM ('presente', 'ausente', 'justivicado') NOT NULL,
    observacoes TEXT,
    hora_entrada TIME,
    hora_saida TIME,
    fk_aluno_ra INT NOT NULL,
    fk_professor_id INT NOT NULL,
    
    UNIQUE (id),
    
    CONSTRAINT fk_presenca_aluno
    FOREIGN KEY (fk_aluno_ra)
    REFERENCES tbl_alunos (ra),
    
    CONSTRAINT fk_professor_presenca
    FOREIGN KEY (fk_professor_id)
    REFERENCES tbl_professores (id)
);

INSERT INTO tbl_cursos (nome, tempo_curso, valor) values ('Administração', 10, '220.90');

INSERT INTO tbl_turmas (data_inicio, periodo) values ('20240901', 1);

INSERT INTO tbl_alunos (nome, data_registro, cpf, data_nascimento, fk_curso_id, fk_turma_id) values ('Jeferson Oliveira', "20241024", '22476589098', "20240409", 2, 1);
select * from tbl_alunos;

select tbl_alunos.nome, tbl_cursos.nome as nome_curso, tbl_cursos.valor from tbl_alunos
inner join tbl_cursos on tbl_cursos.id = tbl_alunos.fk_curso_id;

show tables;