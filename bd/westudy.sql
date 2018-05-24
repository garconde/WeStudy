-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 24-05-2018 a las 22:35:46
-- Versión del servidor: 5.7.19
-- Versión de PHP: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `westudy`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alerta`
--

DROP TABLE IF EXISTS `alerta`;
CREATE TABLE IF NOT EXISTS `alerta` (
  `cod_Alerta` int(11) NOT NULL AUTO_INCREMENT,
  `cod_Estudiante` int(11) DEFAULT NULL,
  `cod_Asignatura` int(11) DEFAULT NULL,
  `tema` varchar(80) DEFAULT NULL,
  `observacion` varchar(80) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL,
  `fecha_Inicio` date DEFAULT NULL,
  `id_Habilidad` int(11) NOT NULL,
  `fecha_Atencion` date DEFAULT NULL,
  PRIMARY KEY (`cod_Alerta`),
  KEY `cod_Estudiante_fk_idx` (`cod_Estudiante`),
  KEY `cod_Asignatura_fk_idx` (`cod_Asignatura`),
  KEY `fk_Alerta_CapitalHumano1_idx` (`id_Habilidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivosdeapoyo`
--

DROP TABLE IF EXISTS `archivosdeapoyo`;
CREATE TABLE IF NOT EXISTS `archivosdeapoyo` (
  `id_archivo` int(11) NOT NULL AUTO_INCREMENT,
  `archivo` blob,
  `titulo` varchar(80) DEFAULT NULL,
  `cod_asignatura_R` int(11) DEFAULT NULL,
  `Estudiante_codigoEstudiante` int(11) NOT NULL,
  PRIMARY KEY (`id_archivo`),
  KEY `cod_asignatura_fk_idx` (`cod_asignatura_R`),
  KEY `fk_ArchivosDeApoyo_Estudiante1_idx` (`Estudiante_codigoEstudiante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignatura`
--

DROP TABLE IF EXISTS `asignatura`;
CREATE TABLE IF NOT EXISTS `asignatura` (
  `cod_Asignatura` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `creditos` int(11) DEFAULT NULL,
  `semestre` int(11) DEFAULT NULL,
  `microcurriculo` blob,
  PRIMARY KEY (`cod_Asignatura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `capitalhumano`
--

DROP TABLE IF EXISTS `capitalhumano`;
CREATE TABLE IF NOT EXISTS `capitalhumano` (
  `id_capital` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_C_Humano` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_capital`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clasificacion`
--

DROP TABLE IF EXISTS `clasificacion`;
CREATE TABLE IF NOT EXISTS `clasificacion` (
  `Id_Habilidad_Debilidad` int(11) NOT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id_Habilidad_Debilidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

DROP TABLE IF EXISTS `estudiante`;
CREATE TABLE IF NOT EXISTS `estudiante` (
  `codigoEstudiante` int(11) NOT NULL,
  `cod_programa` int(11) DEFAULT NULL,
  `Persona_cod_Usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigoEstudiante`),
  UNIQUE KEY `codigoEstudiante_UNIQUE` (`codigoEstudiante`),
  KEY `cod_programa_fk_idx` (`cod_programa`),
  KEY `fk_Estudiante_Persona1_idx` (`Persona_cod_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habilidaddebilidad`
--

DROP TABLE IF EXISTS `habilidaddebilidad`;
CREATE TABLE IF NOT EXISTS `habilidaddebilidad` (
  `CapitalHumano_id_capital` int(11) NOT NULL,
  `Estudiante_codigoEstudiante` int(11) NOT NULL,
  `Id_Habilidad_Debilidad` int(11) NOT NULL,
  PRIMARY KEY (`CapitalHumano_id_capital`,`Estudiante_codigoEstudiante`,`Id_Habilidad_Debilidad`),
  KEY `fk_CapitalHumano_has_Estudiante_Estudiante1_idx` (`Estudiante_codigoEstudiante`),
  KEY `fk_CapitalHumano_has_Estudiante_CapitalHumano1_idx` (`CapitalHumano_id_capital`),
  KEY `fk_HabilidadDebilidad_Clasificacion1_idx` (`Id_Habilidad_Debilidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

DROP TABLE IF EXISTS `horario`;
CREATE TABLE IF NOT EXISTS `horario` (
  `cod_Horario` int(11) NOT NULL AUTO_INCREMENT,
  `cod_Estudiante` int(11) DEFAULT NULL,
  `horaInicio` date DEFAULT NULL,
  `HoraFin` date DEFAULT NULL,
  PRIMARY KEY (`cod_Horario`),
  KEY `cod_Estudiante_idx` (`cod_Estudiante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `cod_Usuario` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `clave` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cod_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programa`
--

DROP TABLE IF EXISTS `programa`;
CREATE TABLE IF NOT EXISTS `programa` (
  `cod_Snies` int(11) NOT NULL,
  `nombre` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`cod_Snies`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alerta`
--
ALTER TABLE `alerta`
  ADD CONSTRAINT `cod_Asignatura_fk` FOREIGN KEY (`cod_Asignatura`) REFERENCES `asignatura` (`cod_Asignatura`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `cod_Estudiante_fk` FOREIGN KEY (`cod_Estudiante`) REFERENCES `estudiante` (`codigoEstudiante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Alerta_CapitalHumano1` FOREIGN KEY (`id_Habilidad`) REFERENCES `capitalhumano` (`id_capital`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `archivosdeapoyo`
--
ALTER TABLE `archivosdeapoyo`
  ADD CONSTRAINT `cod_asignatura_fk_R` FOREIGN KEY (`cod_asignatura_R`) REFERENCES `asignatura` (`cod_Asignatura`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ArchivosDeApoyo_Estudiante1` FOREIGN KEY (`Estudiante_codigoEstudiante`) REFERENCES `estudiante` (`codigoEstudiante`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `cod_programa_fk` FOREIGN KEY (`cod_programa`) REFERENCES `programa` (`cod_Snies`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Estudiante_Persona1` FOREIGN KEY (`Persona_cod_Usuario`) REFERENCES `persona` (`cod_Usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `habilidaddebilidad`
--
ALTER TABLE `habilidaddebilidad`
  ADD CONSTRAINT `fk_CapitalHumano_has_Estudiante_CapitalHumano1` FOREIGN KEY (`CapitalHumano_id_capital`) REFERENCES `capitalhumano` (`id_capital`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_CapitalHumano_has_Estudiante_Estudiante1` FOREIGN KEY (`Estudiante_codigoEstudiante`) REFERENCES `estudiante` (`codigoEstudiante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_HabilidadDebilidad_Clasificacion1` FOREIGN KEY (`Id_Habilidad_Debilidad`) REFERENCES `clasificacion` (`Id_Habilidad_Debilidad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `cod_Estudiante` FOREIGN KEY (`cod_Estudiante`) REFERENCES `estudiante` (`codigoEstudiante`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
