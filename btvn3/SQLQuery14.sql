CREATE TRIGGER trg_SanSangThanhLy
ON HopDong
AFTER UPDATE
AS
BEGIN

    UPDATE TaiSan
    SET TrangThai = N'Sẵn sàng thanh lý'
    WHERE MaTS IN
    (
        SELECT ct.MaTS
        FROM ChiTietHopDong ct
        JOIN HopDong hd
        ON ct.MaHD = hd.MaHD

        WHERE
            hd.TrangThai = N'Quá hạn'
            AND GETDATE() > hd.Deadline2
    );

END;