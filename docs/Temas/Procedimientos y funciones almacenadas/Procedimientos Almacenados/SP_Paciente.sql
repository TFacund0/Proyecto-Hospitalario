-- 1. Procedimientos almacenados: Insertar, Modificar y Borrar paciente

-- 1.1 Procedimiento para insertar pacientes

CREATE PROCEDURE dbo.sp_InsertarPaciente
    @nombre           VARCHAR(20), -- Parametro del nombre del paciente
    @apellido         VARCHAR(20), -- Parametro del apellido del paciente
    @dni              INT,         -- Parametro del dni del paciente
    @direccion        VARCHAR(50), -- Parametro de la direccion del paciente
    @telefono         BIGINT,      -- Parametro del telefono del paciente
    @fecha_nacimiento DATE         -- Parametro de la fecha de nacimiento del paciente
AS
BEGIN -- Indica el comienzo del bloque de instrucciones
    SET NOCOUNT ON; -- Evita que SQL mande mensajes tipo "(1 row affected)"

    -- Inserta un nuevo registro en la tabla paciente
    INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento)
    VALUES (@nombre, @apellido, @dni, @direccion, @telefono, @fecha_nacimiento);

    -- Devuelve el ID generado, en caso de que sea necesario su uso
    SELECT SCOPE_IDENTITY() AS id_paciente_nuevo;
END; -- Indica el fin del bloque de instrucciones del procedimiento almacenado

-- 1.2. Procedimiento para modificar pacientes

CREATE PROCEDURE dbo.sp_ActualizarPaciente
    @id_paciente      INT,         -- Parametro del id del paciente
    @nombre           VARCHAR(20), -- Parametro del nombre del paciente
    @apellido         VARCHAR(20), -- Parametro del apellido del paciente
    @dni              INT,         -- Parametro del dni del paciente
    @direccion        VARCHAR(50), -- Parametro de la direccion del paciente
    @telefono         BIGINT,      -- Parametro del telefono del paciente
    @fecha_nacimiento DATE         -- Parametro de la fecha de nacimiento del paciente
AS
BEGIN -- Indica comienzo del conjunto de instrucciones del procedimiento
    SET NOCOUNT ON; 

    -- Instrucción que permite la modificación de un registro de la tabla paciente, buscado por su ID
    UPDATE paciente
    SET nombre           = @nombre,
        apellido         = @apellido,
        dni              = @dni,
        direccion        = @direccion,
        telefono         = @telefono,
        fecha_nacimiento = @fecha_nacimiento
    WHERE id_paciente = @id_paciente;
END; -- Indica el fin del conjunto de instrucciones del procedimiento

-- 1.3. Procedimiento para borrar pacientes

CREATE PROCEDURE dbo.sp_EliminarPaciente
    @id_paciente INT
AS
BEGIN -- Indica el comienzo del prcedimiento
    SET NOCOUNT ON; 

    -- Si hay internaciones o intervenciones que referencien al paciente, este DELETE puede fallar por FK.
    DELETE FROM paciente
    WHERE id_paciente = @id_paciente;
END;

