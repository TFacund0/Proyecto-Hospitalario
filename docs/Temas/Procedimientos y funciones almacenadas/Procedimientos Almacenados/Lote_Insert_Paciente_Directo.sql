USE sistema_hospitalario_2;
GO

-- Lote de INSERTs directos sobre la tabla paciente

INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento)
VALUES ('Juan',  'Pérez',   30123456, 'Calle 1 123',        3794000001, '1985-05-10');

INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento)
VALUES ('Ana',   'Gómez',   30234567, 'Av. Libertad 456',   3794000002, '1990-08-20');

INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento)
VALUES ('Luis',  'Ramírez', 30345678, 'San Martín 789',     3794000003, '1978-12-01');

INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento)
VALUES ('Marta', 'López',   30456789, 'Belgrano 321',       3794000004, '2000-03-15');

INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento)
VALUES ('Carla', 'Fernández',30567890, 'Lavalle 555',       3794000005, '1982-09-30');

INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento)
VALUES ('Pedro', 'Sosa',    30678901, 'Rivadavia 999',      3794000006, '1995-01-12');

INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento)
VALUES ('Sofía', 'Martínez',30789012, 'Ruta 12 Km 10',      3794000007, '1972-07-07');
