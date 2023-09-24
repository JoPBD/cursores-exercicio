-- 1.1 Escreva um cursor que exiba as variáveis rank e youtuber de toda tupla que tiver
-- video_count pelo menos igual a 1000 e cuja category seja igual a Sports ou Music.

DO $$
DECLARE
	v_video_count INT;
	v_category VARCHAR(200);
	cur_rank_youtuber REFCURSOR;
	v_rank INT;
 	v_youtuber VARCHAR(200);
BEGIN
    OPEN cur_rank_youtuber FOR SELECT rank, youtuber FROM tb_top_youtubers
        WHERE video_count >= 1000
            AND (category = 'Music' OR category = 'Sports');
	LOOP 
		FETCH cur_rank_youtuber INTO v_rank, v_youtuber;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE 'Contagem: % e Youtuber: %',v_rank, v_youtuber;
	END LOOP;
	CLOSE cur_rank_youtuber;
END; 
$$

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