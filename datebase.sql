DROP TABLE IF EXISTS user_library;
DROP TABLE IF EXISTS system_requirements;
DROP TABLE IF EXISTS game_platforms;
DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS platforms;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    nickname VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE genres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE platforms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE games (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(255) NOT NULL,
    developer VARCHAR(255) NOT NULL,
    publisher VARCHAR(255) NOT NULL,
    release_date DATE NOT NULL,
    price DECIMAL(10,2) NOT NULL DEFAULT 0,
    rating DECIMAL(3,1),
    description TEXT,
    genre_id INTEGER NOT NULL,
    image_path VARCHAR(500),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE game_platforms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_id INTEGER NOT NULL,
    platform_id INTEGER NOT NULL,
    FOREIGN KEY (game_id) REFERENCES games(id),
    FOREIGN KEY (platform_id) REFERENCES platforms(id)
);

CREATE TABLE user_library (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    game_id INTEGER NOT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (game_id) REFERENCES games(id)
);

CREATE TABLE system_requirements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_id INTEGER NOT NULL,
    type VARCHAR(20) NOT NULL,
    os VARCHAR(255),
    processor VARCHAR(255),
    ram VARCHAR(50),
    gpu VARCHAR(255),
    storage VARCHAR(100),
    FOREIGN KEY (game_id) REFERENCES games(id)
);

INSERT INTO genres (name, slug) VALUES
('Ролевая игра', 'rpg'),
('Экшен', 'action'),
('Шутер', 'shooter'),
('Стратегия', 'strategy'),
('Приключения', 'adventure'),
('Симулятор', 'simulation'),
('Спорт', 'sports'),
('Хоррор', 'horror');

INSERT INTO platforms (name, slug) VALUES
('PC (Windows)', 'pc'),
('Xbox', 'xbox'),
('PlayStation', 'playstation'),
('Nintendo Switch', 'nintendo');

INSERT INTO games (id, title, developer, publisher, release_date, price, rating, description, genre_id, image_path) VALUES
(1, 'Cyberpunk 2077', 'CD PROJEKT RED', 'CD PROJEKT RED', '2020-12-10', 1999, 8.5, 'Ролевая игра с открытым миром в Найт-Сити.', 1, 'images/cyberpunk.jpg'),
(2, 'Elden Ring', 'FromSoftware', 'Bandai Namco', '2022-02-25', 2499, 9.5, 'Ролевая игра в жанре тёмного фэнтези.', 1, 'images/elden-ring.jpg'),
(3, 'Counter-Strike 2', 'Valve', 'Valve', '2023-09-27', 0, 8.0, 'Бесплатный тактический шутер.', 3, 'images/cs2.jpg'),
(4, 'Baldurs Gate 3', 'Larian Studios', 'Larian Studios', '2023-08-03', 1999, 9.8, 'Ролевая игра по D&D пятой редакции.', 1, 'images/baldurs-gate-3.jpg'),
(5, 'Civilization VI', 'Firaxis Games', '2K Games', '2016-10-21', 1499, 8.7, 'Пошаговая стратегия.', 4, 'images/civ6.jpg'),
(6, 'Zelda: Tears of the Kingdom', 'Nintendo', 'Nintendo', '2023-05-12', 3999, 9.7, 'Приключения Линка в Хайруле.', 5, 'images/zelda-totk.jpg'),
(7, 'FIFA 24', 'EA Sports', 'Electronic Arts', '2023-09-29', 2999, 7.5, 'Футбольный симулятор.', 7, 'images/fifa24.jpg'),
(8, 'Resident Evil 4 Remake', 'Capcom', 'Capcom', '2023-03-24', 2499, 9.2, 'Ремейк культового хоррора.', 8, 'images/resident-evil-4.jpg');

INSERT INTO game_platforms (game_id, platform_id) VALUES
(1,1),(1,2),(1,3),
(2,1),(2,2),(2,3),
(3,1),
(4,1),(4,2),(4,3),
(5,1),(5,2),(5,3),(5,4),
(6,4),
(7,1),(7,2),(7,3),
(8,1),(8,2),(8,3);

INSERT INTO system_requirements (game_id, type, os, processor, ram, gpu, storage) VALUES
(1,'min','64-bit Windows 10','Intel Core i5-3570K','8 GB','GTX 970','70 GB SSD'),
(1,'rec','64-bit Windows 10','Intel Core i7-4790','12 GB','GTX 1060','70 GB SSD'),
(2,'min','Windows 10','Intel Core i5-8400','12 GB','GTX 1060','60 GB'),
(2,'rec','Windows 11','Intel Core i7-8700K','16 GB','GTX 1070','60 GB SSD'),
(3,'min','Windows 10','Intel Core i5-750','8 GB','GTX 650','85 GB'),
(3,'rec','Windows 11','Intel Core i5-2400','16 GB','GTX 1060','85 GB SSD'),
(4,'min','Windows 10','Intel Core i5-4690','8 GB','GTX 970','150 GB SSD'),
(4,'rec','Windows 10','Intel Core i7-8700K','16 GB','RTX 2060','150 GB SSD'),
(5,'min','Windows 7','Intel Core i3','4 GB','Radeon HD 5570','17 GB'),
(5,'rec','Windows 10','Intel Core i5','8 GB','Radeon R9 380','17 GB SSD'),
(6,'min','Nintendo Switch','-','-','-','16 GB'),
(6,'rec','Nintendo Switch OLED','-','-','-','16 GB'),
(7,'min','Windows 10','Intel Core i5-6600K','8 GB','GTX 1050 Ti','100 GB'),
(7,'rec','Windows 11','Intel Core i7-6700','12 GB','GTX 1660','100 GB SSD'),
(8,'min','Windows 10','Intel Core i5-7500','8 GB','GTX 1050 Ti','50 GB'),
(8,'rec','Windows 11','Intel Core i7-8700','16 GB','RTX 2060','50 GB SSD');

INSERT INTO users (email, password_hash, nickname) VALUES
('player1@mail.ru', 'hash_123456', 'Игрок1'),
('admin@gamehub.ru', 'hash_admin', 'Админ'),
('gamer@mail.ru', 'hash_789', 'GamerPro');

INSERT INTO user_library (user_id, game_id, added_at) VALUES
(1,1,'2026-05-10 10:00:00'),
(1,4,'2026-05-12 14:30:00'),
(2,2,'2026-05-08 09:00:00'),
(2,8,'2026-05-15 16:00:00'),
(3,1,'2026-05-11 20:00:00'),
(3,5,'2026-05-13 11:00:00'),
(3,7,'2026-05-14 18:30:00');