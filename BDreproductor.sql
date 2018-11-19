
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PruebasBD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PruebasBD
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `PruebasBD` DEFAULT CHARACTER SET utf8;
USE `PruebasBD` ;

-- -----------------------------------------------------
-- Table `PruebasBD`.`tipousuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PruebasBD`.`tipousuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombretipousuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PruebasBD`.`genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PruebasBD`.`genero` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombregenero` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PruebasBD`.`artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PruebasBD`.`artista` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombreartista` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PruebasBD`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PruebasBD`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombreusuario` VARCHAR(50) NOT NULL,
  `contrausuario` VARCHAR(50) NOT NULL,
  `idtipousuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_tipousuario_idx` (`idtipousuario` ASC),
  CONSTRAINT `fk_usuario_tipousuario`
    FOREIGN KEY (`idtipousuario`)
    REFERENCES `PruebasBD`.`tipousuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PruebasBD`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PruebasBD`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombreplaylist` VARCHAR(50) NOT NULL,
  `numCancplaylist` INT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_playlist_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `PruebasBD`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PruebasBD`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PruebasBD`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombrealbum` VARCHAR(50) NOT NULL,
  `añoalbum` DATE NULL,
  `numCancalbum` INT NULL,
  `idartista` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_album_artista1_idx` (`idartista` ASC),
  CONSTRAINT `fk_album_artista1`
    FOREIGN KEY (`idartista`)
    REFERENCES `PruebasBD`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PruebasBD`.`cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PruebasBD`.`cancion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombrecancion` VARCHAR(50) NOT NULL,
  `duracioncancion` VARCHAR(45) NULL,
  `direccioncancion` VARCHAR(100) NULL,
  `idartista` INT NOT NULL,
  `idalbum` INT NOT NULL,
  `idgenero` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cancion_artista1_idx` (`idartista` ASC),
  INDEX `fk_cancion_album1_idx` (`idalbum` ASC),
  INDEX `fk_cancion_genero1_idx` (`idgenero` ASC),
  CONSTRAINT `fk_cancion_artista1`
    FOREIGN KEY (`idartista`)
    REFERENCES `PruebasBD`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cancion_album1`
    FOREIGN KEY (`idalbum`)
    REFERENCES `PruebasBD`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cancion_genero1`
    FOREIGN KEY (`idgenero`)
    REFERENCES `PruebasBD`.`genero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PruebasBD`.`playlist_cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PruebasBD`.`playlist_cancion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idplaylist` INT NOT NULL,
  `idcancion` INT NOT NULL,
  PRIMARY KEY (`id`, `idplaylist`, `idcancion`),
  INDEX `fk_playlist_has_cancion_cancion1_idx` (`idcancion` ASC),
  INDEX `fk_playlist_has_cancion_playlist1_idx` (`idplaylist` ASC),
  CONSTRAINT `fk_playlist_has_cancion_playlist1`
    FOREIGN KEY (`idplaylist`)
    REFERENCES `PruebasBD`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_has_cancion_cancion1`
    FOREIGN KEY (`idcancion`)
    REFERENCES `PruebasBD`.`cancion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PruebasBD`.`artista_nombregenero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PruebasBD`.`artista_genero` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idartista` INT NOT NULL,
  `idgenero` INT NOT NULL,
  PRIMARY KEY (`id`, `idartista`, `idgenero`),
  INDEX `fk_artista_has_genero_genero1_idx` (`idgenero` ASC),
  INDEX `fk_artista_has_genero_artista1_idx` (`idartista` ASC),
  CONSTRAINT `fk_artista_has_genero_artista1`
    FOREIGN KEY (`idartista`)
    REFERENCES `PruebasBD`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artista_has_genero_genero1`
    FOREIGN KEY (`idgenero`)
    REFERENCES `PruebasBD`.`genero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- ----------------------------------------------------
-- Haciendo los insert en el catalogo nombregeneros
-- -----------------------------------------------------
INSERT INTO `genero`(`nombregenero`) VALUES ("Clasica");
INSERT INTO `genero`(`nombregenero`) VALUES ("Blues");
INSERT INTO `genero`(`nombregenero`) VALUES ("Corrido");
INSERT INTO `genero`(`nombregenero`) VALUES ("Country");
INSERT INTO `genero`(`nombregenero`) VALUES ("Cumbia");
INSERT INTO `genero`(`nombregenero`) VALUES ("Disco");
INSERT INTO `genero`(`nombregenero`) VALUES ("Electrónica");
INSERT INTO `genero`(`nombregenero`) VALUES ("Flamenco");
INSERT INTO `genero`(`nombregenero`) VALUES ("Folk");
INSERT INTO `genero`(`nombregenero`) VALUES ("Funk");
INSERT INTO `genero`(`nombregenero`) VALUES ("Gospel");
INSERT INTO `genero`(`nombregenero`) VALUES ("Heavy Metal");
INSERT INTO `genero`(`nombregenero`) VALUES ("Hip Hop");
INSERT INTO `genero`(`nombregenero`) VALUES ("Indie​");
INSERT INTO `genero`(`nombregenero`) VALUES ("Jazz​");
INSERT INTO `genero`(`nombregenero`) VALUES ("Merengue");
INSERT INTO `genero`(`nombregenero`) VALUES ("Pop");
INSERT INTO `genero`(`nombregenero`) VALUES ("Ranchera");
INSERT INTO `genero`(`nombregenero`) VALUES ("Rap");
INSERT INTO `genero`(`nombregenero`) VALUES ("Reggae");
INSERT INTO `genero`(`nombregenero`) VALUES ("Reggaeton");
INSERT INTO `genero`(`nombregenero`) VALUES ("Rumba");
INSERT INTO `genero`(`nombregenero`) VALUES ("Rock");
INSERT INTO `genero`(`nombregenero`) VALUES ("Rock and Roll");
INSERT INTO `genero`(`nombregenero`) VALUES ("Salsa");
INSERT INTO `genero`(`nombregenero`) VALUES ("Son");
INSERT INTO `genero`(`nombregenero`) VALUES ("Soul");
INSERT INTO `genero`(`nombregenero`) VALUES ("Tango");
INSERT INTO `genero`(`nombregenero`) VALUES ("Balada");
-- ----------------------------------------------------
-- Haciendo los insert en el catalogo Tipo de usuarios
-- -----------------------------------------------------
INSERT INTO `tipousuario` (`nombretipousuario`) VALUES ("Administrador");
InSERT INTO `tipousuario` (`nombretipousuario`) VALUES ("usuario");
-- ----------------------------------------------------
-- Haciendo los inserts de artistas
-- -----------------------------------------------------
INSERT INTO `artista`(`nombreartista`) VALUES ("Ludwig van Beethoven");
INSERT INTO `artista`(`nombreartista`) VALUES ("Jose Luis Perales");
INSERT INTO `artista`(`nombreartista`) VALUES ("The Killers");
INSERT INTO `artista`(`nombreartista`) VALUES ("Ramones");
INSERT INTO `artista`(`nombreartista`) VALUES ("Queen");
INSERT INTO `artista`(`nombreartista`) VALUES ("Black Sabbath");
INSERT INTO `artista`(`nombreartista`) VALUES ("Frank Sinatra");
INSERT INTO `artista`(`nombreartista`) VALUES ("José José");
INSERT INTO `artista`(`nombreartista`) VALUES ("Juan Gabriel");
INSERT INTO `artista`(`nombreartista`) VALUES ("Snoop Dog");
INSERT INTO `artista`(`nombreartista`) VALUES ("Elvis Presley");
INSERT INTO `artista`(`nombreartista`) VALUES ("The Beatles");
INSERT INTO `artista`(`nombreartista`) VALUES ("Bee Gees");
INSERT INTO `artista`(`nombreartista`) VALUES ("DLD");

-- ----------------------------------------------------
-- Haciendo los inserts de Albunes
-- -----------------------------------------------------
INSERT INTO `album`(`nombrealbum`,`añoalbum`,`numCancalbum`,`idartista`) 
      VALUES ("Compilacion Piano Beethoven","2000",0,(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Ludwig van Beethoven")
        );
INSERT INTO `album`(`nombrealbum`,`añoalbum`,`numCancalbum`,`idartista`) 
      VALUES ("Paranoid","1970",0,(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Black Sabbath")
        );
INSERT INTO `album`(`nombrealbum`,`añoalbum`,`numCancalbum`,`idartista`) 
      VALUES ("Idea","1968",0,(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Bee Gees")
        );

INSERT INTO `album`(`nombrealbum`,`añoalbum`,`numCancalbum`,`idartista`) 
      VALUES ("Celebridades","2008",0,(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Jose Luis Perales")
        );
INSERT INTO `album`(`nombrealbum`,`añoalbum`,`numCancalbum`,`idartista`) 
      VALUES ("Sam's Town","2006",0,(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers")
        );
INSERT INTO `album`(`nombrealbum`,`añoalbum`,`numCancalbum`,`idartista`) 
      VALUES ("El Triste","1970",0,(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José")
        );
INSERT INTO `album`(`nombrealbum`,`añoalbum`,`numCancalbum`,`idartista`) 
      VALUES ("Futura","2015",0,(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD")
        );
INSERT INTO `album`(`nombrealbum`,`añoalbum`,`numCancalbum`,`idartista`) 
      VALUES ("Primario","2013",15,(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD")
        );
INSERT INTO `album`(`nombrealbum`,`añoalbum`,`numCancalbum`,`idartista`) 
      VALUES ("Sinfonico","2018",26,(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José")
        );
INSERT INTO `album`(`nombrealbum`,`añoalbum`,`numCancalbum`,`idartista`) 
      VALUES ("Greatest Hits","2011",0,(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen")
        );
-- ----------------------------------------------------
-- Haciendo los inserts de usuarios de prueba
-- -----------------------------------------------------
INSERT INTO `usuario`(`nombreusuario`,`contrausuario`,`idtipousuario`) 
      VALUES ("Hugo","123",(
              SELECT `id`
              FROM `tipousuario`
              WHERE nombretipousuario = "Administrador")
        );
INSERT INTO `usuario`(`nombreusuario`,`contrausuario`,`idtipousuario`) 
      VALUES ("Hernán","123",(
              SELECT `id`
              FROM `tipousuario`
              WHERE nombretipousuario = "Administrador")
        );
INSERT INTO `usuario`(`nombreusuario`,`contrausuario`,`idtipousuario`) 
      VALUES ("David","123",(
              SELECT `id`
              FROM `tipousuario`
              WHERE nombretipousuario = "usuario")
        );
INSERT INTO `usuario`(`nombreusuario`,`contrausuario`,`idtipousuario`) 
      VALUES ("Rafael","123",(
              SELECT `id`
              FROM `tipousuario`
              WHERE nombretipousuario = "usuario")
        );
-- ----------------------------------------------------
-- Haciendo los inserts para crear una playlist
-- -----------------------------------------------------
INSERT INTO `playlist`(`nombrePlayList`,`numCancplaylist`,`idusuario`) 
      VALUES ("Favoritas",2,(
              SELECT `id`
              FROM `usuario`
              WHERE nombreusuario = "Rafael")
      );
INSERT INTO `playlist`(`nombrePlayList`,`numCancplaylist`,`idusuario`) 
      VALUES ("Mis canciones",3,(
              SELECT `id`
              FROM `usuario`
              WHERE nombreusuario = "David")
      );
INSERT INTO `playlist`(`nombrePlayList`,`numCancplaylist`,`idusuario`) 
      VALUES ("Todas",3,(
              SELECT `id`
              FROM `usuario`
              WHERE nombreusuario = "Rafael")
      );
INSERT INTO `playlist`(`nombrePlayList`,`numCancplaylist`,`idusuario`) 
      VALUES ("Para fiesta",3,(
              SELECT `id`
              FROM `usuario`
              WHERE nombreusuario = "David")
      );
-- ----------------------------------------------------
-- Haciendo los inserts para poner los generos a los artistas
-- -----------------------------------------------------
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Ludwig van Beethoven"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Clasica")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Jose Luis Perales"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Ramones"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Black Sabbath"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Heavy Metal")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Frank Sinatra"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Blues")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Juan Gabriel"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Pop")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Snoop Dog"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Hip Hop")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Elvis Presley"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock and Roll")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Beatles"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Bee Gees"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Disco")
        );
INSERT INTO `artista_genero`(`idartista`,`idgenero`) 
      VALUES ((
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock")
        );
-- ----------------------------------------------------
-- Haciendo los inserts para las canciones
-- -----------------------------------------------------
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Für Elise","2:55","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Ludwig van Beethoven"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Compilacion Piano Beethoven"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Clasica"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Moon Light Sonata","3:15","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Ludwig van Beethoven"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Compilacion Piano Beethoven"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Clasica"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Me llamas","4:36","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Jose Luis Perales"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Celebridades"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Un Velero Llamado Libertad","4:36","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Jose Luis Perales"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Celebridades"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("For Reasons Unknown","3:33","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("When You Were Young","3:33","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Paranoid","3:33","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Black Sabbath"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Paranoid"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Heavy Metal"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("El Triste","4:13","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "El Triste"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("I Started A Joke","3:33","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Bee Gees"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Idea"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Disco"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Las Cruzadas","3:46","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Estare","3:23","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Control","3:37","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Señales","3:55","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Reencuentro","5:47","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Sabado(¿Por Que a Mi?)","3:14","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Nemesis","3:53","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Sigo Siendo Yo","3:24","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("El Mapa de Tus Ojos","4:42","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Soy","2:57","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Nuestros Tiempos","3:35","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Futura"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Animal","3:57","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Arsenico","3:17","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Sea","3:50","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Todo Cuenta","3:53","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("A Distancia","4:23","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("El Tamaño de las Cosas","4:25","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("cancion de Cuna","3:58","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Necesidad","3:33","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("La Era Moderna","3:21","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Viernes","3:52","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Mi Voz","3:57","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Todo Cuenta - DOG Remix","4:36","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Todo Cuenta - (Panoptica Remix)","4:47","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Todo Cuenta - (Da Punto Beat Remix)","4:23","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Sea - Sussie 4 Remix","4:41","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "DLD"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Primario"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Almohada - Sinfonico","3:31","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Almohada - Sinfonico","3:31","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Me Basta - Sinfonico","4:00","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Lo Que No Fue No Sera - Sinfonico","3:45","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("No Me Platiques Mas - Sinfonico","3:53","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Lo Dudo - Sinfonico","3:53","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Lagrimas - Sinfonico","4:41","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Lo Pasado, Pasado - Sinfonico","4:14","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("¿Y Quien Puede Ser? - Sinfonico","3:39","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Volcan - Sinfonico","4:26","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("La Barca - Sinfonico","3:46","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("40 y 20 - Sinfonico","3:53","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Un Minuto de Amor - Sinfonico","2:49","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("¿Y Que? - Sinfonico","3:15","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("La Nave del Olvido - Sinfonico","3:53","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Contigo en la Distancia - Sinfonico","3:50","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Desesperado - Sinfonico","3:45","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Sabor a Mi - Sinfonico","3:37","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("El Triste - Sinfonico","4:10","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Una Mañana - Sinfonico","2:56","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Payaso - Sinfonico","2:57","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("No Me Digas Que Te VaS - Sinfonico","4:01","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("El Amor Acaba - Sinfonico","4:14","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Preso - Sinfonico","3:35","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Voy a Llenarte Toda - Sinfonico","3:57","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Nuestro Amor Es el Mas Bello del Mundo - Sinfonico","3:05","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Cruz de Olvido - Sinfonico","3:13","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "José José"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sinfonico"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Balada"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Bohemian Rhapsody","5:52","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Another One Bite The Dust","3:35","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Killer Queen","3:00","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Fat Bottomed Girls","3:22","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Bicycle Race","3:00","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("You're My Best Friend","2:50","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Don't Stop Me Now","3:30","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Save Me","3:48","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );

INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Crazy Little Thing Called Love","2:43","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );

INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Some Body to Love","4:56","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
  INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Now I'm Here ","3:10","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Good Old-Fashioned Lover Boy","2:53","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );

INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Play the Game","3:40","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );

INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Flash","2:48","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Seven Seas Of Rhye","2:40","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("We Will Rock You","2:00","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("We Are The Champions","3:05","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "Queen"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Greatest Hits"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Rock"
                )
        );

INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Sam's Town","4:06","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Enterlude","0:50","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Bling(Confession of a King)","4:08","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Read My Mind","1:34","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Uncle Jonny","2:45","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Bones","3:33","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("My List","3:10","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("This River is Wild","4:10","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Why Do I Keep Counting","1:27","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );
INSERT INTO `cancion`(`nombrecancion`,`duracioncancion`,`direccioncancion`,`idartista`,`idalbum`,`idgenero`) 
      VALUES ("Exitlude","1:30","C:\\",(
              SELECT `id`
              FROM `artista`
              WHERE nombreartista = "The Killers"),
              (
              SELECT `id`
              FROM `album`
              WHERE nombrealbum = "Sam's Town"
                ),
              (
              SELECT `id`
              FROM `genero`
              WHERE nombregenero = "Indie​"
                )
        );


-- ----------------------------------------------------
-- Haciendo los inserts para meter canciones a las playlist
-- -----------------------------------------------------

INSERT INTO `playlist_cancion`(`idPlayList`,`idcancion`) 
      VALUES ((
              SELECT `id`
              FROM `playlist`
              WHERE nombrePlayList = "Favoritas"
              AND idusuario = 4
              ),
              (
              SELECT `id`
              FROM `cancion`
              WHERE nombrecancion = "For Reasons Unknown"
                )
        );
INSERT INTO `playlist_cancion`(`idPlayList`,`idcancion`) 
      VALUES ((
              SELECT `id`
              FROM `playlist`
              WHERE nombrePlayList = "Favoritas"
              ),
              (
              SELECT `id`
              FROM `cancion`
              WHERE nombrecancion = "When You Were Young"
              )
        );
INSERT INTO `playlist_cancion`(`idPlayList`,`idcancion`) 
      VALUES ((
              SELECT `id`
              FROM `playlist`
              WHERE nombrePlayList = "Mis canciones"
              ),
              (
              SELECT `id`
              FROM `cancion`
              WHERE nombrecancion = "El Triste"
                )
        );






