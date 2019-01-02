-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-01-2019 a las 08:16:23
-- Versión del servidor: 8.0.13
-- Versión de PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_reproductor`
--

-- --------------------------------------------------------
CREATE DATABASE bd_reproductor CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE bd_reproductor;
--
-- Estructura de tabla para la tabla `albums`
--

CREATE TABLE `albums` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `anio` varchar(50) DEFAULT NULL,
  `numero_de_canciones` int(11) DEFAULT NULL,
  `activo` int(11) NOT NULL DEFAULT '1',
  `id_artista` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `albums`
--

INSERT INTO `albums` (`id`, `nombre`, `anio`, `numero_de_canciones`, `activo`, `id_artista`) VALUES
(1, 'Compilacion Piano Beethoven', '2000', 0, 1, 1),
(2, 'Paranoid', '1970', 0, 1, 6),
(3, 'Idea', '1968', 0, 1, 13),
(4, 'Celebridades', '2008', 0, 1, 2),
(5, 'Sam\'s Town', '2006', 0, 1, 3),
(6, 'El Triste', '1970', 1, 1, 8),
(7, 'Futura', '2015', 11, 1, 14),
(8, 'Primario', '2013', 15, 1, 14),
(9, 'Sinfonico', '2018', 28, 1, 8),
(10, 'Greatest Hits', '2011', 0, 1, 5),
(11, 'www', NULL, 1, 1, 15),
(12, 'Take Me Out', NULL, 3, 1, 16),
(13, 'asss', NULL, 1, 1, 17),
(14, 'aa', NULL, 1, 1, 18),
(15, 'Take', NULL, 1, 1, 19),
(16, 'aaaa', NULL, 1, 1, 18),
(17, 'wwwss', NULL, 1, 1, 20),
(18, 'Prueba', NULL, 1, 1, 21),
(19, '', NULL, 1, 1, 22);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artistas`
--

CREATE TABLE `artistas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `activo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `artistas`
--

INSERT INTO `artistas` (`id`, `nombre`, `activo`) VALUES
(1, 'Ludwig van Beethoven', 1),
(2, 'Jose Luis Perales', 1),
(3, 'The Killers', 1),
(4, 'Ramones', 1),
(5, 'Queen', 1),
(6, 'Black Sabbath', 1),
(7, 'Frank Sinatra', 1),
(8, 'José José', 1),
(9, 'Juan Gabriel', 1),
(10, 'Snoop Dog', 1),
(11, 'Elvis Presley', 1),
(12, 'The Beatles', 1),
(13, 'Bee Gees', 1),
(14, 'DLD', 1),
(15, 'ww', 1),
(16, 'Franz Ferdinand', 1),
(17, 'qwerta', 1),
(18, 'aa', 1),
(19, 'Franz', 1),
(20, 'trw', 1),
(21, 'prueba', 1),
(22, '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artista_genero`
--

CREATE TABLE `artista_genero` (
  `id` int(11) NOT NULL,
  `id_artista` int(11) NOT NULL,
  `id_genero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `artista_genero`
--

INSERT INTO `artista_genero` (`id`, `id_artista`, `id_genero`) VALUES
(1, 1, 1),
(13, 13, 7),
(25, 13, 7),
(6, 6, 13),
(18, 6, 13),
(10, 10, 14),
(22, 10, 14),
(3, 3, 15),
(15, 3, 15),
(7, 7, 16),
(19, 7, 16),
(9, 9, 18),
(21, 9, 18),
(4, 4, 24),
(5, 5, 24),
(12, 12, 24),
(16, 4, 24),
(17, 5, 24),
(24, 12, 24),
(26, 14, 24),
(11, 11, 25),
(23, 11, 25),
(2, 2, 30),
(8, 8, 30),
(14, 2, 30),
(20, 8, 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `canciones`
--

CREATE TABLE `canciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `duracion` varchar(45) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `activo` int(11) NOT NULL DEFAULT '1',
  `id_artista` int(11) NOT NULL,
  `id_album` int(11) NOT NULL,
  `id_genero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `canciones`
--

INSERT INTO `canciones` (`id`, `nombre`, `duracion`, `direccion`, `activo`, `id_artista`, `id_album`, `id_genero`) VALUES
(1, 'Für Elise', '2:55', 'mp3/fur elise.mp3', 1, 1, 1, 1),
(3, 'Moon Light Sonata', '3:15', 'mp3/Sabado (Por Que a Mi) -DLD.mp3', 1, 1, 1, 1),
(4, 'Me llamas', '4:36', 'mp3/Me llamas.mp3', 1, 2, 4, 30),
(5, 'Un Velero Llamado Libertad', '4:36', 'mp3/Sabado (Por Que a Mi) -DLD.mp3', 1, 2, 4, 30),
(6, 'For Reasons Unknown', '3:33', 'mp3/For Reasons Unknown - The Killers.mp3', 1, 3, 5, 15),
(7, 'When You Were Young', '3:33', 'mp3/When You Were Young - The Killers.mp3', 1, 3, 5, 15),
(8, 'Paranoid', '3:33', 'mp3/Sabado (Por Que a Mi) -DLD.mp3', 1, 6, 2, 13),
(9, 'El Triste', '4:13', 'mp3/El triste - Jose Jose.mp3', 1, 8, 6, 30),
(10, 'I Started A Joke', '3:33', 'mp3/Animal - DLD', 1, 13, 3, 7),
(11, 'Las Cruzadas', '3:46', 'mp3/Las Cruzadas - DLD', 1, 14, 7, 24),
(12, 'Estare', '3:23', 'mp3/Estare - DLD', 1, 14, 7, 24),
(13, 'Control', '3:37', 'mp3/Animal - DLD', 1, 14, 7, 24),
(14, 'Señales', '3:55', 'mp3/Animal - DLD', 1, 14, 7, 24),
(15, 'Reencuentro', '5:47', 'mp3/Animal - DLD', 1, 14, 7, 24),
(16, 'Sabado(¿Por Que a Mi?)', '3:14', 'mp3/Sabado (Por Que a Mi) -DLD.mp3', 1, 14, 7, 24),
(17, 'Nemesis', '3:53', 'mp3/Animal - DLD', 1, 14, 7, 24),
(18, 'Sigo Siendo Yo', '3:24', 'mp3/Animal - DLD', 1, 14, 7, 24),
(19, 'El Mapa de Tus Ojos', '4:42', 'mp3/Animal - DLD', 1, 14, 7, 24),
(20, 'Soy', '2:57', 'mp3/Animal - DLD', 1, 14, 7, 24),
(21, 'Nuestros Tiempos', '3:35', 'mp3/Animal - DLD', 1, 14, 7, 24),
(22, 'Animal', '3:57', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(23, 'Arsenico', '3:17', 'mp3/Arsenico - DLD.mp3', 1, 14, 8, 24),
(24, 'Sea', '3:50', 'mp3/Animal - DLD', 1, 14, 8, 24),
(25, 'Todo Cuenta', '3:53', 'mp3/Animal - DLD', 1, 14, 8, 24),
(26, 'A Distancia', '4:23', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(27, 'El Tamanio de las Cosas', '4:25', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(28, 'Cancion de Cuna', '3:58', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(29, 'Necesidad', '3:33', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(30, 'La Era Moderna', '3:21', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(31, 'Viernes', '3:52', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(32, 'Mi Voz', '3:57', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(33, 'Todo Cuenta - DOG Remix', '4:36', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(34, 'Todo Cuenta - (Panoptica Remix)', '4:47', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(35, 'Todo Cuenta - (Da Punto Beat Remix)', '4:23', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(36, 'Sea - Sussie 4 Remix', '4:41', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
(37, 'Almohada - Sinfonico', '3:31', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(38, 'Almohada - Sinfonico', '3:31', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(39, 'Me Basta - Sinfonico', '4:00', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(40, 'Lo Que No Fue No Sera - Sinfonico', '3:45', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(41, 'No Me Platiques Mas - Sinfonico', '3:53', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(42, 'Lo Dudo - Sinfonico', '3:53', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(43, 'Lagrimas - Sinfonico', '4:41', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(44, 'Lo Pasado, Pasado - Sinfonico', '4:14', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(45, '¿Y Quien Puede Ser? - Sinfonico', '3:39', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(46, 'Volcan - Sinfonico', '4:26', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(47, 'La Barca - Sinfonico', '3:46', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(48, '40 y 20 - Sinfonico', '3:53', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(49, 'Un Minuto de Amor - Sinfonico', '2:49', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(50, '¿Y Que? - Sinfonico', '3:15', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(51, 'La Nave del Olvido - Sinfonico', '3:53', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(52, 'Contigo en la Distancia - Sinfonico', '3:50', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(53, 'Desesperado - Sinfonico', '3:45', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(54, 'Sabor a Mi - Sinfonico', '3:37', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(55, 'El Triste - Sinfonico', '4:10', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(56, 'Una Mañana - Sinfonico', '2:56', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(57, 'Payaso - Sinfonico', '2:57', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(58, 'No Me Digas Que Te VaS - Sinfonico', '4:01', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(59, 'El Amor Acaba - Sinfonico', '4:14', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(60, 'Preso - Sinfonico', '3:35', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(61, 'Voy a Llenarte Toda - Sinfonico', '3:57', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(62, 'Nuestro Amor Es el Mas Bello del Mundo - Sinfonico', '3:05', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(63, 'Cruz de Olvido - Sinfonico', '3:13', 'mp3/Animal - DLD.mp3', 1, 8, 9, 30),
(64, 'Bohemian Rhapsody', '5:52', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(65, 'Another One Bite The Dust', '3:35', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(66, 'Killer Queen', '3:00', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(67, 'Fat Bottomed Girls', '3:22', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(68, 'Bicycle Race', '3:00', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(69, 'You\'re My Best Friend', '2:50', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(70, 'Don\'t Stop Me Now', '3:30', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(71, 'Save Me', '3:48', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(72, 'Crazy Little Thing Called Love', '2:43', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(73, 'Some Body to Love', '4:56', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(74, 'Now I\'m Here ', '3:10', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(75, 'Good Old-Fashioned Lover Boy', '2:53', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(76, 'Play the Game', '3:40', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(77, 'Flash', '2:48', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(78, 'Seven Seas Of Rhye', '2:40', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(79, 'We Will Rock You', '2:00', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(80, 'We Are The Champions', '3:05', 'mp3/Animal - DLD.mp3', 1, 5, 10, 24),
(81, 'Sam\'s Town', '4:06', 'mp3/Animal - DLD.mp3', 1, 3, 5, 15),
(82, 'Enterlude', '0:50', 'mp3/Animal - DLD.mp3', 1, 3, 5, 15),
(83, 'Bling(Confession of a King)', '4:08', 'mp3/Animal - DLD.mp3', 1, 3, 5, 15),
(84, 'Read My Mind', '1:34', 'mp3/Animal - DLD.mp3', 1, 3, 5, 15),
(85, 'Uncle Jonny', '2:45', 'mp3/Animal - DLD.mp3', 1, 3, 5, 15),
(86, 'Bones', '3:33', 'mp3/Animal - DLD.mp3', 1, 3, 5, 15),
(87, 'My List', '3:10', 'mp3/Animal - DLD.mp3', 1, 3, 5, 15),
(88, 'This River is Wild', '4:10', 'mp3/Animal - DLD.mp3', 1, 3, 5, 15),
(89, 'Why Do I Keep Counting', '1:27', 'mp3/Animal - DLD.mp3', 1, 3, 5, 15),
(90, 'Exitlude', '1:30', 'mp3/Animal - DLD.mp3', 1, 3, 5, 15),
(93, 'qwert', NULL, 'mp3/Franz_Ferdinand_-_Take_Me_Out3.mp3', 1, 20, 17, 1),
(94, 'cuidado', NULL, 'mp3/Cuidado1.mp3', 1, 8, 9, 30),
(95, 'Take Me Out', NULL, 'mp3/Franz_Ferdinand_-_Take_Me_Out4.mp3', 1, 16, 12, 15),
(96, 'prueba', NULL, 'mp3/Franz_Ferdinand_-_Take_Me_Out5.mp3', 1, 21, 18, 1),
(97, 'Amnesia', NULL, 'mp3/Amnesia_(Remasterizado).mp3', 1, 8, 6, 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `generos`
--

CREATE TABLE `generos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `generos`
--

INSERT INTO `generos` (`id`, `nombre`) VALUES
(1, 'Clasica'),
(3, 'Blues'),
(4, 'Corrido'),
(5, 'Country'),
(6, 'Cumbia'),
(7, 'Disco'),
(8, 'Electrónica'),
(9, 'Flamenco'),
(10, 'Folk'),
(11, 'Funk'),
(12, 'Gospel'),
(13, 'Heavy Metal'),
(14, 'Hip Hop'),
(15, 'Indie?'),
(16, 'Jazz'),
(17, 'Merengue'),
(18, 'Pop'),
(19, 'Ranchera'),
(20, 'Rap'),
(21, 'Reggae'),
(22, 'Reggaeton'),
(23, 'Rumba'),
(24, 'Rock'),
(25, 'Rock and Roll'),
(26, 'Salsa'),
(27, 'Son'),
(28, 'Soul'),
(29, 'Tango'),
(30, 'Balada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlists`
--

CREATE TABLE `playlists` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `numero_de_canciones` int(11) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `activo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `playlists`
--

INSERT INTO `playlists` (`id`, `nombre`, `numero_de_canciones`, `id_usuario`, `activo`) VALUES
(1, 'Favoritas', 2, 4, 1),
(2, 'Mis Canciones', 3, 3, 1),
(3, 'Todas', 3, 4, 1),
(7, 'Para fiesta', 3, 3, 1),
(8, 'CGMA', 1, 11, 1),
(9, 'test', 1, 11, 1),
(10, 'Mi primer playlist', 1, 13, 1),
(11, 'mis canciones', 1, 16, 1),
(12, 'sddc', 1, 16, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlist_con_canciones`
--

CREATE TABLE `playlist_con_canciones` (
  `id` int(11) NOT NULL,
  `id_playlist` int(11) NOT NULL,
  `id_cancion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `playlist_con_canciones`
--

INSERT INTO `playlist_con_canciones` (`id`, `id_playlist`, `id_cancion`) VALUES
(20, 7, 4),
(1, 1, 6),
(14, 7, 6),
(2, 1, 7),
(13, 7, 7),
(22, 8, 8),
(29, 1, 8),
(3, 2, 9),
(24, 8, 11),
(6, 2, 16),
(12, 7, 16),
(4, 2, 22),
(15, 7, 22),
(5, 2, 23),
(25, 8, 39),
(26, 8, 57),
(21, 7, 64),
(23, 8, 82),
(30, 1, 85),
(18, 1, 94),
(27, 2, 94),
(16, 1, 95),
(17, 1, 95),
(28, 10, 97);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuarios`
--

CREATE TABLE `tipo_usuarios` (
  `id` int(11) NOT NULL,
  `tipo` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_usuarios`
--

INSERT INTO `tipo_usuarios` (`id`, `tipo`) VALUES
(1, 'Administrador'),
(2, 'Usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `contrasenia` varchar(50) NOT NULL,
  `id_tipo_usuario` int(11) NOT NULL,
  `activo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `contrasenia`, `id_tipo_usuario`, `activo`) VALUES
(1, 'Hugo', '123', 1, 1),
(2, 'Hernán', '123', 1, 1),
(3, 'David', '123', 2, 1),
(4, 'Rafael', '123', 2, 1),
(10, 'prueba', '123', 1, 1),
(11, 'Efrén', '123456', 2, 1),
(12, 'Efrén Admin', '123456', 1, 1),
(13, 'pruebaUs', '123', 2, 1),
(14, 'pruebaAd', '123', 1, 1),
(15, 'prueba123', '123', 1, 1),
(16, 'prueba4', '123', 2, 0),
(17, 'PruebaD', '123', 2, 0),
(18, 'usuarioPOSTadmin', 'usuario', 2, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Album_Artista1_idx` (`id_artista`);

--
-- Indices de la tabla `artistas`
--
ALTER TABLE `artistas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `artista_genero`
--
ALTER TABLE `artista_genero`
  ADD PRIMARY KEY (`id`,`id_artista`,`id_genero`),
  ADD KEY `fk_Artista_has_Genero_Genero1_idx` (`id_genero`),
  ADD KEY `fk_Artista_has_Genero_Artista1_idx` (`id_artista`);

--
-- Indices de la tabla `canciones`
--
ALTER TABLE `canciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Cancion_Artista1_idx` (`id_artista`),
  ADD KEY `fk_Cancion_Album1_idx` (`id_album`),
  ADD KEY `fk_Cancion_Genero1_idx` (`id_genero`);

--
-- Indices de la tabla `generos`
--
ALTER TABLE `generos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `playlists`
--
ALTER TABLE `playlists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Playlist_Usuario1_idx` (`id_usuario`);

--
-- Indices de la tabla `playlist_con_canciones`
--
ALTER TABLE `playlist_con_canciones`
  ADD PRIMARY KEY (`id`,`id_playlist`,`id_cancion`),
  ADD KEY `fk_Playlist_has_Cancion_Cancion1_idx` (`id_cancion`),
  ADD KEY `fk_Playlist_has_Cancion_Playlist1_idx` (`id_playlist`);

--
-- Indices de la tabla `tipo_usuarios`
--
ALTER TABLE `tipo_usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Usuario_TipoUsuario_idx` (`id_tipo_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `albums`
--
ALTER TABLE `albums`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `artistas`
--
ALTER TABLE `artistas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `artista_genero`
--
ALTER TABLE `artista_genero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `canciones`
--
ALTER TABLE `canciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT de la tabla `generos`
--
ALTER TABLE `generos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `playlist_con_canciones`
--
ALTER TABLE `playlist_con_canciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `tipo_usuarios`
--
ALTER TABLE `tipo_usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `albums`
--
ALTER TABLE `albums`
  ADD CONSTRAINT `fk_Album_Artista1` FOREIGN KEY (`id_artista`) REFERENCES `artistas` (`id`);

--
-- Filtros para la tabla `artista_genero`
--
ALTER TABLE `artista_genero`
  ADD CONSTRAINT `fk_Artista_has_Genero_Artista1` FOREIGN KEY (`id_artista`) REFERENCES `artistas` (`id`),
  ADD CONSTRAINT `fk_Artista_has_Genero_Genero1` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`id`);

--
-- Filtros para la tabla `canciones`
--
ALTER TABLE `canciones`
  ADD CONSTRAINT `fk_Cancion_Album1` FOREIGN KEY (`id_album`) REFERENCES `albums` (`id`),
  ADD CONSTRAINT `fk_Cancion_Artista1` FOREIGN KEY (`id_artista`) REFERENCES `artistas` (`id`),
  ADD CONSTRAINT `fk_Cancion_Genero1` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`id`);

--
-- Filtros para la tabla `playlists`
--
ALTER TABLE `playlists`
  ADD CONSTRAINT `fk_Playlist_Usuario1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `playlist_con_canciones`
--
ALTER TABLE `playlist_con_canciones`
  ADD CONSTRAINT `fk_Playlist_has_Cancion_Cancion1` FOREIGN KEY (`id_cancion`) REFERENCES `canciones` (`id`),
  ADD CONSTRAINT `fk_Playlist_has_Cancion_Playlist1` FOREIGN KEY (`id_playlist`) REFERENCES `playlists` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_Usuario_TipoUsuario` FOREIGN KEY (`id_tipo_usuario`) REFERENCES `tipo_usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;