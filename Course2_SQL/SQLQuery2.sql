--2.	�C�X�̨��w�諸�ѫe���W(�ɾ\�ƶq�̦h�e���W)

SELECT TOP(5) WITH TIES	bd.BOOK_ID AS BookId, 
		BOOK_NAME AS BookName,
		COUNT(*) AS QTY
FROM BOOK_LEND_RECORD AS blr
	INNER JOIN BOOK_DATA AS bd
		ON blr.BOOK_ID = bd.BOOK_ID
GROUP BY bd.BOOK_ID, BOOK_NAME
ORDER BY QTY DESC





