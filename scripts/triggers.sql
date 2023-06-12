USE bd_medicamentos;


DELIMITER //

CREATE TRIGGER validar_precio_medicamento
BEFORE INSERT ON Medicamentos
FOR EACH ROW
BEGIN
    IF NEW.Precio < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El precio del medicamento no puede ser negativo.';
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER validar_eliminacion_proveedor
BEFORE DELETE ON Proveedor
FOR EACH ROW
BEGIN
    DECLARE num_medicamentos INT;

    SELECT COUNT(*) INTO num_medicamentos
    FROM AdquisicionMedicamentos
    WHERE IDProveedor = OLD.IDProveedor;

    IF num_medicamentos > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el proveedor porque tiene medicamentos asociados.';
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER validar_eliminacion_hospital
BEFORE DELETE ON Hospital
FOR EACH ROW
BEGIN
    DECLARE num_consultorios INT;

    SELECT COUNT(*) INTO num_consultorios
    FROM Consultorio
    WHERE IDHospital = OLD.IDHospital;

    IF num_consultorios > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el hospital porque tiene consultorios asociados.';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER validar_insercion_paciente
BEFORE INSERT ON Paciente
FOR EACH ROW
BEGIN
    IF NEW.FechaNacimiento > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La fecha de nacimiento del paciente no puede ser en el futuro.';
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER gestion_inventario
BEFORE INSERT ON AdquisicionMedicamentos
FOR EACH ROW
BEGIN
    DECLARE cantidad_actual INT;

    -- Obtener la cantidad actual de medicamentos en inventario
    SELECT Cantidad INTO cantidad_actual
    FROM AdquisicionMedicamentos
    WHERE IDMedicamento = NEW.IDMedicamento
    ORDER BY FechaAdquisicion DESC
    LIMIT 1;

    IF cantidad_actual IS NULL THEN
        SET cantidad_actual = 0;
    END IF;

    -- Verificar si la cantidad solicitada excede el inventario disponible
    IF NEW.Cantidad > cantidad_actual THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No hay suficientes medicamentos en inventario.';
    ELSE
        -- Actualizar la cantidad actual de medicamentos en inventario
        SET NEW.Cantidad = cantidad_actual - NEW.Cantidad;
    END IF;
END//

DELIMITER ;

DELIMITER //
CREATE TRIGGER validar_cirujano_hospital
BEFORE INSERT ON Cirujanos
FOR EACH ROW
BEGIN
    DECLARE hospital_existente INT;

    -- Verificar si el cirujano ya pertenece a un hospital
    SELECT COUNT(*) INTO hospital_existente
    FROM Cirujanos
    WHERE IDPersona = NEW.IDPersona;

    IF hospital_existente > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El cirujano ya pertenece a otro hospital.';
    END IF;
END//
DELIMITER ;




DELIMITER //
CREATE TRIGGER Audit_Medicamentos
AFTER INSERT ON Medicamentos
FOR EACH ROW
BEGIN
  INSERT INTO AuditoriaMedicamentos (IDMedicamento, Nombre, Descripcion, Precio, Accion)
  VALUES (NEW.IDMedicamento, NEW.Nombre, NEW.Descripcion, NEW.Precio, 'INSERT');
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER Audit_Proveedor
AFTER INSERT ON Proveedor
FOR EACH ROW
BEGIN
  INSERT INTO AuditoriaProveedor (IDProveedor, Nombre, Telefono, IDDireccion, Accion)
  VALUES (NEW.IDProveedor, NEW.Nombre, NEW.Telefono, NEW.IDDireccion, 'INSERT');
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER Audit_Paciente
AFTER INSERT ON Paciente
FOR EACH ROW
BEGIN
  INSERT INTO AuditoriaPaciente (IDPaciente, FechaNacimiento, Historial, IDPersona, Accion)
  VALUES (NEW.IDPaciente, NEW.FechaNacimiento, NEW.Historial, NEW.IDPersona, 'INSERT');
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER Audit_AdquisicionMedicamentos
AFTER DELETE ON AdquisicionMedicamentos
FOR EACH ROW
BEGIN
  INSERT INTO AuditoriaAdquisicionMedicamentos (IDAquisicion, IDMedicamento, IDProveedor, Cantidad, FechaAdquisicion, Accion)
  VALUES (OLD.IDAquisicion, OLD.IDMedicamento, OLD.IDProveedor, OLD.Cantidad, OLD.FechaAdquisicion, 'DELETE');
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER Audit_Consultorio
AFTER DELETE ON Consultorio
FOR EACH ROW
BEGIN
  INSERT INTO AuditoriaConsultorio (IDConsultorio, Nombre, Descripcion, IDHospital, Accion)
  VALUES (OLD.IDConsultorio, OLD.Nombre, OLD.Descripcion, OLD.IDHospital, 'DELETE');
END //
DELIMITER ;