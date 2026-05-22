SELECT title, developer, price, rating FROM games WHERE price = 0 AND rating > 7;

INSERT INTO games (title, developer, publisher, release_date, price, rating, description, genre_id)
VALUES ('Minecraft', 'Mojang', 'Microsoft', '2011-11-18', 1499, 9.0, 'Песочница', 6);
SELECT id, title, developer, price, rating FROM games WHERE title = 'Minecraft';

UPDATE games SET price = ROUND(price * 0.8, 0) WHERE price > 2000;
SELECT title, price FROM games WHERE title IN ('Elden Ring', 'FIFA 24', 'Zelda: Tears of the Kingdom', 'Resident Evil 4 Remake');

DELETE FROM user_library WHERE user_id = 1 AND game_id = 4;
SELECT u.nickname, g.title, ul.added_at FROM user_library ul JOIN users u ON ul.user_id = u.id JOIN games g ON ul.game_id = g.id WHERE u.id = 1;

SELECT u.nickname, g.title, gen.name, g.price, GROUP_CONCAT(p.name) AS platforms, ul.added_at, min_r.processor, rec_r.processor
FROM user_library ul JOIN users u ON ul.user_id = u.id JOIN games g ON ul.game_id = g.id JOIN genres gen ON g.genre_id = gen.id
LEFT JOIN game_platforms gp ON g.id = gp.game_id LEFT JOIN platforms p ON gp.platform_id = p.id
LEFT JOIN system_requirements min_r ON g.id = min_r.game_id AND min_r.type = 'min'
LEFT JOIN system_requirements rec_r ON g.id = rec_r.game_id AND rec_r.type = 'rec'
GROUP BY ul.id ORDER BY ul.added_at DESC;