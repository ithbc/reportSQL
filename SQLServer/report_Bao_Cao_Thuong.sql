select * FROM 
(select *,
		case 
			when ItmsGrpNam = N'08_MPĐ xăng' then N'08_MPĐ xăng'
			when ItmsGrpNam = N'05_MPĐ dầu' then N'05_MPĐ dầu'
			when ItmsGrpNam = N'07_Máy nông nghiệp' then N'07_Máy nông nghiệp'
			when ItmsGrpNam = N'02_Máy xây dựng' then N'02_Máy xây dựng'
			when ItmsGrpNam = N'03_Thiết bị NN' then
													case when  FirmName = N'KUBOTA' then N'03_Thiết bị NN_Kubota'
														when FirmName = N'GreenLand' then N'03_Thiết bị NN_GreenLand'
														else N'03_Thiết bị NN_Khác'
													end
			when ItmsGrpNam = N'06_Máy cắt cỏ'  then N'06_Máy cắt cỏ'
			when ItmsGrpNam = N'04_Phụ tùng CNN' then 
														case when  FirmName = N'KUBOTA' then N'04_Phụ tùng CNN_Kubota'
															else N'04_Phụ tùng CNN'
														end
				when ItmsGrpNam = N'01_Động cơ dầu'  then N'01_Động cơ dầu'
			else 'Others'
		end as ItemGroupThuong,
		case 
			when GroupName = N'04_Cust_Lẻ'  then 
				case 
					when BPType = 'N'then 1
					else 0.75
				end 
			when GroupName = N'03_Cust_Dự_Án'  then 
				case 
					when BPType = 'N'then 0.5
					else 0.3
				end 
			when GroupName = N'05_Cust_Xuất_Khẩu'  then 
				case 
					when BPType = 'N'then 0.4
					else 0.25
				end
			when GroupName = N'01_Cust_Nội_Bộ'  then 0.2
			when GroupName = N'02_Cust_Đại_Lý'  then 0.3
			else 0
		end as 'TLKH'
FROM (
select CorpName = 'HBC',a.DocEntry,a.DocStatus,a.CardCode,a.CardName,
	CASE 
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 3 and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].HBCCORP.dbo.OINV g where g.cardcode =a.CardCode)   then 'N'
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 6 and MONTH(b.CreateDate) >= 4  and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].HBCCORP.dbo.OINV g where g.cardcode =a.CardCode) then 'N'
	ELSE 'O'
	end as 'BPType'
,b.CreateDate,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,PaidDate=(select max(t1.ReconDate) FROM [192.168.3.9].HBCCORP.dbo.OITR t1 where ReconNum in (select ReconNum FROM [192.168.3.9].HBCCORP.dbo.ITR1  t2 where t2.SrcObjTyp = 13 and t2.SrcObjAbs = a.docentry ))
		,CASE 
			when e.TargetType = -1 then 'S'
			ELSE 'D'
		END as 'TargetType',
		FirmName = (select FirmName from [192.168.3.9].HBCCORP.dbo.OMRC  where FirmCode = f.FirmCode)

FROM	[192.168.3.9].HBCCORP.dbo.OINV a, 
		[192.168.3.9].HBCCORP.dbo.OCRD b, 
		[192.168.3.9].HBCCORP.dbo.OCRG c,
		[192.168.3.9].HBCCORP.dbo.OSLP d,
		[192.168.3.9].HBCCORP.dbo.INV1 e,
		[192.168.3.9].HBCCORP.dbo.OITM f,
		[192.168.3.9].HBCCORP.dbo.OITB g
where (YEAR(a.DocDate) >= '2020' and MONTH(a.DocDate) < 7)  and DocType = 'I' and a.CANCELED = 'N' and a.DocStatus = 'C'
and a.CardCode = b.CardCode and b.GroupCode = c.GroupCode
and a.SlpCode = d.SlpCode
and a.DocEnTry = e.DocEntry and e.TargetType != 14
and e.ItemCode = f.ItemCode 
and f.ItmsGrpCod = g.ItmsGrpCod
Group By a.DocEntry,a.DocStatus,a.CardCode,a.CardName,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,b.CreateDate,e.TargetType,FirmCode,f.ItmsGrpCod
) t1

union 

select *,
		case 
			when ItmsGrpNam = N'08_MPĐ xăng' then N'08_MPĐ xăng'
			when ItmsGrpNam = N'05_MPĐ dầu' then N'05_MPĐ dầu'
			when ItmsGrpNam = N'07_Máy nông nghiệp' then N'07_Máy nông nghiệp'
			when ItmsGrpNam = N'02_Máy xây dựng' then N'02_Máy xây dựng'
			when ItmsGrpNam = N'03_Thiết bị NN' then
													case when  FirmName = N'KUBOTA' then N'03_Thiết bị NN_Kubota'
														when FirmName = N'GreenLand' then N'03_Thiết bị NN_GreenLand'
														else N'03_Thiết bị NN_Khác'
													end
			when ItmsGrpNam = N'06_Máy cắt cỏ'  then N'06_Máy cắt cỏ'
			when ItmsGrpNam = N'04_Phụ tùng CNN' then 
														case when  FirmName = N'KUBOTA' then N'04_Phụ tùng CNN_Kubota'
															else N'04_Phụ tùng CNN'
														end
				when ItmsGrpNam = N'01_Động cơ dầu'  then N'01_Động cơ dầu'
			else 'Others'
		end as ItemGroupThuong,
		case 
			when GroupName = N'04_Cust_Lẻ'  then 
				case 
					when BPType = 'N'then 1
					else 0.75
				end 
			when GroupName = N'03_Cust_Dự_Án'  then 
				case 
					when BPType = 'N'then 0.5
					else 0.3
				end 
			when GroupName = N'05_Cust_Xuất_Khẩu'  then 
				case 
					when BPType = 'N'then 0.4
					else 0.25
				end
			when GroupName = N'01_Cust_Nội_Bộ'  then 0.2
			when GroupName = N'02_Cust_Đại_Lý'  then 0.3
			else 0
		end as 'TLKH'
FROM (
select CorpName = 'KBI',a.DocEntry,a.DocStatus,a.CardCode,a.CardName,
	CASE 
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 3 and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].KBI.dbo.OINV g where g.cardcode =a.CardCode)   then 'N'
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 6 and MONTH(b.CreateDate) >= 4  and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].KBI.dbo.OINV g where g.cardcode =a.CardCode) then 'N'
	ELSE 'O'
	end as 'BPType'
,b.CreateDate,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,PaidDate=(select max(t1.ReconDate) FROM [192.168.3.9].KBI.dbo.OITR t1 where ReconNum in (select ReconNum FROM [192.168.3.9].KBI.dbo.ITR1  t2 where t2.SrcObjTyp = 13 and t2.SrcObjAbs = a.docentry ))
		,CASE 
			when e.TargetType = -1 then 'S'
			ELSE 'D'
		END as 'TargetType',
		FirmName = (select FirmName from [192.168.3.9].KBI.dbo.OMRC  where FirmCode = f.FirmCode)

FROM	[192.168.3.9].KBI.dbo.OINV a, 
		[192.168.3.9].KBI.dbo.OCRD b, 
		[192.168.3.9].KBI.dbo.OCRG c,
		[192.168.3.9].KBI.dbo.OSLP d,
		[192.168.3.9].KBI.dbo.INV1 e,
		[192.168.3.9].KBI.dbo.OITM f,
		[192.168.3.9].KBI.dbo.OITB g
where (YEAR(a.DocDate) >= '2020' and MONTH(a.DocDate) < 7)  and DocType = 'I' and a.CANCELED = 'N' and a.DocStatus = 'C'
and a.CardCode = b.CardCode and b.GroupCode = c.GroupCode
and a.SlpCode = d.SlpCode
and a.DocEnTry = e.DocEntry and e.TargetType != 14
and e.ItemCode = f.ItemCode 
and f.ItmsGrpCod = g.ItmsGrpCod
Group By a.DocEntry,a.DocStatus,a.CardCode,a.CardName,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,b.CreateDate,e.TargetType,FirmCode,f.ItmsGrpCod
) t1

union 

select *,
		case 
			when ItmsGrpNam = N'08_MPĐ xăng' then N'08_MPĐ xăng'
			when ItmsGrpNam = N'05_MPĐ dầu' then N'05_MPĐ dầu'
			when ItmsGrpNam = N'07_Máy nông nghiệp' then N'07_Máy nông nghiệp'
			when ItmsGrpNam = N'02_Máy xây dựng' then N'02_Máy xây dựng'
			when ItmsGrpNam = N'03_Thiết bị NN' then
													case when  FirmName = N'KUBOTA' then N'03_Thiết bị NN_Kubota'
														when FirmName = N'GreenLand' then N'03_Thiết bị NN_GreenLand'
														else N'03_Thiết bị NN_Khác'
													end
			when ItmsGrpNam = N'06_Máy cắt cỏ'  then N'06_Máy cắt cỏ'
			when ItmsGrpNam = N'04_Phụ tùng CNN' then 
														case when  FirmName = N'KUBOTA' then N'04_Phụ tùng CNN_Kubota'
															else N'04_Phụ tùng CNN'
														end
				when ItmsGrpNam = N'01_Động cơ dầu'  then N'01_Động cơ dầu'
			else 'Others'
		end as ItemGroupThuong,
		case 
			when GroupName = N'04_Cust_Lẻ'  then 
				case 
					when BPType = 'N'then 1
					else 0.75
				end 
			when GroupName = N'03_Cust_Dự_Án'  then 
				case 
					when BPType = 'N'then 0.5
					else 0.3
				end 
			when GroupName = N'05_Cust_Xuất_Khẩu'  then 
				case 
					when BPType = 'N'then 0.4
					else 0.25
				end
			when GroupName = N'01_Cust_Nội_Bộ'  then 0.2
			when GroupName = N'02_Cust_Đại_Lý'  then 0.3
			else 0
		end as 'TLKH'
FROM (
select CorpName = 'AKBC',a.DocEntry,a.DocStatus,a.CardCode,a.CardName,
	CASE 
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 3 and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].AKBC.dbo.OINV g where g.cardcode =a.CardCode)   then 'N'
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 6 and MONTH(b.CreateDate) >= 4  and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].AKBC.dbo.OINV g where g.cardcode =a.CardCode) then 'N'
	ELSE 'O'
	end as 'BPType'
,b.CreateDate,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,PaidDate=(select max(t1.ReconDate) FROM [192.168.3.9].AKBC.dbo.OITR t1 where ReconNum in (select ReconNum FROM [192.168.3.9].AKBC.dbo.ITR1  t2 where t2.SrcObjTyp = 13 and t2.SrcObjAbs = a.docentry ))
		,CASE 
			when e.TargetType = -1 then 'S'
			ELSE 'D'
		END as 'TargetType',
		FirmName = (select FirmName from [192.168.3.9].AKBC.dbo.OMRC  where FirmCode = f.FirmCode)

FROM	[192.168.3.9].AKBC.dbo.OINV a, 
		[192.168.3.9].AKBC.dbo.OCRD b, 
		[192.168.3.9].AKBC.dbo.OCRG c,
		[192.168.3.9].AKBC.dbo.OSLP d,
		[192.168.3.9].AKBC.dbo.INV1 e,
		[192.168.3.9].AKBC.dbo.OITM f,
		[192.168.3.9].AKBC.dbo.OITB g
where (YEAR(a.DocDate) >= '2020' and MONTH(a.DocDate) < 7)  and DocType = 'I' and a.CANCELED = 'N' and a.DocStatus = 'C'
and a.CardCode = b.CardCode and b.GroupCode = c.GroupCode
and a.SlpCode = d.SlpCode
and a.DocEnTry = e.DocEntry and e.TargetType != 14
and e.ItemCode = f.ItemCode 
and f.ItmsGrpCod = g.ItmsGrpCod
Group By a.DocEntry,a.DocStatus,a.CardCode,a.CardName,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,b.CreateDate,e.TargetType,FirmCode,f.ItmsGrpCod
) t1

union 

select *,
		case 
			when ItmsGrpNam = N'08_MPĐ xăng' then N'08_MPĐ xăng'
			when ItmsGrpNam = N'05_MPĐ dầu' then N'05_MPĐ dầu'
			when ItmsGrpNam = N'07_Máy nông nghiệp' then N'07_Máy nông nghiệp'
			when ItmsGrpNam = N'02_Máy xây dựng' then N'02_Máy xây dựng'
			when ItmsGrpNam = N'03_Thiết bị NN' then
													case when  FirmName = N'KUBOTA' then N'03_Thiết bị NN_Kubota'
														when FirmName = N'GreenLand' then N'03_Thiết bị NN_GreenLand'
														else N'03_Thiết bị NN_Khác'
													end
			when ItmsGrpNam = N'06_Máy cắt cỏ'  then N'06_Máy cắt cỏ'
			when ItmsGrpNam = N'04_Phụ tùng CNN' then 
														case when  FirmName = N'KUBOTA' then N'04_Phụ tùng CNN_Kubota'
															else N'04_Phụ tùng CNN'
														end
				when ItmsGrpNam = N'01_Động cơ dầu'  then N'01_Động cơ dầu'
			else 'Others'
		end as ItemGroupThuong,
		case 
			when GroupName = N'04_Cust_Lẻ'  then 
				case 
					when BPType = 'N'then 1
					else 0.75
				end 
			when GroupName = N'03_Cust_Dự_Án'  then 
				case 
					when BPType = 'N'then 0.5
					else 0.3
				end 
			when GroupName = N'05_Cust_Xuất_Khẩu'  then 
				case 
					when BPType = 'N'then 0.4
					else 0.25
				end
			when GroupName = N'01_Cust_Nội_Bộ'  then 0.2
			when GroupName = N'02_Cust_Đại_Lý'  then 0.3
			else 0
		end as 'TLKH'
FROM (
select CorpName = 'HHBC',a.DocEntry,a.DocStatus,a.CardCode,a.CardName,
	CASE 
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 3 and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].HBC_DN.dbo.OINV g where g.cardcode =a.CardCode)   then 'N'
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 6 and MONTH(b.CreateDate) >= 4  and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].HBC_DN.dbo.OINV g where g.cardcode =a.CardCode) then 'N'
	ELSE 'O'
	end as 'BPType'
,b.CreateDate,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,PaidDate=(select max(t1.ReconDate) FROM [192.168.3.9].HBC_DN.dbo.OITR t1 where ReconNum in (select ReconNum FROM [192.168.3.9].HBC_DN.dbo.ITR1  t2 where t2.SrcObjTyp = 13 and t2.SrcObjAbs = a.docentry ))
		,CASE 
			when e.TargetType = -1 then 'S'
			ELSE 'D'
		END as 'TargetType',
		FirmName = (select FirmName from [192.168.3.9].HBC_DN.dbo.OMRC  where FirmCode = f.FirmCode)

FROM	[192.168.3.9].HBC_DN.dbo.OINV a, 
		[192.168.3.9].HBC_DN.dbo.OCRD b, 
		[192.168.3.9].HBC_DN.dbo.OCRG c,
		[192.168.3.9].HBC_DN.dbo.OSLP d,
		[192.168.3.9].HBC_DN.dbo.INV1 e,
		[192.168.3.9].HBC_DN.dbo.OITM f,
		[192.168.3.9].HBC_DN.dbo.OITB g
where (YEAR(a.DocDate) >= '2020' and MONTH(a.DocDate) < 7)  and DocType = 'I' and a.CANCELED = 'N' and a.DocStatus = 'C'
and a.CardCode = b.CardCode and b.GroupCode = c.GroupCode
and a.SlpCode = d.SlpCode
and a.DocEnTry = e.DocEntry and e.TargetType != 14
and e.ItemCode = f.ItemCode 
and f.ItmsGrpCod = g.ItmsGrpCod
Group By a.DocEntry,a.DocStatus,a.CardCode,a.CardName,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,b.CreateDate,e.TargetType,FirmCode,f.ItmsGrpCod
) t1

UNION 

select *,
		case 
			when ItmsGrpNam = N'08_MPĐ xăng' then N'08_MPĐ xăng'
			when ItmsGrpNam = N'05_MPĐ dầu' then N'05_MPĐ dầu'
			when ItmsGrpNam = N'07_Máy nông nghiệp' then N'07_Máy nông nghiệp'
			when ItmsGrpNam = N'02_Máy xây dựng' then N'02_Máy xây dựng'
			when ItmsGrpNam = N'03_Thiết bị NN' then
													case when  FirmName = N'KUBOTA' then N'03_Thiết bị NN_Kubota'
														when FirmName = N'GreenLand' then N'03_Thiết bị NN_GreenLand'
														else N'03_Thiết bị NN_Khác'
													end
			when ItmsGrpNam = N'06_Máy cắt cỏ'  then N'06_Máy cắt cỏ'
			when ItmsGrpNam = N'04_Phụ tùng CNN' then 
														case when  FirmName = N'KUBOTA' then N'04_Phụ tùng CNN_Kubota'
															else N'04_Phụ tùng CNN'
														end
				when ItmsGrpNam = N'01_Động cơ dầu'  then N'01_Động cơ dầu'
			else 'Others'
		end as ItemGroupThuong,
		case 
			when GroupName = N'04_Cust_Lẻ'  then 
				case 
					when BPType = 'N'then 1
					else 0.75
				end 
			when GroupName = N'03_Cust_Dự_Án'  then 
				case 
					when BPType = 'N'then 0.5
					else 0.3
				end 
			when GroupName = N'05_Cust_Xuất_Khẩu'  then 
				case 
					when BPType = 'N'then 0.4
					else 0.25
				end
			when GroupName = N'01_Cust_Nội_Bộ'  then 0.2
			when GroupName = N'02_Cust_Đại_Lý'  then 0.3
			else 0
		end as 'TLKH'
FROM (
select CorpName = 'TBC',a.DocEntry,a.DocStatus,a.CardCode,a.CardName,
	CASE 
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 3 and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].HBC_HN.dbo.OINV g where g.cardcode =a.CardCode)   then 'N'
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 6 and MONTH(b.CreateDate) >= 4  and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].HBC_HN.dbo.OINV g where g.cardcode =a.CardCode) then 'N'
	ELSE 'O'
	end as 'BPType'
,b.CreateDate,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,PaidDate=(select max(t1.ReconDate) FROM [192.168.3.9].HBC_HN.dbo.OITR t1 where ReconNum in (select ReconNum FROM [192.168.3.9].HBC_HN.dbo.ITR1  t2 where t2.SrcObjTyp = 13 and t2.SrcObjAbs = a.docentry ))
		,CASE 
			when e.TargetType = -1 then 'S'
			ELSE 'D'
		END as 'TargetType',
		FirmName = (select FirmName from [192.168.3.9].HBC_HN.dbo.OMRC  where FirmCode = f.FirmCode)

FROM	[192.168.3.9].HBC_HN.dbo.OINV a, 
		[192.168.3.9].HBC_HN.dbo.OCRD b, 
		[192.168.3.9].HBC_HN.dbo.OCRG c,
		[192.168.3.9].HBC_HN.dbo.OSLP d,
		[192.168.3.9].HBC_HN.dbo.INV1 e,
		[192.168.3.9].HBC_HN.dbo.OITM f,
		[192.168.3.9].HBC_HN.dbo.OITB g
where (YEAR(a.DocDate) >= '2020' and MONTH(a.DocDate) < 7)  and DocType = 'I' and a.CANCELED = 'N' and a.DocStatus = 'C'
and a.CardCode = b.CardCode and b.GroupCode = c.GroupCode
and a.SlpCode = d.SlpCode
and a.DocEnTry = e.DocEntry and e.TargetType != 14
and e.ItemCode = f.ItemCode 
and f.ItmsGrpCod = g.ItmsGrpCod
Group By a.DocEntry,a.DocStatus,a.CardCode,a.CardName,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,b.CreateDate,e.TargetType,FirmCode,f.ItmsGrpCod
) t1

UNION 

select *,
		case 
			when ItmsGrpNam = N'08_MPĐ xăng' then N'08_MPĐ xăng'
			when ItmsGrpNam = N'05_MPĐ dầu' then N'05_MPĐ dầu'
			when ItmsGrpNam = N'07_Máy nông nghiệp' then N'07_Máy nông nghiệp'
			when ItmsGrpNam = N'02_Máy xây dựng' then N'02_Máy xây dựng'
			when ItmsGrpNam = N'03_Thiết bị NN' then
													case when  FirmName = N'KUBOTA' then N'03_Thiết bị NN_Kubota'
														when FirmName = N'GreenLand' then N'03_Thiết bị NN_GreenLand'
														else N'03_Thiết bị NN_Khác'
													end
			when ItmsGrpNam = N'06_Máy cắt cỏ'  then N'06_Máy cắt cỏ'
			when ItmsGrpNam = N'04_Phụ tùng CNN' then 
														case when  FirmName = N'KUBOTA' then N'04_Phụ tùng CNN_Kubota'
															else N'04_Phụ tùng CNN'
														end
				when ItmsGrpNam = N'01_Động cơ dầu'  then N'01_Động cơ dầu'
			else 'Others'
		end as ItemGroupThuong,
		case 
			when GroupName = N'04_Cust_Lẻ'  then 
				case 
					when BPType = 'N'then 1
					else 0.75
				end 
			when GroupName = N'03_Cust_Dự_Án'  then 
				case 
					when BPType = 'N'then 0.5
					else 0.3
				end 
			when GroupName = N'05_Cust_Xuất_Khẩu'  then 
				case 
					when BPType = 'N'then 0.4
					else 0.25
				end
			when GroupName = N'01_Cust_Nội_Bộ'  then 0.2
			when GroupName = N'02_Cust_Đại_Lý'  then 0.3
			else 0
		end as 'TLKH'
FROM (
select CorpName = 'AKiBC',a.DocEntry,a.DocStatus,a.CardCode,a.CardName,
	CASE 
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 3 and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].HBC_LA.dbo.OINV g where g.cardcode =a.CardCode)   then 'N'
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 6 and MONTH(b.CreateDate) >= 4  and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].HBC_LA.dbo.OINV g where g.cardcode =a.CardCode) then 'N'
	ELSE 'O'
	end as 'BPType'
,b.CreateDate,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,PaidDate=(select max(t1.ReconDate) FROM [192.168.3.9].HBC_LA.dbo.OITR t1 where ReconNum in (select ReconNum FROM [192.168.3.9].HBC_LA.dbo.ITR1  t2 where t2.SrcObjTyp = 13 and t2.SrcObjAbs = a.docentry ))
		,CASE 
			when e.TargetType = -1 then 'S'
			ELSE 'D'
		END as 'TargetType',
		FirmName = (select FirmName from [192.168.3.9].HBC_LA.dbo.OMRC  where FirmCode = f.FirmCode)

FROM	[192.168.3.9].HBC_LA.dbo.OINV a, 
		[192.168.3.9].HBC_LA.dbo.OCRD b, 
		[192.168.3.9].HBC_LA.dbo.OCRG c,
		[192.168.3.9].HBC_LA.dbo.OSLP d,
		[192.168.3.9].HBC_LA.dbo.INV1 e,
		[192.168.3.9].HBC_LA.dbo.OITM f,
		[192.168.3.9].HBC_LA.dbo.OITB g
where (YEAR(a.DocDate) >= '2020' and MONTH(a.DocDate) < 7)  and DocType = 'I' and a.CANCELED = 'N' and a.DocStatus = 'C'
and a.CardCode = b.CardCode and b.GroupCode = c.GroupCode
and a.SlpCode = d.SlpCode
and a.DocEnTry = e.DocEntry and e.TargetType != 14
and e.ItemCode = f.ItemCode 
and f.ItmsGrpCod = g.ItmsGrpCod
Group By a.DocEntry,a.DocStatus,a.CardCode,a.CardName,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,b.CreateDate,e.TargetType,FirmCode,f.ItmsGrpCod
) t1

UNION 
select *,
		case 
			when ItmsGrpNam = N'08_MPĐ xăng' then N'08_MPĐ xăng'
			when ItmsGrpNam = N'05_MPĐ dầu' then N'05_MPĐ dầu'
			when ItmsGrpNam = N'07_Máy nông nghiệp' then N'07_Máy nông nghiệp'
			when ItmsGrpNam = N'02_Máy xây dựng' then N'02_Máy xây dựng'
			when ItmsGrpNam = N'03_Thiết bị NN' then
													case when  FirmName = N'KUBOTA' then N'03_Thiết bị NN_Kubota'
														when FirmName = N'GreenLand' then N'03_Thiết bị NN_GreenLand'
														else N'03_Thiết bị NN_Khác'
													end
			when ItmsGrpNam = N'06_Máy cắt cỏ'  then N'06_Máy cắt cỏ'
			when ItmsGrpNam = N'04_Phụ tùng CNN' then 
														case when  FirmName = N'KUBOTA' then N'04_Phụ tùng CNN_Kubota'
															else N'04_Phụ tùng CNN'
														end
				when ItmsGrpNam = N'01_Động cơ dầu'  then N'01_Động cơ dầu'
			else 'Others'
		end as ItemGroupThuong,
		case 
			when GroupName = N'04_Cust_Lẻ'  then 
				case 
					when BPType = 'N'then 1
					else 0.75
				end 
			when GroupName = N'03_Cust_Dự_Án'  then 
				case 
					when BPType = 'N'then 0.5
					else 0.3
				end 
			when GroupName = N'05_Cust_Xuất_Khẩu'  then 
				case 
					when BPType = 'N'then 0.4
					else 0.25
				end
			when GroupName = N'01_Cust_Nội_Bộ'  then 0.2
			when GroupName = N'02_Cust_Đại_Lý'  then 0.3
			else 0
		end as 'TLKH'
FROM (
select CorpName = 'GiBC',a.DocEntry,a.DocStatus,a.CardCode,a.CardName,
	CASE 
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 3 and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].HBC_TN.dbo.OINV g where g.cardcode =a.CardCode)   then 'N'
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 6 and MONTH(b.CreateDate) >= 4  and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].HBC_TN.dbo.OINV g where g.cardcode =a.CardCode) then 'N'
	ELSE 'O'
	end as 'BPType'
,b.CreateDate,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,PaidDate=(select max(t1.ReconDate) FROM [192.168.3.9].HBC_TN.dbo.OITR t1 where ReconNum in (select ReconNum FROM [192.168.3.9].HBC_TN.dbo.ITR1  t2 where t2.SrcObjTyp = 13 and t2.SrcObjAbs = a.docentry ))
		,CASE 
			when e.TargetType = -1 then 'S'
			ELSE 'D'
		END as 'TargetType',
		FirmName = (select FirmName from [192.168.3.9].HBC_TN.dbo.OMRC  where FirmCode = f.FirmCode)

FROM	[192.168.3.9].HBC_TN.dbo.OINV a, 
		[192.168.3.9].HBC_TN.dbo.OCRD b, 
		[192.168.3.9].HBC_TN.dbo.OCRG c,
		[192.168.3.9].HBC_TN.dbo.OSLP d,
		[192.168.3.9].HBC_TN.dbo.INV1 e,
		[192.168.3.9].HBC_TN.dbo.OITM f,
		[192.168.3.9].HBC_TN.dbo.OITB g
where (YEAR(a.DocDate) >= '2020' and MONTH(a.DocDate) < 7)  and DocType = 'I' and a.CANCELED = 'N' and a.DocStatus = 'C'
and a.CardCode = b.CardCode and b.GroupCode = c.GroupCode
and a.SlpCode = d.SlpCode
and a.DocEnTry = e.DocEntry and e.TargetType != 14
and e.ItemCode = f.ItemCode 
and f.ItmsGrpCod = g.ItmsGrpCod
Group By a.DocEntry,a.DocStatus,a.CardCode,a.CardName,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,b.CreateDate,e.TargetType,FirmCode,f.ItmsGrpCod
) t1

UNION 

select *,
		case 
			when ItmsGrpNam = N'08_MPĐ xăng' then N'08_MPĐ xăng'
			when ItmsGrpNam = N'05_MPĐ dầu' then N'05_MPĐ dầu'
			when ItmsGrpNam = N'07_Máy nông nghiệp' then N'07_Máy nông nghiệp'
			when ItmsGrpNam = N'02_Máy xây dựng' then N'02_Máy xây dựng'
			when ItmsGrpNam = N'03_Thiết bị NN' then
													case when  FirmName = N'KUBOTA' then N'03_Thiết bị NN_Kubota'
														when FirmName = N'GreenLand' then N'03_Thiết bị NN_GreenLand'
														else N'03_Thiết bị NN_Khác'
													end
			when ItmsGrpNam = N'06_Máy cắt cỏ'  then N'06_Máy cắt cỏ'
			when ItmsGrpNam = N'04_Phụ tùng CNN' then 
														case when  FirmName = N'KUBOTA' then N'04_Phụ tùng CNN_Kubota'
															else N'04_Phụ tùng CNN'
														end
				when ItmsGrpNam = N'01_Động cơ dầu'  then N'01_Động cơ dầu'
			else 'Others'
		end as ItemGroupThuong,
		case 
			when GroupName = N'04_Cust_Lẻ'  then 
				case 
					when BPType = 'N'then 1
					else 0.75
				end 
			when GroupName = N'03_Cust_Dự_Án'  then 
				case 
					when BPType = 'N'then 0.5
					else 0.3
				end 
			when GroupName = N'05_Cust_Xuất_Khẩu'  then 
				case 
					when BPType = 'N'then 0.4
					else 0.25
				end
			when GroupName = N'01_Cust_Nội_Bộ'  then 0.2
			when GroupName = N'02_Cust_Đại_Lý'  then 0.3
			else 0
		end as 'TLKH'
FROM (
select CorpName = 'LBCTT',a.DocEntry,a.DocStatus,a.CardCode,a.CardName,
	CASE 
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 3 and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].LBC_TT.dbo.OINV g where g.cardcode =a.CardCode)   then 'N'
	when YEAR(b.CreateDate) = 2020 and MONTH(b.CreateDate) <= 6 and MONTH(b.CreateDate) >= 4  and a.DocEntry =  (select min(g.docentry) from [192.168.3.9].LBC_TT.dbo.OINV g where g.cardcode =a.CardCode) then 'N'
	ELSE 'O'
	end as 'BPType'
,b.CreateDate,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,PaidDate=(select max(t1.ReconDate) FROM [192.168.3.9].LBC_TT.dbo.OITR t1 where ReconNum in (select ReconNum FROM [192.168.3.9].LBC_TT.dbo.ITR1  t2 where t2.SrcObjTyp = 13 and t2.SrcObjAbs = a.docentry ))
		,CASE 
			when e.TargetType = -1 then 'S'
			ELSE 'D'
		END as 'TargetType',
		FirmName = (select FirmName from [192.168.3.9].LBC_TT.dbo.OMRC  where FirmCode = f.FirmCode)

FROM	[192.168.3.9].LBC_TT.dbo.OINV a, 
		[192.168.3.9].LBC_TT.dbo.OCRD b, 
		[192.168.3.9].LBC_TT.dbo.OCRG c,
		[192.168.3.9].LBC_TT.dbo.OSLP d,
		[192.168.3.9].LBC_TT.dbo.INV1 e,
		[192.168.3.9].LBC_TT.dbo.OITM f,
		[192.168.3.9].LBC_TT.dbo.OITB g
where (YEAR(a.DocDate) >= '2020' and MONTH(a.DocDate) < 7)  and DocType = 'I' and a.CANCELED = 'N' and a.DocStatus = 'C'
and a.CardCode = b.CardCode and b.GroupCode = c.GroupCode
and a.SlpCode = d.SlpCode
and a.DocEnTry = e.DocEntry and e.TargetType != 14
and e.ItemCode = f.ItemCode 
and f.ItmsGrpCod = g.ItmsGrpCod
Group By a.DocEntry,a.DocStatus,a.CardCode,a.CardName,d.SlpName,c.GroupName,g.ItmsGrpNam,f.ItemName,e.LineTotal,b.CreateDate,e.TargetType,FirmCode,f.ItmsGrpCod
) t1
) Table2
where Year(PaidDate) = 2020