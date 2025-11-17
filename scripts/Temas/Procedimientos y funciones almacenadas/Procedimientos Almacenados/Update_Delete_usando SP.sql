-- 1. UPDATE y DELETE usando los procedimientos

-- Primero encontrar el id del paciente
SELECT id_paciente, nombre, apellido, dni, telefono
FROM paciente;

-- 1.1. UPDATE usando el procedimiento

EXEC dbo.sp_ActualizarPaciente
    @id_paciente      = 1,
    @nombre           = 'Diego',
    @apellido         = 'Suárez',
    @dni              = 30890123,              
    @direccion        = 'Belgrano 1999',          -- nueva dirección
    @telefono         = 3777090909,             -- nuevo teléfono
    @fecha_nacimiento = '1995-01-12';

-- 1.2. DELETE usando el procedimiento

EXEC dbo.sp_EliminarPaciente
    @id_paciente = 8;

