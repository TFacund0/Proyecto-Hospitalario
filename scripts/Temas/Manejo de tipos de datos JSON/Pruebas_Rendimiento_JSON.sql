
-- --------------------------------------------------------------------------
-- Tema: Manejo y Optimización de Datos Semi-Estructurados (JSON)
-- Alumno: Fernando Arce
-- Script para demostrar operaciones CRUD y comparación de rendimiento
-- --------------------------------------------------------------------------
USE tempdb; -- Usamos tempdb para no ensuciar la BD principal. O cambia esto a tu BD de pruebas.
GO

-- 1. ACTIVAR ESTADÍSTICAS
-- Habilitamos esto para ver el costo (Lecturas Lógicas y Tiempo) en la pestaña "Mensajes"
PRINT '--- HABILITANDO ESTADISTICAS (IO Y TIME) ---';
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

-- --------------------------------------------------------------------------
-- 2. CREACIÓN DE LA TABLA DE PRUEBA
-- --------------------------------------------------------------------------
PRINT '--- CREANDO TABLA DE PRUEBAS "Pacientes_Test_JSON" ---';
IF OBJECT_ID('Pacientes_Test_JSON') IS NOT NULL
    DROP TABLE Pacientes_Test_JSON;
GO

CREATE TABLE Pacientes_Test_JSON (
    id INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(100),
    datos_adicionales NVARCHAR(MAX)
    -- Agregamos la restricción para asegurar que SÓLO se guarde JSON válido
    CONSTRAINT CHK_Pacientes_Test_JSON_IsJSON
    CHECK (ISJSON(datos_adicionales) > 0)
);
GO

-- --------------------------------------------------------------------------
-- 3. OPERACIONES CRUD (TAREA 2)
-- --------------------------------------------------------------------------
PRINT '--- DEMOSTRACION DE OPERACIONES CRUD ---';

-- A. CREATE (INSERT)
PRINT '--- A. INSERTANDO DATOS ---';
INSERT INTO Pacientes_Test_JSON (nombre, datos_adicionales)
VALUES
('Juan Zacarias',    '{"alergia": "penicilina", "tipo_sangre": "O+", "contacto_emergencia": {"nombre": "Ana", "telefono": "3794-111222"}}'),
('Tobias Acevedo',   '{"alergia": "polvo", "tipo_sangre": "A-"}'),
('Luciano Erck',     '{"alergia": "ninguna", "tipo_sangre": "B+"}'),
('Fernando Arce','{"alergia": "penicilina", "tipo_sangre": "AB+"}');
GO

SELECT * FROM Pacientes_Test_JSON;
GO

-- B. UPDATE (JSON_MODIFY)
PRINT '--- B. ACTUALIZANDO DATOS (JSON_MODIFY) ---';
-- Actualizar la alergia de Tobias
UPDATE Pacientes_Test_JSON
SET datos_adicionales = JSON_MODIFY(datos_adicionales, '$.alergia', 'polen')
WHERE nombre = 'Tobias Acevedo';

-- Agregar un nuevo dato (email) a Luciano
UPDATE Pacientes_Test_JSON
SET datos_adicionales = JSON_MODIFY(datos_adicionales, '$.email', 'luciano@correo.com')
WHERE nombre = 'Luciano Erck';
GO

SELECT * FROM Pacientes_Test_JSON;
GO

-- C. DELETE (JSON_MODIFY con NULL)
PRINT '--- C. BORRANDO DATOS (JSON_MODIFY con NULL) ---';
-- Borrar la clave "tipo_sangre" de Juan
UPDATE Pacientes_Test_JSON
SET datos_adicionales = JSON_MODIFY(datos_adicionales, '$.tipo_sangre', NULL)
WHERE nombre = 'Juan Zacarias';
GO

SELECT * FROM Pacientes_Test_JSON;
GO

-- --------------------------------------------------------------------------
-- 4. PRUEBA DE CARGA MASIVA (OPCIONAL PERO RECOMENDADO)
-- --------------------------------------------------------------------------
PRINT '--- INSERTANDO DATOS MASIVOS (1000 filas) ---';

SET NOCOUNT ON;
DECLARE @i INT = 0;
WHILE @i < 1000
BEGIN
    INSERT INTO Pacientes_Test_JSON (nombre, datos_adicionales)
    VALUES
    ('Paciente ' + CAST(@i AS VARCHAR), '{"alergia": "ninguna", "tipo_sangre": "O+"}'),
    ('Paciente ' + CAST(@i+1 AS VARCHAR), '{"alergia": "penicilina", "tipo_sangre": "A+"}');
    SET @i = @i + 2;
END;
SET NOCOUNT OFF;
GO


-- --------------------------------------------------------------------------
-- 5. COMPARACIÓN DE EFICIENCIA (TAREA 3 Y 4)
-- --------------------------------------------------------------------------

-- PRIMERO: HABILITA "Incluir plan de ejecución real" en SSMS (Ctrl+M)
-- Luego ejecuta todo el script

PRINT '--- INICIO DE PRUEBA DE RENDIMIENTO ---';
GO

-- 5.1. CONSULTA SIN OPTIMIZAR (SIN ÍNDICE)
PRINT '--- 5.1. EJECUTANDO CONSULTA SIN OPTIMIZACION (Table Scan) ---';
SELECT id, nombre, JSON_VALUE(datos_adicionales, '$.tipo_sangre') AS TipoSangre
FROM Pacientes_Test_JSON
WHERE JSON_VALUE(datos_adicionales, '$.alergia') = 'penicilina';
GO
-- Revisa la pestaña "Mensajes": Verás "lecturas lógicas" altas y un "Table Scan" en el plan de ejecución.
-- (Con 1000 filas, la diferencia ya es notable)


-- 5.2. CREANDO LA OPTIMIZACIÓN (ÍNDICE)
PRINT '--- 5.2. CREANDO OPTIMIZACION (Columna Computada + Indice) ---';
IF COL_LENGTH('Pacientes_Test_JSON', 'alergia_computada') IS NULL
BEGIN
    ALTER TABLE Pacientes_Test_JSON
    ADD alergia_computada AS JSON_VALUE(datos_adicionales, '$.alergia') PERSISTED;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IDX_paciente_alergia_json')
BEGIN
    CREATE INDEX IDX_paciente_alergia_json
    ON Pacientes_Test_JSON(alergia_computada);
END
GO
PRINT '--- Indice creado ---';


-- 5.3. CONSULTA OPTIMIZADA (CON ÍNDICE)
PRINT '--- 5.3. EJECUTANDO LA *MISMA* CONSULTA CON OPTIMIZACION (Index Seek) ---';
SELECT id, nombre, JSON_VALUE(datos_adicionales, '$.tipo_sangre') AS TipoSangre
FROM Pacientes_Test_JSON
WHERE JSON_VALUE(datos_adicionales, '$.alergia') = 'penicilina';
GO
-- Revisa la pestaña "Mensajes" OTRA VEZ:
-- Verás que las "lecturas lógicas" son MÍNIMAS.
-- El plan de ejecución ahora muestra un "Index Seek".
-- ¡Esta es la prueba de tu informe!


-- --------------------------------------------------------------------------
-- 6. LIMPIEZA
-- --------------------------------------------------------------------------
PRINT '--- DESHABILITANDO ESTADISTICAS ---';
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO

PRINT '--- LIMPIANDO TABLA DE PRUEBA ---';
DROP TABLE Pacientes_Test_JSON;
GO

