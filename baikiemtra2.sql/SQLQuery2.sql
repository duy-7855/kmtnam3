CREATE TABLE [SinhVien] (
    [MaSV] INT PRIMARY KEY, -- PK
    [TenSV] NVARCHAR(100) NOT NULL,
    [NgaySinh] DATE,
    [GioiTinh] NVARCHAR(10),
    [HocBong] MONEY DEFAULT 0 CHECK ([HocBong] >= 0) -- CK
);