-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-02-2025 a las 01:54:04
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `farmacia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_medicamento`
--

CREATE TABLE `categorias_medicamento` (
  `cod_cat` int(11) NOT NULL,
  `nombrec` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias_medicamento`
--

INSERT INTO `categorias_medicamento` (`cod_cat`, `nombrec`) VALUES
(1, 'Antibióticos'),
(2, 'Analgésicos'),
(3, 'Antiinflamatorios'),
(4, 'Antihistamínicos'),
(5, 'Vitamínicos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `cod_clt` int(11) NOT NULL,
  `nombre_clt` varchar(100) DEFAULT NULL,
  `direccion_clt` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`cod_clt`, `nombre_clt`, `direccion_clt`) VALUES
(1, 'Juan Pérez', 'Calle 123, Ciudad ABC'),
(2, 'María García', 'Av. Siempre Viva 742, Springfield'),
(3, 'Luis Rodríguez', 'Calle 45, Barrio Central'),
(4, 'Ana Martínez', 'Avenida de la Reforma, No. 789'),
(5, 'Pedro González', 'Plaza Mayor, Edificio 3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `nro_venta` int(11) NOT NULL,
  `cod_med` int(11) NOT NULL,
  `cantidadv` smallint(6) DEFAULT NULL,
  `preciov` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`nro_venta`, `cod_med`, `cantidadv`, `preciov`) VALUES
(1, 1, 2, 16),
(2, 2, 3, 10),
(3, 3, 1, 9),
(4, 4, 4, 12),
(5, 5, 2, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `cod_emp` int(11) NOT NULL,
  `nombre_emp` varchar(100) DEFAULT NULL,
  `telefono_emp` char(12) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`cod_emp`, `nombre_emp`, `telefono_emp`, `email`) VALUES
(1, 'Carlos López', '123456789012', NULL),
(2, 'Sofía Hernández', '234567890123', NULL),
(3, 'Miguel Sánchez', '345678901234', NULL),
(4, 'Laura Ramírez', '456789012345', NULL),
(5, 'Andrés Torres', '567890123456', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamento`
--

CREATE TABLE `medicamento` (
  `cod_med` int(11) NOT NULL,
  `nombrem` varchar(30) DEFAULT NULL,
  `preciom` decimal(10,0) NOT NULL DEFAULT 0,
  `stockm` int(11) NOT NULL DEFAULT 0,
  `fecha_vencimiento` date DEFAULT NULL,
  `cod_cat` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medicamento`
--

INSERT INTO `medicamento` (`cod_med`, `nombrem`, `preciom`, `stockm`, `fecha_vencimiento`, `cod_cat`) VALUES
(1, 'Amoxicilina', 16, 100, '2025-03-01', 1),
(2, 'Ibuprofeno', 10, 150, '2025-03-10', 2),
(3, 'Paracetamol', 9, 200, '2025-03-15', 3),
(4, 'Diclofenaco', 12, 80, '2025-03-20', 4),
(5, 'Lorazepam', 20, 50, '2025-03-25', 5);

--
-- Disparadores `medicamento`
--
DELIMITER $$
CREATE TRIGGER `verificar_vencimientos_insert` BEFORE INSERT ON `medicamento` FOR EACH ROW BEGIN
    IF NEW.fecha_vencimiento <= DATE_ADD(CURDATE(), INTERVAL 7 DAY) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "El producto está próximo a vencer";
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `verificar_vencimientos_update` BEFORE UPDATE ON `medicamento` FOR EACH ROW BEGIN
    IF NEW.fecha_vencimiento <= DATE_ADD(CURDATE(), INTERVAL 7 DAY) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "El producto está próximo a vencer";
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `correo` varchar(100) NOT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `correo`, `password`) VALUES
(1, 'Juan Perez', 'usuario@email.com', '$2y$10$W2kLfZvwHWalSe0uBm/d1Oh3724AkYCgHBef0urGLRtxIKsQ7jXGC'),
(2, 'Yoisi', 'yarlenis@hotmail.com', '$2y$10$ClRNhJd92UQuDKqmzCFEt.eQx5OEw4/1S2fiyn7veNT6n97OOm29i'),
(3, 'Yoisi', 'yoisiyarlenisp@gmail.com', '$2y$10$zcPfsgXq8T3TqUfaee.Elek0EMw3mkYIk2lRsTQRVTpxkKC88O4S2'),
(4, 'yarlenis', 'yarlenis@email.com', '$2y$10$36IWJprEhS88pDCtmHCD2uikGbYnUeSkPs6FHSKHwOpzr3nI4kf.i'),
(5, 'Yoisi Yarlenis', 'yyoisi@email.com', '$2y$10$PnteEZOYXK7xOn/TH3H/wumWARag60jxgg5wFGhvwh7q4o.3FfLOG'),
(6, 'Yoisi Yarlenis', 'yyarlenis@email.com', '$2y$10$xf7My98Lt/blYe.6aFMmPuurAzLZMRnQz6nDny58UuCHhi23JMgDy'),
(7, 'Yoisi Yarlenis', 'usuario@gmail.com', '$2y$10$2u6KLKrgP.DxQgmRqjkEzOt4e1iqQM1hMcr/3mZSfNhCKKD9rrbYy'),
(8, 'Juan', 'juan@gmail.com', '$2y$10$IiT6kSfPyT32wDmsqkc6zuYYXQooEiyo752fZYI3jKlpgDEgnQjDy'),
(9, 'Juan', 'juan@email.com', '$2y$10$dohQIu43PDuyuaGnaZ1jzeRtGS4xE76bdYmsw01IYTarNYmxJDTZi'),
(10, 'maria', 'maria@yahoo.com', '$2y$10$hh99kUvo3rTG4ozXs/KxS.K4DGEtfQhtHkg7e/CnwZKlTUc70ife2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `nro_venta` int(11) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `cod_clt` int(11) DEFAULT NULL,
  `cod_emp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`nro_venta`, `fecha`, `cod_clt`, `cod_emp`) VALUES
(1, '2025-02-17 10:00:00', 1, 1),
(2, '2025-02-18 11:00:00', 2, 2),
(3, '2025-02-19 12:00:00', 3, 3),
(4, '2025-02-20 13:00:00', 4, 4),
(5, '2025-02-21 14:00:00', 5, 5);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias_medicamento`
--
ALTER TABLE `categorias_medicamento`
  ADD PRIMARY KEY (`cod_cat`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cod_clt`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`nro_venta`,`cod_med`),
  ADD KEY `cod_med` (`cod_med`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`cod_emp`);

--
-- Indices de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  ADD PRIMARY KEY (`cod_med`),
  ADD KEY `cod_cat` (`cod_cat`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`nro_venta`),
  ADD KEY `cod_clt` (`cod_clt`),
  ADD KEY `cod_emp` (`cod_emp`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias_medicamento`
--
ALTER TABLE `categorias_medicamento`
  MODIFY `cod_cat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `cod_clt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `cod_emp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  MODIFY `cod_med` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `nro_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`nro_venta`) REFERENCES `venta` (`nro_venta`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`cod_med`) REFERENCES `medicamento` (`cod_med`);

--
-- Filtros para la tabla `medicamento`
--
ALTER TABLE `medicamento`
  ADD CONSTRAINT `medicamento_ibfk_1` FOREIGN KEY (`cod_cat`) REFERENCES `categorias_medicamento` (`cod_cat`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`cod_clt`) REFERENCES `clientes` (`cod_clt`),
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`cod_emp`) REFERENCES `empleados` (`cod_emp`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
