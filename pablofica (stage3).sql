CREATE DATABASE pablofica DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

USE pablofica;

CREATE TABLE paciente(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(200) UNIQUE NOT NULL,
    senha VARCHAR(200) NOT NULL,
    nome VARCHAR(40) NOT NULL,
    nascimento DATE NOT NULL,
    peso DECIMAL(5,2) UNSIGNED  NOT NULL,
    altura DECIMAL(3,2) UNSIGNED NOT NULL,
    sexo ENUM( 'masculino', 'feminino') NOT NULL,
    nacionalidade varchar(20) DEFAULT 'Brasil'
)DEFAULT CHARSET = utf8;

CREATE TABLE responsavel(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(200) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    nome VARCHAR(40) NOT NULL,
    nascimento DATE NOT NULL,  
    sexo ENUM( 'masculino', 'feminino') NOT NULL,
    peso DECIMAL(5,2) UNSIGNED NOT NULL ,
    altura DECIMAL(3,2) UNSIGNED NOT NULL,
    nacionalidade VARCHAR(20) DEFAULT 'Brasil',
    parentesco VARCHAR(15) NOT NULL
)DEFAULT CHARSET = utf8;

CREATE TABLE personal(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(200) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    nome VARCHAR(40) NOT NULL,
    nascimento DATE NOT NULL,
    sexo ENUM( 'masculino', 'feminino') NOT NULL
)DEFAULT CHARSET = utf8;

CREATE TABLE treinar(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_personal int NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id),
    FOREIGN KEY (id_personal) REFERENCES personal(id)
) DEFAULT CHARSET = utf8;

CREATE TABLE internacao(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(70) NOT NULL,
    data_hora DATETIME NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  medico(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(200) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    nome VARCHAR(40) NOT NULL,
    crm VARCHAR(30) NOT NULL,
    especialidade VARCHAR(30),
    nascimento DATE NOT NULL,
    sexo ENUM( 'masculino', 'feminino') NOT NULL
)DEFAULT CHARSET = utf8;

CREATE TABLE  nutricionista(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(200) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    nome VARCHAR(40) NOT NULL,
    crn VARCHAR(30) NOT NULL,
    nascimento DATE NOT NULL,
    sexo ENUM( 'masculino', 'feminino') NOT NULL
)DEFAULT CHARSET = utf8;

CREATE TABLE exame(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    local VARCHAR(40) NOT NULL,
    data_hora DATETIME NOT NULL,
    descricao VARCHAR(70) NOT NULL,
    id_paciente INT NOT NULL,
    id_medico INT,
    id_nutricionista INT,
    FOREIGN KEY(id_paciente) REFERENCES paciente(id),
    FOREIGN KEY (id_medico) REFERENCES medico(id),
    FOREIGN KEY (id_nutricionista) REFERENCES nutricionista(id)
)DEFAULT CHARSET  = utf8;

CREATE TABLE consulta(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    local VARCHAR(40) NOT NULL,
    data_hora DATETIME NOT NULL,
    id_paciente INT NOT NULL,
    id_medico INT,
    id_nutricionista INT,
    FOREIGN KEY(id_paciente) REFERENCES paciente(id),
    FOREIGN KEY (id_medico) REFERENCES medico(id),
    FOREIGN KEY (id_nutricionista) REFERENCES nutricionista(id)
)DEFAULT CHARSET  = utf8;

CREATE TABLE  receita(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    descricao VARCHAR(70) NOT NULL,
    id_exame INT NOT NULL,
    id_consulta INT NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY(id_exame) REFERENCES exame(id),
    FOREIGN KEY(id_consulta) REFERENCES consulta(id),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  exercicio(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    descricao VARCHAR(70) NOT NULL,
    id_paciente INT NOT NULL,
    id_personal INT,
    FOREIGN KEY(id_paciente) REFERENCES paciente(id),
    FOREIGN KEY(id_personal) REFERENCES personal(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  causa(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(70) NOT NULL,
    data_hora DATETIME NOT NULL,
    id_internacao INT NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY(id_internacao) REFERENCES internacao(id),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  tratamento(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    descricao VARCHAR(70) NOT NULL,
    inicio DATE NOT NULL,
    fim DATE,
    id_internacao INT NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY(id_internacao) REFERENCES internacao(id),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  alimento(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    descricao VARCHAR(70) NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE classificacao(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL (2,1) UNSIGNED NOT NULL,
    id_nutricionista INT,
    id_medico INT,
    id_personal INT,
    FOREIGN KEY (id_nutricionista) REFERENCES nutricionista(id),
    FOREIGN KEY (id_medico) REFERENCES medico(id),
    FOREIGN KEY (id_personal) REFERENCES personal(id)

)DEFAULT CHARSET = utf8;

CREATE TABLE  dieta(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    descricao VARCHAR(70) NOT NULL,
    id_nutricionista INT,
    id_alimento INT,
    id_paciente INT NOT NULL,
    FOREIGN KEY(id_nutricionista) REFERENCES nutricionista(id),
    FOREIGN KEY(id_alimento) REFERENCES alimento(id),
    FOREIGN KEY(id_paciente) REFERENCES paciente(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  medicamento(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    descricao VARCHAR(70) NOT NULL,
    id_paciente INT NOT NULL,
    id_tratamento INT,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id),
    FOREIGN KEY (id_tratamento) REFERENCES tratamento(id)
)DEFAULT CHARSET = utf8;



CREATE TABLE  prescricao_medico(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medicamento INT NOT NULL,
    id_medico INT NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES medico(id),
    FOREIGN KEY (id_medicamento) REFERENCES medicamento(id),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id)
    ) DEFAULT CHARSET = utf8;

CREATE TABLE  prescricao_nutricionista(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_nutricionista INT NOT NULL,
    id_medicamento INT NOT NULL,
    FOREIGN KEY (id_medicamento) REFERENCES medicamento(id),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id),
    FOREIGN KEY (id_nutricionista) REFERENCES nutricionista(id)
    ) DEFAULT CHARSET = utf8;

CREATE TABLE  itemreceita(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_receita INT NOT NULL,
    id_medicamento INT NOT NULL,
    FOREIGN KEY(id_receita) REFERENCES receita(id),
    FOREIGN KEY(id_medicamento) REFERENCES medicamento(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  cuidar(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_responsavel INT NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY(id_responsavel) REFERENCES responsavel(id),
    FOREIGN KEY(id_paciente) REFERENCES paciente(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  peso(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    gramas INT UNSIGNED NOT NULL,
    id_alimento INT NOT NULL,
    FOREIGN KEY(id_alimento) REFERENCES alimento(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE semana(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    somente_hoje BOOLEAN DEFAULT 0,
    segunda BOOLEAN DEFAULT 0,
    terca BOOLEAN DEFAULT 0,
    quarta BOOLEAN DEFAULT 0,
    quinta BOOLEAN DEFAULT 0,
    sexta BOOLEAN DEFAULT 0,
    sabado BOOLEAN DEFAULT 0,
    domingo BOOLEAN DEFAULT 0,
    id_exercicio INT NOT NULL,
    id_medicamento INT NOT NULL,
    id_alimento INT NOT NULL,
    FOREIGN KEY(id_exercicio) REFERENCES exercicio(id),
    FOREIGN KEY(id_medicamento) REFERENCES medicamento(id),
    FOREIGN KEY(id_alimento) REFERENCES alimento(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  horario(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    horario DATETIME,
    id_alimento INT,
    id_medicamento INT,
    id_semana INT,
    FOREIGN KEY(id_alimento) REFERENCES alimento(id),
    FOREIGN KEY(id_medicamento) REFERENCES medicamento(id),
    FOREIGN KEY(id_semana) REFERENCES semana(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  tempo(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    minutos  INT UNSIGNED NOT NULL ,
    id_semana INT NOT NULL,
    FOREIGN KEY(id_semana) REFERENCES semana(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  dosagem(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    miligramas INT UNSIGNED NOT NULL,
    id_medicamento INT NOT NULL,
    FOREIGN KEY(id_medicamento) REFERENCES medicamento(id)
)DEFAULT CHARSET = utf8;



CREATE TABLE  contato(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    id_personal INT,
    id_paciente INT,
    id_responsavel INT,
    id_medico INT,
    id_nutricinista INT,
    FOREIGN KEY(id_personal) REFERENCES personal(id),
    FOREIGN KEY(id_paciente) REFERENCES paciente(id),
    FOREIGN KEY(id_responsavel) REFERENCES responsavel(id),
    FOREIGN KEY(id_medico) REFERENCES medico(id),
    FOREIGN KEY(id_nutricinista) REFERENCES nutricionista(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  email(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	email VARCHAR(250) NOT NULL,
    id_contato INT NOT NULL,
	FOREIGN KEY(id_contato) REFERENCES contato(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  telefone(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	numero VARCHAR(12) NOT NULL,
    id_contato INT NOT NULL,
	FOREIGN KEY(id_contato) REFERENCES contato(id)
)DEFAULT CHARSET = utf8;


CREATE TABLE  quantidade(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    quantidade INT UNSIGNED NOT NULL,
    id_exercicio INT,
    id_alimento INT,
    id_medicamento INT,
    FOREIGN KEY(id_exercicio) REFERENCES exercicio(id),
    FOREIGN KEY(id_alimento) REFERENCES alimento(id),
    FOREIGN KEY(id_medicamento) REFERENCES medicamento(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE  status(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    status ENUM( 'feito' , 'nao_feito' , 'a_fazer') DEFAULT 'a_fazer',
    id_medicamento INT,
    id_exercicio INT,
    id_consulta INT,
    id_exame INT,
    id_dieta INT,
    FOREIGN KEY(id_medicamento) REFERENCES medicamento(id),
    FOREIGN KEY(id_exercicio) REFERENCES exercicio(id),
    FOREIGN KEY(id_consulta) REFERENCES consulta(id),
    FOREIGN KEY(id_exame) REFERENCES exame(id),
    FOREIGN KEY(id_dieta) REFERENCES dieta(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE imc(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    peso DECIMAL(5,2) NOT NULL,
    altura DECIMAL(3,2) NOT NULL,
    data DATE NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id)
)DEFAULT CHARSET = utf8;

CREATE TABLE token(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    idusuario INT NOT NULL,
    token VARCHAR(1000) NOT NULL,
    refresh_token VARCHAR(1000) NOT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 1,
    expired_at DATETIME NOT NULL
)DEFAULT CHARSET = utf8;

CREATE TABLE  relacionamento_medico_paciente(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	amizade_med BOOL,
    amizade_paciente BOOL,
    id_paciente INT,
    id_medico INT,
    FOREIGN KEY(id_paciente) REFERENCES paciente(id),
    FOREIGN KEY(id_medico) REFERENCES medico(id)
)DEFAULT CHARSET = utf8;


CREATE TABLE  alteracao(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	create_table BOOL NOT NULL,
    update_table BOOL NOT NULL,
    delete_table BOOL NOT NULL,
	data_hora DATETIME NOT NULL,
    nome_tabela VARCHAR(100),
    id_alteracao INT
)DEFAULT CHARSET = utf8;
    
