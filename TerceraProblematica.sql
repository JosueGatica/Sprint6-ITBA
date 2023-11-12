/*Seleccionar las cuentas con saldo negativo*/
Select * from cuenta 
	where cuenta.balance < 0;

/*Seleccionar el nombre, apellido y edad de los clientes que tengan en el apellido la letra Z*/
Select customer_name,customer_surname, (date("Now") - cliente.dob) as Edad from cliente
	where UPPER(customer_surname) LIKE '%Z%';

/*Seleccionar el nombre, apellido, edad y nombre de sucursal de las personas cuyo nombre sea “Brendan” y el resultado ordenarlo por nombre de sucursal*/
Select customer_name,customer_surname, (date("Now") - cliente.dob) as Edad, sucursal.branch_name from cliente
	inner join sucursal on sucursal.branch_id = cliente.branch_id
	where UPPER(customer_name) = 'BRENDAN'
	order by sucursal.branch_name;

/*Seleccionar de la tabla de préstamos, los préstamos con un importe mayor a $80.000 y los préstamos prendarios utilizando la unión de tablas/consultas (recordar que en las bases de datos la moneda se guarda como integer, en este caso con 2 centavos)*/
Select * from prestamo
	where prestamo.loan_total > 8000000
UNION
Select * from prestamo
	where prestamo.loan_type = "PRENDARIO"

/*Seleccionar los prestamos cuyo importe sea mayor que el importe medio de todos los prestamos*/
Select *
    from prestamo
    where prestamo.loan_total > (Select AVG(loan_total) from prestamo);

/*Contar la cantidad de clientes menores a 50 años*/
Select count(*) as "Menores de 50 años"  from cliente
	where (date("Now") - cliente.dob) < 50;

/*Seleccionar las primeras 5 cuentas con saldo mayor a 8.000$*/
Select * from cuenta
	where cuenta.balance > 8000
	order by cuenta.balance DESC --saldo mayor arriba
	limit 5

Select * from cuenta
	where cuenta.balance > 8000
	order by cuenta.balance
	limit 5

/*Seleccionar los préstamos que tengan fecha en abril, junio y agosto, ordenándolos por importe*/
Select *
    from prestamo
    where strftime('%m', prestamo.loan_date) IN ('04', '06', '08')
    order by prestamo.loan_total;

/*Obtener el importe total de los prestamos agrupados por tipo de préstamos. Por cada tipo de préstamo de la tabla préstamo, calcular la suma de sus importes. Renombrar la columna como loan_total_accu*/
Select prestamo.loan_type, sum(prestamo.loan_total) as loan_total_accun from prestamo
	GROUP by prestamo.loan_type