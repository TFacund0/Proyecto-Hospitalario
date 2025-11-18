-- --------------------------------------------------------------------------
-- Tema: Manejo y Optimización de Datos Semi-Estructurados (JSON)
-- Alumno: Fernando Arce
-- Script para integrar JSON en la BD "sistema_hospitalario"
--
-- IMPORTANTE: Este script debe ejecutarse DESPUÉS de:
-- 1. `Creacion de la base de datos.sql`
-- 2. `Lote de Datos.sql`
-- --------------------------------------------------------------------------

-- Usar la base de datos del grupo
USE sistema_hospitalarioBDD;

-- 1. ACTIVAR ESTADÍSTICAS
PRINT '--- HABILITANDO ESTADISTICAS (IO Y TIME) ---';
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

-- --------------------------------------------------------------------------
-- 2. ALTERAR LA ESTRUCTURA EXISTENTE (TAREA 1)
-- --------------------------------------------------------------------------
PRINT '--- 2. Agregando columna [datos_adicionales] a la tabla [paciente] ---';

-- Se añade la columna (si no existe)
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = N'datos_adicionales' AND Object_ID = Object_ID(N'paciente'))
BEGIN
    ALTER TABLE paciente
    ADD datos_adicionales NVARCHAR(MAX);
    PRINT 'Columna [datos_adicionales] agregada.';
END
GO

-- Se añade la restricción (si no existe)
IF NOT EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CHK_Paciente_DatosAdicionales_IsJSON')
BEGIN
    ALTER TABLE paciente
    ADD CONSTRAINT CHK_Paciente_DatosAdicionales_IsJSON
    CHECK (ISJSON(datos_adicionales) > 0);
    PRINT 'Restriccion CHK_Paciente_DatosAdicionales_IsJSON agregada.';
END
GO

-- --------------------------------------------------------------------------
-- 3. OPERACIONES CRUD (TAREA 2)
-- --------------------------------------------------------------------------
PRINT '--- 3. Demostracion de operaciones CRUD ---';

-- A. UPDATE (Actualizar datos del Lote de Datos)
PRINT '--- 3.1. UPDATE: Agregando JSON a pacientes existentes ---';
UPDATE paciente
SET datos_adicionales = '{"alergia": "polvo", "tipo_sangre": "A+", "contacto_emergencia": {"nombre": "Maria Perez", "telefono": "3794-111111"}}'
WHERE dni = 30123456; -- Juan Pérez

UPDATE paciente
SET datos_adicionales = '{"alergia": "penicilina", "tipo_sangre": "O-", "contacto_emergencia": {"nombre": "Carlos Gomez", "telefono": "3794-222222"}}'
WHERE dni = 30234567; -- Ana Gómez

UPDATE paciente
SET datos_adicionales = '{"alergia": "ninguna", "tipo_sangre": "B+"}'
WHERE dni = 30345678; -- Luis Ramírez

UPDATE paciente
SET datos_adicionales = '{"alergia": "penicilina", "tipo_sangre": "AB+"}'
WHERE dni = 30456789; -- Marta López
GO

SELECT id_paciente, nombre, apellido, datos_adicionales FROM paciente WHERE id_paciente <= 4;
GO

-- B. CREATE (Insertar un nuevo paciente con JSON)
PRINT '--- 3.2. INSERT: Agregando nuevo paciente con JSON ---';
INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento, datos_adicionales)
VALUES ('Fernando', 'Arce', 45644949, 'Calle Falsa 123', 3794999999, '2000-01-01',
        '{"alergia": "polen", "tipo_sangre": "A-"}');
GO

SELECT id_paciente, nombre, apellido, datos_adicionales FROM paciente WHERE dni = 45644949;
GO

-- C. DEMOSTRACIÓN DE CONSULTAS (TAREA 3)
PRINT '--- 3.3. SELECT: Consultando con JSON_VALUE y OPENJSON ---';

-- JSON_VALUE: Extraer un solo valor
PRINT 'Pacientes con tipo de sangre A-';
SELECT nombre, apellido, JSON_VALUE(datos_adicionales, '$.tipo_sangre') AS TipoSangre
FROM paciente
WHERE JSON_VALUE(datos_adicionales, '$.tipo_sangre') = 'A-';
GO

-- OPENJSON: Descomponer un objeto anidado
PRINT 'Contactos de emergencia de todos los pacientes';
SELECT p.nombre, p.apellido, j.nombre AS ContactoNombre, j.telefono AS ContactoTelefono
FROM paciente p
    CROSS APPLY OPENJSON(p.datos_adicionales, '$.contacto_emergencia')
        WITH (
            nombre VARCHAR(50) '$.nombre',
            telefono VARCHAR(20) '$.telefono'
        ) AS j;
GO

-- --------------------------------------------------------------------------
-- 4. PRUEBA DE CARGA MASIVA (Para la Comparación)
-- --------------------------------------------------------------------------
PRINT '--- 4. Insertando 10,000 filas de prueba... ---';
SET NOCOUNT ON;
DECLARE @i INT = 0;
WHILE @i < 10000
BEGIN
    DECLARE @dni_test INT = 50000000 + @i;
    DECLARE @alergia_test VARCHAR(20) = CASE WHEN @i % 10 = 0 THEN 'penicilina' ELSE 'ninguna' END;
    
    INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, fecha_nacimiento, datos_adicionales)
    VALUES ('Test', 'Paciente ' + CAST(@i AS VARCHAR), @dni_test, 'N/A', 123456, '2000-01-01',
            '{"alergia": "' + @alergia_test + '", "tipo_sangre": "O+"}');
    SET @i = @i + 1;
END;
SET NOCOUNT OFF;
PRINT '--- Carga masiva completada ---';
GO

-- --------------------------------------------------------------------------
-- 5. COMPARACIÓN DE EFICIENCIA (TAREA 4) - ¡LA BUENA!
-- --------------------------------------------------------------------------
PRINT '--- 5. INICIO DE PRUEBA DE RENDIMIENTO ---';
GO

-- 5.1. CONSULTA SIN OPTIMIZAR (SIN ÍNDICE)
PRINT '--- 5.1. EJECUTANDO CONSULTA SIN OPTIMIZACION (Table Scan) ---';
PRINT 'Buscando pacientes con alergia a la penicilina...';
SELECT id_paciente, nombre, apellido, dni
FROM paciente
WHERE JSON_VALUE(datos_adicionales, '$.alergia') = 'penicilina';
GO
-- ACÁ VAS A VER LAS ~188 LECTURAS LÓGICAS (EL "TABLE SCAN")


-- 5.2. CREANDO LA OPTIMIZACIÓN (EL ÍNDICE DE COBERTURA)
PRINT '--- 5.2. CREANDO OPTIMIZACION (Columna Computada + INDICE CON INCLUDE) ---';
IF COL_LENGTH('paciente', 'alergia_computada') IS NULL
BEGIN
    ALTER TABLE paciente
    ADD alergia_computada AS JSON_VALUE(datos_adicionales, '$.alergia');
    PRINT 'Columna [alergia_computada] agregada.';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IDX_paciente_alergia_json_COV')
BEGIN
    --
    -- ¡¡¡AQUÍ ESTÁ LA MAGIA!!! (LA SOLUCIÓN FINAL)
    -- Creamos el índice en 'alergia_computada'
    -- E "INCLUIMOS" el resto de columnas que necesita el SELECT.
    --
    CREATE INDEX IDX_paciente_alergia_json_COV
    ON paciente(alergia_computada)
    INCLUDE (nombre, apellido, dni); -- <-- ESTO ES UN "COVERING INDEX"
    
    PRINT 'Indice de Cobertura [IDX_paciente_alergia_json_COV] creado.';
END
GO


-- 5.3. CONSULTA OPTIMIZADA (CON ÍNDICE DE COBERTURA)
PRINT '--- 5.3. EJECUTANDO LA CONSULTA CON OPTIMIZACION (Index Seek) ---';
PRINT 'Buscando pacientes con alergia a la penicilina (esta vez con el indice BUENO)...';
SELECT id_paciente, nombre, apellido, dni
FROM paciente
-- Usamos la columna computada para que SQL Server
-- elija el índice que creamos para esa columna.
WHERE alergia_computada = 'penicilina';
GO

-- --------------------------------------------------------------------------
-- 6. LIMPIEZA (Para devolver la BD a su estado original)
-- --------------------------------------------------------------------------
PRINT '--- 6. LIMPIEZA DEL ENTORNO DE PRUEBAS ---';

-- 1. Borrar el índice (el BUENO, con _COV)
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IDX_paciente_alergia_json_COV')
BEGIN
    DROP INDEX IDX_paciente_alergia_json_COV ON paciente;
    PRINT 'Indice [IDX_paciente_alergia_json_COV] eliminado.';
END
GO

-- 2. Borrar la columna computada
IF COL_LENGTH('paciente', 'alergia_computada') IS NOT NULL
BEGIN
    ALTER TABLE paciente
    DROP COLUMN alergia_computada;
    PRINT 'Columna [alergia_computada] eliminada.';
END
GO

-- 3. Borrar los datos de prueba masivos
PRINT 'Borrando datos de prueba masivos...';
DELETE FROM paciente WHERE nombre = 'Test';
GO

-- 4. Borrar la columna JSON y su restricción (o dejarla, según decida el grupo)
IF EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CHK_Paciente_DatosAdicionales_IsJSON')
BEGIN
    ALTER TABLE paciente
    DROP CONSTRAINT CHK_Paciente_DatosAdicionales_IsJSON;
    PRINT 'Restriccion [CHK_Paciente_DatosAdicionales_IsJSON] eliminada.';
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = N'datos_adicionales' AND Object_ID = Object_ID(N'paciente'))
BEGIN
    ALTER TABLE paciente
    DROP COLUMN datos_adicionales;
    PRINT 'Columna [datos_adicionales] eliminada.';
END
GO

-- 5. Borrar el paciente de prueba 'Fernando Arce'
PRINT 'Borrando paciente de prueba...';
DELETE FROM paciente WHERE dni = 45644949;
GO

PRINT '--- LIMPIEZA FINALIZADA ---';
PRINT '--- DESHABILITANDO ESTADISTICAS ---';
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO