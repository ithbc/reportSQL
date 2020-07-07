select t2.SlpName,t0.CardName,t0.CardCode,T0.DocStatus, T0.DocDate,T0.DocNum,t1.LineTotal,t1.Price,t1.Quantity,t1.Dscription,t1.ItemCode
from	OINV T0		INNER JOIN INV1 T1 ON T0.[DocEntry] = T1.[DocEntry] 
					INNER JOIN OSLP T2 ON T0.[SlpCode] = T2.[SlpCode] 
where t1.SlpCode in (22,23,24,25) and year(t0.DocDate)=2020 and T1.TargetType<>14



SELECT        T3.SlpName, T2.CardCode, T2.CardName, T2.CreditLine, T2.Balance,T0.DocDate, MONTH(T0.DocDate) AS Thang, DATEDIFF(DAY, T0.DocDate, 
                         GETDATE()) - 30 AS Days, (CASE WHEN ((DATEDIFF(DAY, T0.[DocDate], getdate())) - 30) < 15 AND balance > 0 THEN linetotal ELSE 0 END) AS duoi15, (CASE WHEN ((DATEDIFF(DAY, T0.[DocDate], getdate())) - 30) >= 15 AND 
                         ((DATEDIFF(DAY, T0.[DocDate], getdate())) - 30) < 30 AND balance > 0 THEN linetotal ELSE 0 END) AS duoi30, (CASE WHEN ((DATEDIFF(DAY, T0.[DocDate], getdate())) - 30) >= 30 AND ((DATEDIFF(DAY, T0.[DocDate], getdate())) - 30) 
                         < 45 AND balance > 0 THEN linetotal ELSE 0 END) AS duoi45, (CASE WHEN ((DATEDIFF(DAY, T0.[DocDate], getdate())) - 30) > 45 AND balance > 0 THEN linetotal ELSE 0 END) AS tren45
FROM            OINV AS T0 INNER JOIN
                         INV1 AS T1 ON T0.DocEntry = T1.DocEntry INNER JOIN
                         OCRD AS T2 ON T0.CardCode = T2.CardCode
						 INNER JOIN OSLP T3 ON T0.[SlpCode] = T3.[SlpCode] 
WHERE        t1.SlpCode in (22,23,24,25) and year(t0.DocDate)=2020 and T1.TargetType<>14