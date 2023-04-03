CREATE SCHEMA simplisoft_bd;

USE simplisoft_bd;

CREATE TABLE Users (
	id_user INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    rut VARCHAR(10) NOT NULL,
    user_name VARCHAR(50) NOT NULL,
    user_password VARCHAR(50) NOT NULL,
    email VARCHAR(80) NOT NULL,
    address VARCHAR(80) NOT NULL,
    user_status BOOLEAN,
    phone VARCHAR(50) NOT NULL,
    fk_id_role INTEGER UNSIGNED
);

ALTER TABLE Users MODIFY COLUMN user_password VARCHAR(350);


CREATE TABLE Roles (
	id_role INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
	role_name VARCHAR(50) NOT NULL
);

CREATE TABLE Tickets (
id_ticket INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
ticket_creation_date DATETIME NOT NULL,
ticket_close_date DATETIME NOT NULL,
ticket_status VARCHAR(50),
fk_id_ticketuser INTEGER UNSIGNED
);

CREATE TABLE Devices (
id_device INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT, 
device_type VARCHAR(50) NOT NULL, 
device_brand VARCHAR(50), 
device_model VARCHAR(50),
serial_number VARCHAR(50) NOT NULL,
fk_id_user INTEGER UNSIGNED
);

CREATE TABLE Orders (
id_order_service INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT, 
comment_initial TEXT,
comment_technical TEXT,
comment_client TEXT, 
files VARCHAR(100),		-- se va a colocar una url que apunte a la foto/archivo/ que queramos mostrar
status_order VARCHAR (30),
order_creation_date DATETIME,
order_close_date DATETIME,
fk_id_device INTEGER UNSIGNED,
fk_id_ticket INTEGER UNSIGNED
);
-- -------------------------------------------------------------------
-- -----  Creamos la relacion entre tablas con las Foreing Key -------
-- -------------------------------------------------------------------

-- FK de la tabla Dispositivos con Users
ALTER TABLE Devices ADD FOREIGN KEY (fk_id_user) REFERENCES Users(id_user);

-- Foreing Key a la tabla de TICKETS ---------

ALTER TABLE Tickets ADD FOREIGN KEY (fk_id_ticketuser) REFERENCES Users (id_user);

-- Foreing Key a la tabla de Orders ---------

ALTER TABLE Orders ADD FOREIGN KEY (fk_id_ticket) REFERENCES Tickets (id_ticket);

ALTER TABLE Orders ADD FOREIGN KEY (fk_id_device) REFERENCES Devices (id_device);


-- FK de la table Users con Roles
ALTER TABLE Users ADD FOREIGN KEY (fk_id_role) REFERENCES Roles(id_role);

INSERT INTO roles(role_name) VALUES 
("Administrador"),
("Técnico"),
("Cliente");
SELECT * FROM roles;
-- Ingresamos usuarios a la tabla users
INSERT INTO users(rut, user_name, user_password, email, address, user_status, phone, fk_id_role) VALUES 
("27856958-2", "Elvis", "123", "elvis@simplisoft.cl", "Santiago - Centro", "1", "+56949852412", 1),
("26856958-1", "Felipe", "123", "felipe@simplisoft.cl", "Santiago - Ñuñoa", "1", "+56949852533", 2),
("22856957-3", "Tamara", "123", "tamara@simplisoft.cl", "Santiago - Condes", "1", "+56949852123", 3);

INSERT INTO users(rut, user_name, user_password, email, address, user_status, phone, fk_id_role) VALUES 
("27854548-2", "Jesus", "123", "jesus@simplisoft.cl", "Santiago - Vitacura", "1", "+56949852785", 1),
("26856474-1", "Valeria", "123", "valeria@gmail.com", "Santiago - Calera", "1", "+56949852533", 3);
SELECT * FROM users;
SELECT * FROM users WHERE rut LIKE "27854548-2";

SELECT * FROM users INNER JOIN roles ON users.fk_id_role = roles.id_role;

INSERT INTO Tickets (ticket_creation_date, ticket_close_date, ticket_status, fk_id_ticketuser) VALUES
("2023-03-01 13:30:00", "2023-03-10 18:15:00", "Abierto" , 3),
("2023-03-15 10:22:00", "2023-03-22 17:55:00", "Cerrado" , 5);
INSERT INTO Tickets (ticket_creation_date, ticket_close_date, ticket_status, fk_id_ticketuser) VALUES
("2023-03-16 13:30:00", "2023-03-16 18:15:00", "Abierto" , 3),
("2023-03-18 10:22:00", "2023-03-18 17:55:00", "Abierto" , 5);
SELECT * FROM Tickets;

INSERT INTO devices (device_type, device_brand, device_model, serial_number, fk_id_user) VALUES
("celular", "Iphone", "Iphone 11", "NKS4258", 3),
("televisor", "Samsung", "au700", "SUM845", 5),
("celular", "Iphone", "Iphone 11", "NKS41258", 3),
("celular", "Xiaomi", "Xiaomi Redmi Note 11", "L1D598", 5),
("radio", "Sony", "icf-19", "ALOD418", 5),
("televisor", "LG", "LG8000", "OE8SE",  5);
SELECT * FROM devices;

INSERT INTO Orders (comment_initial, comment_technical, comment_client, files, status_order, order_creation_date, order_close_date, fk_id_device, fk_id_ticket) VALUES
("Pantalla rota","Se realiza cambio de pantalla y limpieza de componente sulfatados","Se realiza cambio de pantalla y limpieza a mainboard","google.com","Reparado","2023-02-10 17:15:25","2023-02-12 17:15:25",1,1),
("TV no enciende","Se realiza limpieza de componente sulfatados","Se realiza soldadura a etapa de alimentacion","youtube.com","En reparación","2023-02-12 17:15:25","2023-02-15 17:15:25",2,2),
("Sin wifi","Se sustituye módulo wifi","Se deja operativo con módulo wifi nuevo","youtube.com","reparado","2023-03-16 13:30:00", "2023-03-16 18:15:00",3,3),
("Sin wifi","Se sustituye módulo wifi","Se deja operativo con módulo wifi nuevo","youtube.com","reparado","2023-03-18 10:22:00", "2023-03-18 17:55:00",4,4),
("Sin Recepcion","Se sustituye módulo Rx","Se deja operativo con módulo Rx nuevo","generation.com","Sin Revisar","2023-03-18 10:22:00", "2023-03-18 17:55:00",5,4),
("Sin Recepcion","Se sustituye módulo Rx","Se deja operativo con módulo Rx nuevo","generation.com","Sin Revisar","2023-03-18 10:22:00", "2023-03-18 17:55:00",6,4);

INSERT INTO Orders (comment_initial, comment_technical, comment_client, files, status_order, order_creation_date, order_close_date, fk_id_device, fk_id_ticket) VALUES
("Pantalla rota","Se realiza limpieza de componente sulfatados","Se realiza limpieza a mainboard","google.com","Reparado","2023-02-10 17:15:25","2023-02-12 17:15:25",1,1),
("TV no enciende","Se realiza limpieza de componente sulfatados","Se realiza soldadura a etapa de alimentacion","youtube.com","En reparación","2023-02-12 17:15:25","2023-02-15 17:15:25",1,1),
("Sin wifi","Se sustituye módulo wifi","Se deja operativo con módulo wifi nuevo","youtube.com","reparado","2023-03-16 13:30:00", "2023-03-16 18:15:00",3,3);

SELECT * FROM Users;

-- Query para buscar los dispositivos asociados a un username.


-- Query para buscar todos los id_tickets asociados a un username
SELECT Tickets.id_ticket FROM Tickets INNER JOIN Users ON Tickets.fk_id_ticketuser = Users.id_user WHERE Users.user_name LIKE "Valeria";

-- Query para buscar los tickets asociados a un username
SELECT Tickets.id_ticket, Tickets.ticket_creation_date, Tickets.ticket_close_date, Tickets.ticket_status, Tickets.fk_id_ticketuser FROM Tickets 
INNER JOIN Users ON Tickets.fk_id_ticketuser = Users.id_user WHERE Users.user_name LIKE "Valeria";

-- Query para buscar los equipos asociados a un username
SELECT devices.device_type, devices.device_brand, devices.device_model, devices.serial_number, devices.fk_id_user FROM devices
INNER JOIN Users ON Users.id_user = devices.fk_id_user WHERE Users.user_name LIKE "Valeria";

-- Query para saber la cantidad de Tickets totales
SELECT COUNT(*) FROM Tickets;

-- Query para saber la cantidad de Tickets por status
SELECT COUNT(*) FROM Tickets WHERE Tickets.ticket_status LIKE "Cerrado";

-- Query para saber la cantidad de Tickets asociado a un username
SELECT COUNT(*) FROM Tickets INNER JOIN Users ON Users.id_user =Tickets.fk_id_ticketuser WHERE Users.user_name LIKE "Valeria";

-- Query para saber la cantidad de equipos asociados a un username
SELECT COUNT(*) FROM Devices INNER JOIN Users ON Users.id_user = Devices.fk_id_user WHERE  Users.user_name LIKE "Elvis";

-- Query que retorna el equipo asociado a una orden a través del id_order_service
SELECT * FROM Devices INNER JOIN Orders ON Devices.id_device = Orders.fk_id_device WHERE Orders.id_order_service LIKE 11;

-- Query que retorna los equipos asociados distintas órdenes a través del id_order_service
SELECT Devices.id_device, Devices.device_type, Devices.device_brand, Devices.device_model, Devices.serial_number FROM Devices 
INNER JOIN Orders ON Devices.id_device = Orders.fk_id_device WHERE Orders.id_order_service IN(9,10,11);

-- Query que retorna la orden asociada a un ticket
SELECT Orders.id_order_service, Orders.comment_initial, Orders.comment_technical, Orders.comment_client, Orders.files, Orders.status_order, Orders.order_creation_date, Orders.order_close_date 
FROM Orders INNER JOIN Tickets ON Orders.fk_id_ticket  = Tickets.id_ticket WHERE Tickets.id_ticket LIKE 1;

-- Query que retorna los id_order asociados a un ticket

SELECT Orders.id_order_service FROM Orders INNER JOIN Tickets ON Orders.fk_id_ticket  = Tickets.id_ticket WHERE Tickets.id_ticket LIKE 1;

SELECT COUNT(*) FROM Users;
SELECT * FROM Users;

SELECT COUNT(*) FROM Users INNER JOIN Roles ON Users.fk_id_role = Roles.id_role WHERE Roles.role_name LIKE "Técnico";

SELECT Users.id_user, Users.rut, Users.user_name, Users.user_password, Users.email, Users.address, Users.user_status, Users.phone, Users.fk_id_role FROM Users 
INNER JOIN Roles ON Users.fk_id_role = Roles.id_role WHERE Roles.role_name LIKE "Cliente";