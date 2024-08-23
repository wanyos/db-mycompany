use mycompany;

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
alter table articulos rename column fecha_registro to fecha_fabricacion;
alter table articulos modify column fecha_fabricacion datetime;
alter table articulos drop column name_colum;
alter table articulos change column fecha_fabricacion fecha_registro datetime not null;





















