CREATE TABLE [MonHoc] (
    [MaMH] INT PRIMARY KEY, -- PK
    [TenMH] NVARCHAR(100) NOT NULL,
    [SoTinChi] INT CHECK ([SoTinChi] > 0) -- CK
);