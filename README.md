# PROYECTO DE ESTUDIO

## PRESENTACIÓN - SISTEMA HOSPITALARIO

**Facultad:** Facultad de Ciencias Exactas y Naturales y Agrimensura

**Carrera:** Lic. en Sistemas de Información

**Asignatura:** Bases de Datos I (FaCENA-UNNE)

**Año:** 2025

**Grupo:** Nº 21

#### Integrantes:
- Acevedo, Tobias Cesar Facundo | 45.527.225
- Arce Obregon, Fernando Antonio | 45.644.949
- Zacarias, Juan Roman | 46.074.586
- Erck, Luciano Andres | 45.791.360

## CAPÍTULO I: INTRODUCCIÓN


### Caso de Estudio
El tema del presente Trabajo Práctico es **el diseño e implementación de un Sistema Hospitalario**, que permita gestionar de manera centralizada la información clínica y administrativa de un hospital.  

El proyecto se enfoca en resolver las dificultades actuales en la administración hospitalaria, donde la información se encuentra dispersa en registros físicos o en sistemas no integrados, lo cual genera pérdida de datos, duplicaciones, demoras en la atención y errores en la gestión de recursos.  

Estos problemas se reflejan principalmente en:

- **Demoras en la atención al paciente**, debido a la falta de información accesible en tiempo real.  
- **Errores en la asignación de camas y recursos**, ocasionados por registros manuales poco confiables.  
- **Dificultades en el seguimiento de historiales médicos**, lo que impacta en diagnósticos y tratamientos.  
- **Información dispersa en distintos registros físicos o digitales** sin conexión entre sí, dificultando la trazabilidad de los pacientes.  

Con este proyecto se busca dar una solución que permita **digitalizar y centralizar los procesos clave del hospital**, mejorando la eficiencia administrativa y clínica, y ofreciendo una herramienta confiable tanto para el personal médico como para el administrativo.  

---

### Definición o Planteamiento del Problema
El problema que este trabajo aborda puede expresarse mediante la siguiente pregunta central:  

**¿Cómo optimizar y centralizar la administración de un hospital mediante una base de datos relacional que facilite el acceso rápido a la información clave y automatice procesos críticos como la gestión de pacientes, internaciones, consultas médicas, medicación y asignación de habitaciones?**

Este problema surge de la observación de que:

- La información hospitalaria se encuentra **fragmentada y desorganizada**.  
- No existe un **historial médico unificado** para cada paciente.  
- Los procesos de internación, asignación de camas, administración de medicación y traslados se realizan de manera **manual o con herramientas poco eficientes**.  
- La trazabilidad de la atención médica se ve limitada por la **ausencia de un sistema informatizado**.  

Por lo tanto, se requiere un sistema que unifique y garantice la **integridad, consistencia, seguridad y disponibilidad** de la información hospitalaria, aplicando los principios de las bases de datos relacionales y las mejores prácticas de diseño de sistemas de información.  

---

### Objetivo del Trabajo Práctico

#### Objetivo General
Desarrollar un **Sistema Hospitalario Integral** que permita centralizar y optimizar la gestión clínica y administrativa de un hospital, asegurando la integridad y disponibilidad de la información de pacientes, profesionales, internaciones, consultas, medicaciones, procedimientos y traslados, a través del diseño e implementación de un **modelo de datos relacional en SQL Server**.  

#### Objetivos Específicos

##### Modelado y diseño de datos
- Elaborar un **modelo entidad–relación** que represente los procesos hospitalarios fundamentales.  
- Transformar el modelo conceptual en un **modelo lógico relacional normalizado**.  
- Implementar físicamente las tablas en **SQL Server**, aplicando claves primarias, foráneas y restricciones de integridad (`NOT NULL`, `UNIQUE`, `CHECK`).  
- Elaborar un **diccionario de datos** que documente entidades, atributos y reglas de negocio.  

##### Gestión de procesos hospitalarios
- Permitir el **registro y consulta de pacientes**, con toda su información personal y administrativa.  
- Gestionar las **habitaciones** del hospital, su estado y disponibilidad.  
- Administrar las **internaciones**, registrando ingresos, egresos y traslados de pacientes.  
- Registrar y organizar **consultas médicas**, incluyendo motivos, observaciones y médicos responsables.  
- Documentar **procedimientos médicos** y medicaciones suministradas a los pacientes, con control de dosis, horarios y personal a cargo.  
- Centralizar toda la información clínica en un **historial médico completo por paciente**.  

##### Optimización de la administración hospitalaria
- Garantizar la **integridad referencial y consistencia** de la información mediante la base de datos relacional.  
- Reducir la **duplicación y dispersión de datos**, minimizando errores administrativos y clínicos.  
- Proveer **consultas rápidas y reportes** que mejoren la toma de decisiones médicas y administrativas.  
- Establecer un **control de accesos y roles diferenciados** para médicos, enfermeros y administrativos.  

##### Desarrollo académico y tecnológico
- Aplicar en un caso práctico los conocimientos adquiridos en la materia **Base de Datos I**.  
- Publicar y versionar el avance del proyecto en un **repositorio GIT**, garantizando trazabilidad y trabajo colaborativo.  
- Sentar las bases para futuras mejoras del sistema (ejemplo: integración con **facturación, obras sociales o historias clínicas electrónicas nacionales**).  

---

### Alcance del Proyecto
El **Sistema Hospitalario Integral** cubrirá los siguientes aspectos:

- **Gestión de Pacientes**: alta de pacientes, registro de datos personales y administrativos.  
- **Gestión de Habitaciones**: registro de habitaciones, su estado (libre, ocupada, mantenimiento) y piso correspondiente.  
- **Gestión de Internaciones**: asignación de pacientes a habitaciones, con fechas de ingreso y egreso.  
- **Gestión de Consultas Médicas**: registro de motivos, observaciones, recomendaciones y médico responsable.  
- **Gestión de Procedimientos**: documentación de procedimientos médicos aplicados.  
- **Gestión de Medicación**: administración de fármacos con dosis, turnos y personal encargado.  
- **Gestión de Traslados**: registro de movimientos de pacientes entre habitaciones.  
- **Gestión de Usuarios**: médicos, enfermeros y administrativos, con control de roles y accesos.  
- **Historial Médico**: centralización de toda la información clínica de cada paciente, con trazabilidad de consultas, internaciones, traslados y medicación.  

Incluye un **módulo de gestión de turnos**, pero como una **modificación a futuro**, junto a otros requerimientos que vayan surgiendo y que permitan el crecimiento del sistema.  

---

### Límites del Proyecto
El sistema **no abarcará** los siguientes aspectos:

- Facturación, cobros ni integración con sistemas de obras sociales o seguros médicos.  
- Gestión de proveedores externos de insumos ni stock de medicamentos.  
- Almacenamiento de **archivos multimedia** (radiografías, imágenes, videos, etc.).  
- Integración con sistemas de historia clínica electrónica a nivel regional o nacional.  
- Implementación de módulos de **seguridad física** ni de vigilancia hospitalaria.  
- Gestión de **cirugías complejas, emergencias o planificación avanzada** de recursos hospitalarios.  


## CAPÍTULO II – MARCO CONCEPTUAL O REFERENCIAL

### 2.1. Introducción al Marco Conceptual

El presente capítulo reúne los fundamentos teóricos necesarios para comprender el diseño, implementación y posterior análisis del Sistema Hospitalario desarrollado. El marco conceptual permite contextualizar el proyecto dentro del campo de los Sistemas de Gestión de Bases de Datos (SGBD), aportando definiciones y nociones que sustentan las decisiones de modelado, normalización, seguridad, optimización y manejo de información clínica.

Este conjunto de conceptos ofrece la base para interpretar el modelo de datos utilizado, así como los temas técnicos que se implementan en la segunda etapa del trabajo: procedimientos almacenados, funciones, índices, transacciones y manejo de datos semiestructurados (JSON).

### 2.2. Sistemas de Gestión de Bases de Datos (DBMS)

Un Sistema de Gestión de Bases de Datos (SGBD) es un software encargado de administrar, almacenar, recuperar y proteger los datos de forma eficiente. En el contexto hospitalario, donde la información es crítica y debe mantenerse íntegra, los SGBD permiten garantizar:

- Integridad de los datos

- Disponibilidad en tiempo real

- Seguridad y control de acceso

- Optimización de consultas clínicas y administrativas

SQL Server fue elegido como motor de base de datos, dado su soporte robusto para:

- Transacciones ACID

- Procedimientos almacenados

- Índices avanzados

- Funciones definidas por el usuario

- Manejo de datos JSON

- Integridad referencial y restricciones

Estas características se alinean perfectamente con las necesidades de un sistema hospitalario que requiere precisión, trazabilidad y consistencia.

### 2.3. Modelo Relacional de Datos

El modelo relacional, desarrollado por Codd, es la base teórica que organiza la información en tablas relacionadas mediante claves primarias y foráneas.

En nuestro proyecto, el modelo relacional representa entidades reales del hospital tales como:

- Paciente

- Profesional

- Habitación / Cama

- Internación

- Intervención

- Procedimiento

Todas ellas están documentadas en el Diccionario de Datos y se reflejan en el Diagrama Relacional del Capítulo IV del proyecto 


#### Principios aplicados:

- 1FN, 2FN y 3FN para eliminar redundancia.

- Uso correcto de PK, FK, UNIQUE, CHECK.

- Relaciones: 1–N (Paciente–Intervención, Habitación–Cama) y N–N (Profesión–TipoProcedimiento).

El resultado es un modelo coherente con los procesos hospitalarios, garantizando integridad y consistencia de la información clínica.

### 2.4. Lenguaje SQL y sus componentes

Para implementar el modelo, SQL Server utiliza distintos subconjuntos del lenguaje SQL:

#### DDL (Data Definition Language)

Define la estructura de la base de datos:
CREATE TABLE, ALTER TABLE, DROP TABLE.

#### DML (Data Manipulation Language)

Manipula los datos existentes:
INSERT, UPDATE, DELETE, SELECT.

#### TCL (Transaction Control Language)

Gestiona transacciones:
BEGIN TRAN, COMMIT, ROLLBACK.

Estos lenguajes son utilizados en las implementaciones incluidas en el repositorio y en los temas técnicos asignados.

### 2.5. Marco Teórico de los Temas Técnicos del Proyecto

A continuación, se documentan los fundamentos conceptuales de los temas técnicos obligatorios requeridos por la cátedra.

#### 2.5.1. Procedimientos y Funciones Almacenadas

Los procedimientos almacenados y funciones son componentes esenciales para encapsular lógica de negocio dentro del SGBD.

##### Procedimientos Almacenados

- Ejecutan múltiples operaciones SQL.

- Admiten parámetros de entrada y salida.

- Permiten realizar operaciones CRUD.

- Mejoran la seguridad y el rendimiento.

Ejemplos: Insertar un paciente, registrar una internación, actualizar el estado de una cama.

##### Funciones Definidas por el Usuario (UDF)

- Devuelven un valor escalar o una tabla.

- No pueden modificar datos.

- Útiles para cálculos reutilizables (ej.: calcular edad).

##### Diferencias clave

###### Procedimiento
- Devuelve valor:	Opcional
- Usa SELECT:	No directo
- Modifica datos:	Sí
- Uso en FROM: No

###### Función	
- Devuelve valor: Obligatorio
- Usa SELECT:	Sí, como expresión
- Modifica datos:	No
- Uso en FROM: Sí (table-valued)


#### 2.5.2. Optimización de Consultas mediante Índices

Los índices son estructuras de datos que aceleran el acceso a grandes volúmenes de información. Su correcta implementación es esencial en un hospital donde se consultan constantemente internaciones, pacientes y procedimientos.

##### Tipos utilizados:

- Índice Agrupado (Clustered): Organiza físicamente los datos.

- Índice No Agrupado (Non-Clustered): estructura separada, ordenada por una o más columnas.

##### Casos aplicados:

- Búsqueda por DNI en paciente.

- Búsqueda por fecha de ingreso en internacion.

- Consultas analíticas optimizadas mediante índices de cobertura (INCLUDE).

El informe concluye que los índices reducen el tiempo de búsqueda hasta en un 88% y las lecturas lógicas hasta en un 98%, dependiendo del escenario.

#### 2.5.3. Manejo de Transacciones y Transacciones Anidadas

Las transacciones garantizan la consistencia del sistema, especialmente en procesos hospitalarios críticos como internaciones, intervenciones o asignación de camas.

##### Propiedades ACID:

- Atomicidad

- Consistencia

- Aislamiento

- Durabilidad

##### Transacciones anidadas

- Permiten manejar procesos complejos paso a paso

- Uso de SAVEPOINT para no perder progreso parcial

- Útiles en intervenciones con múltiples procedimientos vinculados

###### Ejemplo aplicado

Registrar una internación y actualizar el estado de una cama dentro de la misma transacción para asegurar consistencia.

#### 2.5.4. Manejo de Datos Semi-Estructurados (JSON)

En hospitales, existe información variable o no estructurada:

- alergias

- contactos alternativos

- historial de síntomas

- notas clínicas

SQL Server permite manejar estos datos mediante JSON sobre campos NVARCHAR(MAX).

##### Funciones importantes:

- JSON_VALUE

- OPENJSON

- JSON_MODIFY

##### Optimización:

El uso de columnas computadas indexadas permite:

- Evitar escaneos completos de tabla

- Mejorar rendimientos por encima del 90%

Esto aporta flexibilidad sin alterar el modelo relacional.

### 2.6. Conceptos Específicos del Dominio Hospitalario

El sistema se basa en conceptos reales del ámbito clínico:

- Paciente como entidad central.

- Intervención como evento clínico principal.

- Procedimientos registrados con profesional y tipo.

- Internación con habitación y cama.

- Profesionales y profesiones asociadas a especialidades médicas.

Estos conceptos se encuentran desarrollados formalmente en el Diccionario de Datos del proyecto

### 2.7. Conclusión del Marco Conceptual

El conjunto de conceptos presentados en este capítulo proporciona el fundamento teórico que sustenta el diseño y desarrollo del Sistema Hospitalario. Desde los principios del modelo relacional hasta técnicas avanzadas como índices, transacciones y manejo de datos semiestructurados, cada uno de estos elementos resulta esencial para garantizar un sistema eficiente, sólido y alineado con las necesidades reales del entorno hospitalario.

Este marco conceptual servirá como referencia para comprender los resultados expuestos en el Capítulo IV y las decisiones técnicas adoptadas durante todo el proyecto.