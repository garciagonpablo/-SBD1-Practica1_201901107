-- TABLA: Avion
-- id
-- modelo
-- matricula (se le debe de anteponer el prefijo TG seguido por la combinacion de letras)
-- numero_asientos_clase_primera
-- numero asientos_clase_economica
-- numero_asientos_clase_ejecutiva
-- fecha_ultimo_mantenimiento
-- fecha_proximo_mantenimiento
-- datetime_despegue_ultimo_vuelo
-- datetime_aterrizaje_ultimo_vuelo
-- capacidad_gasolina
-- distancia_maxima (millas)
-- altura_maxima (pies)

-- TABLA: Mantenimiento
-- id
-- datetime_mantenimiento
-- observaciones
-- problemas
-- id_mecanico_1
-- id_mecanico_2
-- id_mecanico_3
-- id_mecanico_4
-- id_mecanico_5
-- id_mecanico_6
-- id_mecanico_7
-- id_mecanico_8

-- TABLA: Empleado
-- id
-- nombre
-- apellido
-- edad
-- CUI
-- direccion
-- fecha_contratacion
-- fecha_nacimiento
-- correo
-- telefono
-- idiomas
-- turno_hora_inicio
-- turno_hora_final
-- jornada
-- puesto
-- horas_vuelo



-- TABLA: Baja
-- id 
-- retiro_despido (retiro/despido)
-- fecha
-- motivo

-- TABLA: Asistencia
-- id
-- id_empleado
-- datetime_entrada
-- datetime_salida
-- falta
-- motivo_falta

-- TABLA CLiente:
-- id
-- nombre
-- apellido
-- edad
-- cui
-- fecha_nacimiento
-- correo
-- telefono
-- direccion
-- codigo_postal
-- numero_pasaporte

-- TABLA: Pasajero
-- id
-- metodo_pago
-- lugar_origen
-- lugar_destino
-- clase
-- monto_total
-- fecha_salida
-- fecha_retorno

-- TABLA: Boleto
-- id
-- id_pasajero
-- ciudades_escala
-- peso_equipaje_permitido (default 50 libras)
-- restricciones_cambios_reembolsos
-- fecha_validez
-- id_avion
-- directo_escala (directo/escala)

-- TABLA: Pago
-- id
-- numero_tarjeta
-- credito_debito (credito/debito)
-- monto_total
-- id_boleto

DROP DATABASE IF EXISTS Caso4 ;
CREATE DATABASE IF NOT EXISTS Caso4 DEFAULT CHARACTER SET utf8 ;
USE Caso4;

DROP TABLE IF EXISTS Avion ;
CREATE TABLE Avion (
    id NUMBER PRIMARY KEY,
    modelo VARCHAR2(100),
    matricula VARCHAR2(20) CONSTRAINT chk_matricula CHECK (matricula LIKE 'TG%'),
    numero_asientos_clase_primera NUMBER,
    numero_asientos_clase_economica NUMBER,
    numero_asientos_clase_ejecutiva NUMBER,
    fecha_ultimo_mantenimiento DATE,
    fecha_proximo_mantenimiento DATE,
    datetime_despegue_ultimo_vuelo TIMESTAMP,
    datetime_aterrizaje_ultimo_vuelo TIMESTAMP,
    capacidad_gasolina NUMBER,
    distancia_maxima NUMBER,
    altura_maxima NUMBER
);

DROP TABLE IF EXISTS Mantenimiento ;
CREATE TABLE Mantenimiento (
    id NUMBER PRIMARY KEY,
    datetime_mantenimiento TIMESTAMP,
    observaciones VARCHAR2(500),
    problemas VARCHAR2(500),
    id_mecanico_1 NUMBER,
    id_mecanico_2 NUMBER,
    id_mecanico_3 NUMBER,
    id_mecanico_4 NUMBER,
    id_mecanico_5 NUMBER,
    id_mecanico_6 NUMBER,
    id_mecanico_7 NUMBER,
    id_mecanico_8 NUMBER,
    FOREIGN KEY (id_mecanico_1) REFERENCES Empleado(id),
    FOREIGN KEY (id_mecanico_2) REFERENCES Empleado(id),
    FOREIGN KEY (id_mecanico_3) REFERENCES Empleado(id),
    FOREIGN KEY (id_mecanico_4) REFERENCES Empleado(id),
    FOREIGN KEY (id_mecanico_5) REFERENCES Empleado(id),
    FOREIGN KEY (id_mecanico_6) REFERENCES Empleado(id),
    FOREIGN KEY (id_mecanico_7) REFERENCES Empleado(id),
    FOREIGN KEY (id_mecanico_8) REFERENCES Empleado(id)
);

DROP TABLE IF EXISTS Empleado ;
CREATE TABLE Empleado (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    apellido VARCHAR2(100),
    edad NUMBER,
    CUI VARCHAR2(20),
    direccion VARCHAR2(200),
    fecha_contratacion DATE,
    fecha_nacimiento DATE,
    correo VARCHAR2(100),
    telefono VARCHAR2(20),
    idiomas VARCHAR2(200),
    turno_hora_inicio TIMESTAMP,
    turno_hora_final TIMESTAMP,
    jornada VARCHAR2(50),
    puesto VARCHAR2(100),
    horas_vuelo NUMBER
);

DROP TABLE IF EXISTS Baja ;
CREATE TABLE Baja (
    id NUMBER PRIMARY KEY,
    retiro_despido VARCHAR2(10) CHECK (retiro_despido IN ('retiro', 'despido')),
    fecha DATE,
    motivo VARCHAR2(500),
    id_empleado NUMBER,
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id),
);

DROP TABLE IF EXISTS Asistencia ;
CREATE TABLE Asistencia (
    id NUMBER PRIMARY KEY,
    id_empleado NUMBER,
    datetime_entrada TIMESTAMP,
    datetime_salida TIMESTAMP,
    falta CHAR(1) CHECK (falta IN ('S', 'N')),
    motivo_falta VARCHAR2(500),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id)
);

DROP TABLE IF EXISTS Cliente ;
CREATE TABLE Cliente (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    apellido VARCHAR2(100),
    edad NUMBER,
    cui VARCHAR2(20),
    fecha_nacimiento DATE,
    correo VARCHAR2(100),
    telefono VARCHAR2(20),
    direccion VARCHAR2(200),
    codigo_postal VARCHAR2(10),
    numero_pasaporte VARCHAR2(20)
);

DROP TABLE IF EXISTS Pasajero ;
CREATE TABLE Pasajero (
    id NUMBER PRIMARY KEY,
    metodo_pago VARCHAR2(50),
    lugar_origen VARCHAR2(100),
    lugar_destino VARCHAR2(100),
    clase VARCHAR2(20),
    monto_total NUMBER,
    fecha_salida DATE,
    fecha_retorno DATE
);

DROP TABLE IF EXISTS Boleto ;
CREATE TABLE Boleto (
    id NUMBER PRIMARY KEY,
    id_pasajero NUMBER,
    ciudades_escala VARCHAR2(500),
    peso_equipaje_permitido NUMBER DEFAULT 50,
    restricciones_cambios_reembolsos VARCHAR2(500),
    fecha_validez DATE,
    id_avion NUMBER,
    directo_escala VARCHAR2(10) CHECK (directo_escala IN ('directo', 'escala')),
    FOREIGN KEY (id_pasajero) REFERENCES Pasajero(id),
    FOREIGN KEY (id_avion) REFERENCES Avion(id)
);

DROP TABLE IF EXISTS Pago ;
CREATE TABLE Pago (
    id NUMBER PRIMARY KEY,
    numero_tarjeta VARCHAR2(20),
    credito_debito VARCHAR2(10) CHECK (credito_debito IN ('credito', 'debito')),
    monto_total NUMBER,
    id_boleto NUMBER,
    FOREIGN KEY (id_boleto) REFERENCES Boleto(id)
);
