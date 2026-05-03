CREATE FUNCTION fn_PhanLoaiHocLuc ()
RETURNS @KQ TABLE (
    MaSV INT,
    TenSV NVARCHAR(100),
    DTB FLOAT,
    HocLuc NVARCHAR(50)
)
AS
BEGIN
    INSERT INTO @KQ
    SELECT 
        SV.MaSV,
        SV.TenSV,
        AVG(D.Diem),
        CASE 
            WHEN AVG(D.Diem) >= 8 THEN N'Giỏi'
            WHEN AVG(D.Diem) >= 6.5 THEN N'Khá'
            ELSE N'Trung bình'
        END
    FROM SinhVien SV
    JOIN Diem D ON SV.MaSV = D.MaSV
    GROUP BY SV.MaSV, SV.TenSV;

    RETURN;
END;