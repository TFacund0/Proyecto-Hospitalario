BEGIN TRY
    -- Declaración de variable funcional para capturar la ID generada
    DECLARE @id_intervencion_reciente INT;
    
    -- 1. Iniciamos la transacción para asegurar atomicidad
    BEGIN TRANSACTION;

    -- PASO 1: INSERT 1 - Registramos el Ingreso en INTERNACION
    INSERT INTO internacion (fecha_inicio, fecha_fin, id_paciente, id_habitacion, id_cama)
    VALUES (GETDATE(), NULL, 1, 1, 2);

    -- PASO 2: INSERT 2 - Registramos la INTERVENCION inicial
    INSERT INTO intervencion (fecha, id_paciente)
    VALUES (GETDATE(), 1);
    
    -- Capturar el ID de Intervención recién creado 
    SET @id_intervencion_reciente = SCOPE_IDENTITY();

    -- PASO 3: INSERT 3 - Insertar un PROCEDIMIENTO usando el ID capturado
    
    -- id_proc_real=1 (primer proc. en la intervención), id_intervencion=@id_intervencion_reciente
    INSERT INTO procedimiento (id_proc_real, id_profesion, id_tipo_procedimiento, id_profesional, id_intervencion)
    VALUES (1, 1, 1, 1, @id_intervencion_reciente); 
    
    -- PASO 4: UPDATE - Actualizar el estado de la CAMA a Ocupada (ID 2)
    UPDATE cama
    SET estado = 2
    WHERE id_habitacion = 1 AND id_cama = 2;

    -- 5. Confirmar la transacción
    COMMIT TRANSACTION;
    PRINT 'TRANSACCIÓN COMPLETA CONFIRMADA. Los datos han sido actualizados con éxito.';

END TRY
BEGIN CATCH
    -- Bloque de CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    PRINT 'ERROR: La transacción falló y fue revertida. Detalle: ' + ERROR_MESSAGE();--No deberia ejecutarse si todo sale bien
END CATCH


BEGIN TRY
    DECLARE @id_intervencion_reciente INT;
    -- 1. Iniciamos la transacción para asegurar atomicidad
    BEGIN TRANSACTION;

    -- PASO 1: INSERT 1 - Registramos el Ingreso en INTERNACION
    INSERT INTO internacion (fecha_inicio, fecha_fin, id_paciente, id_habitacion, id_cama)
    VALUES (GETDATE(), NULL, 1, 1, 2);
    PRINT '1. INSERT en Internacion EXITOSO (temporalmente).';

    -- PASO 2: INSERT 2 - Registramos la INTERVENCION inicial (FALLO PROVOCADO)
    -- ERROR INTENCIONAL: id_paciente 999 NO EXISTE en la tabla Paciente.
    INSERT INTO intervencion (fecha, id_paciente)
    VALUES (GETDATE(), 999); 
    
    -- El fallo ocurre aquí, el control salta al CATCH, y las siguientes líneas no se ejecutan.
    SET @id_intervencion_reciente = SCOPE_IDENTITY();
    
    PRINT '2. INSERT en Intervencion FALLÓ (ESTA LÍNEA NO SE IMPRIME).';

    INSERT INTO procedimiento (id_proc_real, id_profesion, id_tipo_procedimiento, id_profesional, id_intervencion)
    VALUES (1, 1, 1, 1, @id_intervencion_reciente); 
    
    UPDATE cama
    SET estado = 2
    WHERE id_habitacion = 1 AND id_cama = 2;

    COMMIT TRANSACTION; 
    
END TRY
BEGIN CATCH
    -- 4. Manejo de errores y ROLLBACK
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END
    PRINT 'TRANSACCIÓN REVERTIDA completamente. La operación falló en el Paso 2.'; --Debería mostrarse este mensaje
    PRINT 'Detalle del error: ' + ERROR_MESSAGE();
END CATCH

