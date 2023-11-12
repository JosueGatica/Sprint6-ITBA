--CONSULTA 1

SELECT branch_name, COUNT(customer_id) AS cantidad_clientes
FROM sucursal AS s
LEFT JOIN cliente AS c ON s.branch_id = c.branch_id
GROUP BY branch_name
ORDER BY cantidad_clientes DESC;

--CONSULTA 2

SELECT customer_name, branch_name,
COUNT(customer_id) AS cantidad_empleados
FROM cliente AS c	
JOIN sucursal AS s ON c.branch_id = c.customer_id
LEFT JOIN empleado AS e ON s.branch_id = e.employee_id
GROUP BY customer_name, branch_name
ORDER BY branch_name, customer_name 


--CONSULTA 3

SELECT
    s.branch_name AS nombre_sucursal,
    'Credito' AS tipo_tarjeta,
    COUNT(t.ID) AS cantidad_tarjetas
FROM sucursal AS s
JOIN cliente AS c ON s.branch_id = c.branch_id
LEFT JOIN Tarjeta AS t ON c.tarjeta_id = t.ID
WHERE t.TipoTarjeta = 'Credito'
GROUP BY s.branch_name
ORDER BY nombre_sucursal;

--CONSULTA 4

SELECT 
	s.branch_name AS nombre_sucursal,
	COUNT(p.loan_id) AS cantidad_prestamos
	FROM sucursal AS s
	JOIN cliente AS c ON s.branch_id = c.branch_id
	LEFT JOIN prestamo AS p ON c.customer_id = p.customer_id
	GROUP BY s.branch_name
	ORDER BY s.branch_name

--ME TRAE SOLO 91 SUCURSALES Y YO TENGO 100, POR QUE?

--CONSULTA 5 
 -
CREATE TABLE "auditoria_cuenta" (
	"old_id"	INTEGER NOT NULL,
	"new_id"	INTEGER NOT NULL,
	"old_balance"	INTEGER NOT NULL,
	"new_balance"	INTEGER NOT NULL,
	"old_iban"	TEXT NOT NULL,
	"new_iban"	TEXT NOT NULL,
	"old_type"	INTEGER NOT NULL,
	"new_type"	INTEGER NOT NULL,
	"user_action"	INTEGER,
	"created_at"	TEXT NOT NULL,
	PRIMARY KEY("new_id" AUTOINCREMENT)
);
--
CREATE TRIGGER before_cuentas_update
BEFORE UPDATE ON cuenta
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_cuenta 
        (old_id, new_id, old_balance, new_balance, old_iban, new_iban, old_type, new_type, user_action, created_at)
    VALUES 
        (OLD.account_id, NEW.account_id, OLD.balance, NEW.balance, OLD.iban, NEW.iban, OLD.tipoCuenta, NEW.tipoCuenta, 'SE ACTUALIZO LA TABLA CUENTA', datetime('now'));
END;

UPDATE cuenta 
SET balance = balance - 100
WHERE account_id = (10, 11, 12, 13, 14);

--CONSULTA 6

CREATE INDEX idx_cliente_dni ON cliente(customer_DNI);

--CONSULTA 7

CREATE TABLE "movimientos" (
	"id"	INTEGER NOT NULL,
	"numero_cuenta"	INTEGER NOT NULL,
	"monto"	INTEGER NOT NULL,
	"tipo_operacion"	TEXT NOT NULL,
	"hora"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

--TERMINAR CONSULTA 7