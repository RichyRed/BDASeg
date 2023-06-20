USE bd_medicamentos;

CREATE TABLE Medicamentos (
  IDMedicamento INT PRIMARY KEY,
  Nombre VARCHAR(50),
  Descripcion VARCHAR(200),
  Precio DECIMAL(10, 2)
);

CREATE TABLE Persona (
  IDPersona INT PRIMARY KEY,
  Nombre VARCHAR(50),
  Apellido VARCHAR(50),
  Ciudad VARCHAR(50),
  Telefono VARCHAR(20)
);

CREATE TABLE Direccion (
  IDDireccion INT PRIMARY KEY,
  Ciudad VARCHAR(50),
  Pais VARCHAR(50)
);

CREATE TABLE Proveedor (
  IDProveedor INT PRIMARY KEY,
  Nombre VARCHAR(50),
  Telefono VARCHAR(20),
  IDDireccion INT,
  FOREIGN KEY (IDDireccion) REFERENCES Direccion(IDDireccion)
);


CREATE TABLE AdquisicionMedicamentos (
  IDAquisicion INT PRIMARY KEY,
  IDMedicamento INT,
  IDProveedor INT,
  Cantidad INT,
  FechaAdquisicion DATE,
  FOREIGN KEY (IDMedicamento) REFERENCES Medicamentos(IDMedicamento),
  FOREIGN KEY (IDProveedor) REFERENCES Proveedor(IDProveedor)
);

CREATE TABLE Hospital (
  IDHospital INT PRIMARY KEY,
  Nombre VARCHAR(50),
  IDDireccion INT,
  FOREIGN KEY (IDDireccion) REFERENCES Direccion(IDDireccion)
);

CREATE TABLE Consultorio (
  IDConsultorio INT PRIMARY KEY,
  Nombre VARCHAR(50),
  Descripcion VARCHAR(200),
  IDHospital INT,
  FOREIGN KEY (IDHospital) REFERENCES Hospital(IDHospital)
);

CREATE TABLE Paciente (
  IDPaciente INT PRIMARY KEY,
  FechaNacimiento DATE,
  Historial VARCHAR(200),
  IDPersona INT,
  FOREIGN KEY (IDPersona) REFERENCES Persona(IDPersona)
);

CREATE TABLE Cirujanos (
  IDCirujano INT PRIMARY KEY,
  Especialidad VARCHAR(50),
  IDHospital INT,
  IDPersona INT,
  FOREIGN KEY (IDHospital) REFERENCES Hospital(IDHospital),
  FOREIGN KEY (IDPersona) REFERENCES Persona(IDPersona)
);

CREATE TABLE ProcedimientosQuirurgicos (
  IDProcedimiento INT PRIMARY KEY,
  Nombre VARCHAR(50),
  Descripcion VARCHAR(200),
  IDCirujano INT,
  FOREIGN KEY (IDCirujano) REFERENCES Cirujanos(IDCirujano)
);


-- Datos para la tabla Medicamentos
INSERT INTO Medicamentos (IDMedicamento, Nombre, Descripcion, Precio) 
VALUES (1, 'Paracetamol', 'Analgesico y antipiretico', 5.99);
INSERT INTO Medicamentos (IDMedicamento, Nombre, Descripcion, Precio)
VALUES (2, 'Golpex', 'Medicamento para el dolor y la fiebre', 5.99);
INSERT INTO Medicamentos (IDMedicamento, Nombre, Descripcion, Precio)
VALUES (3, 'Ibuprofeno', 'Antiinflamatorio y analgesico', 8.99);
INSERT INTO Medicamentos (IDMedicamento, Nombre, Descripcion, Precio)
VALUES (4, 'Amoxicilina', 'Antibiotico de amplio espectro', 12.99);


-- Datos para la tabla Persona
INSERT INTO Persona (IDPersona, Nombre, Apellido, Ciudad, Telefono) 
VALUES (1, 'Juan', 'Perez', 'Santa', '555-1234'),
       (2, 'Juan', 'Carlos', 'Cochita', '555-1239'),
       (3, 'Juan', 'Martinez', 'Sucre', '555-1236');

-- Datos para la tabla Direccion
INSERT INTO Direccion (IDDireccion, Ciudad, Pais) VALUES
(1, 'Cochabamba', 'Bolivia'),
(2, 'La Paz', 'Bolivia'),
(3, 'Santa Cruz', 'Bolivia'),
(4, 'Sucre', 'Bolivia');

-- Datos para la tabla Proveedor
INSERT INTO Proveedor (IDProveedor, Nombre, Telefono, IDDireccion) VALUES
(1, 'Farmacia Santa María', '555-6789', 1),
(2, 'Farmacia San Juan', '555-9876', 2),
(3, 'Farmacia Los Pinos', '555-1234', 3),
(4, 'Farmacia El Sol', '555-4321', 4);

-- Datos para la tabla AdquisicionMedicamentos
INSERT INTO AdquisicionMedicamentos (IDAquisicion, IDMedicamento, IDProveedor, Cantidad, FechaAdquisicion) VALUES 
(1, 1, 1, 10, '2023-05-01'),
(2, 2, 2, 5, '2023-05-15'),
(3, 3, 3, 8, '2023-06-01'),
(4, 4, 4, 3, '2023-06-05');


-- Datos para la tabla Hospital
INSERT INTO Hospital (IDHospital, Nombre, IDDireccion) VALUES
(1, 'Hospital General', 1),
(2, 'Hospital Infantil', 2),
(3, 'Hospital Policial', 3);

-- Datos para la tabla Consultorio
INSERT INTO Consultorio (IDConsultorio, Nombre, Descripcion, IDHospital) VALUES
(1, 'Consultorio A', 'Consultorio para especialistas', 1),
(2, 'Consultorio B', 'Consultorio oftalmologia', 1),
(3, 'Consultorio C', 'Consultorio privado', 1);

-- Datos para la tabla Paciente
INSERT INTO Paciente (IDPaciente, FechaNacimiento, Historial, IDPersona) VALUES
(1, '1990-03-15', 'Historial medico del paciente', 1),
(2, '1990-03-15', 'Historial medico', 2),
(3, '1990-03-15', 'Historial medico del paciente', 3);

-- Datos para la tabla Cirujanos
INSERT INTO Cirujanos (IDCirujano, Especialidad, IDHospital, IDPersona) VALUES
(1, 'Cirugia General', 1, 1),
(2, 'Cirugia General', 1, 3);

-- Datos para la tabla ProcedimientosQuirurgicos
INSERT INTO ProcedimientosQuirurgicos (IDProcedimiento, Nombre, Descripcion, IDCirujano) VALUES
(1, 'Extraccion de apendice', 'Procedimiento quirurgico para remover el apendice', 1);


/* AUDITORIAS */

CREATE TABLE AuditoriaMedicamentos (
  IDAuditoria INT PRIMARY KEY AUTO_INCREMENT,
  IDMedicamento INT,
  Nombre VARCHAR(50),
  Descripcion VARCHAR(200),
  Precio DECIMAL(10, 2),
  Accion VARCHAR(20),
  FechaAccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE AuditoriaProveedor (
  IDAuditoria INT PRIMARY KEY AUTO_INCREMENT,
  IDProveedor INT,
  Nombre VARCHAR(50),
  Telefono VARCHAR(20),
  IDDireccion INT,
  Accion VARCHAR(20),
  FechaAccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE AuditoriaPaciente (
  IDAuditoria INT PRIMARY KEY AUTO_INCREMENT,
  IDPaciente INT,
  FechaNacimiento DATE,
  Historial VARCHAR(200),
  IDPersona INT,
  Accion VARCHAR(20),
  FechaAccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE AuditoriaAdquisicionMedicamentos (
  IDAuditoria INT PRIMARY KEY AUTO_INCREMENT,
  IDAquisicion INT,
  IDMedicamento INT,
  IDProveedor INT,
  Cantidad INT,
  FechaAdquisicion DATE,
  Accion VARCHAR(20),
  FechaAccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE AuditoriaConsultorio (
  IDAuditoria INT PRIMARY KEY AUTO_INCREMENT,
  IDConsultorio INT,
  Nombre VARCHAR(50),
  Descripcion VARCHAR(200),
  IDHospital INT,
  Accion VARCHAR(20),
  FechaAccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* INDICES */
-- Índice 
CREATE INDEX idx_Proveedor_IDDireccion ON Proveedor(IDDireccion);

-- Índice 
CREATE INDEX idx_Hospital_Hospital ON Hospital (IDHospital);
CREATE INDEX idx_Consultorio_Hospital ON Consultorio (IDHospital);
CREATE INDEX idx_Consultorio_IDConsultorio ON Consultorio (IDConsultorio);

-- Índice 
CREATE INDEX idx_Paciente_IDPersona_FechaNacimiento ON Paciente(IDPersona, FechaNacimiento);

-- Indice 
CREATE INDEX idx_Paciente_IDPersona ON Paciente(IDPersona);
CREATE INDEX idx_Cirujanos_Persona ON Cirujanos(IDPersona);
CREATE INDEX idx_Cirujanos_Hospital ON Cirujanos(IDHospital);
CREATE INDEX idx_Hospital_IDHospital ON Hospital(IDHospital);
CREATE INDEX idx_Consultorio_IDHospital ON Consultorio(IDHospital);
CREATE INDEX idx_ProcedimientosQuirurgicos_IDCirujano ON ProcedimientosQuirurgicos(IDCirujano);

-- Indice 
CREATE INDEX idx_Medicamentos_Precio ON Medicamentos(Precio);
CREATE INDEX idx_AdquisicionMedicamentos_IDMedicamento_IDProveedor ON AdquisicionMedicamentos(IDMedicamento, IDProveedor);
CREATE INDEX idx_Proveedor_IDProveedor ON Proveedor(IDProveedor);


