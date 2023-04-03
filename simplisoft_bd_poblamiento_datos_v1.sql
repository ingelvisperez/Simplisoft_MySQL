USE simplisoft_bd

INSERT INTO roles(role_name) VALUES 
("Administrador"),
("Técnico"),
("Cliente");

INSERT INTO users(rut, user_name, user_password, email, address, user_status, phone, fk_id_role) VALUES 
("27856958-2", "Elvis", "123", "elvis@simplisoft.cl", "Santiago - Centro", "1", "+56949852412", 1),
("26856958-1", "Felipe", "123", "felipe@simplisoft.cl", "Santiago - Ñuñoa", "1", "+56949852533", 2),
("22856957-3", "Tamara", "123", "tamara@simplisoft.cl", "Santiago - Condes", "1", "+56949852123", 3);