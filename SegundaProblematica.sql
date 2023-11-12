/*Crear una vista con las columnas id, numero sucursal, nombre, apellido, DNI y edad de la tabla cliente calculada a partir de la fecha de nacimiento*/
CREATE VIEW Vista_Segunda_Problematica
as
Select cliente.customer_id, sucursal.branch_id, cliente.customer_name, cliente.customer_surname, cliente.customer_DNI, (date("now") - cliente.dob) as Edad from cliente
	inner join sucursal on sucursal.branch_id = cliente.branch_id

/*Mostrar las columnas de los clientes, ordenadas por el DNI de menor a mayor y cuya edad sea superior a 40 años*/
Select * from Vista_Segunda_Problematica
	where Vista_Segunda_Problematica.Edad > 40
	order by Vista_Segunda_Problematica.customer_DNI asc

Select * from Vista_Segunda_Problematica
	where Vista_Segunda_Problematica.customer_name = "Anne" or Vista_Segunda_Problematica.customer_name = "Tyler"
	order by Vista_Segunda_Problematica.Edad asc

/*Dado el siguiente JSON. Insertar 5 nuevos clientes en la base de datos y verificar que se haya realizado con éxito la inserción*/
Insert into cliente (customer_name,customer_surname,customer_DNI,branch_id,dob)
values ("Lois","Stout",47730534,80,"1984-07-07");

Insert into cliente (customer_name,customer_surname,customer_DNI,branch_id,dob)
values ("Hall","Mcconnell",52055464,45,"1968-04-30");

Insert into cliente (customer_name,customer_surname,customer_DNI,branch_id,dob)
values ("Hilel","Mclean",43625213,77,"1993-03-28");

Insert into cliente (customer_name,customer_surname,customer_DNI,branch_id,dob)
values ("Jin","Cooley",21207908,96,"1959-08-24");

Insert into cliente (customer_name,customer_surname,customer_DNI,branch_id,dob)
values ("Gabriel","Harmon",57063950,27,"1976-04-01");

/*Actualizar 5 clientes recientemente agregados en la base de datos dado que hubo un error en el JSON que traía la información, la sucursal de todos es la 10*/
Update cliente set branch_id = 10 where cliente.customer_id > ((select count(cliente.customer_id) from cliente) - 5)

/*Eliminar el registro correspondiente a “Noel David” realizando la selección por el nombre y apellido*/
delete from cliente where cliente.customer_name = "Noel" and cliente.customer_surname = "David"

/*Consultar sobre cuál es el tipo de préstamo de mayor importe*/
select prestamo.loan_type, MAX(prestamo.loan_total) AS "Mayor importe"
from prestamo
group by prestamo.loan_type
order by "Mayor importe" desc;
