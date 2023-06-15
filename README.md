# Proyecto de Adquisición de Medicamentos e Insumos para Procedimientos Quirúrgicos Oftalmológicos a Nivel Nacional del PNFRFSS

La adquisición de medicamentos e insumos para procedimientos quirúrgicos en los servicios especializados de oftalmología a nivel nacional del PNFRFSS (Programa Nacional de Fortalecimiento de la Red de Farmacias y Servicios de Salud) se refiere al proceso mediante el cual se obtienen los medicamentos y suministros necesarios para llevar a cabo intervenciones quirúrgicas oftalmológicas en diferentes centros de salud en todo el país. 
Este programa tiene como objetivo garantizar el abastecimiento adecuado de medicamentos e insumos, asegurando la calidad y disponibilidad de los mismos para brindar una atención médica de calidad a los pacientes con afecciones oftalmológicas en todo el territorio nacional.

El proyecto incluye el diseño de una base de datos que permita almacenar la información relacionada con los medicamentos, insumos, hospitales, consultorios, cirujanos, pacientes y demás entidades involucradas en el proceso de adquisición y realización de procedimientos quirúrgicos oftalmológicos. Además, se implementarán reglas y restricciones mediante triggers para garantizar la integridad de los datos y asegurar que se cumplan ciertas validaciones y condiciones necesarias.

## 📊 Diagrama propuesto de Base de Datos

Aquí se muestra el diagrama propuesto de la base de datos para el proyecto.  clara de la estructura de la base de datos.

![Ultimo](https://github.com/RichyRed/BDASeg/assets/84047015/7217bae6-180b-4998-8034-40cdd1e759da)

## Triggers🐱‍🏍
* Validar que el precio de un medicamento no sea negativo antes de insertarlo.
* Evitar la eliminación de un proveedor si tiene medicamentos asociados en la tabla.
* Evitar la eliminación de un hospital si tiene consultorios asociados.
* Validar que la fecha de nacimiento de un paciente no sea en el futuro
* Controlar la cantidad de medicamentos en inventario al realizar una adquisición en la tabla.
* Evitar que un cirujano pertenezca a más de un hospital

## Stored Procedures 🤖
* Buscar medicamentos
* Contar el numero de proveedores
* Actualizar el precio de algun medicamento 
* Generar reporte de ventas
* Calcular el promedio del precio de los medicamentos

## 🛠️ Requisitos técnicos

* Tener un sistema operativo:
  - Windows 10 64-bit: Pro, Enterprise o Education (versión 1607 o posterior) o Windows Server 2016.
  - macOS 10.13 o superior.
* Docker Desktop: Asegúrate de tener instalado Docker Desktop.
* Git: Será necesario tener Git instalado para clonar nuestro repositorio.

## 🚀 Cómo levantar el proyecto

* Clonar el repositorio:

        git clone <URL_DEL_REPOSITORIO>
* Nos dirigimos a la ruta:

       cd <ruta donde clonaste el proyecto>
* Levantamos el archivo .yml:

        docker-compose -f docker-compose.yml up

* Para bajar el servicio colocamos: 

        docker-compose -f docker-compose.yml down
## ✍️ El autor

[RichyRed]

