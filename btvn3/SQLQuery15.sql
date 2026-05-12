    CREATE TRIGGER trg_DaBanThanhLy
    ON HopDong
    AFTER UPDATE
    AS
    BEGIN

        UPDATE TaiSan
        SET TrangThai = N'Đã bán thanh lý'
        WHERE MaTS IN
        (
            SELECT ct.MaTS
            FROM ChiTietHopDong ct
            JOIN inserted i
            ON ct.MaHD = i.MaHD
            WHERE i.TrangThai = N'Đã thanh lý'
        );

    END;