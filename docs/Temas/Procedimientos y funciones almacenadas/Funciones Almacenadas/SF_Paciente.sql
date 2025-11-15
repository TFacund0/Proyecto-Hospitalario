-- 1. Funciones almacenadas

-- 1.1. Función para calcular la edad de una persona

CREATE FUNCTION dbo.fn_CalcularEdad (@fecha_nacimiento DATE) -- Función que calcula la edad, según la fecha pasada como parametro
RETURNS INT -- Indica el tipo de dato de retorno de la función
AS
BEGIN -- Indica el comienzo del bloque de instrucciones
    
    -- Define una variable interna/local de tipo INT
    DECLARE @edad INT; 

    -- Asigna un valor para la variable edad, la cual se calcula con la fecha de nacimiento pasada como parametro
    SET @edad = DATEDIFF(YEAR, @fecha_nacimiento, GETDATE());

    -- Ajuste si aún no cumplió años este año

    -- DATEADD es una función de SQL Server que suma (o resta) una cantidad de unidades de tiempo a una fecha.
    -- Esta setencia permite determinar la edad exacta
    IF (DATEADD(YEAR, @edad, @fecha_nacimiento) > CAST(GETDATE() AS DATE))
        SET @edad = @edad - 1;

    -- Indica el valor a devolver por la función
    RETURN @edad; 
END; -- Indica el fin del bloque de instrucciones de la función
GO

-- Ejemplo aplicando la función almacenada: fn_CalcularEdad
SELECT nombre,
       apellido,
       fecha_nacimiento,
       dbo.fn_CalcularEdad(fecha_nacimiento) AS edad
FROM paciente;

-- 1.2. Función para obtener el nombre completo del paciente

CREATE FUNCTION dbo.fn_NombreCompletoPaciente (@id_paciente INT) -- Función que devuelve el nombre completo del paciente, dando como parametro el id del paciente
RETURNS VARCHAR(60) -- Indica el tipo de retorno de la función
AS
BEGIN -- Indica el comienzo de la función
    DECLARE @resultado VARCHAR(60); -- Define una variable local para el resultado que se va a retornar, es de tipo String

    -- Sentencias que permiten obtener el paciente, según su ID
    SELECT @resultado = apellido + ', ' + nombre -- Asigna a resultado la concatenación del apellido y nombre
    FROM paciente
    WHERE id_paciente = @id_paciente; 

    RETURN @resultado; -- Retorno el resultado de la busqueda del nombre completo del paciente
END; -- Indica el fin de la función
GO

-- Ejemplo aplicando la función almacenada: fn_NombreCompletoPaciente
SELECT id_paciente,
       dbo.fn_NombreCompletoPaciente(id_paciente) AS nombre_completo
FROM paciente;

-- 1.3. Función para contar internaciones de un paciente

CREATE FUNCTION dbo.fn_CantidadInternacionesPaciente (@id_paciente INT) -- Función que permite obtener la cantidad de internaciones de un paciente, según el id dado como parametro
RETURNS INT -- Indica que la función retorna un valor entero
AS
BEGIN
    DECLARE @cantidad INT; -- Define una variable local de tipo entero

    -- Sentencias que asigna a la variable la cantidad de internaciones asociadas al id del paciente pasada como parametro
    SELECT @cantidad = COUNT(*)
    FROM internacion
    WHERE id_paciente = @id_paciente;

    RETURN @cantidad; -- Devuelve el valor asignado a la variable
END; -- Indica la finalización de las instrucciones de la función
GO

-- Ejemplo aplicando la función almacenada: fn_CantidadInternacionesPaciente
SELECT p.id_paciente,
       dbo.fn_NombreCompletoPaciente(p.id_paciente) AS nombre_completo,
       dbo.fn_CantidadInternacionesPaciente(p.id_paciente) AS cant_internaciones
FROM paciente p;
