
select a.DocEntry,a.CardCode,a.CardName,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName 
FROM	[192.168.3.9].KBI.dbo.OINV a, 
		[192.168.3.9].KBI.dbo.OCRD b, 
		[192.168.3.9].KBI.dbo.OCRG c,
		[192.168.3.9].KBI.dbo.OSLP d,
		[192.168.3.9].KBI.dbo.INV1 e,
		[192.168.3.9].KBI.dbo.OITM f,
		[192.168.3.9].KBI.dbo.OITB g
where YEAR(a.DocDate) >= '2020' and DocType = 'I'
and a.CardCode = b.CardCode and b.GroupCode = c.GroupCode
and a.SlpCode = d.SlpCode
and a.DocEnTry = e.DocEntry 
and e.ItemCode = f.ItemCode 
and f.ItmsGrpCod = g.ItmsGrpCod
Group By a.DocEntry,a.CardCode,a.CardName,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName