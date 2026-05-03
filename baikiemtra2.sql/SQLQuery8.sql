CREATE FUNCTION fn_SinhVienDiemCao (@DiemMin FLOAT)
RETURNS TABLE
AS
RETURN
(
    SELECT SV.[MaSV], SV.[TenSV], D.[Diem]
    FROM [SinhVien] SV
    JOIN [Diem] D ON SV.[MaSV] = D.[MaSV]
    WHERE D.[Diem] >= @DiemMin
);