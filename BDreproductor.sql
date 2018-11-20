
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DBrep
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DBrep
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `DBrep` DEFAULT CHARACTER SET utf8;
USE `DBrep` ;

-- -----------------------------------------------------
-- Table `DBrep`.`TipoUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBrep`.`TipoUsuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombreTipoUsuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBrep`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBrep`.`Genero` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombreGenero` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBrep`.`Artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBrep`.`Artista` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombreArtista` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBrep`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBrep`.`Usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombreUsuario` VARCHAR(50) NOT NULL,
  `contraUsuario` VARCHAR(50) NOT NULL,
  `idTipoUsuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Usuario_TipoUsuario_idx` (`idTipoUsuario` ASC),
  CONSTRAINT `fk_Usuario_TipoUsuario`
    FOREIGN KEY (`idTipoUsuario`)
    REFERENCES `DBrep`.`TipoUsuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBrep`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBrep`.`Playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombrePlaylist` VARCHAR(50) NOT NULL,
  `numCancPlaylist` INT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Playlist_Usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_Playlist_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `DBrep`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBrep`.`Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBrep`.`Album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombreAlbum` VARCHAR(50) NOT NULL,
  `añoAlbum` DATE NULL,
  `numCancAlbum` INT NULL,
  `idArtista` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Album_Artista1_idx` (`idArtista` ASC),
  CONSTRAINT `fk_Album_Artista1`
    FOREIGN KEY (`idArtista`)
    REFERENCES `DBrep`.`Artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBrep`.`Cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBrep`.`Cancion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombreCancion` VARCHAR(50) NOT NULL,
  `duracionCancion` VARCHAR(45) NULL,
  `direccionCancion` VARCHAR(100) NULL,
  `idArtista` INT NOT NULL,
  `idAlbum` INT NOT NULL,
  `idGenero` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Cancion_Artista1_idx` (`idArtista` ASC),
  INDEX `fk_Cancion_Album1_idx` (`idAlbum` ASC),
  INDEX `fk_Cancion_Genero1_idx` (`idGenero` ASC),
  CONSTRAINT `fk_Cancion_Artista1`
    FOREIGN KEY (`idArtista`)
    REFERENCES `DBrep`.`Artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cancion_Album1`
    FOREIGN KEY (`idAlbum`)
    REFERENCES `DBrep`.`Album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cancion_Genero1`
    FOREIGN KEY (`idGenero`)
    REFERENCES `DBrep`.`Genero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DBrep`.`Playlist_Cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBrep`.`Playlist_Cancion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idPlaylist` INT NOT NULL,
  `idCancion` INT NOT NULL,
  PRIMARY KEY (`id`, `idPlaylist`, `idCancion`),
  INDEX `fk_Playlist_has_Cancion_Cancion1_idx` (`idCancion` ASC),
  INDEX `fk_Playlist_has_Cancion_Playlist1_idx` (`idPlaylist` ASC),
  CONSTRAINT `fk_Playlist_has_Cancion_Playlist1`
    FOREIGN KEY (`idPlaylist`)
    REFERENCES `DBrep`.`Playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlist_has_Cancion_Cancion1`
    FOREIGN KEY (`idCancion`)
    REFERENCES `DBrep`.`Cancion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBrep`.`Artista_nombreGenero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBrep`.`Artista_Genero` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idArtista` INT NOT NULL,
  `idGenero` INT NOT NULL,
  PRIMARY KEY (`id`, `idArtista`, `idGenero`),
  INDEX `fk_Artista_has_Genero_Genero1_idx` (`idGenero` ASC),
  INDEX `fk_Artista_has_Genero_Artista1_idx` (`idArtista` ASC),
  CONSTRAINT `fk_Artista_has_Genero_Artista1`
    FOREIGN KEY (`idArtista`)
    REFERENCES `DBrep`.`Artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artista_has_Genero_Genero1`
    FOREIGN KEY (`idGenero`)
    REFERENCES `DBrep`.`Genero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- ----------------------------------------------------
-- Haciendo los insert en el catalogo nombreGeneros
-- -----------------------------------------------------
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Clasica");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Blues");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Corrido");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Country");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Cumbia");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Disco");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Electrónica");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Flamenco");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Folk");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Funk");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Gospel");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Heavy Metal");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Hip Hop");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Indie​");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Jazz​");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Merengue");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Pop");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Ranchera");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Rap");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Reggae");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Reggaeton");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Rumba");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Rock");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Rock and Roll");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Salsa");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Son");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Soul");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Tango");
INSERT INTO `Genero`(`nombreGenero`) VALUES ("Balada");
-- ----------------------------------------------------
-- Haciendo los insert en el catalogo Tipo de Usuarios
-- -----------------------------------------------------
INSERT INTO `TipoUsuario` (`nombreTipoUsuario`) VALUES ("Administrador");
InSERT INTO `TipoUsuario` (`nombreTipoUsuario`) VALUES ("Usuario");
-- ----------------------------------------------------
-- Haciendo los inserts de Artistas
-- -----------------------------------------------------
INSERT INTO `Artista`(`nombreArtista`) VALUES ("Ludwig van Beethoven");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("Jose Luis Perales");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("The Killers");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("Ramones");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("Queen");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("Black Sabbath");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("Frank Sinatra");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("José José");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("Juan Gabriel");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("Snoop Dog");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("Elvis Presley");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("The Beatles");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("Bee Gees");
INSERT INTO `Artista`(`nombreArtista`) VALUES ("DLD");

-- ----------------------------------------------------
-- Haciendo los inserts de Albunes
-- -----------------------------------------------------
INSERT INTO `Album`(`nombreAlbum`,`añoAlbum`,`numCancAlbum`,`idArtista`) 
      VALUES ("Compilacion Piano Beethoven","2000",0,(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Ludwig van Beethoven")
        );
INSERT INTO `Album`(`nombreAlbum`,`añoAlbum`,`numCancAlbum`,`idArtista`) 
      VALUES ("Paranoid","1970",0,(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Black Sabbath")
        );
INSERT INTO `Album`(`nombreAlbum`,`añoAlbum`,`numCancAlbum`,`idArtista`) 
      VALUES ("Idea","1968",0,(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Bee Gees")
        );

INSERT INTO `Album`(`nombreAlbum`,`añoAlbum`,`numCancAlbum`,`idArtista`) 
      VALUES ("Celebridades","2008",0,(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Jose Luis Perales")
        );
INSERT INTO `Album`(`nombreAlbum`,`añoAlbum`,`numCancAlbum`,`idArtista`) 
      VALUES ("Sam's Town","2006",0,(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers")
        );
INSERT INTO `Album`(`nombreAlbum`,`añoAlbum`,`numCancAlbum`,`idArtista`) 
      VALUES ("El Triste","1970",0,(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José")
        );
INSERT INTO `Album`(`nombreAlbum`,`añoAlbum`,`numCancAlbum`,`idArtista`) 
      VALUES ("Futura","2015",0,(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD")
        );
INSERT INTO `Album`(`nombreAlbum`,`añoAlbum`,`numCancAlbum`,`idArtista`) 
      VALUES ("Primario","2013",15,(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD")
        );
INSERT INTO `Album`(`nombreAlbum`,`añoAlbum`,`numCancAlbum`,`idArtista`) 
      VALUES ("Sinfonico","2018",26,(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José")
        );
INSERT INTO `Album`(`nombreAlbum`,`añoAlbum`,`numCancAlbum`,`idArtista`) 
      VALUES ("Greatest Hits","2011",0,(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen")
        );
-- ----------------------------------------------------
-- Haciendo los inserts de Usuarios de prueba
-- -----------------------------------------------------
INSERT INTO `Usuario`(`nombreUsuario`,`contraUsuario`,`idTipoUsuario`) 
      VALUES ("Hugo","123",(
              SELECT `id`
              FROM `TipoUsuario`
              WHERE nombreTipoUsuario = "Administrador")
        );
INSERT INTO `Usuario`(`nombreUsuario`,`contraUsuario`,`idTipoUsuario`) 
      VALUES ("Hernán","123",(
              SELECT `id`
              FROM `TipoUsuario`
              WHERE nombreTipoUsuario = "Administrador")
        );
INSERT INTO `Usuario`(`nombreUsuario`,`contraUsuario`,`idTipoUsuario`) 
      VALUES ("David","123",(
              SELECT `id`
              FROM `TipoUsuario`
              WHERE nombreTipoUsuario = "Usuario")
        );
INSERT INTO `Usuario`(`nombreUsuario`,`contraUsuario`,`idTipoUsuario`) 
      VALUES ("Rafael","123",(
              SELECT `id`
              FROM `TipoUsuario`
              WHERE nombreTipoUsuario = "Usuario")
        );
-- ----------------------------------------------------
-- Haciendo los inserts para crear una Playlist
-- -----------------------------------------------------
INSERT INTO `Playlist`(`nombrePlaylist`,`numCancPlaylist`,`idUsuario`) 
      VALUES ("Favoritas",2,(
              SELECT `id`
              FROM `Usuario`
              WHERE nombreUsuario = "Rafael")
      );
INSERT INTO `Playlist`(`nombrePlaylist`,`numCancPlaylist`,`idUsuario`) 
      VALUES ("Mis Canciones",3,(
              SELECT `id`
              FROM `Usuario`
              WHERE nombreUsuario = "David")
      );
INSERT INTO `Playlist`(`nombrePlaylist`,`numCancPlaylist`,`idUsuario`) 
      VALUES ("Todas",3,(
              SELECT `id`
              FROM `Usuario`
              WHERE nombreUsuario = "Rafael")
      );
INSERT INTO `Playlist`(`nombrePlaylist`,`numCancPlaylist`,`idUsuario`) 
      VALUES ("Para fiesta",3,(
              SELECT `id`
              FROM `Usuario`
              WHERE nombreUsuario = "David")
      );
-- ----------------------------------------------------
-- Haciendo los inserts para poner los Generos a los Artistas
-- -----------------------------------------------------
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Ludwig van Beethoven"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Clasica")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Jose Luis Perales"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Ramones"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Black Sabbath"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Heavy Metal")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Frank Sinatra"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Blues")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Juan Gabriel"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Pop")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Snoop Dog"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Hip Hop")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Elvis Presley"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock and Roll")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Beatles"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Bee Gees"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Disco")
        );
INSERT INTO `Artista_Genero`(`idArtista`,`idGenero`) 
      VALUES ((
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock")
        );
-- ----------------------------------------------------
-- Haciendo los inserts para las Canciones
-- -----------------------------------------------------
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Für Elise","2:55","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Ludwig van Beethoven"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Compilacion Piano Beethoven"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Clasica"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Moon Light Sonata","3:15","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Ludwig van Beethoven"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Compilacion Piano Beethoven"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Clasica"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Me llamas","4:36","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Jose Luis Perales"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Celebridades"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Un Velero Llamado Libertad","4:36","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Jose Luis Perales"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Celebridades"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("For Reasons Unknown","3:33","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("When You Were Young","3:33","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Paranoid","3:33","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Black Sabbath"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Paranoid"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Heavy Metal"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("El Triste","4:13","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "El Triste"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("I Started A Joke","3:33","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Bee Gees"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Idea"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Disco"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Las Cruzadas","3:46","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Estare","3:23","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Control","3:37","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Señales","3:55","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Reencuentro","5:47","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Sabado(¿Por Que a Mi?)","3:14","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Nemesis","3:53","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Sigo Siendo Yo","3:24","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("El Mapa de Tus Ojos","4:42","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Soy","2:57","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Nuestros Tiempos","3:35","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Animal","3:57","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Arsenico","3:17","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Sea","3:50","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Todo Cuenta","3:53","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("A Distancia","4:23","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("El Tamaño de las Cosas","4:25","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Cancion de Cuna","3:58","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Necesidad","3:33","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("La Era Moderna","3:21","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Viernes","3:52","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Mi Voz","3:57","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Todo Cuenta - DOG Remix","4:36","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Todo Cuenta - (Panoptica Remix)","4:47","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Todo Cuenta - (Da Punto Beat Remix)","4:23","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Sea - Sussie 4 Remix","4:41","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "DLD"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Almohada - Sinfonico","3:31","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Almohada - Sinfonico","3:31","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Me Basta - Sinfonico","4:00","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Lo Que No Fue No Sera - Sinfonico","3:45","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("No Me Platiques Mas - Sinfonico","3:53","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Lo Dudo - Sinfonico","3:53","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Lagrimas - Sinfonico","4:41","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Lo Pasado, Pasado - Sinfonico","4:14","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("¿Y Quien Puede Ser? - Sinfonico","3:39","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Volcan - Sinfonico","4:26","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("La Barca - Sinfonico","3:46","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("40 y 20 - Sinfonico","3:53","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Un Minuto de Amor - Sinfonico","2:49","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("¿Y Que? - Sinfonico","3:15","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("La Nave del Olvido - Sinfonico","3:53","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Contigo en la Distancia - Sinfonico","3:50","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Desesperado - Sinfonico","3:45","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Sabor a Mi - Sinfonico","3:37","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("El Triste - Sinfonico","4:10","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Una Mañana - Sinfonico","2:56","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Payaso - Sinfonico","2:57","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("No Me Digas Que Te VaS - Sinfonico","4:01","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("El Amor Acaba - Sinfonico","4:14","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Preso - Sinfonico","3:35","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Voy a Llenarte Toda - Sinfonico","3:57","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Nuestro Amor Es el Mas Bello del Mundo - Sinfonico","3:05","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Cruz de Olvido - Sinfonico","3:13","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "José José"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Balada"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Bohemian Rhapsody","5:52","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Another One Bite The Dust","3:35","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Killer Queen","3:00","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Fat Bottomed Girls","3:22","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Bicycle Race","3:00","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("You're My Best Friend","2:50","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Don't Stop Me Now","3:30","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Save Me","3:48","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );

INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Crazy Little Thing Called Love","2:43","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );

INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Some Body to Love","4:56","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
  INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Now I'm Here ","3:10","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Good Old-Fashioned Lover Boy","2:53","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );

INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Play the Game","3:40","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );

INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Flash","2:48","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Seven Seas Of Rhye","2:40","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("We Will Rock You","2:00","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("We Are The Champions","3:05","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "Queen"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Rock"
                )
        );

INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Sam's Town","4:06","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Enterlude","0:50","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Bling(Confession of a King)","4:08","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Read My Mind","1:34","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Uncle Jonny","2:45","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Bones","3:33","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("My List","3:10","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("This River is Wild","4:10","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Why Do I Keep Counting","1:27","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );
INSERT INTO `Cancion`(`nombreCancion`,`duracionCancion`,`direccionCancion`,`idArtista`,`idAlbum`,`idGenero`) 
      VALUES ("Exitlude","1:30","C:\\",(
              SELECT `id`
              FROM `Artista`
              WHERE nombreArtista = "The Killers"),
              (
              SELECT `id`
              FROM `Album`
              WHERE nombreAlbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `Genero`
              WHERE nombreGenero = "Indie​"
                )
        );


-- ----------------------------------------------------
-- Haciendo los inserts para meter Canciones a las Playlist
-- -----------------------------------------------------

INSERT INTO `Playlist_Cancion`(`idPlaylist`,`idCancion`) 
      VALUES ((
              SELECT `id`
              FROM `Playlist`
              WHERE nombrePlaylist = "Favoritas"
              AND idUsuario = 4
              ),
              (
              SELECT `id`
              FROM `Cancion`
              WHERE nombreCancion = "For Reasons Unknown"
                )
        );
INSERT INTO `Playlist_Cancion`(`idPlaylist`,`idCancion`) 
      VALUES ((
              SELECT `id`
              FROM `Playlist`
              WHERE nombrePlaylist = "Favoritas"
              ),
              (
              SELECT `id`
              FROM `Cancion`
              WHERE nombreCancion = "When You Were Young"
              )
        );
INSERT INTO `Playlist_Cancion`(`idPlaylist`,`idCancion`) 
      VALUES ((
              SELECT `id`
              FROM `Playlist`
              WHERE nombrePlaylist = "Mis Canciones"
              ),
              (
              SELECT `id`
              FROM `Cancion`
              WHERE nombreCancion = "El Triste"
                )
        );






