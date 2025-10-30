CREATE DATABASE sistema_hospitalario;

USE sistema_hospitalario;

CREATE TABLE paciente
(	
  id_paciente INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  dni INT NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono BIGINT NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  CONSTRAINT PK_cliente PRIMARY KEY (id_paciente),
  CONSTRAINT UQ_paciente_dni UNIQUE (dni)
);

CREATE TABLE tipo_habitacion
(
  id_tipo_habitacion INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  CONSTRAINT PK_tipo_hapitacion PRIMARY KEY (id_tipo_habitacion)
);

CREATE TABLE habitacion
(
  id_habitacion INT IDENTITY(1,1) NOT NULL,
  numero INT NOT NULL,
  piso INT NOT NULL,
  tipo_habitacion INT NOT NULL,
  CONSTRAINT PK_habitacion PRIMARY KEY (id_habitacion),
  CONSTRAINT FK_habitacion_tipo FOREIGN KEY (tipo_habitacion) REFERENCES tipo_habitacion(id_tipo_habitacion)
);

CREATE TABLE estado_cama
(
  id_estado_cama INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  CONSTRAINT PK_estado_cama PRIMARY KEY (id_estado_cama)
);

CREATE TABLE cama
(
  id_cama INT NOT NULL,
  id_habitacion INT NOT NULL,
  estado INT NOT NULL,
  CONSTRAINT PK_cama PRIMARY KEY (id_habitacion, id_cama),
  CONSTRAINT FK_cama_habitacion FOREIGN KEY (id_habitacion) REFERENCES habitacion(id_habitacion),
  CONSTRAINT FK_cama_estado FOREIGN KEY (estado) REFERENCES estado_cama(id_estado_cama)
);

CREATE TABLE tipo_procedimiento
(
  id_tipo_procedimiento INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(40) NOT NULL,
  CONSTRAINT PK_tipo_procedimiento PRIMARY KEY (id_tipo_procedimiento)
);

CREATE TABLE internacion
(
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  id_internacion INT IDENTITY(1,1) NOT NULL,
  id_paciente INT NOT NULL,
  id_habitacion INT NOT NULL,
  id_cama INT NOT NULL,
  CONSTRAINT PK_internacion PRIMARY KEY (id_internacion),
  CONSTRAINT FK_internacion_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
  CONSTRAINT FK_habitacion FOREIGN KEY (id_habitacion, id_cama) REFERENCES cama(id_habitacion, id_cama),
  CONSTRAINT CK_internacion_fecha CHECK (fecha_fin > fecha_inicio)
);

CREATE TABLE profesion
(
  id_profesion INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  CONSTRAINT PK_profesion PRIMARY KEY (id_profesion)
);

CREATE TABLE profesional
(
  id_profesional INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  dni INT NOT NULL,
  id_profesion INT NOT NULL,
  CONSTRAINT PK_profesional PRIMARY KEY (id_profesional, id_profesion),
  CONSTRAINT FK_profesional_profesion FOREIGN KEY (id_profesion) REFERENCES profesion(id_profesion),
  CONSTRAINT UQ_profesional_dni UNIQUE (dni)
);

CREATE TABLE profesion_procedimiento
(
  id_profesion INT NOT NULL,
  id_tipo_procedimiento INT NOT NULL,
  CONSTRAINT PK_profesion_procedimiento PRIMARY KEY (id_profesion, id_tipo_procedimiento),
  CONSTRAINT FK_profesion_procedimiento_profesion FOREIGN KEY (id_profesion) REFERENCES profesion(id_profesion),
  CONSTRAINT FK_profesion_procedimiento_procedimiento FOREIGN KEY (id_tipo_procedimiento) REFERENCES tipo_procedimiento(id_tipo_procedimiento)
);

CREATE TABLE intervencion
(
  id_intervencion INT IDENTITY(1,1) NOT NULL,
  fecha DATE NOT NULL,
  id_paciente INT NOT NULL,
  CONSTRAINT PK_intervencion PRIMARY KEY (id_intervencion),
  CONSTRAINT FK_intervencion_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

CREATE TABLE procedimiento
(
  id_proc_real INT NOT NULL,
  id_profesion INT NOT NULL,
  id_tipo_procedimiento INT NOT NULL,
  id_profesional INT NOT NULL,
  id_intervencion INT NOT NULL,
  CONSTRAINT PK_procedimiento PRIMARY KEY (id_proc_real, id_intervencion),
  CONSTRAINT FK_procedimiento_tipo_procedimiento FOREIGN KEY (id_profesion, id_tipo_procedimiento) REFERENCES profesion_procedimiento(id_profesion,id_tipo_procedimiento ),
  CONSTRAINT FK_procedimiento_profesional FOREIGN KEY (id_profesional, id_profesion) REFERENCES profesional(id_profesional,id_profesion),
  CONSTRAINT FK_procedimiento_intervencion FOREIGN KEY (id_intervencion) REFERENCES intervencion(id_intervencion)
);

