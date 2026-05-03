DECLARE cur CURSOR FOR
SELECT MaSV FROM SinhVien;

DECLARE @MaSV INT;
DECLARE @DTB FLOAT;

OPEN cur;
FETCH NEXT FROM cur INTO @MaSV;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @DTB = dbo.fn_TinhDiemTB(@MaSV);

    IF @DTB > 8
        UPDATE SinhVien
        SET HocBong = HocBong + 500000
        WHERE MaSV = @MaSV;

    FETCH NEXT FROM cur INTO @MaSV;
END;

CLOSE cur;
DEALLOCATE cur;