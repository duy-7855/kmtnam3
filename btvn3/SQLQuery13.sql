CREATE TRIGGER trg_QuaHan
ON HopDong
AFTER UPDATE
AS
BEGIN

    UPDATE HopDong
    SET TrangThai = N'Quá hạn'
    WHERE
        TrangThai = N'Đang vay'
        AND GETDATE() > Deadline1;

END;