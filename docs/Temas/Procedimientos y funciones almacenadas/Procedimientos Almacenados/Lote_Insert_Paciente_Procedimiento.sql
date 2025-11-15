USE sistema_hospitalario_2;
GO

-- Lote de INSERTs usando el procedimiento almacenado sp_InsertarPaciente

EXEC sp_InsertarPaciente
    @nombre = 'Diego',
    @apellido = 'Suárez',
    @dni = 30890123,
    @direccion = 'Calle Corrientes 100',
    @telefono = 3794000008,
    @fecha_nacimiento = '1988-11-02';

EXEC dbo.sp_InsertarPaciente
    @nombre = 'Valentina',
    @apellido = 'Rodríguez',
    @dni = 30901234,
    @direccion = 'Av. Uruguay 250',
    @telefono = 3794000009,
    @fecha_nacimiento = '1993-04-18';

EXEC dbo.sp_InsertarPaciente
    @nombre = 'Nicolás',
    @apellido = 'Benítez',
    @dni = 31012345,
    @direccion = 'B° Laguna Seca Mz 3 Casa 5',
    @telefono = 3794000010,
    @fecha_nacimiento = '1980-09-09';

EXEC dbo.sp_InsertarPaciente
    @nombre = 'Camila',
    @apellido = 'Acosta',
    @dni = 31123456,
    @direccion = 'Calle Mendoza 890',
    @telefono = 3794000011,
    @fecha_nacimiento = '1999-02-25';

EXEC dbo.sp_InsertarPaciente
    @nombre = 'Franco',
    @apellido = 'Luna',
    @dni = 31234567,
    @direccion = 'Av. 3 de Abril 2000',
    @telefono = 3794000012,
    @fecha_nacimiento = '1975-06-30';
