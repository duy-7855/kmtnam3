CREATE PROCEDURE sp_ThemDiem
    @MaSV INT,
    @MaMH INT,
    @Diem FLOAT
AS
BEGIN
    IF @Diem < 0 OR @Diem > 10
    BEGIN
        PRINT N'Điểm không hợp lệ';
        RETURN;
    END

    INSERT INTO Diem VALUES (@MaSV, @MaMH, @Diem);
END;