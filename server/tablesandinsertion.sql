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
    original_price DECIMAL(10,2),
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

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
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
(15, 'Downpipe HJS - Porsche 911', 899.99, 999.99, 4.9, 37, 17, 1, TRUE, 5, 'Downpipe con catalizador 300 células homologado');

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
(15, '/product_assets/product_15_4.webp');