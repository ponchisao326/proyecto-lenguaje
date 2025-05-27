-- Desactivar verificaciones de claves foráneas temporalmente
SET FOREIGN_KEY_CHECKS = 0;

-- Eliminar datos de tablas dependientes primero
DROP TABLE order_items;
DROP TABLE orders;
DROP TABLE product_compatibility;
DROP TABLE product_features;
DROP TABLE product_images;
DROP TABLE product_specifications;
DROP TABLE products;
DROP TABLE subcategories;
DROP TABLE brands;
DROP TABLE categories;

-- Reactivar verificaciones de claves foráneas
SET FOREIGN_KEY_CHECKS = 1;