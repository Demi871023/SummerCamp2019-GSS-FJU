--3.	�H�@�u�C�X2019�~�C�@�u���y�ɾ\�Ѷq

--��l�g�k

SELECT CASE (MONTH(blr.LEND_DATE) - 1)/3
			WHEN 0 THEN '2019/01~2019/03'
			WHEN 1 THEN '2019/04~2019/06'
			WHEN 2 THEN '2019/07~2019/09'
			WHEN 3 THEN '2019/10~2019/12'
			END AS [Quarter],
			COUNT(*) AS Cnt
FROM BOOK_LEND_RECORD AS blr
WHERE YEAR(LEND_DATE) IN (2019)
GROUP BY (MONTH(LEND_DATE) - 1)/3

--��}�g�k�A�Q��SPAN_TABLE�ӹ����~�׻P�u�O

SELECT st.SPAN_YEAR + '/' + st.SPAN_START + '~' + st.SPAN_YEAR + '/' + st.SPAN_END AS [Quarter],
		COUNT(blr.BOOK_ID) AS Cnt
FROM BOOK_LEND_RECORD AS blr
	INNER JOIN SPAN_TABLE AS st
		ON YEAR(blr.LEND_DATE) = st.SPAN_YEAR
		AND MONTH(blr.LEND_DATE) BETWEEN st.SPAN_START AND st.SPAN_END
WHERE st.SPAN_YEAR = 2019
GROUP BY st.SPAN_YEAR, st.SPAN_START, st.SPAN_END
ORDER BY [Quarter]