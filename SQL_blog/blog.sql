/*1. Crear base de datos llamada blog.*/
CREATE DATABASE blog;
\c blog;
/*2. Crear las tablas indicadas de acuerdo al modelo de datos.*/
    /*Tabla usuarios*/
CREATE TABLE usuarios (
    id SERIAL,
    email VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

INSERT INTO usuarios (email) 
VALUES ('usuario01@hotmail.com'),
('usuario02@hotmail.com'),
('usuario03@hotmail.com'),
('usuario04@hotmail.com'),
('usuario05@hotmail.com'),
('usuario06@hotmail.com'),
('usuario07@hotmail.com'),
('usuario08@hotmail.com'),
('usuario09@hotmail.com');
    /*Tabla post*/
CREATE TABLE post (
    id SERIAL,
    usuario_id INT,
    titulo VARCHAR(100) NOT NULL,
    fecha DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (usuario_id) REFERENCES
    usuarios (id)
);

INSERT INTO post (usuario_id, titulo, fecha) VALUES
(1,'Post 1: Esto es malo','2020-06-29'),
(5,'Post 2: Esto es malo ','2020-06-20'),
(1,'Post 3: Esto es excelente','2020-05-30'),
(9,'Post 4: Esto es bueno','2020-05-09'),
(7,'Post 5: Esto es bueno','2020-07-10'),
(5,'Post 6: Esto es excelente','2020-07-18'),
(8,'Post 7: Esto es excelente ','2020-07-07'),
(5,'Post 8: Esto es excelente','2020-05-14'),
(2,'Post 9: Esto es bueno','2020-05-08'),
(6,'Post 10: Esto es bueno ','2020-06-02'),
(4,'Post 11: Esto es bueno','2020-05-05'),
(9,'Post 12: Esto es malo','2020-07-23'),
(5,'Post 13: Esto es excelente','2020-05-30'),
(8,'Post 14: Esto es excelente','2020-05-01'),
(7,'Post 15: Esto es malo ','2020-06-17');

    /*Tabla comentario*/
CREATE TABLE comentario (
    id SERIAL,
    usuario_id INT,
    post_id INT,
    texto VARCHAR(300),
    fecha DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (post_id) REFERENCES post(id)    
);

INSERT INTO comentario (usuario_id, post_id, texto, fecha) VALUES
(3, 6, 'Este es el comentario 1', '2020-07-08'),
(4, 2, 'Este es el comentario 2', '2020-06-07'),
(6, 4, 'Este es el comentario 3', '2020-06-16'),
(2, 13, 'Este es el comentario 4', '2020-06-15'),
(6, 6, 'Este es el comentario 5', '2020-05-14'),
(3, 3, 'Este es el comentario 6', '2020-07-08'),
(6, 1, 'Este es el comentario 7', '2020-05-22'),
(6, 7, 'Este es el comentario 8', '2020-07-09'),
(8, 13, 'Este es el comentario 9', '2020-06-30'),
(8, 6, 'Este es el comentario 10', '2020-06-19'),
(5, 1, 'Este es el comentario 11', '2020-05-09'),
(8, 15, 'Este es el comentario 12', '2020-06-17'),
(1, 9, 'Este es el comentario 13', '2020-05-01'),
(2, 5, 'Este es el comentario 14', '2020-05-31'),
(4, 3, 'Este es el comentario 15', '2020-06-28');
/*4. Seleccionar el correo, id y título de todos los post publicados por el usuario 5.*/
SELECT usuarios.id, usuarios.email, post.titulo FROM usuarios INNER JOIN post ON usuarios.id = post.usuario_id WHERE post.usuario_id = 5;

/*5. Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.*/
SELECT usuarios.id, usuarios.email, comentario.texto FROM usuarios INNER JOIN comentario ON usuarios.id = comentario.usuario_id WHERE usuarios.id <> (SELECT usuarios.id FROM usuarios WHERE usuarios.email = 'usuario06@hotmail.com');

/*6. Listar los usuarios que no han publicado ningún post.*/
SELECT usuarios.id, usuarios.email FROM usuarios LEFT JOIN post ON usuarios.id = post.usuario_id WHERE post.usuario_id IS NULL;

/*7. Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).*/
SELECT post.id, post.usuario_id, post.titulo, post.fecha, comentario.texto FROM post LEFT JOIN comentario ON post.id = comentario.post_id;

/*8. Listar todos los usuarios que hayan publicado un post en Junio.*/
SELECT usuarios.id, usuarios.email FROM usuarios INNER JOIN post ON usuarios.id = post.usuario_id WHERE post.fecha BETWEEN '2020-06-01' AND '2020-06-30';