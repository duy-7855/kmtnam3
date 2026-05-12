CREATE PROC sp_ThanhToan
(
    @MaHD INT,
    @SoTienTra DECIMAL(18,2),
    @NguoiThu NVARCHAR(100)
)
AS
BEGIN

    DECLARE
        @TongNo DECIMAL(18,2),
        @DaTra DECIMAL(18,2),
        @ConNo DECIMAL(18,2),
        @TrangThai NVARCHAR(50);

    SELECT @TrangThai = TrangThai
    FROM HopDong
    WHERE MaHD = @MaHD;

    IF @TrangThai = N'Đã thanh lý'
    BEGIN
        PRINT N'Tài sản đã thanh lý';
        RETURN;
    END

    SET @TongNo =
        dbo.fn_CalcMoneyContract(@MaHD, GETDATE());

    SELECT
        @DaTra = ISNULL(SUM(SoTienTra),0)
    FROM ThanhToan
    WHERE MaHD = @MaHD;

    SET @ConNo =
        @TongNo - @DaTra - @SoTienTra;

    INSERT INTO ThanhToan
    (
        MaHD,
        NgayTra,
        SoTienTra,
        NguoiThu
    )
    VALUES
    (
        @MaHD,
        GETDATE(),
        @SoTienTra,
        @NguoiThu
    );

    IF @ConNo <= 0
    BEGIN

        UPDATE HopDong
        SET TrangThai = N'Đã thanh toán'
        WHERE MaHD = @MaHD;

        UPDATE TaiSan
        SET TrangThai = N'Đã trả khách'
        WHERE MaTS IN
        (
            SELECT MaTS
            FROM ChiTietHopDong
            WHERE MaHD = @MaHD
        );

    END

    ELSE
    BEGIN

        UPDATE HopDong
        SET TrangThai = N'Đang trả góp'
        WHERE MaHD = @MaHD;

        PRINT N'Còn nợ: ' + CAST(@ConNo AS NVARCHAR);

    END

END;