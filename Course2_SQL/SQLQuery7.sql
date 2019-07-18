--7.	�Ьd�ߥX���|���ɮѬ����A�䤤�]�t�ѥ�ID�B�ʮѤ��(yyyy/mm/dd)�B�ɾ\���(yyyy/mm/dd)�B���y���O(id-name)�B�ɾ\�H(id-cname(ename))�B���A(id-name)�B�ʮѪ��B

SELECT	bd.BOOK_ID AS �ѥ�ID,
		CONVERT(VARCHAR(10),bd.BOOK_BOUGHT_DATE,111) AS �ʮѤ��,
		CONVERT(VARCHAR(10),blr.LEND_DATE,111) AS �ɾ\���,
		bcla.BOOK_CLASS_ID + '-' + bcla.BOOK_CLASS_NAME AS ���y���O,
		blr.KEEPER_ID+'-'+mm.USER_CNAME+'('+mm.USER_ENAME+')' AS �ɾ\�H,
		bd.BOOK_STATUS + '-' + bcod.CODE_NAME AS ���A,
		REPLACE(CONVERT(NVARCHAR(20),CAST(bd.BOOK_AMOUNT AS Money) ,1),'.00','') + '��' AS �ʶR���B
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



