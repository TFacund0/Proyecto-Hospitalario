-----------------------------------------------------
-----------------------------------------------------
--          CREACION DE FUNCIONES ALMACENADAS
-----------------------------------------------------
-----------------------------------------------------

-----------------------------------------------------
--  FUNCION ALMACENADA: Calcular edad paciente
-----------------------------------------------------
CREATE FUNCTION fn_EdadPaciente(@id_paciente INT)
RETURNS INT
AS
BEGIN
  DECLARE @fecha DATE = (
                          SELECT fecha_nacimiento
                          FROM dbo.paciente
                          WHERE id_paciente = @id_paciente
                         );

  IF @fecha IS NULL RETURN NULL;

  RETURN DATEDIFF(YEAR, @fecha, GETDATE())
END;
GO

----------------------------------------
--  VERIFICACION DE FUNCIONAMIENTO
----------------------------------------

-- Mostrar pacientes con su edad
SELECT id_paciente, nombre, apellido, fn_EdadPaciente(id_paciente) AS edad
FROM paciente;

-- Filtrar mayores de 60
SELECT *
FROM paciente
WHERE fn_EdadPaciente(id_paciente) >= 60;



