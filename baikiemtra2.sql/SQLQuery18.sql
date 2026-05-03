CREATE TRIGGER trg_CapNhatHocBong
ON Diem
AFTER INSERT
AS
BEGIN
    UPDATE SinhVien
    SET HocBong = HocBong + 100000
    WHERE MaSV IN (SELECT MaSV FROM inserted);
END;