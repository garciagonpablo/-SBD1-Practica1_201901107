-- Para esta base de datos las tablas más modificadas fueron las que se relacionaban con el cliente.
-- Entre estos cambios se encuentran: referencia entre cliente y poliza se encuentra a traves del  
-- contrato para que exista la posibilidad de que un cliente adquiera varias polizas, la tabla de 
-- pago almacena la poliza y el cliente que lo pagó para ser consistente con la capacidad de un 
-- cliente de tener varias polizas y que no se pierda la información acerca de que poliza se está pagando.

-- TABLA: Personal
-- id
-- nombres
-- apellidos
-- dpi
-- fecha_nacimiento
-- fecha_inicio_labores
-- edad
-- telefono
-- direccion
-- salario
-- id_puesto
-- id_departamento

-- TABLA: Puesto
-- id
-- nombre
-- rango_salarial

-- TABLA: Area
-- id
-- nombre

-- TABLA: Departamento
-- id
-- nombre
-- funcion
-- id_area

-- TABLA: Seguro
-- id
-- nombre
-- requerimentos
-- lista_papeleria

-- TABLA: Prospecto
-- id
-- id_personal
-- nombre_completo
-- telefono
-- id_seguro
-- datetime_llamada (Hora solo puede ser entre 08:00 y 17:00 horas tiempo Guatemala)
-- duracion_llamada

-- TABLA: Cliente
-- id
-- nombres
-- apellidos
-- cui
-- fecha_nacimiento (Mayor a 18 años)
-- telefono
-- direccion
-- edad
-- correo

-- TABLA: Contrato
-- id
-- id_cliente
-- id_seguro
-- vigencia (Vigente/No vigente)

-- TABLA: Poliza
-- id
-- codigo_poliza (inicia a partir del numero 10000 y será auto incrementable)
-- id_empleado
-- id_cliente
-- fecha_inicio
-- fecha_final
-- monto_poliza
-- tipo_pago (Mensual/Trimestral/Anual)

-- TABLA: Pago
-- id
-- tarifa
-- mora
-- monto
-- forma_pago (Cheque/Tarjeta de Credito o Debito/Efectivo)
-- fecha
-- id_empleado
-- id_cliente
-- id_poliza

DROP DATABASE IF EXISTS Caso5 ;
CREATE DATABASE IF NOT EXISTS Caso5 DEFAULT CHARACTER SET utf8 ;
USE Caso5;

DROP TABLE IF EXISTS Puesto ;
CREATE TABLE Puesto (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    rango_salarial VARCHAR2(50)
);

DROP TABLE IF EXISTS Area ;
CREATE TABLE Area (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

DROP TABLE IF EXISTS Departamento ;
CREATE TABLE Departamento (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    funcion VARCHAR2(255),
    id_area NUMBER,
    FOREIGN KEY (id_area) REFERENCES Area(id)
);

DROP TABLE IF EXISTS Personal ;
CREATE TABLE Personal (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombres VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    dpi VARCHAR2(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    fecha_inicio_labores DATE NOT NULL,
    edad NUMBER GENERATED ALWAYS AS (FLOOR((SYSDATE - fecha_nacimiento) / 365.25)),
    telefono VARCHAR2(15),
    direccion VARCHAR2(255),
    salario NUMBER,
    id_puesto NUMBER,
    id_departamento NUMBER,
    FOREIGN KEY (id_puesto) REFERENCES Puesto(id),
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id)
);

DROP TABLE IF EXISTS Seguro ;
CREATE TABLE Seguro (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    requerimentos VARCHAR2(255),
    lista_papeleria VARCHAR2(255)
);

DROP TABLE IF EXISTS Prospecto ;
CREATE TABLE Prospecto (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_personal NUMBER,
    nombre_completo VARCHAR2(200) NOT NULL,
    telefono VARCHAR2(15) NOT NULL,
    id_seguro NUMBER,
    datetime_llamada TIMESTAMP NOT NULL CHECK (EXTRACT(HOUR FROM datetime_llamada) BETWEEN 8 AND 17),
    duracion_llamada INTERVAL DAY TO SECOND,
    FOREIGN KEY (id_personal) REFERENCES Personal(id),
    FOREIGN KEY (id_seguro) REFERENCES Seguro(id)
);

DROP TABLE IF EXISTS Cliente ;
CREATE TABLE Cliente (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombres VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    cui VARCHAR2(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL CHECK (fecha_nacimiento <= ADD_MONTHS(SYSDATE, -18*12)),
    telefono VARCHAR2(15),
    direccion VARCHAR2(255),
    edad NUMBER GENERATED ALWAYS AS (FLOOR((SYSDATE - fecha_nacimiento) / 365.25)),
    correo VARCHAR2(100)
);

DROP TABLE IF EXISTS Contrato ;
CREATE TABLE Contrato (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_cliente NUMBER,
    id_seguro NUMBER,
    vigencia VARCHAR2(10) CHECK (vigencia IN ('Vigente', 'No vigente')),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id),
    FOREIGN KEY (id_seguro) REFERENCES Seguro(id)
);

DROP TABLE IF EXISTS Poliza ;
CREATE TABLE Poliza (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo_poliza NUMBER GENERATED BY DEFAULT AS IDENTITY(START WITH 10000) NOT NULL,
    id_empleado NUMBER,
    id_contrato NUMBER,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL,
    monto_poliza NUMBER NOT NULL,
    tipo_pago VARCHAR2(10) CHECK (tipo_pago IN ('Mensual', 'Trimestral', 'Anual')),
    FOREIGN KEY (id_empleado) REFERENCES Personal(id),
    FOREIGN KEY (id_contrato) REFERENCES Contrato(id)
);

DROP TABLE IF EXISTS Pago ;
CREATE TABLE Pago (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tarifa NUMBER NOT NULL,
    mora NUMBER,
    monto NUMBER NOT NULL,
    forma_pago VARCHAR2(20) CHECK (forma_pago IN ('Cheque', 'Tarjeta de Credito', 'Tarjeta de Debito', 'Efectivo')),
    fecha DATE NOT NULL,
    id_empleado NUMBER,
    id_cliente NUMBER,
    id_poliza NUMBER,
    FOREIGN KEY (id_empleado) REFERENCES Personal(id),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id),
    FOREIGN KEY (id_poliza) REFERENCES Poliza(id)
);