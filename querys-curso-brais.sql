use mycompany;use mycompany;

select * from datos_clientes;
select * from clientes order by saldo;
select * from clientes order by saldo desc;
select * from datos_clientes where email="juan@mail.com" order by edad;
select * from datos_clientes where email like '%gmail.com';
select * from datos_clientes where nombre like 'juan%';
select * from datos_clientes where email like '%@%';
select * from datos_clientes where not email = 'juan@mail.com';    #and, not, or
select * from datos_clientes limit 2;
select * from datos_clientes where email is null;
select * from datos_clientes where email is not null;
select max(edad) from datos_clientes;
select count(*) from datos_clientes;
select count(edad) from datos_clientes;
select sum(edad) from datos_clientes;
select avg(edad) from datos_clientes;
select * from datos_clientes where nombre in('juanjo', 'david');
select * from datos_clientes where edad between 20 and 45;
select nombre as 'dentro del rango' from datos_clientes where edad between 40 and 45;
select concat(nombre, ' ', apellidos) from datos_clientes;
select max(edad) from datos_clientes group by edad;
select count(edad) from datos_clientes having count(edad) > 2;  #limita el total de count edad

select *,
case
	when edad > 45 then 'es muy mayor' #se pueden poner mas when como si fueran if
	else 'no es mayor'
end as edadText
from datos_clientes;

select nombre, apellidos, edad, ifnull(edad, 0) as nueva_edad from datos_clientes; #si hay algun valor null pone 0 


# insert
insert into direcciones (calle, numero, comunidad, ciudad) values ('colombia', 33, 'madrid', 'fuenlabrada');
insert into datos_clientes (nombre, apellidos, direccion, telefono, email, edad) values ('juanjo', 'romero ramos', 5, '615 615 529', 'juanjor@gmail.com', 50);


# update
update datos_clientes set edad = 45 where id = 10;
update datos_clientes set edad=46, apellidos='romero ramo' where id=10;

# delete
delete from datos_clientes where id=10;
select * from datos_clientes;

# drop table
create table aux (id int primary key, name varchar(10) unique, last varchar(12));
show tables;
drop table aux;

# alter table
show create table articulos;
alter table articulos add fecha_registro date;
-- alter table articulos rename column fecha_registro to fecha_fabricacion;
alter table articulos modify column fecha_fabricacion datetime;
alter table articulos drop column name_colum;
alter table articulos change column fecha_fabricacion fecha_registro datetime not null;


# inner join
-- nos trae todos los datos de la primera tabla con todos los datos de la segunda tabla
-- por cada entrada de la primera tabla recorre todo de la segunda. Se suele usar en relaciones 1:1
select * from clientes inner join datos_clientes;
select * from clientes inner join datos_clientes on clientes.id_cliente = datos_clientes.id; -- cada entrada de clientes trae los datos del cliente
select * from clientes inner join datos_clientes on clientes.id_cliente = datos_clientes.id order by edad asc;

select * from articulos inner join fabricas on articulos.fabrica = fabricas.id; -- relacion 1:N
select * from pedidos 
	inner join cabeceras on pedidos.cabecera = cabeceras.id_cliente
    inner join cuerpos on pedidos.cuerpo = cuerpos.id_articulo; -- relacion N.N

# left join
-- obtenemos todos los datos de la tabla de la izquierda, tenga datos de la otra tabla o no los tenga
select * from clientes left join datos_clientes on clientes.id_cliente = datos_clientes.id;
select * from datos_clientes left join clientes on datos_clientes.id = clientes.id_cliente;
select * from pedidos left join cabeceras on pedidos.cabecera = cabeceras.id_cliente left join cuerpos on pedidos.cuerpo = cuerpos.id_articulo;
-- el right join es igual que el left join

#  union (full join)
select id_articulo as art from cuerpos union select nombre from fabricas;

# index
-- los indices repercuten en el rendimiento de la base datos
-- se usa indice en aquel o aquellos campos de busqueda que vamos a usar con frecuencia. Buscara mas rapido con un indice
create index idx_name on datos_clientes(nombre);
create index idx_name_last on datos_clientes(nombre, apellidos);
drop index idx_name on datos_clientes;

# triggers
-- en los values se ponen los campos de la tabla datos_clientes, ya sean nuevos o viejos con old
delimiter -
create trigger tg_historico 
after insert on datos_clientes 
for each row  
begin 
	insert into historico_clientes (id_cliente, fecha_registro, email, hora_registro) values (new.id, curdate(), new.email, curtime()); 
end;
-
delimiter ;

drop trigger name;


# fechas y horas
SELECT DATE(NOW()) AS fecha, CURDATE() AS fecha2; -- fecha sistema
SELECT TIME(NOW()) hora, CURTIME() hora2; -- hora sistema
SELECT EXTRACT(DAY FROM fecha) AS dia FROM cabeceras; -- extrae el dia del campo fecha
SELECT EXTRACT(MONTH FROM fecha) AS mes FROM cabeceras; -- extrae el mes del campo fecha
SELECT EXTRACT(YEAR FROM fecha) AS año, EXTRACT(MONTH FROM fecha) AS mes FROM cabeceras; -- extrae el año y el mes campo fecha


# views
create view v_clientes_edad as select nombre, edad from datos_clientes where edad >= 45;
select * from v_clientes_edad; -- se usa cuando va ha ser una consulta constante, es mas rapido con una view
drop view name;


# stored procedure
delimiter -
create procedure p_all_users()
begin
	select * from datos_clientes;
end; -

delimiter -
create procedure p_edad_users(in edad_param int)
begin
	select * from datos_clientes where edad >= edad_param;
end; -

call p_all_users();
call p_edad_users(47);

drop procedure p_edad_users;


# transaction
start transaction;
set autocommit = 0; # las instrucciones se guardan de forma temporal
	insert into fabricas (id, nombre, telefono) values (4, 'clicar', '014 456 456');
	SET @new_id = (SELECT id FROM fabricas WHERE nombre = 'clicar' ORDER BY id DESC LIMIT 1);
		SELECT @new_id AS 'Nuevo ID';
        
SET @should_commit = IF(@new_id IS NOT NULL, 1, 0);
SELECT IF(@should_commit = 1, 'Committing transaction', 'Rolling back transaction') AS Action;
SELECT IF(@should_commit = 1, 'COMMIT', 'ROLLBACK') INTO @action;

# concurrencia

# sql injection
 # no dejar concatenar string a una query hecha con cualquier conector de otro lenguaje
 # todos los conectores tienen mecanismos para evitar la posibilidad de concatenar string de los parametros














