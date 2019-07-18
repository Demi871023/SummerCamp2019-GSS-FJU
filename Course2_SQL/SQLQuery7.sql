--7.	請查詢出李四的借書紀錄，其中包含書本ID、購書日期(yyyy/mm/dd)、借閱日期(yyyy/mm/dd)、書籍類別(id-name)、借閱人(id-cname(ename))、狀態(id-name)、購書金額

SELECT	bd.BOOK_ID AS 書本ID,
		CONVERT(VARCHAR(10),bd.BOOK_BOUGHT_DATE,111) AS 購書日期,
		CONVERT(VARCHAR(10),blr.LEND_DATE,111) AS 借閱日期,
		bcla.BOOK_CLASS_ID + '-' + bcla.BOOK_CLASS_NAME AS 書籍類別,
		blr.KEEPER_ID+'-'+mm.USER_CNAME+'('+mm.USER_ENAME+')' AS 借閱人,
		bd.BOOK_STATUS + '-' + bcod.CODE_NAME AS 狀態,
		REPLACE(CONVERT(NVARCHAR(20),CAST(bd.BOOK_AMOUNT AS Money) ,1),'.00','') + '元' AS 購買金額
FROM BOOK_LEND_RECORD AS blr
	INNER JOIN BOOK_DATA AS bd
		ON blr.BOOK_ID = bd.BOOK_ID
	INNER JOIN MEMBER_M AS mm
		ON blr.KEEPER_ID = mm.[USER_ID]
	INNER JOIN BOOK_CLASS AS bcla
		ON bd.BOOK_CLASS_ID = bcla.BOOK_CLASS_ID
	INNER JOIN BOOK_CODE AS bcod
		ON bd.BOOK_STATUS =  bcod.CODE_ID AND bcod.CODE_TYPE='BOOK_STATUS'
WHERE blr.KEEPER_ID = 0002
ORDER BY bd.BOOK_AMOUNT DESC



