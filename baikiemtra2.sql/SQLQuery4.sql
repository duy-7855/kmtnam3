CREATE TABLE [Diem] (
    [MaSV] INT,
    [MaMH] INT,
    [Diem] FLOAT CHECK ([Diem] BETWEEN 0 AND 10), -- CK
    PRIMARY KEY ([MaSV], [MaMH]), -- PK kép

    FOREIGN KEY ([MaSV]) REFERENCES [SinhVien]([MaSV]), -- FK
    FOREIGN KEY ([MaMH]) REFERENCES [MonHoc]([MaMH])   -- FK
);