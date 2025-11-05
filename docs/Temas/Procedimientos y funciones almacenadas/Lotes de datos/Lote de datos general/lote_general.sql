-- Estados de cama
INSERT INTO estado_cama(nombre) VALUES ('Libre'), ('Ocupada'), ('Mantenimiento');

-- Tipos de habitación
INSERT INTO tipo_habitacion(nombre) VALUES ('Individual'), ('Doble'), ('Terapia Intensiva');

-- Profesiones
INSERT INTO profesion(nombre) VALUES ('Médico Clínico'), ('Cirujano'), ('Enfermero/a');

-- Tipos de procedimiento
INSERT INTO tipo_procedimiento(nombre) VALUES ('Curación'), ('Cirugía menor'), ('Cirugía mayor');

-- Habilitaciones (qué profesión puede realizar qué tipo de procedimiento)
-- Ejemplo: 1: Clínico → Curación, Cirugía menor
INSERT INTO profesion_procedimiento(id_profesion, id_tipo_procedimiento) VALUES
(1,1),(1,2), -- clínico
(2,2),(2,3), -- cirujano
(3,1);       -- enfermero/a

-- Habitaciones + camas (habitaciones con 2 camas cada una)
INSERT INTO habitacion(numero, piso, tipo_habitacion) VALUES (101,1,1),(102,1,2),(201,2,3);

-- Para cada habitación crear camas #1 y #2 en estado 'Libre'
DECLARE @id_libre INT = (SELECT id_estado_cama FROM estado_cama WHERE nombre='Libre');

INSERT INTO cama(id_cama, id_habitacion, estado)
SELECT 1, id_habitacion, @id_libre FROM habitacion;
INSERT INTO cama(id_cama, id_habitacion, estado)
SELECT 2, id_habitacion, @id_libre FROM habitacion;

-- Profesionales (asignar una profesión existente)
INSERT INTO profesional(nombre, apellido, fecha_nacimiento, dni, id_profesion) VALUES
('Laura','Sosa','1985-04-01',30111222,1),
('Carlos','Rivas','1979-08-20',28123456,2),
('Marta','Gómez','1992-12-02',34555111,3);
