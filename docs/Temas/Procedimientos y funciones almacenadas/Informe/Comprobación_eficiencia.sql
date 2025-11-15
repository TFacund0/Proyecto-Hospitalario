-- 1. Comparación de eficiencias entre "directo vs procedimientos/funciones"

SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

-- COMPARACION DIRECTO VS PROCEDIMIENTOS

-- 1) INSERT directo
INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento)
VALUES ('Test5', 'Directo', 40000009, 'Calle X', 3794111111, '1990-05-05');
GO

-- 2) INSERT vía procedimiento
EXEC dbo.sp_InsertarPaciente
    @nombre = 'Test5',
    @apellido = 'Procedimiento',
    @dni = 40000010,
    @direccion = 'Calle Y',
    @telefono = 3794222222,
    @fecha_nacimiento = '1991-07-07';
GO

SELECT *
FROM paciente

-- COMPARACION DIRECTO VS FUNCIONES

-- 1) SELECT DIRECTO
SELECT nombre,
       apellido,
       fecha_nacimiento,
       YEAR(GETDATE()) - YEAR(fecha_nacimiento)
          - CASE WHEN DATEADD(YEAR, YEAR(GETDATE()) - YEAR(fecha_nacimiento), fecha_nacimiento) > GETDATE()
                 THEN 1 ELSE 0 END AS edad
FROM paciente;

-- 2) SELECT CON FUNCION
SELECT nombre,
       apellido,
       fecha_nacimiento,
       dbo.fn_CalcularEdad(fecha_nacimiento) AS edad
FROM paciente;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
