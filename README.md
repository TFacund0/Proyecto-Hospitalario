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
