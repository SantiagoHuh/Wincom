create database wincom;
use wincom;
drop database wincom;

create table empresa (
	IdEmpresa int(10) not null auto_increment,
    Nombre varchar(150) not null,
    Categoria varchar (40) not null,
    Telefono varchar(60),
    Direccion text not null,
    primary key(idEmpresa)
) engine = InnoDB;

create table usuarios ( 
  IdUsuario int(10) not null auto_increment,
  IdEmpresa int(10) not null,
  Nombres varchar(30) not null,
  ApellidoPa varchar(30) not null,
  ApellidoMa varchar(30) not null,
  Email varchar(250) not null,
  password varchar(10) not null,
  foreign key (IdEmpresa) references empresa(IdEmpresa),
  primary key  (IdUsuario) 
);

create table categoria (
IdCategoria int (10) not null auto_increment,
IdEmpresa int(10) not null,
Nombre text,
foreign key (IdEmpresa) references empresa(IdEmpresa),
primary key (IdCategoria)
)engine = InnoDB;

create table producto(
	IdProducto varchar (20) not null, /*varchar*/
    Nombre varchar(30) not null,
    IdCategoria int(10),
    Descripcion text,
    Precio float(30) not null,
    Porcentaje float(40) not null,
    foreign key (IdCategoria) references categoria(IdCategoria),
    primary key (idProducto)
) engine = InnoDB;

create table VentaUsuario(
	IdProducto char (20) not null,
    Nombre varchar(30) not null,
    Precio char(10) not null,
    Descripcion varchar(200),
    FolioComprobante char (18) not null,
    PorcentajeGanado char(40) not null,
    foreign key (IdProducto) references producto(IdProducto)
) engine = InnoDB;

drop trigger if exists ´idmayusproducto´;
delimiter //
create trigger idmayusproducto before insert on producto
for each row
	begin
	set new.nombre = upper(new.nombre);
    end;//
delimiter ;

drop trigger if exists ´idmayusempresa´;
delimiter //
create trigger idmayusempresa before insert on empresa
for each row
	begin
    set new.nombre = upper(new.nombre);
    end;//
delimiter ;

drop trigger if exists ´mayusventausuario´;
delimiter //
create trigger mayususerfree before insert on ventausuario
for each row
	begin
        set new.nombre = upper(new.nombre);
    end;//
delimiter ;

drop trigger if exists ´salto_vocal´;
delimiter //
create trigger salto_vocal before insert on producto
for each row
	begin
    set new.IdProducto = upper(left(replace(replace(replace(replace(
    replace(new.nombre,"u",""),"o",""),"i",""),"e",""),"a",""),5));
    end;//
delimiter ;

create view comisiones as select idproducto, nombre, precio, porcentajeganado from ventausuario;
create index busUsuarios on wincom.usuarios(Nombres, ApellidoPa, ApellidoMa, email);
create index busProducto on wincom.producto (IdProducto, Nombre, precio);
show index from wincom.producto;

insert into empresa values (1,'Telcel','Celulares','123456789','Diag. 85');
insert into categoria values (1, 1, 'Tecnologia');
insert into producto values (1,'Samsung',1,'Telefono nuevo','80.00','15%');
insert into usuarios values (1,1,'Santiago Ayran', 'Huh', 'Can', 'ayrancan619@gmail.com','sahc');
insert into ventausuario values ('SAMSU','Samsung','80.00','venta de la semana','234566543','15%');
select * from ventausuario;
select * from comisiones;
delete ventausuario from ventausuario where IdProducto = 'samsu';

select * from ventausuario;
/*crear index en la tabla usuario en la columna nombre, apellidos, correo*/
/*select * from producto;
select * from comisiones;

drop table tablefree;*/