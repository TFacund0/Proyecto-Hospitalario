USE sistema_hospitalario_2;
GO

/* 1) PACIENTE */
INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento)
VALUES 
('Juan',   'Pérez',    30123456, 'Calle 1 123',       3794000001, '1985-05-10'),
('Ana',    'Gómez',    30234567, 'Av. Libertad 456',  3794000002, '1990-08-20'),
('Luis',   'Ramírez',  30345678, 'San Martín 789',    3794000003, '1978-12-01'),
('Marta',  'López',    30456789, 'Belgrano 321',      3794000004, '2000-03-15');
-- id_paciente = 1..4
GO

/* 2) TIPO_HABITACION */
INSERT INTO tipo_habitacion (nombre)
VALUES 
('Individual'),
('Doble'),
('Terapia Intensiva');
-- id_tipo_habitacion = 1..3
GO

/* 3) HABITACION */
INSERT INTO habitacion (numero, piso, tipo_habitacion)
VALUES
(101, 1, 1),   -- hab 1, Individual
(102, 1, 2),   -- hab 2, Doble
(201, 2, 3);   -- hab 3, Terapia Intensiva
-- id_habitacion = 1..3
GO

/* 4) ESTADO_CAMA */
INSERT INTO estado_cama (nombre)
VALUES
('Disponible'),
('Ocupada'),
('Mantenimiento');
-- id_estado_cama = 1..3
GO

/* 5) CAMA (PK: id_habitacion, id_cama) */
INSERT INTO cama (id_cama, id_habitacion, estado)
VALUES
-- Habitación 1
(1, 1, 2),  -- Ocupada
(2, 1, 1),  -- Disponible
(3, 1, 1),  -- Disponible
-- Habitación 2
(1, 2, 2),  -- Ocupada
(2, 2, 1),  -- Disponible
-- Habitación 3
(1, 3, 1),  -- Disponible
(2, 3, 3);  -- Mantenimiento
GO

/* 6) TIPO_PROCEDIMIENTO */
INSERT INTO tipo_procedimiento (nombre)
VALUES
('Consulta'),
('Cirugía menor'),
('Estudio diagnóstico');
-- id_tipo_procedimiento = 1..3
GO

/* 7) PROFESION */
INSERT INTO profesion (nombre)
VALUES
('Médico Clínico'),
('Cirujano'),
('Enfermero');
-- id_profesion = 1..3
GO

/* 8) PROFESIONAL (PK: id_profesional, id_profesion) */
INSERT INTO profesional (nombre, apellido, fecha_nacimiento, dni, id_profesion)
VALUES
('Carlos',  'Gómez',  '1980-05-10', 35000001, 1), -- Médico Clínico
('Ana',     'López',  '1985-03-20', 35000002, 2), -- Cirujano
('Luis',    'Pérez',  '1990-07-15', 35000003, 3); -- Enfermero
-- id_profesional = 1..3
GO

/* 9) PROFESION_PROCEDIMIENTO (qué profesión puede hacer qué tipo) */
INSERT INTO profesion_procedimiento (id_profesion, id_tipo_procedimiento)
VALUES
(1, 1),  -- Médico Clínico → Consulta
(1, 3),  -- Médico Clínico → Estudio diagnóstico
(2, 2),  -- Cirujano → Cirugía menor
(2, 3),  -- Cirujano → Estudio diagnóstico
(3, 3);  -- Enfermero → Estudio diagnóstico
GO

/* 10) INTERNACION 
   (usa paciente + cama (id_habitacion, id_cama), fechas con fecha_fin > fecha_inicio)
*/
INSERT INTO internacion (fecha_inicio, fecha_fin, id_paciente, id_habitacion, id_cama)
VALUES
('2025-01-01', '2025-01-10', 1, 1, 1),  -- Juan en Hab 1 Cama 1
('2025-02-05', '2025-02-12', 2, 2, 1);  -- Ana en Hab 2 Cama 1
-- id_internacion = 1..2
GO

/* 11) INTERVENCION (evento en el que se aplican procedimientos) */
INSERT INTO intervencion (fecha, id_paciente)
VALUES
('2025-01-05', 1),  -- Intervención para Juan
('2025-02-10', 2),  -- Intervención para Ana
('2025-03-15', 3);  -- Intervención para Luis
-- id_intervencion = 1..3
GO

/* 12) PROCEDIMIENTO 
   PK: (id_proc_real, id_intervencion)
   FK1: (id_profesion, id_tipo_procedimiento) → profesion_procedimiento
   FK2: (id_profesional, id_profesion) → profesional
   FK3: id_intervencion → intervencion
*/
INSERT INTO procedimiento (id_proc_real, id_profesion, id_tipo_procedimiento, id_profesional, id_intervencion)
VALUES
(1, 1, 1, 1, 1),  -- Intervención 1: Médico Clínico (profesional 1) hace Consulta (tipo 1)
(1, 2, 2, 2, 2),  -- Intervención 2: Cirujano (profesional 2) hace Cirugía menor (tipo 2)
(1, 3, 3, 3, 3);  -- Intervención 3: Enfermero (profesional 3) hace Estudio diagnóstico (tipo 3)
GO


SELECT * FROM paciente;
SELECT * FROM tipo_habitacion;
SELECT * FROM habitacion;
SELECT * FROM estado_cama;
SELECT * FROM cama;
SELECT * FROM tipo_procedimiento;
SELECT * FROM profesion;
SELECT * FROM profesional;
SELECT * FROM profesion_procedimiento;
SELECT * FROM internacion;
SELECT * FROM intervencion;
SELECT * FROM procedimiento;
