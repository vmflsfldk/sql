
CREATE PROCEDURE test1()
BEGIN
    DECLARE workyear INT DEFAULT 2024;
    DECLARE yearinput INT DEFAULT 10;
    DECLARE week_num INT;
    DECLARE total_weeks INT;

   
   -- 2030년까지 workyear 계산
    WHILE workyear <= 2030 DO
       -- 윤년 계산
      IF(workyear % 4 = 0 AND workyear % 100 <>0) OR workyear % 400 = 0
      THEN 
      SET total_weeks = 53;
      ELSE 
      SET total_weeks = 52;
   END IF;
	  SET week_num = 1;
        -- 첫 번째 주 부터 총 주 수(52주 또는 53주)까지 반복
        WHILE week_num <= total_weeks DO
            -- calendar1 테이블에 yearseq, workdate, MP_PERIOD을 삽입
            INSERT INTO calendar1 (yearseq, workdate, MP_PERIOD)
            VALUES (
                -- yearseq는 workyear와 LPAD를 통해 형식화된 yearinput 결합
                CONCAT(workyear, LPAD(CAST(yearinput AS CHAR), 6, '0')),
                -- workdate는 workyear
                workyear,
                -- MP_PERIOD는 workyear와 주 번호(week_num)를 조합
                CONCAT(workyear, LPAD(CAST(week_num AS CHAR), 2, '0'))
            );
            -- yearinput을 10씩 증가시킴
        SET yearinput = yearinput + 10;
            -- 주 번호를 1씩 증가시킴
            SET week_num = week_num + 1;
        END WHILE;
       -- yearinput을 10 초기화
        SET yearinput = 10;
        -- workyear를 1씩 증가시킴
        SET workyear = workyear + 1;
        -- 주 번호를 초기화
        SET week_num = 1;
    END WHILE;
END;
