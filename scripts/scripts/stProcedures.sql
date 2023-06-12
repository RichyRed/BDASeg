USE bd_medicamentos;

DELIMITER //

CREATE PROCEDURE SP_BuscarMedicamentos (
    IN criterio VARCHAR(50)
)
BEGIN
    SELECT *
    FROM Medicamentos
    WHERE Nombre LIKE CONCAT('%', criterio, '%')
       OR Descripcion LIKE CONCAT('%', criterio, '%');
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE SP_ContarProveedores (
    OUT totalProveedores INT
)
BEGIN
    SELECT COUNT(*) INTO totalProveedores
    FROM Proveedor;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE SP_ActualizarPrecioMedicamento (
    IN medicamentoID INT,
    IN nuevoPrecio DECIMAL(10, 2)
)
BEGIN
    UPDATE Medicamentos
    SET Precio = nuevoPrecio
    WHERE IDMedicamento = medicamentoID;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE SP_GenerarReporteVentas (
    IN fechaInicio DATE,
    IN fechaFin DATE,
    OUT totalVentas DECIMAL(10, 2)
)
BEGIN
    -- Cálculo del total de ventas
    SELECT SUM(M.Precio * A.Cantidad) INTO totalVentas
    FROM AdquisicionMedicamentos A
    INNER JOIN Medicamentos M ON A.IDMedicamento = M.IDMedicamento
    WHERE A.FechaAdquisicion BETWEEN fechaInicio AND fechaFin;
    
    -- Generar el reporte de ventas
    SELECT M.Nombre AS Medicamento, A.Cantidad, A.FechaAdquisicion
    FROM AdquisicionMedicamentos A
    INNER JOIN Medicamentos M ON A.IDMedicamento = M.IDMedicamento
    WHERE A.FechaAdquisicion BETWEEN fechaInicio AND fechaFin;
    
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE SP_CalcularPromedioPrecios (
    OUT promedio DECIMAL(10, 2)
)
BEGIN
    -- Cálculo del promedio de precios de los medicamentos
    SELECT AVG(Precio) INTO promedio
    FROM Medicamentos;
    
END //

DELIMITER ;
