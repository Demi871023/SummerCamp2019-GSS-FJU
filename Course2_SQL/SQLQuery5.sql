--5.	請列出 2016, 2017, 2018, 2019 各書籍類別的借閱數量比較

SELECT	Result.BOOK_CLASS_ID AS ClassId, 
		Result.BOOK_CLASS_NAME AS ClassName, 
		SUM((CASE [year] WHEN 2016 THEN Result.num ELSE 0 END)) AS 'CNT2016',
		SUM((CASE [year] WHEN 2017 THEN Result.num ELSE 0 END)) AS 'CNT2017',
		SUM((CASE [year] WHEN 2018 THEN Result.num ELSE 0 END)) AS 'CNT2018',
		SUM((CASE [year] WHEN 2019 THEN Result.num ELSE 0 END)) AS 'CNT2019'
FROM (
		SELECT	bc.BOOK_CLASS_ID, 
				bc.BOOK_CLASS_NAME, 
				YEAR(blr.LEND_DATE) AS [year], 
				COUNT(bc.BOOK_CLASS_ID) AS num
		FROM BOOK_CLASS AS bc
			LEFT JOIN ( BOOK_DATA AS bd
				INNER JOIN BOOK_LEND_RECORD AS blr
					ON bd.BOOK_ID =  blr.BOOK_ID
				)
			ON bc.BOOK_CLASS_ID = bd.BOOK_CLASS_ID
		GROUP BY	bc.BOOK_CLASS_ID, 
					bc.BOOK_CLASS_NAME, 
					YEAR(blr.LEND_DATE)
	)Result
GROUP BY	Result.BOOK_CLASS_ID, 
			Result.BOOK_CLASS_NAME
ORDER BY Result.BOOK_CLASS_ID


