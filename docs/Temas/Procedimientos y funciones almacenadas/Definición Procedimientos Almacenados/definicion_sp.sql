--------------------------------------------------------------
--           CREACION DE PROCEDIMIENTOS ALMACENADOS
--------------------------------------------------------------

--------------------------------------------------------------
-------------- Procedimiento - Insertar Paciente -------------
--------------------------------------------------------------

CREATE PROCEDURE sp_Paciente_Insert
  @nombre           VARCHAR(20),
  @apellido         VARCHAR(20),
  @dni              INT,
  @direccion        VARCHAR(50),
  @telefono         BIGINT,
  @fecha_nacimiento DATE,
  @id_paciente      INT OUTPUT
AS -- Indica comienzo de las instrucciones relacionadas al procedimiento 
BEGIN
  SET NOCOUNT ON; -- Evita que SQL Server muestre el mensaje “(1 row(s) affected)” por cada operación

  IF EXISTS (
        SELECT 1 
        FROM paciente 
        WHERE dni = @dni
    )
    THROW 50001, 'Ya existe un paciente con ese DNI.', 1;

  INSERT INTO paciente(nombre, apellido, dni, direccion, telefono, fecha_nacimiento)
  VALUES (@nombre, @apellido, @dni, @direccion, @telefono, @fecha_nacimiento);

  SET @id_paciente = SCOPE_IDENTITY(); -- Guarda en el parámetro de salida (@id_paciente) el último valor autogenerado (IDENTITY) que se insertó
END;
GO

--------------------------------------------------------------
-------------- Procedimiento - Actualizar Paciente -----------
--------------------------------------------------------------

CREATE PROCEDURE sp_Paciente_UpdateContacto
  @id_paciente INT,
  @nueva_direccion VARCHAR(50),
  @nuevo_telefono  BIGINT
AS
BEGIN
  SET NOCOUNT ON;

  IF NOT EXISTS (SELECT 1 FROM paciente WHERE id_paciente = @id_paciente)
    THROW 50002, 'Paciente inexistente.', 1;

  UPDATE paciente
    SET direccion = @nueva_direccion,
        telefono  = @nuevo_telefono
  WHERE id_paciente = @id_paciente;
END;
GO

--------------------------------------------------------------
-------------- Procedimiento - Actualizar Paciente -----------
--------------------------------------------------------------

CREATE PROCEDURE sp_Paciente_Delete
  @id_paciente INT
AS
BEGIN
  SET NOCOUNT ON;

  IF NOT EXISTS (SELECT 1 FROM dbo.paciente WHERE id_paciente = @id_paciente)
    THROW 50004, 'Paciente inexistente.', 1;

  IF EXISTS (SELECT 1 FROM dbo.internacion WHERE id_paciente = @id_paciente)
    THROW 50005, 'No se puede eliminar: el paciente tiene internaciones registradas.', 1;

  IF EXISTS (SELECT 1 FROM dbo.intervencion WHERE id_paciente = @id_paciente)
    THROW 50006, 'No se puede eliminar: el paciente tiene intervenciones registradas.', 1;

  DELETE FROM dbo.paciente WHERE id_paciente = @id_paciente;
END;
GO


