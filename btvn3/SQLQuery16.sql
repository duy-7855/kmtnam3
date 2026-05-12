CREATE PROC sp_GiaHanHopDong
(
    @MaHD INT,
    @Deadline1Moi DATE,
    @Deadline2Moi DATE
)
AS
BEGIN

    UPDATE HopDong
    SET
        Deadline1 = @Deadline1Moi,
        Deadline2 = @Deadline2Moi,
        TrangThai = N'Đang vay'
    WHERE MaHD = @MaHD;

END;