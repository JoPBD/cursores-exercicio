-- 1.2 Escreva um cursor que exibe todos os nomes dos youtubers em ordem reversa. Para tal
-- - O SELECT deverá ordenar em ordem não reversa
-- - O Cursor deverá ser movido para a última tupla
-- - Os dados deverão ser exibidos de baixo para cima

DO $$
	DECLARE
		cur_youtubers_reverse REFCURSOR;
		tupla RECORD;
	BEGIN
		OPEN cur_youtubers_reverse SCROLL FOR
		SELECT * FROM tb_top_youtubers;
		LOOP
			FETCH cur_youtubers_reverse INTO tupla;
			EXIT WHEN NOT FOUND;
			IF tupla.youtuber IS NULL THEN
					DELETE FROM tb_top_youtubers WHERE CURRENT OF cur_youtubers_reverse;
			END IF;
		END LOOP;
		LOOP
			FETCH BACKWARD FROM cur_youtubers_reverse INTO tupla;
			EXIT WHEN NOT FOUND;
			RAISE NOTICE '%', tupla;
		END LOOP;
	CLOSE cur_youtubers_reverse;
END;
$$

-- 1.1 Escreva um cursor que exiba as variáveis rank e youtuber de toda tupla que tiver
-- video_count pelo menos igual a 1000 e cuja category seja igual a Sports ou Music.

-- DO $$
-- DECLARE
-- 	v_video_count INT;
-- 	v_category VARCHAR(200);
-- 	cur_rank_youtuber REFCURSOR;
-- 	v_rank INT;
--  	v_youtuber VARCHAR(200);
-- BEGIN
--     OPEN cur_rank_youtuber FOR SELECT rank, youtuber FROM tb_top_youtubers
--         WHERE video_count >= 1000
--             AND (category = 'Music' OR category = 'Sports');
-- 	LOOP 
-- 		FETCH cur_rank_youtuber INTO v_rank, v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE 'Contagem: % e Youtuber: %',v_rank, v_youtuber;
-- 	END LOOP;
-- 	CLOSE cur_rank_youtuber;
-- END; 
-- $$

-- CREATE TABLE tb_top_youtubers(
-- cod_top_youtubers SERIAL PRIMARY KEY,
-- rank INT,
-- youtuber VARCHAR(200),
-- subscribers INT,
-- video_views VARCHAR(200),
-- video_count INT,
-- category VARCHAR(200),
-- started INT
-- );