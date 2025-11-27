-- Indice Agrupado
CREATE CLUSTERED INDEX IX_paciente_dni_clustered
ON paciente (dni);

-- Indice No Agrupado
CREATE UNIQUE NONCLUSTERED INDEX IX_paciente_dni
ON paciente (dni);

-- Indice no agrupado compuesto
CREATE NONCLUSTERED INDEX IX_paciente_apellido_nombre
ON paciente (apellido, nombre)



 
/*
=====================================================================
 TEMA: OPTIMIZACIÓN DE CONSULTAS A TRAÉS DE ÍNDICES
 OBJETIVO: Comparar el rendimiento de E/S (IO) y Tiempo (TIME)
           de una consulta NO optimizada (Full Table Scan)
           vs. una consulta SÍ optimizada (Index Seek).
=====================================================================
*/

 
-- Activamos las estadísticas para la comparación
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

PRINT '--- COMPARACION: FULL TABLE SCAN VS. INDEX SEEK ---';
PRINT '---';
 -- -----------------------------------------------------------------
-- 1) Consulta SIN OPTIMIZACION (Forzando un Full Table Scan)
-- -----------------------------------------------------------------
PRINT '--- 1) Ejecutando SELECT... (Full Table Scan) ---';
 -- Usamos el "query hint" WITH (INDEX(0)) para forzar a SQL Server
-- a ignorar CUALQUIER índice y escanear la tabla completa.
-- Este es el escenario "sin índice".
SELECT *
FROM paciente WITH (INDEX(0))
-- DNI de Tobias Acevedo 
GO 

-- -----------------------------------------------------------------
-- 2) Consulta CON OPTIMIZACION (Usando el Index Seek)
-- -----------------------------------------------------------------
PRINT '--- 2) Ejecutando SELECT... (Index Seek) ---';
 -- Ejecutamos la MISMA consulta, pero esta vez dejamos que el
-- Optimizador de Consultas use el índice UNIQUE que
-- ya existe en la columna 'dni'.
SELECT *
FROM paciente
WHERE dni = 45527225;
 GO

-- Desactivamos las estadísticas
PRINT '--- Comparacion Finalizada ---';
SET STATISTICS IO OFF;
 SET STATISTICS TIME OFF;
 GO
