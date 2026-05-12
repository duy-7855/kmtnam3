CREATE PROC sp_TaoHopDong
(
    @MaKH INT,
    @SoTienGoc DECIMAL(18,2),
    @NgayVay DATE,
    @Deadline1 DATE,
    @Deadline2 DATE
)
AS
BEGIN

    INSERT INTO HopDong
    (
        MaKH,
        SoTienGoc,
        NgayVay,
        Deadline1,
        Deadline2,
        TrangThai
    )
    VALUES
    (
        @MaKH,
        @SoTienGoc,
        @NgayVay,
        @Deadline1,
        @Deadline2,
        N'Đang vay'
    );

END;