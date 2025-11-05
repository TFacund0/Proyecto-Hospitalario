------------------------------------------------------------
------------------------------------------------------------
-- LOTE DE INSERCIONES USANDO PROCEDIMIENTOS ALMACENADOS
------------------------------------------------------------
------------------------------------------------------------

USE sistema_hospitalario_2;
GO

-------------------------
-- 1) PACIENTES NUEVOS --
-------------------------
DECLARE @p1 INT, @p2 INT, @p3 INT; -- capturan @id_paciente OUTPUT

EXEC sp_Paciente_Insert
  @nombre = 'Bruno', @apellido='Meza', @dni=47111222,
  @direccion = 'Lavalle 450', @telefono=3794111111, @fecha_nacimiento='1998-02-15',
  @id_paciente = @id_bruno OUTPUT;

EXEC sp_Paciente_Insert
  @nombre = 'Lucía', @apellido='Paredes', @dni=47222333,
  @direccion = 'Mendoza 900', @telefono=3794222222, @fecha_nacimiento='2001-07-05',
  @id_paciente = @id_lucia OUTPUT;

EXEC sp_Paciente_Insert
  @nombre='Nicolás', @apellido='Benítez', @dni=47333444,
  @direccion='Catamarca 120', @telefono=3794333333, @fecha_nacimiento='1993-11-30',
  @id_paciente = @id_nicolas OUTPUT;

SELECT @id_bruno AS Paciente1, @id_lucia AS Paciente2, @id_nicolas AS Paciente3;

------------------------------------------------------------
--						Verificaciones
------------------------------------------------------------
-- Pacientes insertados
SELECT TOP 10 * FROM paciente ORDER BY id_paciente DESC;


------------------------------------------------------------
------------------------------------------------------------
-- LOTE DE ACTUALIZACIONES USANDO PROCEDIMIENTOS ALMACENADOS
------------------------------------------------------------
------------------------------------------------------------

------------------------------------------------------------
-- UPDATE 1: Actualizar datos de BRUNO (cambio de dirección y teléfono)
-- (Usa sp_Paciente_Update: valida existencia y DNI único)
------------------------------------------------------------
EXEC sp_Paciente_Update
  @id_paciente      = @id_bruno,
  @nombre           = 'Bruno', 
  @apellido         = 'Meza',
  @dni              = 47111222,           -- Mantiene su DNI
  @direccion        = 'Lavalle 470',      -- Nueva dirección
  @telefono         = 3794999000,         -- Nuevo teléfono
  @fecha_nacimiento = '1998-02-15';

-- Verificación
SELECT * FROM paciente WHERE id_paciente = @id_bruno;

------------------------------------------------------------
-- UPDATE #2: Actualizar datos de LUCÍA (incluye cambio de DNI)
-- (sp_Paciente_Update valida que el nuevo DNI no esté usado por otro)
------------------------------------------------------------
EXEC sp_Paciente_Update
  @id_paciente      = @id_lucia,
  @nombre           = 'Lucía',
  @apellido         = 'Paredes',
  @dni              = 47222334,           -- NUEVO DNI (debe ser único)
  @direccion        = 'Mendoza 920',
  @telefono         = 3794222299,
  @fecha_nacimiento = '2001-07-05';

-- Verificación
SELECT * FROM paciente WHERE id_paciente = @id_lucia;

------------------------------------------------------------
-- DELETE: Eliminar a NICOLÁS
-- (sp_Paciente_Delete bloquea si tuviera internaciones/intervenciones;
--  si solo cargaste pacientes, se elimina sin problemas)
------------------------------------------------------------
EXEC sp_Paciente_Delete @id_paciente = @id_nicolas;

-- Verificación: debería no existir
SELECT * FROM paciente WHERE id_paciente = @id_nicolas;
