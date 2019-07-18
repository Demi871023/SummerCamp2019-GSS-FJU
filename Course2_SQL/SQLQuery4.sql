--4.	撈出每個分類借閱數量前三名書本及數量

SELECT Result.Seq, Result.BookClass, Result.BookId, Result.BookName, Result.Cnt
FROM(
	SELECT	ROW_NUMBER() OVER (PARTITION BY bc.BOOK_CLASS_NAME ORDER BY COUNT(bd.BOOK_ID)DESC) AS Seq, 
			bc.BOOK_CLASS_NAME AS BookClass,
			bd.BOOK_ID AS BookId,
			bd.BOOK_NAME AS BookName,
			COUNT(bd.BOOK_ID) AS Cnt
	FROM BOOK_CLASS AS bc
		LEFT JOIN (BOOK_DATA AS bd
			INNER JOIN BOOK_LEND_RECORD AS blr
				ON bd.BOOK_ID = blr.BOOK_ID
		)
		ON bc.BOOK_CLASS_ID = bd.BOOK_CLASS_ID

	GROUP BY	bc.BOOK_CLASS_NAME, 
				bd.BOOK_ID,
				bd.BOOK_NAME
)Result
WHERE Seq <= 3
ORDER BY	Result.BookClass,
			Result.Cnt DESC, 
			Result.BookId
