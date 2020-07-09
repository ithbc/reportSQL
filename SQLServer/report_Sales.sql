SELECT Corp='AKBC', T4.[ItmsGrpNam] as "ItemGroup", T3.[FirmName] as "Brand", T6.[GroupName] as "Channel", sum(T0.[Quantity]) as "Quantity", sum(T0.[LineTotal]) as "SalesAmount", month(T1.[DocDate]) as "Month", year(T1.[DocDate]) as "Year" 
FROM AKBC.dbo.INV1 T0  inner join AKBC.dbo.OINV T1 on T0.[DocEntry] = T1.[DocEntry] inner join AKBC.dbo.OITM T2 on T0.[ItemCode] = T2.[ItemCode] inner join AKBC.dbo.OMRC T3 on T2.[FirmCode] = T3.[FirmCode] inner join AKBC.dbo.OITB T4 on T2.[ItmsGrpCod] = T4.[ItmsGrpCod] inner join AKBC.dbo.OCRD T5 on T0.[BaseCard] = T5.[CardCode] inner join AKBC.dbo.OCRG T6 on T5.[GroupCode] = T6.[GroupCode] 
WHERE YEAR(T1.DocDate) >= 2019 and T1.[Canceled]='N' and T0.[TargetType]<>14 GROUP BY T4.[ItmsGrpNam], T3.[FirmName], T6.[GroupName], month(T1.[DocDate]), year(T1.[DocDate])
union
SELECT Corp='HHBC',T4.[ItmsGrpNam] as "ItemGroup", T3.[FirmName] as "Brand", T6.[GroupName] as "Channel", sum(T0.[Quantity]) as "Quantity", sum(T0.[LineTotal]) as "SalesAmount", month(T1.[DocDate]) as "Month", year(T1.[DocDate]) as "Year" 
FROM HBC_DN.dbo.INV1 T0  inner join HBC_DN.dbo.OINV T1 on T0.[DocEntry] = T1.[DocEntry] inner join HBC_DN.dbo.OITM T2 on T0.[ItemCode] = T2.[ItemCode] 
inner join HBC_DN.dbo.OMRC T3 on T2.[FirmCode] = T3.[FirmCode] inner join HBC_DN.dbo.OITB T4 on T2.[ItmsGrpCod] = T4.[ItmsGrpCod] inner join HBC_DN.dbo.OCRD T5 on T0.[BaseCard] = T5.[CardCode] 
inner join HBC_DN.dbo.OCRG T6 on T5.[GroupCode] = T6.[GroupCode] 
WHERE YEAR(T1.DocDate) >= 2019 and T1.[Canceled]='N' and T0.[TargetType]<>14 GROUP BY T4.[ItmsGrpNam], T3.[FirmName], T6.[GroupName], month(T1.[DocDate]), year(T1.[DocDate])
union
SELECT Corp='TBC',T4.[ItmsGrpNam] as "ItemGroup", T3.[FirmName] as "Brand", T6.[GroupName] as "Channel", sum(T0.[Quantity]) as "Quantity", sum(T0.[LineTotal]) as "SalesAmount", month(T1.[DocDate]) as "Month", year(T1.[DocDate]) as "Year" 
FROM HBC_HN.dbo.INV1 T0  inner join HBC_HN.dbo.OINV T1 on T0.[DocEntry] = T1.[DocEntry] inner join HBC_HN.dbo.OITM T2 on T0.[ItemCode] = T2.[ItemCode] 
inner join HBC_HN.dbo.OMRC T3 on T2.[FirmCode] = T3.[FirmCode] inner join HBC_HN.dbo.OITB T4 on T2.[ItmsGrpCod] = T4.[ItmsGrpCod] inner join HBC_HN.dbo.OCRD T5 on T0.[BaseCard] = T5.[CardCode] 
inner join HBC_HN.dbo.OCRG T6 on T5.[GroupCode] = T6.[GroupCode] 
WHERE YEAR(T1.DocDate) >= 2019 and T1.[Canceled]='N' and T0.[TargetType]<>14 GROUP BY T4.[ItmsGrpNam], T3.[FirmName], T6.[GroupName], month(T1.[DocDate]), year(T1.[DocDate])
union
SELECT Corp='AKiBC',T4.[ItmsGrpNam] as "ItemGroup", T3.[FirmName] as "Brand", T6.[GroupName] as "Channel", sum(T0.[Quantity]) as "Quantity", sum(T0.[LineTotal]) as "SalesAmount", month(T1.[DocDate]) as "Month", year(T1.[DocDate]) as "Year" 
FROM HBC_LA.dbo.INV1 T0  inner join HBC_LA.dbo.OINV T1 on T0.[DocEntry] = T1.[DocEntry] inner join HBC_LA.dbo.OITM T2 on T0.[ItemCode] = T2.[ItemCode] 
inner join HBC_LA.dbo.OMRC T3 on T2.[FirmCode] = T3.[FirmCode] inner join HBC_LA.dbo.OITB T4 on T2.[ItmsGrpCod] = T4.[ItmsGrpCod] inner join HBC_LA.dbo.OCRD T5 on T0.[BaseCard] = T5.[CardCode] 
inner join HBC_LA.dbo.OCRG T6 on T5.[GroupCode] = T6.[GroupCode] 
WHERE YEAR(T1.DocDate) >= 2019 and T1.[Canceled]='N' and T0.[TargetType]<>14 GROUP BY T4.[ItmsGrpNam], T3.[FirmName], T6.[GroupName], month(T1.[DocDate]), year(T1.[DocDate])
union
SELECT Corp='GiBC',T4.[ItmsGrpNam] as "ItemGroup", T3.[FirmName] as "Brand", T6.[GroupName] as "Channel", sum(T0.[Quantity]) as "Quantity", sum(T0.[LineTotal]) as "SalesAmount", month(T1.[DocDate]) as "Month", year(T1.[DocDate]) as "Year" 
FROM HBC_TN.dbo.INV1 T0  inner join HBC_TN.dbo.OINV T1 on T0.[DocEntry] = T1.[DocEntry] inner join HBC_TN.dbo.OITM T2 on T0.[ItemCode] = T2.[ItemCode] 
inner join HBC_TN.dbo.OMRC T3 on T2.[FirmCode] = T3.[FirmCode] inner join HBC_TN.dbo.OITB T4 on T2.[ItmsGrpCod] = T4.[ItmsGrpCod] inner join HBC_TN.dbo.OCRD T5 on T0.[BaseCard] = T5.[CardCode] 
inner join HBC_TN.dbo.OCRG T6 on T5.[GroupCode] = T6.[GroupCode] 
WHERE YEAR(T1.DocDate) >= 2019 and T1.[Canceled]='N' and T0.[TargetType]<>14 GROUP BY T4.[ItmsGrpNam], T3.[FirmName], T6.[GroupName], month(T1.[DocDate]), year(T1.[DocDate])
union
SELECT Corp='HBC',T4.[ItmsGrpNam] as "ItemGroup", T3.[FirmName] as "Brand", T6.[GroupName] as "Channel", sum(T0.[Quantity]) as "Quantity", sum(T0.[LineTotal]) as "SalesAmount", month(T1.[DocDate]) as "Month", year(T1.[DocDate]) as "Year" 
FROM HBCCORP.dbo.INV1 T0  inner join HBCCORP.dbo.OINV T1 on T0.[DocEntry] = T1.[DocEntry] inner join HBCCORP.dbo.OITM T2 on T0.[ItemCode] = T2.[ItemCode] 
inner join HBCCORP.dbo.OMRC T3 on T2.[FirmCode] = T3.[FirmCode] inner join HBCCORP.dbo.OITB T4 on T2.[ItmsGrpCod] = T4.[ItmsGrpCod] inner join HBCCORP.dbo.OCRD T5 on T0.[BaseCard] = T5.[CardCode] 
inner join HBCCORP.dbo.OCRG T6 on T5.[GroupCode] = T6.[GroupCode] 
WHERE YEAR(T1.DocDate) >= 2019 and T1.[Canceled]='N' and T0.[TargetType]<>14 GROUP BY T4.[ItmsGrpNam], T3.[FirmName], T6.[GroupName], month(T1.[DocDate]), year(T1.[DocDate])
union
SELECT Corp='KBI',T4.[ItmsGrpNam] as "ItemGroup", T3.[FirmName] as "Brand", T6.[GroupName] as "Channel", sum(T0.[Quantity]) as "Quantity", sum(T0.[LineTotal]) as "SalesAmount", month(T1.[DocDate]) as "Month", year(T1.[DocDate]) as "Year" 
FROM KBI.dbo.INV1 T0  inner join KBI.dbo.OINV T1 on T0.[DocEntry] = T1.[DocEntry] inner join KBI.dbo.OITM T2 on T0.[ItemCode] = T2.[ItemCode] 
inner join KBI.dbo.OMRC T3 on T2.[FirmCode] = T3.[FirmCode] inner join KBI.dbo.OITB T4 on T2.[ItmsGrpCod] = T4.[ItmsGrpCod] inner join KBI.dbo.OCRD T5 on T0.[BaseCard] = T5.[CardCode] 
inner join KBI.dbo.OCRG T6 on T5.[GroupCode] = T6.[GroupCode] 
WHERE YEAR(T1.DocDate) >= 2019 and T1.[Canceled]='N' and T0.[TargetType]<>14 GROUP BY T4.[ItmsGrpNam], T3.[FirmName], T6.[GroupName], month(T1.[DocDate]), year(T1.[DocDate])
union
SELECT Corp='LBCTT',T4.[ItmsGrpNam] as "ItemGroup", T3.[FirmName] as "Brand", T6.[GroupName] as "Channel", sum(T0.[Quantity]) as "Quantity", sum(T0.[LineTotal]) as "SalesAmount", month(T1.[DocDate]) as "Month", year(T1.[DocDate]) as "Year" 
FROM LBC_TT.dbo.INV1 T0  inner join LBC_TT.dbo.OINV T1 on T0.[DocEntry] = T1.[DocEntry] inner join LBC_TT.dbo.OITM T2 on T0.[ItemCode] = T2.[ItemCode] 
inner join LBC_TT.dbo.OMRC T3 on T2.[FirmCode] = T3.[FirmCode] inner join LBC_TT.dbo.OITB T4 on T2.[ItmsGrpCod] = T4.[ItmsGrpCod] inner join LBC_TT.dbo.OCRD T5 on T0.[BaseCard] = T5.[CardCode] 
inner join LBC_TT.dbo.OCRG T6 on T5.[GroupCode] = T6.[GroupCode] 
WHERE Year(T1.[DocDate])>='2019' and T1.[Canceled]='N' and T0.[TargetType]<>14 GROUP BY T4.[ItmsGrpNam], T3.[FirmName], T6.[GroupName], month(T1.[DocDate]), year(T1.[DocDate])