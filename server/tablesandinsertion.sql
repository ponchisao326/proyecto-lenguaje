-- Creación de tablas
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE subcategories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE brands (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    original_price DECIMAL(10,2)c,
    rating DECIMAL(3,1),
    reviews INT,
    brand_id INT NOT NULL,
    subcategory_id INT NOT NULL,
    in_stock BOOLEAN DEFAULT TRUE,
    stock_count INT,
    description TEXT,
    FOREIGN KEY (brand_id) REFERENCES brands(id),
    FOREIGN KEY (subcategory_id) REFERENCES subcategories(id)
);

CREATE TABLE product_features (
    product_id INT NOT NULL,
    feature VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE product_specifications (
    product_id INT NOT NULL,
    spec_name VARCHAR(255) NOT NULL,
    spec_value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE product_compatibility (
    product_id INT NOT NULL,
    compatible_model VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE product_images (
    product_id INT NOT NULL,
    image_url VARCHAR(512) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insertar categorías principales
INSERT INTO categories (id, name) VALUES
(1, 'Performance'),
(2, 'Detailing');

-- Insertar subcategorías
INSERT INTO subcategories (category_id, name) VALUES
-- Performance
(1, 'DownPipes'),
(1, 'Embragues'),
(1, 'Frenos'),
(1, 'Suspension'),
(1, 'Escapes'),
(1, 'Intercoolers'),
(1, 'Radiadores'),
-- Detailing
(2, 'Body Kits'),
(2, 'Vinilos'),
(2, 'Pegatinas'),
(2, 'Alerones'),
(2, 'Frontales'),
(2, 'Difusores'),
(2, 'Paragolpes');

-- Insertar marcas
INSERT INTO brands (id, name) VALUES
(1, 'Brembo'),
(2, 'Eibach'),
(3, 'KW'),
(4, 'Mishimoto'),
(5, 'APR'),
(6, 'HKS'),
(7, 'Borla'),
(8, 'Garrett'),
(9, 'Clutch Masters'),
(10, 'CSF'),
(11, '3M'),
(12, 'Avery Dennison'),
(13, 'Maxton Design'),
(14, 'Seibon'),
(15, 'WeatherTech'),
(16, 'Michelin'),
(17, 'Forge Motorsport'),
(18, 'StopTech'),
(19, 'Whiteline'),
(20, 'Roush');

-- Insertar productos (30 productos)
INSERT INTO products (id, name, price, original_price, rating, reviews, brand_id, subcategory_id, in_stock, stock_count, description) VALUES
(1, 'Downpipe Deportivo APR - VW Golf R', 599.99, 699.99, 4.8, 45, 5, 1, TRUE, 8, 'Downpipe de 3" en acero inoxidable con celda deportiva de 200 células'),
(2, 'Kit Embrague Stage 3 Clutch Masters - Subaru WRX STI', 899.99, NULL, 4.7, 32, 9, 2, TRUE, 5, 'Kit completo con volante bimasa y cojinete de embrague'),
(3, 'Kit Frenos Brembo GT - BMW M3', 3499.99, 3999.99, 4.9, 67, 1, 3, TRUE, 3, 'Kit Big Brake con pinzas de 6 pistones y discos perforados'),
(4, 'Suspensión KW Variant 3 - Audi S4', 2299.99, NULL, 4.8, 28, 3, 4, TRUE, 4, 'Coilovers ajustables en altura y amortiguación'),
(5, 'Sistema Escape Completo Borla - Ford Mustang GT', 1599.99, 1799.99, 4.7, 53, 7, 5, TRUE, 7, 'Sistema cat-back con terminales de carbono'),
(6, 'Intercooler Garrett - Subaru WRX', 799.99, NULL, 4.6, 41, 8, 6, TRUE, 9, 'Intercooler front mount con núcleo bar-and-plate'),
(7, 'Radiador CSF - BMW 335i', 449.99, 499.99, 4.5, 22, 10, 7, TRUE, 12, 'Radiador aluminio triple paso con tanques reforzados'),
(8, 'Body Kit Maxton Design - VW Golf GTI', 899.99, NULL, 4.4, 18, 13, 8, TRUE, 6, 'Kit completo: splitter, faldones y difusor'),
(9, 'Vinilo Matte Black 3M - Rollo Completo', 499.99, 599.99, 4.8, 89, 11, 9, TRUE, 15, 'Vinilo mate autoadhesivo con protección UV'),
(10, 'Pegatinas Racing Michelin - Juego 4pzs', 29.99, NULL, 4.3, 127, 16, 10, TRUE, 50, 'Calcomanías resistentes a altas temperaturas'),
(11, 'Alerón CF Seibon - Honda Civic Type R', 699.99, 799.99, 4.7, 34, 14, 11, TRUE, 4, 'Alerón en fibra de carbono con montaje OEM'),
(12, 'Splitter Delantero APR - Audi TT RS', 399.99, NULL, 4.6, 23, 5, 12, TRUE, 8, 'Splitter en polímero reforzado con fibra de vidrio'),
(13, 'Difusor Trasero Maxton - BMW M4', 549.99, 649.99, 4.5, 19, 13, 13, TRUE, 3, 'Difusor con canales direccionales y salidas para escape'),
(14, 'Paragolpes Roush - Ford F-150', 1299.99, NULL, 4.8, 12, 20, 14, TRUE, 2, 'Paragolpes deportivo con protección skid plate'),
(15, 'Downpipe HJS - Porsche 911', 899.99, 999.99, 4.9, 37, 17, 1, TRUE, 5, 'Downpipe con catalizador 300 células homologado'),
(16, 'Volante Motor Forge - VW EA888', 349.99, NULL, 4.6, 44, 17, 2, TRUE, 10, 'Volante bimasa para altos niveles de par'),
(17, 'Pastillas Frenos StopTech - Track Pack', 199.99, 249.99, 4.7, 68, 18, 3, TRUE, 15, 'Pastillas compuesto race para alta temperatura'),
(18, 'Barras Whiteline - Subaru BRZ', 299.99, NULL, 4.5, 27, 19, 4, TRUE, 7, 'Kit completo barras estabilizadoras ajustables'),
(19, 'Tubo Escape Titanio HKS - Nissan GT-R', 2999.99, 3299.99, 4.9, 14, 6, 5, TRUE, 2, 'Sistema completo en titanio con válvula controlable'),
(20, 'Intercooler Wagner Tuning - BMW N54', 649.99, NULL, 4.7, 31, 17, 6, TRUE, 6, 'Núcleo de alta densidad con tanques reforzados'),
(21, 'Kit Radiador Mishimoto - Mazda MX-5', 389.99, 449.99, 4.6, 19, 4, 7, TRUE, 9, 'Kit completo con mangueras silicona y abrazaderas'),
(22, 'Vinilo Avery Gloss Blue - Rollo 15m', 429.99, NULL, 4.8, 56, 12, 9, TRUE, 11, 'Vinilo brillo automotriz con tecnología air-release'),
(23, 'Pegatinas Rally - Juego 6pzs', 39.99, 49.99, 4.4, 83, 16, 10, TRUE, 22, 'Calcomanías reflectantes para competición'),
(24, 'Alerón GT APR - Porsche 718', 1199.99, NULL, 4.7, 9, 5, 11, TRUE, 3, 'Alerón ajustable con soportes de aluminio aeronáutico'),
(25, 'Protector Paragolpes WeatherTech - Pickups', 149.99, 199.99, 4.3, 47, 15, 12, TRUE, 18, 'Protector de goma termoformado para paragolpes'),
(26, 'Kit Body Kit Liberty Walk - Nissan 370Z', 5499.99, NULL, 4.9, 5, 13, 8, TRUE, 1, 'Kit widebody completo con arcos extendidos'),
(27, 'Discos Frenos Perforados EBC - Track Use', 299.99, 349.99, 4.6, 62, 18, 3, TRUE, 14, 'Discos slotted para mejor refrigeración en circuito'),
(28, 'Coilovers Eibach Pro-Street-S - BMW M2', 1799.99, NULL, 4.7, 21, 2, 4, TRUE, 4, 'Suspensión deportiva con tecnología Pro-Damper'),
(29, 'Sistema Escape Akrapovič - BMW M4', 4299.99, 4599.99, 5.0, 8, 6, 5, TRUE, 2, 'Sistema completo en titanio con terminales carbono'),
(30, 'Intercooler CSF - Mercedes AMG A45', 729.99, 799.99, 4.8, 17, 10, 6, TRUE, 5, 'Diseño race con núcleo de alta eficiencia');

-- PRODUCTO 1: Downpipe Deportivo APR - VW Golf R
INSERT INTO product_features VALUES
(1, 'Acero inoxidable T304'),
(1, 'Catalizador deportivo de 200 celdas'),
(1, 'Soldaduras TIG de< alta calidad'),
(1, 'Mejora el flujo de gases de escape');
INSERT INTO product_specifications VALUES
(1, 'Diámetro', '3 pulgadas'),
(1, 'Material', 'Acero inoxidable T304'),
(1, 'Tipo de catalizador', '200 celdas'),
(1, 'Peso', '7 kg');
INSERT INTO product_compatibility VALUES
(1, 'Volkswagen Golf R MK7'),
(1, 'Audi S3 8V'),
(1, 'Seat Leon Cupra 5F');

-- PRODUCTO 2: Kit Embrague Stage 3 Clutch Masters - Subaru WRX STI
INSERT INTO product_features VALUES
(2, 'Incluye volante bimasa'),
(2, 'Material compuesto cerámico'),
(2, 'Diseñado para alto par motor'),
(2, 'Incluye cojinete de embrague');
INSERT INTO product_specifications VALUES
(2, 'Tipo', 'Stage 3'),
(2, 'Material', 'Compuesto cerámico'),
(2, 'Torque máximo soportado', '600 Nm'),
(2, 'Incluye volante', 'Sí');
INSERT INTO product_compatibility VALUES
(2, 'Subaru WRX STI 2004-2021');

-- PRODUCTO 3: Kit Frenos Brembo GT - BMW M3
INSERT INTO product_features VALUES
(3, 'Pinzas de 6 pistones'),
(3, 'Discos perforados y ventilados'),
(3, 'Pastillas de alto rendimiento'),
(3, 'Incluye latiguillos metálicos');
INSERT INTO product_specifications VALUES
(3, 'Diámetro disco', '380 mm'),
(3, 'Material disco', 'Hierro fundido'),
(3, 'Número de pistones', '6'),
(3, 'Tipo de disco', 'Perforado y ventilado');
INSERT INTO product_compatibility VALUES
(3, 'BMW M3 E92'),
(3, 'BMW M3 F80');

-- PRODUCTO 4: Suspensión KW Variant 3 - Audi S4
INSERT INTO product_features VALUES
(4, 'Ajuste independiente de compresión y rebote'),
(4, 'Altura regulable'),
(4, 'Tecnología inox-line'),
(4, 'Uso en calle y pista');
INSERT INTO product_specifications VALUES
(4, 'Altura ajustable', 'Sí'),
(4, 'Material', 'Acero inoxidable'),
(4, 'Tipo', 'Coilover'),
(4, 'Regulación', 'Compresión y rebote');
INSERT INTO product_compatibility VALUES
(4, 'Audi S4 B8'),
(4, 'Audi S4 B9');

-- PRODUCTO 5: Sistema Escape Completo Borla - Ford Mustang GT
INSERT INTO product_features VALUES
(5, 'Acero inoxidable 304'),
(5, 'Sonido agresivo'),
(5, 'Terminales de carbono'),
(5, 'Diseño cat-back');
INSERT INTO product_specifications VALUES
(5, 'Material', 'Acero inoxidable 304'),
(5, 'Tipo', 'Cat-back'),
(5, 'Diámetro', '2.5 pulgadas'),
(5, 'Peso', '18 kg');
INSERT INTO product_compatibility VALUES
(5, 'Ford Mustang GT 2015-2023');

-- PRODUCTO 6: Intercooler Garrett - Subaru WRX
INSERT INTO product_features VALUES
(6, 'Núcleo bar-and-plate'),
(6, 'Mayor capacidad de enfriamiento'),
(6, 'Montaje frontal'),
(6, 'Incluye kit de instalación');
INSERT INTO product_specifications VALUES
(6, 'Tipo', 'Front Mount'),
(6, 'Material', 'Aluminio'),
(6, 'Dimensiones', '610x305x76 mm'),
(6, 'Capacidad', 'Hasta 600 HP');
INSERT INTO product_compatibility VALUES
(6, 'Subaru WRX 2015-2021');

-- PRODUCTO 7: Radiador CSF - BMW 335i
INSERT INTO product_features VALUES
(7, 'Triple paso'),
(7, 'Tanques reforzados'),
(7, 'Aluminio de alta calidad'),
(7, 'Mejora la refrigeración');
INSERT INTO product_specifications VALUES
(7, 'Material', 'Aluminio'),
(7, 'Tipo', 'Triple paso'),
(7, 'Dimensiones', '675x438x68 mm'),
(7, 'Peso', '7.5 kg');
INSERT INTO product_compatibility VALUES
(7, 'BMW 335i E90/E92');

-- PRODUCTO 8: Body Kit Maxton Design - VW Golf GTI
INSERT INTO product_features VALUES
(8, 'Incluye splitter, faldones y difusor'),
(8, 'Material ABS'),
(8, 'Acabado negro brillante'),
(8, 'Montaje OEM');
INSERT INTO product_specifications VALUES
(8, 'Material', 'ABS'),
(8, 'Acabado', 'Negro brillante'),
(8, 'Incluye', 'Splitter, faldones, difusor'),
(8, 'Peso', '8 kg');
INSERT INTO product_compatibility VALUES
(8, 'Volkswagen Golf GTI MK7');

-- PRODUCTO 9: Vinilo Matte Black 3M - Rollo Completo
INSERT INTO product_features VALUES
(9, 'Protección UV'),
(9, 'Fácil de instalar'),
(9, 'Acabado mate'),
(9, 'Tecnología air release');
INSERT INTO product_specifications VALUES
(9, 'Color', 'Negro mate'),
(9, 'Dimensiones', '1.52m x 20m'),
(9, 'Espesor', '0.13 mm'),
(9, 'Resistencia UV', 'Sí');
INSERT INTO product_compatibility VALUES
(9, 'Universal');

-- PRODUCTO 10: Pegatinas Racing Michelin - Juego 4pzs
INSERT INTO product_features VALUES
(10, 'Resistentes a altas temperaturas'),
(10, 'Fácil aplicación'),
(10, 'Adhesivo duradero'),
(10, 'Diseño oficial Michelin');
INSERT INTO product_specifications VALUES
(10, 'Cantidad', '4 piezas'),
(10, 'Material', 'Vinilo'),
(10, 'Resistencia temperatura', 'Hasta 120°C'),
(10, 'Tamaño', '15x3 cm');
INSERT INTO product_compatibility VALUES
(10, 'Universal');

-- PRODUCTO 11: Alerón CF Seibon - Honda Civic Type R
INSERT INTO product_features VALUES
(11, 'Fibra de carbono auténtica'),
(11, 'Montaje OEM'),
(11, 'Acabado brillante'),
(11, 'Peso ligero');
INSERT INTO product_specifications VALUES
(11, 'Material', 'Fibra de carbono'),
(11, 'Peso', '2.5 kg'),
(11, 'Acabado', 'Brillante'),
(11, 'Montaje', 'OEM');
INSERT INTO product_compatibility VALUES
(11, 'Honda Civic Type R FK8');

-- PRODUCTO 12: Splitter Delantero APR - Audi TT RS
INSERT INTO product_features VALUES
(12, 'Polímero reforzado con fibra de vidrio'),
(12, 'Mejora aerodinámica'),
(12, 'Incluye herrajes de montaje'),
(12, 'Acabado negro mate');
INSERT INTO product_specifications VALUES
(12, 'Material', 'Fibra de vidrio reforzada'),
(12, 'Color', 'Negro mate'),
(12, 'Peso', '3 kg'),
(12, 'Incluye', 'Herrajes de montaje');
INSERT INTO product_compatibility VALUES
(12, 'Audi TT RS 8S');

-- PRODUCTO 13: Difusor Trasero Maxton - BMW M4
INSERT INTO product_features VALUES
(13, 'Canales direccionales'),
(13, 'Salidas para escape'),
(13, 'Material ABS'),
(13, 'Acabado negro brillante');
INSERT INTO product_specifications VALUES
(13, 'Material', 'ABS'),
(13, 'Color', 'Negro brillante'),
(13, 'Peso', '2.2 kg'),
(13, 'Montaje', 'OEM');
INSERT INTO product_compatibility VALUES
(13, 'BMW M4 F82');

-- PRODUCTO 14: Paragolpes Roush - Ford F-150
INSERT INTO product_features VALUES
(14, 'Protección skid plate'),
(14, 'Diseño deportivo'),
(14, 'Material resistente'),
(14, 'Montaje directo');
INSERT INTO product_specifications VALUES
(14, 'Material', 'Polímero reforzado'),
(14, 'Color', 'Negro'),
(14, 'Peso', '12 kg'),
(14, 'Incluye', 'Skid plate');
INSERT INTO product_compatibility VALUES
(14, 'Ford F-150 2015-2020');

-- PRODUCTO 15: Downpipe HJS - Porsche 911
INSERT INTO product_features VALUES
(15, 'Catalizador 300 celdas homologado'),
(15, 'Acero inoxidable'),
(15, 'Mejora el flujo de escape'),
(15, 'Soldaduras TIG');
INSERT INTO product_specifications VALUES
(15, 'Material', 'Acero inoxidable'),
(15, 'Catalizador', '300 celdas'),
(15, 'Diámetro', '3 pulgadas'),
(15, 'Peso', '6 kg');
INSERT INTO product_compatibility VALUES
(15, 'Porsche 911 991 Carrera');

-- PRODUCTO 16: Volante Motor Forge - VW EA888
INSERT INTO product_features VALUES
(16, 'Bimasa'),
(16, 'Alto par soportado'),
(16, 'Reducción de peso'),
(16, 'Diseño reforzado');
INSERT INTO product_specifications VALUES
(16, 'Tipo', 'Bimasa'),
(16, 'Material', 'Acero forjado'),
(16, 'Peso', '7.2 kg'),
(16, 'Torque máximo', '650 Nm');
INSERT INTO product_compatibility VALUES
(16, 'VW Golf GTI MK7'),
(16, 'Audi S3 8V');

-- PRODUCTO 17: Pastillas Frenos StopTech - Track Pack
INSERT INTO product_features VALUES
(17, 'Compuesto race'),
(17, 'Alta temperatura'),
(17, 'Bajo desgaste'),
(17, 'Frenada consistente');
INSERT INTO product_specifications VALUES
(17, 'Material', 'Compuesto cerámico'),
(17, 'Temperatura máxima', '800°C'),
(17, 'Aplicación', 'Track day'),
(17, 'Cantidad', '4 pastillas');
INSERT INTO product_compatibility VALUES
(17, 'BMW M3 E46'),
(17, 'Nissan 350Z');

-- PRODUCTO 18: Barras Whiteline - Subaru BRZ
INSERT INTO product_features VALUES
(18, 'Ajustables'),
(18, 'Incluye herrajes'),
(18, 'Mejora estabilidad'),
(18, 'Acero de alta resistencia');
INSERT INTO product_specifications VALUES
(18, 'Material', 'Acero'),
(18, 'Diámetro', '22 mm'),
(18, 'Ajustable', 'Sí'),
(18, 'Incluye', 'Herrajes');
INSERT INTO product_compatibility VALUES
(18, 'Subaru BRZ'),
(18, 'Toyota GT86');

-- PRODUCTO 19: Tubo Escape Titanio HKS - Nissan GT-R
INSERT INTO product_features VALUES
(19, 'Titanio completo'),
(19, 'Válvula controlable'),
(19, 'Peso ultraligero'),
(19, 'Sonido deportivo');
INSERT INTO product_specifications VALUES
(19, 'Material', 'Titanio'),
(19, 'Diámetro', '90 mm'),
(19, 'Peso', '8 kg'),
(19, 'Tipo', 'Cat-back');
INSERT INTO product_compatibility VALUES
(19, 'Nissan GT-R R35');

-- PRODUCTO 20: Intercooler Wagner Tuning - BMW N54
INSERT INTO product_features VALUES
(20, 'Núcleo de alta densidad'),
(20, 'Tanques reforzados'),
(20, 'Mejora enfriamiento'),
(20, 'Montaje directo');
INSERT INTO product_specifications VALUES
(20, 'Material', 'Aluminio'),
(20, 'Dimensiones', '520x210x150 mm'),
(20, 'Capacidad', 'Hasta 700 HP'),
(20, 'Peso', '7.5 kg');
INSERT INTO product_compatibility VALUES
(20, 'BMW 335i E90/E92 N54');

-- PRODUCTO 21: Kit Radiador Mishimoto - Mazda MX-5
INSERT INTO product_features VALUES
(21, 'Incluye mangueras de silicona'),
(21, 'Aluminio pulido'),
(21, 'Mejora refrigeración'),
(21, 'Montaje directo');
INSERT INTO product_specifications VALUES
(21, 'Material', 'Aluminio'),
(21, 'Incluye', 'Mangueras y abrazaderas'),
(21, 'Peso', '5.2 kg'),
(21, 'Dimensiones', '675x438x68 mm');
INSERT INTO product_compatibility VALUES
(21, 'Mazda MX-5 NA/NB');

-- PRODUCTO 22: Vinilo Avery Gloss Blue - Rollo 15m
INSERT INTO product_features VALUES
(22, 'Tecnología air-release'),
(22, 'Acabado brillo'),
(22, 'Fácil de instalar'),
(22, 'Protección UV');
INSERT INTO product_specifications VALUES
(22, 'Color', 'Azul brillo'),
(22, 'Dimensiones', '1.52m x 15m'),
(22, 'Espesor', '0.13 mm'),
(22, 'Resistencia UV', 'Sí');
INSERT INTO product_compatibility VALUES
(22, 'Universal');

-- PRODUCTO 23: Pegatinas Rally - Juego 6pzs
INSERT INTO product_features VALUES
(23, 'Reflectantes'),
(23, 'Fácil aplicación'),
(23, 'Resistentes al agua'),
(23, 'Diseño competición');
INSERT INTO product_specifications VALUES
(23, 'Cantidad', '6 piezas'),
(23, 'Material', 'Vinilo reflectante'),
(23, 'Tamaño', '12x4 cm'),
(23, 'Resistencia agua', 'Sí');
INSERT INTO product_compatibility VALUES
(23, 'Universal');

-- PRODUCTO 24: Alerón GT APR - Porsche 718
INSERT INTO product_features VALUES
(24, 'Ajustable'),
(24, 'Soportes aluminio aeronáutico'),
(24, 'Fibra de carbono'),
(24, 'Montaje directo');
INSERT INTO product_specifications VALUES
(24, 'Material', 'Fibra de carbono'),
(24, 'Peso', '3.2 kg'),
(24, 'Ajustable', 'Sí'),
(24, 'Soportes', 'Aluminio aeronáutico');
INSERT INTO product_compatibility VALUES
(24, 'Porsche 718 Cayman/Boxster');

-- PRODUCTO 25: Protector Paragolpes WeatherTech - Pickups
INSERT INTO product_features VALUES
(25, 'Goma termoformada'),
(25, 'Protección UV'),
(25, 'Fácil instalación'),
(25, 'Diseño antideslizante');
INSERT INTO product_specifications VALUES
(25, 'Material', 'Goma termoformada'),
(25, 'Color', 'Negro'),
(25, 'Dimensiones', '120x15 cm'),
(25, 'Resistencia UV', 'Sí');
INSERT INTO product_compatibility VALUES
(25, 'Ford F-150'),
(25, 'Chevrolet Silverado'),
(25, 'RAM 1500');

-- PRODUCTO 26: Kit Body Kit Liberty Walk - Nissan 370Z
INSERT INTO product_features VALUES
(26, 'Widebody completo'),
(26, 'Arcos extendidos'),
(26, 'Material FRP'),
(26, 'Incluye herrajes');
INSERT INTO product_specifications VALUES
(26, 'Material', 'Fibra de vidrio (FRP)'),
(26, 'Incluye', 'Arcos, faldones, difusor'),
(26, 'Peso', '18 kg'),
(26, 'Montaje', 'Atornillado');
INSERT INTO product_compatibility VALUES
(26, 'Nissan 370Z');

-- PRODUCTO 27: Discos Frenos Perforados EBC - Track Use
INSERT INTO product_features VALUES
(27, 'Slotted y perforados'),
(27, 'Mejor refrigeración'),
(27, 'Acero de alta calidad'),
(27, 'Diseño para circuito');
INSERT INTO product_specifications VALUES
(27, 'Material', 'Acero'),
(27, 'Diámetro', '330 mm'),
(27, 'Tipo', 'Slotted y perforado'),
(27, 'Peso', '7 kg');
INSERT INTO product_compatibility VALUES
(27, 'BMW M3 E46'),
(27, 'Nissan 350Z');

-- PRODUCTO 28: Coilovers Eibach Pro-Street-S - BMW M2
INSERT INTO product_features VALUES
(28, 'Altura ajustable'),
(28, 'Tecnología Pro-Damper'),
(28, 'Acero inoxidable'),
(28, 'Uso deportivo');
INSERT INTO product_specifications VALUES
(28, 'Material', 'Acero inoxidable'),
(28, 'Altura ajustable', 'Sí'),
(28, 'Tipo', 'Coilover'),
(28, 'Peso', '12 kg');
INSERT INTO product_compatibility VALUES
(28, 'BMW M2 F87');

-- PRODUCTO 29: Sistema Escape Akrapovič - BMW M4
INSERT INTO product_features VALUES
(29, 'Titanio completo'),
(29, 'Terminales de carbono'),
(29, 'Peso ultraligero'),
(29, 'Sonido deportivo');
INSERT INTO product_specifications VALUES
(29, 'Material', 'Titanio'),
(29, 'Tipo', 'Cat-back'),
(29, 'Peso', '9 kg'),
(29, 'Terminales', 'Fibra de carbono');
INSERT INTO product_compatibility VALUES
(29, 'BMW M4 F82');

-- PRODUCTO 30: Intercooler CSF - Mercedes AMG A45
INSERT INTO product_features VALUES
(30, 'Núcleo de alta eficiencia'),
(30, 'Aluminio de alta calidad'),
(30, 'Montaje directo'),
(30, 'Mejora enfriamiento');
INSERT INTO product_specifications VALUES
(30, 'Material', 'Aluminio'),
(30, 'Dimensiones', '600x180x100 mm'),
(30, 'Peso', '6.5 kg'),
(30, 'Capacidad', 'Hasta 550 HP');
INSERT INTO product_compatibility VALUES
(30, 'Mercedes AMG A45 W176');

INSERT INTO product_images (product_id, image_url) VALUES
(1, '/product_assets/product_1_1.webp'),
(1, '/product_assets/product_1_2.webp'),
(1, '/product_assets/product_1_3.webp'),
(1, '/product_assets/product_1_4.webp'),
(2, '/product_assets/product_2_1.webp'),
(2, '/product_assets/product_2_2.webp'),
(2, '/product_assets/product_2_3.webp'),
(2, '/product_assets/product_2_4.webp'),
(3, '/product_assets/product_3_1.webp'),
(3, '/product_assets/product_3_2.webp'),
(3, '/product_assets/product_3_3.webp'),
(3, '/product_assets/product_3_4.webp'),
(4, '/product_assets/product_4_1.webp'),
(4, '/product_assets/product_4_2.webp'),
(4, '/product_assets/product_4_3.webp'),
(4, '/product_assets/product_4_4.webp'),
(5, '/product_assets/product_5_1.webp'),
(5, '/product_assets/product_5_2.webp'),
(5, '/product_assets/product_5_3.webp'),
(5, '/product_assets/product_5_4.webp'),
(6, '/product_assets/product_6_1.webp'),
(6, '/product_assets/product_6_2.webp'),
(6, '/product_assets/product_6_3.webp'),
(6, '/product_assets/product_6_4.webp'),
(7, '/product_assets/product_7_1.webp'),
(7, '/product_assets/product_7_2.webp'),
(7, '/product_assets/product_7_3.webp'),
(7, '/product_assets/product_7_4.webp'),
(8, '/product_assets/product_8_1.webp'),
(8, '/product_assets/product_8_2.webp'),
(8, '/product_assets/product_8_3.webp'),
(8, '/product_assets/product_8_4.webp'),
(9, '/product_assets/product_9_1.webp'),
(9, '/product_assets/product_9_2.webp'),
(9, '/product_assets/product_9_3.webp'),
(9, '/product_assets/product_9_4.webp'),
(10, '/product_assets/product_10_1.webp'),
(10, '/product_assets/product_10_2.webp'),
(10, '/product_assets/product_10_3.webp'),
(10, '/product_assets/product_10_4.webp'),
(11, '/product_assets/product_11_1.webp'),
(11, '/product_assets/product_11_2.webp'),
(11, '/product_assets/product_11_3.webp'),
(11, '/product_assets/product_11_4.webp'),
(12, '/product_assets/product_12_1.webp'),
(12, '/product_assets/product_12_2.webp'),
(12, '/product_assets/product_12_3.webp'),
(12, '/product_assets/product_12_4.webp'),
(13, '/product_assets/product_13_1.webp'),
(13, '/product_assets/product_13_2.webp'),
(13, '/product_assets/product_13_3.webp'),
(13, '/product_assets/product_13_4.webp'),
(14, '/product_assets/product_14_1.webp'),
(14, '/product_assets/product_14_2.webp'),
(14, '/product_assets/product_14_3.webp'),
(14, '/product_assets/product_14_4.webp'),
(15, '/product_assets/product_15_1.webp'),
(15, '/product_assets/product_15_2.webp'),
(15, '/product_assets/product_15_3.webp'),
(15, '/product_assets/product_15_4.webp'),
(16, '/product_assets/product_16_1.webp'),
(16, '/product_assets/product_16_2.webp'),
(16, '/product_assets/product_16_3.webp'),
(16, '/product_assets/product_16_4.webp'),
(17, '/product_assets/product_17_1.webp'),
(17, '/product_assets/product_17_2.webp'),
(17, '/product_assets/product_17_3.webp'),
(17, '/product_assets/product_17_4.webp'),
(18, '/product_assets/product_18_1.webp'),
(18, '/product_assets/product_18_2.webp'),
(18, '/product_assets/product_18_3.webp'),
(18, '/product_assets/product_18_4.webp'),
(19, '/product_assets/product_19_1.webp'),
(19, '/product_assets/product_19_2.webp'),
(19, '/product_assets/product_19_3.webp'),
(19, '/product_assets/product_19_4.webp'),
(20, '/product_assets/product_20_1.webp'),
(20, '/product_assets/product_20_2.webp'),
(20, '/product_assets/product_20_3.webp'),
(20, '/product_assets/product_20_4.webp'),
(21, '/product_assets/product_21_1.webp'),
(21, '/product_assets/product_21_2.webp'),
(21, '/product_assets/product_21_3.webp'),
(21, '/product_assets/product_21_4.webp'),
(22, '/product_assets/product_22_1.webp'),
(22, '/product_assets/product_22_2.webp'),
(22, '/product_assets/product_22_3.webp'),
(22, '/product_assets/product_22_4.webp'),
(23, '/product_assets/product_23_1.webp'),
(23, '/product_assets/product_23_2.webp'),
(23, '/product_assets/product_23_3.webp'),
(23, '/product_assets/product_23_4.webp'),
(24, '/product_assets/product_24_1.webp'),
(24, '/product_assets/product_24_2.webp'),
(24, '/product_assets/product_24_3.webp'),
(24, '/product_assets/product_24_4.webp'),
(25, '/product_assets/product_25_1.webp'),
(25, '/product_assets/product_25_2.webp'),
(25, '/product_assets/product_25_3.webp'),
(25, '/product_assets/product_25_4.webp'),
(26, '/product_assets/product_26_1.webp'),
(26, '/product_assets/product_26_2.webp'),
(26, '/product_assets/product_26_3.webp'),
(26, '/product_assets/product_26_4.webp'),
(27, '/product_assets/product_27_1.webp'),
(27, '/product_assets/product_27_2.webp'),
(27, '/product_assets/product_27_3.webp'),
(27, '/product_assets/product_27_4.webp'),
(28, '/product_assets/product_28_1.webp'),
(28, '/product_assets/product_28_2.webp'),
(28, '/product_assets/product_28_3.webp'),
(28, '/product_assets/product_28_4.webp'),
(29, '/product_assets/product_29_1.webp'),
(29, '/product_assets/product_29_2.webp'),
(29, '/product_assets/product_29_3.webp'),
(29, '/product_assets/product_29_4.webp'),
(30, '/product_assets/product_30_1.webp'),
(30, '/product_assets/product_30_2.webp'),
(30, '/product_assets/product_30_3.webp'),
(30, '/product_assets/product_30_4.webp');