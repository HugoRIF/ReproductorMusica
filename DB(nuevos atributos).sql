-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-11-2018 a las 01:05:21
-- Versión del servidor: 10.1.36-MariaDB
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
-- Base de datos: `dbrep`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `album`
--

CREATE TABLE `album` (
  `id` int(11) NOT NULL,
  `nombreAlbum` varchar(50) NOT NULL,
  `añoAlbum` varchar(50) DEFAULT NULL,
  `numCancAlbum` int(11) DEFAULT NULL,
  `activo` int(11) NOT NULL DEFAULT '1',
  `idArtista` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `album`
--

INSERT INTO `album` (`id`, `nombreAlbum`, `añoAlbum`, `numCancAlbum`, `activo`, `idArtista`) VALUES
(1, 'Compilacion Piano Beethoven', '2000', 0, 1, 1),
(2, 'Paranoid', '1970', 0, 1, 6),
(3, 'Idea', '1968', 0, 1, 13),
(4, 'Celebridades', '2008', 0, 1, 2),
(5, 'Sam\'s Town', '2006', 0, 1, 3),
(6, 'El Triste', '1970', 0, 1, 8),
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
(18, 'Prueba', NULL, 1, 1, 21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artista`
--

CREATE TABLE `artista` (
  `id` int(11) NOT NULL,
  `nombreArtista` varchar(100) NOT NULL,
  `activo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `artista`
--

INSERT INTO `artista` (`id`, `nombreArtista`, `activo`) VALUES
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
(21, 'prueba', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artista_genero`
--

CREATE TABLE `artista_genero` (
  `id` int(11) NOT NULL,
  `idArtista` int(11) NOT NULL,
  `idGenero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `artista_genero`
--

INSERT INTO `artista_genero` (`id`, `idArtista`, `idGenero`) VALUES
(1, 1, 1),
(2, 2, 30),
(3, 3, 15),
(4, 4, 24),
(5, 5, 24),
(6, 6, 13),
(7, 7, 16),
(8, 8, 30),
(9, 9, 18),
(10, 10, 14),
(11, 11, 25),
(12, 12, 24),
(13, 13, 7),
(14, 2, 30),
(15, 3, 15),
(16, 4, 24),
(17, 5, 24),
(18, 6, 13),
(19, 7, 16),
(20, 8, 30),
(21, 9, 18),
(22, 10, 14),
(23, 11, 25),
(24, 12, 24),
(25, 13, 7),
(26, 14, 24);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cancion`
--

CREATE TABLE `cancion` (
  `id` int(11) NOT NULL,
  `nombreCancion` varchar(50) NOT NULL,
  `duracionCancion` varchar(45) DEFAULT NULL,
  `direccionCancion` varchar(100) DEFAULT NULL,
  `activo` int(11) NOT NULL DEFAULT '1',
  `idArtista` int(11) NOT NULL,
  `idAlbum` int(11) NOT NULL,
  `idGenero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cancion`
--

INSERT INTO `cancion` (`id`, `nombreCancion`, `duracionCancion`, `direccionCancion`, `activo`, `idArtista`, `idAlbum`, `idGenero`) VALUES
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
(27, 'El Tamaño de las Cosas', '4:25', 'mp3/Animal - DLD.mp3', 1, 14, 8, 24),
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
(96, 'prueba', NULL, 'mp3/Franz_Ferdinand_-_Take_Me_Out5.mp3', 1, 21, 18, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

CREATE TABLE `genero` (
  `id` int(11) NOT NULL,
  `nombreGenero` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `genero`
--

INSERT INTO `genero` (`id`, `nombreGenero`) VALUES
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
(15, 'Indie​'),
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
-- Estructura de tabla para la tabla `playlist`
--

CREATE TABLE `playlist` (
  `id` int(11) NOT NULL,
  `nombrePlaylist` varchar(50) NOT NULL,
  `numCancPlaylist` int(11) DEFAULT NULL,
  `idUsuario` int(11) NOT NULL,
  `activo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `playlist`
--

INSERT INTO `playlist` (`id`, `nombrePlaylist`, `numCancPlaylist`, `idUsuario`, `activo`) VALUES
(1, 'Favoritas', 2, 4, 1),
(2, 'Mis Canciones', 3, 3, 1),
(3, 'Todas', 3, 4, 1),
(7, 'Para fiesta', 3, 3, 1),
(8, 'CGMA', 1, 11, 1),
(9, 'test', 1, 11, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlist_cancion`
--

CREATE TABLE `playlist_cancion` (
  `id` int(11) NOT NULL,
  `idPlaylist` int(11) NOT NULL,
  `idCancion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `playlist_cancion`
--

INSERT INTO `playlist_cancion` (`id`, `idPlaylist`, `idCancion`) VALUES
(1, 1, 6),
(2, 1, 7),
(3, 2, 9),
(4, 2, 22),
(5, 2, 23),
(6, 2, 16),
(12, 7, 16),
(13, 7, 7),
(14, 7, 6),
(15, 7, 22),
(16, 1, 95),
(17, 1, 95),
(18, 1, 94),
(20, 7, 4),
(21, 7, 64),
(22, 8, 8),
(23, 8, 82),
(24, 8, 11),
(25, 8, 39),
(26, 8, 57),
(27, 2, 94);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipousuario`
--

CREATE TABLE `tipousuario` (
  `id` int(11) NOT NULL,
  `nombreTipoUsuario` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipousuario`
--

INSERT INTO `tipousuario` (`id`, `nombreTipoUsuario`) VALUES
(1, 'Administrador'),
(2, 'Usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombreUsuario` varchar(50) NOT NULL,
  `contraUsuario` varchar(50) NOT NULL,
  `idTipoUsuario` int(11) NOT NULL,
  `activo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombreUsuario`, `contraUsuario`, `idTipoUsuario`, `activo`) VALUES
(1, 'Hugo', '123', 1, 1),
(2, 'Hernán', '123', 1, 1),
(3, 'David', '123', 2, 1),
(4, 'Rafael', '123', 2, 1),
(10, 'prueba', '123', 1, 1),
(11, 'Efrén', '123456', 2, 1),
(12, 'Efrén Admin', '123456', 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Album_Artista1_idx` (`idArtista`);

--
-- Indices de la tabla `artista`
--
ALTER TABLE `artista`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `artista_genero`
--
ALTER TABLE `artista_genero`
  ADD PRIMARY KEY (`id`,`idArtista`,`idGenero`),
  ADD KEY `fk_Artista_has_Genero_Genero1_idx` (`idGenero`),
  ADD KEY `fk_Artista_has_Genero_Artista1_idx` (`idArtista`);

--
-- Indices de la tabla `cancion`
--
ALTER TABLE `cancion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Cancion_Artista1_idx` (`idArtista`),
  ADD KEY `fk_Cancion_Album1_idx` (`idAlbum`),
  ADD KEY `fk_Cancion_Genero1_idx` (`idGenero`);

--
-- Indices de la tabla `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Playlist_Usuario1_idx` (`idUsuario`);

--
-- Indices de la tabla `playlist_cancion`
--
ALTER TABLE `playlist_cancion`
  ADD PRIMARY KEY (`id`,`idPlaylist`,`idCancion`),
  ADD KEY `fk_Playlist_has_Cancion_Cancion1_idx` (`idCancion`),
  ADD KEY `fk_Playlist_has_Cancion_Playlist1_idx` (`idPlaylist`);

--
-- Indices de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Usuario_TipoUsuario_idx` (`idTipoUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `album`
--
ALTER TABLE `album`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `artista`
--
ALTER TABLE `artista`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `artista_genero`
--
ALTER TABLE `artista_genero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `cancion`
--
ALTER TABLE `cancion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT de la tabla `genero`
--
ALTER TABLE `genero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `playlist`
--
ALTER TABLE `playlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `playlist_cancion`
--
ALTER TABLE `playlist_cancion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `album`
--
ALTER TABLE `album`
  ADD CONSTRAINT `fk_Album_Artista1` FOREIGN KEY (`idArtista`) REFERENCES `artista` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `artista_genero`
--
ALTER TABLE `artista_genero`
  ADD CONSTRAINT `fk_Artista_has_Genero_Artista1` FOREIGN KEY (`idArtista`) REFERENCES `artista` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Artista_has_Genero_Genero1` FOREIGN KEY (`idGenero`) REFERENCES `genero` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cancion`
--
ALTER TABLE `cancion`
  ADD CONSTRAINT `fk_Cancion_Album1` FOREIGN KEY (`idAlbum`) REFERENCES `album` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Cancion_Artista1` FOREIGN KEY (`idArtista`) REFERENCES `artista` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Cancion_Genero1` FOREIGN KEY (`idGenero`) REFERENCES `genero` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `playlist`
--
ALTER TABLE `playlist`
  ADD CONSTRAINT `fk_Playlist_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `playlist_cancion`
--
ALTER TABLE `playlist_cancion`
  ADD CONSTRAINT `fk_Playlist_has_Cancion_Cancion1` FOREIGN KEY (`idCancion`) REFERENCES `cancion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Playlist_has_Cancion_Playlist1` FOREIGN KEY (`idPlaylist`) REFERENCES `playlist` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_Usuario_TipoUsuario` FOREIGN KEY (`idTipoUsuario`) REFERENCES `tipousuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
