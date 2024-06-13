-- Para este caso no hubieron muchas modificaciones al los campos que se recomendaron en el encunciado.
-- De las modificaciones que se realizaron fue que se ignoró todo lo que tuviera que ver con municipios,
-- ya que no se describió ninguna funcionalidad que lo requiera. También se le agrego el campo de dispo-
-- nible al vehículo para tener información de cuando un vehículo ya fue procesado en alguna venta.


-- TABLA: Vehiculo
-- id
-- placa
-- color
-- marca
-- modelo
-- kilometraje
-- añó
-- transmision (automatica/mecanica)
-- no_puertas
-- condicion (nuevo/usado)
-- id_proveedor
-- disponible (true/false)

-- TABLA: Sucursal
-- id
-- nombre
-- direccion
-- telefono
-- sitio_web
-- id_departamento

-- TABLA: Departamento
-- id
-- nombre

-- TABLA: Inventario
-- id
-- id_sucursal
-- id_vehiculo 

-- TABLA: Transaccion
-- id
-- id_sucursal
-- id_vehiculo
-- compra_venta (compra/venta)
-- al_credito (true/false)
-- banco (puede ser null)
-- id_tarjeta
-- monto_credito (numero positivo mayor a 0)
-- fecha_transaccion
-- monto_contado (numero positivo mayor a 0)
-- id_empleado
-- descuento
-- motivo_descuento

-- TABLA: Cliente
-- id
-- nombre_completo
-- direccion
-- telefono_personal (NOT NULL)
-- telefono_casa
-- email (NOT NULL)
-- dpi (NOT NULL)
-- nit (NOT NULL)

-- TABLA: Tarjeta
-- id
-- numero_tarjeta
-- fecha_expiracion
-- numero_seguridad
-- nombre_titular

-- TABLA: Proveedor
-- id
-- nombre
-- direccion
-- telefono
-- correo
-- nombre_empresa

-- TABLA: Empleado
-- id
-- nombre
-- dpi
-- nit
-- telefono
-- sueldo (default = 2300)

-- TABLA: Dia_laboral
-- id
-- id_sucursal
-- id_empleado
-- fecha
DROP DATABASE IF EXISTS Caso2 ;
CREATE DATABASE IF NOT EXISTS Caso2 DEFAULT CHARACTER SET utf8 ;
USE Caso2;

DROP TABLE IF EXISTS Departamento ;
CREATE TABLE Departamento (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

DROP TABLE IF EXISTS Proveedor ;
CREATE TABLE Proveedor (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    direccion VARCHAR2(255),
    telefono VARCHAR2(20),
    correo VARCHAR2(100),
    nombre_empresa VARCHAR2(100)
);

DROP TABLE IF EXISTS Sucursal ;
CREATE TABLE Sucursal (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    direccion VARCHAR2(255),
    telefono VARCHAR2(20),
    sitio_web VARCHAR2(100),
    id_departamento NUMBER,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id)
);

DROP TABLE IF EXISTS Empleado ;
CREATE TABLE Empleado (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    dpi VARCHAR2(20) NOT NULL,
    nit VARCHAR2(20) NOT NULL,
    telefono VARCHAR2(20),
    sueldo NUMBER DEFAULT 2300
);

DROP TABLE IF EXISTS Cliente ;
CREATE TABLE Cliente (
    id NUMBER PRIMARY KEY,
    nombre_completo VARCHAR2(100) NOT NULL,
    direccion VARCHAR2(255),
    telefono_personal VARCHAR2(20) NOT NULL,
    telefono_casa VARCHAR2(20),
    email VARCHAR2(100) NOT NULL,
    dpi VARCHAR2(20) NOT NULL,
    nit VARCHAR2(20) NOT NULL
);

DROP TABLE IF EXISTS Tarjeta ;
CREATE TABLE Tarjeta (
    id NUMBER PRIMARY KEY,
    numero_tarjeta VARCHAR2(20) NOT NULL,
    fecha_expiracion DATE NOT NULL,
    numero_seguridad VARCHAR2(4) NOT NULL,
    nombre_titular VARCHAR2(100) NOT NULL,
    id_cliente NUMBER,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);

DROP TABLE IF EXISTS Vehiculo ;
CREATE TABLE Vehiculo (
    id NUMBER PRIMARY KEY,
    placa VARCHAR2(20) NOT NULL,
    color VARCHAR2(50) NOT NULL,
    marca VARCHAR2(50) NOT NULL,
    modelo VARCHAR2(50) NOT NULL,
    kilometraje NUMBER NOT NULL,
    año NUMBER NOT NULL,
    transmision VARCHAR2(20) CHECK (transmision IN ('automatico', 'mecanico')),
    no_puertas NUMBER NOT NULL,
    condicion VARCHAR2(20) CHECK (condicion IN ('nuevo', 'usado')),
    id_proveedor NUMBER,
    disponible CHAR(1) CHECK (disponible IN ('T', 'F')),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id)
);

DROP TABLE IF EXISTS Inventario ;
CREATE TABLE Inventario (
    id NUMBER PRIMARY KEY,
    id_sucursal NUMBER,
    id_vehiculo NUMBER,
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id),
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id)
);

DROP TABLE IF EXISTS Transaccion ;
CREATE TABLE Transaccion (
    id NUMBER PRIMARY KEY,
    id_sucursal NUMBER,
    id_vehiculo NUMBER,
    compra_venta VARCHAR2(20) CHECK (compra_venta IN ('compra', 'venta')),
    al_credito CHAR(1) CHECK (al_credito IN ('T', 'F')),
    banco VARCHAR2(100),
    id_tarjeta NUMBER,
    monto_credito NUMBER CHECK (monto_credito > 0),
    fecha_transaccion DATE NOT NULL,
    monto_contado NUMBER CHECK (monto_contado > 0),
    id_empleado NUMBER,
    descuento NUMBER,
    motivo_descuento VARCHAR2(255),
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id),
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id),
    FOREIGN KEY (id_tarjeta) REFERENCES Tarjeta(id),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id)
);

DROP TABLE IF EXISTS Dia_laboral ;
CREATE TABLE Dia_laboral (
    id NUMBER PRIMARY KEY,
    id_sucursal NUMBER,
    id_empleado NUMBER,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id)
);
