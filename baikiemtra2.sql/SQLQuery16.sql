CREATE PROCEDURE sp_DanhSachDiem
AS
BEGIN
    SELECT SV.TenSV, MH.TenMH, D.Diem
    FROM SinhVien SV
    JOIN Diem D ON SV.MaSV = D.MaSV
    JOIN MonHoc MH ON MH.MaMH = D.MaMH;
END;