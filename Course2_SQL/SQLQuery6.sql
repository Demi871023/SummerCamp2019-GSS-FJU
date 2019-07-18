--6.	請使用 PIVOT 語法列出2016, 2017, 2018, 2019 各書籍類別的借閱數量比較，Sample如第五題

SELECT	PivotTable.BOOK_CLASS_ID AS ClassId, 
		PivotTable.BOOK_CLASS_NAME AS ClassName, 
		CASE WHEN PivotTable.[2016] IS NULL THEN '0' ELSE PivotTable.[2016] END AS 'CNT2016',
		CASE WHEN PivotTable.[2017] IS NULL THEN '0' ELSE PivotTable.[2017] END AS 'CNT2017',
		CASE WHEN PivotTable.[2018] IS NULL THEN '0' ELSE PivotTable.[2018] END AS 'CNT2018',
		CASE WHEN PivotTable.[2019] IS NULL THEN '0' ELSE PivotTable.[2019] END AS 'CNT2019'
FROM(
	SELECT	bc.BOOK_CLASS_ID,
			bc.BOOK_CLASS_NAME,
			YEAR(blr.LEND_DATE) as [year],
			COUNT(bc.BOOK_CLASS_ID) as Cnt
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
PIVOT(
	SUM(Result.Cnt)
	FOR Result.[year] IN ([2016], [2017], [2018], [2019])

)AS PivotTable
ORDER BY PivotTable.BOOK_CLASS_ID