CREATE PROC sp_ThemTaiSan
(
    @MaHD INT,
    @TenTaiSan NVARCHAR(100),
    @GiaTriDinhGia DECIMAL(18,2)
)
AS
BEGIN

    INSERT INTO TaiSan
    (
        TenTaiSan,
        GiaTriDinhGia,
        TrangThai
    )
    VALUES
    (
        @TenTaiSan,
        @GiaTriDinhGia,
        N'Đang cầm cố'
    );

    DECLARE @MaTS INT = SCOPE_IDENTITY();

    INSERT INTO ChiTietHopDong
    VALUES(@MaHD, @MaTS);

END;