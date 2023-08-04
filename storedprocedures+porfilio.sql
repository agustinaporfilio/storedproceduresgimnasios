USE Gimnasios;

DELIMITER $$

-- crear un stored procedure que ordene la tabla socios por sus columnas en orden asc/desc
CREATE PROCEDURE sp_ordenar_tabla_socios (
IN columna VARCHAR(50), 
IN orden VARCHAR(4)
)

BEGIN
 -- validar campo de ordenamiento de la tabla
IF columna <>  '' THEN
	SET @socios_columna = concat('ORDER BY ', columna);
ELSE
	SET @socios_columna = '';
END IF;

 -- verficar si el parametro de orden es valido
 IF (orden <> 'ASC' AND orden <> 'DESC') THEN 
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El parametro de orden debe ser "ASC" o "DESC".';
 END IF;
 
SET @clausula = concat('SELECT * FROM SOCIOS ', @socios_columna, ' ', orden);

PREPARE ordenar FROM @clausula;
EXECUTE ordenar;
DEALLOCATE PREPARE ordenar;
END$$

-- crear un SP que inserte valores en la tabla socios
CREATE PROCEDURE sp_insertar_socio(
    IN p_Nombre VARCHAR(50),
    IN p_Apellido VARCHAR(50),
    IN p_DNI INT,
    IN p_Email VARCHAR(100),
    IN p_Telefono INT,
    IN p_SocioActivo TINYINT(1)
)
BEGIN
-- insertar valores en la tabla socios
    INSERT INTO SOCIOS (Nombre, Apellido, DNI, Email, Telefono, SocioActivo)
    VALUES (p_Nombre, p_Apellido, p_DNI, p_Email, p_Telefono, p_SocioActivo);
END $$

DELIMITER ;
