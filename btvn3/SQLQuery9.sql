CREATE FUNCTION fn_CalcMoneyContract
(
    @MaHD INT,
    @TargetDate DATE
)
RETURNS DECIMAL(18,2)
AS
BEGIN

    DECLARE
        @TienGoc DECIMAL(18,2),
        @NgayVay DATE,
        @Deadline1 DATE,

        @SoNgay INT,
        @SoNgayLaiDon INT,
        @SoNgayLaiKep INT,

        @TienSauLaiDon DECIMAL(18,2),
        @TongTien DECIMAL(18,2),

        @Lai FLOAT = 0.005;

    SELECT
        @TienGoc = SoTienGoc,
        @NgayVay = NgayVay,
        @Deadline1 = Deadline1
    FROM HopDong
    WHERE MaHD = @MaHD;

    SET @SoNgay = DATEDIFF(DAY, @NgayVay, @TargetDate);

    IF @TargetDate <= @Deadline1
    BEGIN

        SET @TongTien =
            @TienGoc +
            (@TienGoc * @Lai * @SoNgay);

    END

    ELSE
    BEGIN

        SET @SoNgayLaiDon =
            DATEDIFF(DAY, @NgayVay, @Deadline1);

        SET @SoNgayLaiKep =
            DATEDIFF(DAY, @Deadline1, @TargetDate);

        SET @TienSauLaiDon =
            @TienGoc +
            (@TienGoc * @Lai * @SoNgayLaiDon);

        SET @TongTien =
            @TienSauLaiDon *
            POWER((1 + @Lai), @SoNgayLaiKep);

    END

    RETURN @TongTien;

END;