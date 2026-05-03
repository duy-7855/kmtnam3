# BÀI KIỂM TRA SỐ 2 – HỆ QUẢN TRỊ CSDL

# Thông tin sinh viên

Họ tên: Nguyễn Văn Duy

Mã SV: K235480106010

Chủ đề: Quản lý sinh viên

# PHẦN 1: THIẾT KẾ DATABASE

Ảnh 1: Tạo Database

Lệnh SQL:

CREATE DATABASE QuanLySinhVien_K123456789;

GO

USE QuanLySinhVien_K123456789;

GO
<img width="1909" height="1020" alt="Screenshot 2026-05-03 114142" src="https://github.com/user-attachments/assets/7e356459-cfcc-4b50-89ac-3b78b0ca57bb" />

🔹 Mô tả:
Ảnh này thực hiện tạo cơ sở dữ liệu QuanLySinhVien_K235480106010.

🔹 Lệnh SQL:
Sử dụng lệnh CREATE DATABASE để tạo database mới và USE để chuyển sang sử dụng database đó.

🔹 Kết quả:
Database được tạo thành công và hiển thị trong danh sách database.

Ảnh 2: Tạo Bảng SinhVien

Lệnh SQL: 

CREATE TABLE [SinhVien] (
   
    [MaSV] INT PRIMARY KEY, -- PK
   
    [TenSV] NVARCHAR(100) NOT NULL,
   
    [NgaySinh] DATE,
   
    [GioiTinh] NVARCHAR(10),
   
    [HocBong] MONEY DEFAULT 0 CHECK ([HocBong] >= 0) -- CK
    
);
<img width="1887" height="964" alt="Screenshot 2026-05-03 193600" src="https://github.com/user-attachments/assets/a79e59ad-1059-4cc1-bafd-2ae3ead31692" />

🔹 Mô tả:
Ảnh này thực hiện tạo bảng SinhVien.

🔹 Lệnh SQL:
Tạo bảng với khóa chính MaSV, sử dụng kiểu NVARCHAR, DATE và ràng buộc CHECK cho học bổng.

🔹 Kết quả:
Bảng SinhVien được tạo thành công trong database.

Ảnh 3: Tạo Bảng Monhoc

Lệnh SQL:

CREATE TABLE [MonHoc] (
   
    [MaMH] INT PRIMARY KEY, -- PK
  
    [TenMH] NVARCHAR(100) NOT NULL,
   
    [SoTinChi] INT CHECK ([SoTinChi] > 0) -- CK
    
);
<img width="1880" height="1000" alt="Screenshot 2026-05-03 114305" src="https://github.com/user-attachments/assets/2786188d-c4f9-484e-9907-01cac054800b" />

🔹 Mô tả:
Ảnh này thực hiện tạo bảng lưu thông tin môn học.

🔹 Lệnh SQL:
Tạo bảng MonHoc với khóa chính MaMH và ràng buộc CHECK đảm bảo số tín chỉ lớn hơn 0.

🔹 Kết quả:
Bảng MonHoc được tạo thành công.

Ảnh 4: Tạo Bảng Diem

Lệnh SQL:

 CREATE TABLE [Diem] (
   
    [MaSV] INT,
   
    [MaMH] INT,
   
    [Diem] FLOAT CHECK ([Diem] BETWEEN 0 AND 10), -- CK
   
    PRIMARY KEY ([MaSV], [MaMH]), -- PK kép

    FOREIGN KEY ([MaSV]) REFERENCES [SinhVien]([MaSV]), -- FK
   
    FOREIGN KEY ([MaMH]) REFERENCES [MonHoc]([MaMH])   -- FK
    
);
<img width="1878" height="973" alt="Screenshot 2026-05-03 115921" src="https://github.com/user-attachments/assets/9e58ecac-3e58-4949-b0be-91feacc91f8e" />

🔹 Mô tả:
Ảnh này tạo bảng Diem và thiết lập quan hệ với các bảng khác.

🔹 Lệnh SQL:
Sử dụng khóa chính kép (MaSV, MaMH) và khóa ngoại liên kết với SinhVien và MonHoc.

🔹 Kết quả:
Bảng Diem được tạo và đảm bảo tính toàn vẹn dữ liệu giữa các bảng.

# PHẦN 2: FUNCTION

Ảnh 5: Built-in Function

Các loại:

Hàm chuỗi: LEN(), UPPER()

Hàm số: ABS(), ROUND()

Hàm ngày: GETDATE(), YEAR()

Hàm hệ thống: @@VERSION, DB_NAME()  

Lệnh SQL:

SELECT LEN([HoTen]) AS DoDaiTen

FROM [SinhVien];

SELECT GETDATE() AS NgayHienTai;

<img width="1829" height="976" alt="Screenshot 2026-05-03 121125" src="https://github.com/user-attachments/assets/41c4e8ec-95e3-49c6-a2e3-d9c2933556fe" />

Function do người dùng tự viết

Mục đích:

Tái sử dụng logic

Tính toán phức tạp

Tăng tính modular

Các loại:

Scalar Function

Inline Table-Valued Function

Multi-statement Table-Valued Function

Ảnh 6: Scalar Function

Yêu cầu: Tính điểm trung bình của 1 sinh viên

Lệnh SQL:

CREATE FUNCTION fn_TinhDiemTB (@MaSV INT)

RETURNS FLOAT

AS

BEGIN

    DECLARE @DTB FLOAT;

    SELECT @DTB = AVG([Diem])

    FROM [Diem]
    
    WHERE [MaSV] = @MaSV;

    RETURN @DTB;

END;
<img width="1910" height="976" alt="Screenshot 2026-05-03 121235" src="https://github.com/user-attachments/assets/5447073d-92c3-48b8-b10c-809a8b4496f1" />

🔹 Mô tả:
Ảnh này thực hiện tạo hàm để tính điểm trung bình của sinh viên.

🔹 Lệnh SQL:
Hàm fn_TinhDiemTB nhận tham số MaSV và sử dụng AVG để tính điểm trung bình từ bảng Diem.

🔹 Kết quả:
Hàm được tạo thành công và sẵn sàng sử dụng.

Lệnh SQL:

SELECT dbo.fn_TinhDiemTB(1) AS DiemTrungBinh;

<img width="1901" height="987" alt="Screenshot 2026-05-03 130943" src="https://github.com/user-attachments/assets/47837de1-5104-4958-afc1-02a8b17cc821" />

🔹 Mô tả:
Ảnh này thực hiện gọi hàm để tính điểm trung bình của một sinh viên.

🔹 Lệnh SQL:
Gọi hàm dbo.fn_TinhDiemTB với tham số MaSV cụ thể.

🔹 Kết quả:
Hệ thống trả về giá trị điểm trung bình của sinh viên.

Ảnh 7: Inline Table Function

Yêu cầu: Lấy danh sách SV có điểm > X

Lệnh SQL:

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
<img width="1885" height="1004" alt="Screenshot 2026-05-03 122109" src="https://github.com/user-attachments/assets/d0011a64-c827-42c1-bbda-38c45988eec8" />
<img width="1908" height="992" alt="Screenshot 2026-05-03 131328" src="https://github.com/user-attachments/assets/e4e81548-1adc-46fe-b985-3396051d4ce5" />

🔹 Mô tả:
Ảnh này tạo hàm trả về danh sách sinh viên có điểm lớn hơn một giá trị cho trước.

🔹 Lệnh SQL:
Hàm trả về bảng kết quả bằng cách JOIN giữa SinhVien và Diem, lọc theo điều kiện điểm.

🔹 Kết quả:
Hàm được tạo thành công và có thể truy vấn như một bảng.

Ảnh 8: Multi-statement Function

Lệnh SQL:

CREATE FUNCTION fn_PhanLoaiHocLuc ()

RETURNS @KQ TABLE (

    MaSV INT,
    
    TenSV NVARCHAR(100),
    
    DTB FLOAT,
    
    HocLuc NVARCHAR(50)
)

AS

BEGIN

    INSERT INTO @KQ
    
    SELECT 
    
        SV.MaSV,
        
        SV.TenSV,
        
        AVG(D.Diem),
        
        CASE 
        
            WHEN AVG(D.Diem) >= 8 THEN N'Giỏi'
            
            WHEN AVG(D.Diem) >= 6.5 THEN N'Khá'
            
            ELSE N'Trung bình'
        
        END
    
    FROM SinhVien SV
    
    JOIN Diem D ON SV.MaSV = D.MaSV
    
    GROUP BY SV.MaSV, SV.TenSV;

    RETURN;

END;
<img width="1901" height="982" alt="Screenshot 2026-05-03 122206" src="https://github.com/user-attachments/assets/abc0df5a-3a31-4b1e-8a84-cf3f02220fa4" />
<img width="1891" height="970" alt="Screenshot 2026-05-03 131509" src="https://github.com/user-attachments/assets/62a4aefe-bd28-46ea-bfc2-014edb336a54" />

🔹 Mô tả:
Ảnh này tạo hàm có xử lý logic phức tạp để phân loại học lực sinh viên.

🔹 Lệnh SQL:
Sử dụng bảng tạm và CASE WHEN để phân loại học lực theo điểm trung bình.

🔹 Kết quả:
Hàm trả về bảng gồm MaSV, TenSV, điểm trung bình và học lực.

# PHẦN 3: STORED PROCEDURE

Ảnh 9: SP Insert

1.System Stored Procedure
   
Lệnh SQL:

EXEC sp_help SinhVien; -- Xem cấu trúc bảng

EXEC sp_databases;     -- Xem DB
<img width="1883" height="984" alt="Screenshot 2026-05-03 122313" src="https://github.com/user-attachments/assets/788b153c-238b-4b47-8cd4-9e5309964b37" />

Giải thích:

sp_help: xem thông tin bảng

sp_databases: danh sách DB

2. SP Insert có kiểm tra

 Không cho nhập điểm > 10

 Lệnh SQL:

 CREATE PROCEDURE sp_ThemDiem
  
   @MaSV INT,
   
    @MaMH INT,
    
    @Diem FLOAT

AS

BEGIN

    IF @Diem < 0 OR @Diem > 10
    
    BEGIN
    
        PRINT N'Điểm không hợp lệ';
        
        RETURN;
    
    END

   INSERT INTO Diem VALUES (@MaSV, @MaMH, @Diem);

END;
<img width="1903" height="1018" alt="Screenshot 2026-05-03 122706" src="https://github.com/user-attachments/assets/9272194c-c388-47b3-939a-8ee73237f360" />

🔹 Mô tả:
Ảnh này tạo procedure để thêm dữ liệu điểm.

🔹 Lệnh SQL:
Procedure kiểm tra điều kiện điểm hợp lệ trước khi thực hiện INSERT.

🔹 Kết quả:
Procedure được tạo thành công và đảm bảo dữ liệu nhập đúng.

Ảnh 10. SP có OUTPUT

Trả về điểm TB

Lệnh SQL:

CREATE PROCEDURE sp_TinhDTB
  
     @MaSV INT,
   
    @DTB FLOAT OUTPUT

AS

BEGIN
   
    SELECT @DTB = AVG(Diem)
  
    FROM Diem
  
    WHERE MaSV = @MaSV;

END;
<img width="1879" height="975" alt="Screenshot 2026-05-03 122750" src="https://github.com/user-attachments/assets/461ab5a1-d371-4c0d-9830-3acc9906d8c2" />

DECLARE @KQ FLOAT;

EXEC sp_TinhDTB 1, @KQ OUTPUT;

SELECT @KQ;
<img width="1866" height="927" alt="Screenshot 2026-05-03 131731" src="https://github.com/user-attachments/assets/5c798265-be85-463e-b17a-59349289a8f4" />

🔹 Mô tả:
Ảnh này minh họa Stored Procedure trả về giá trị qua tham số OUTPUT.

🔹 Lệnh SQL:
Procedure tính điểm trung bình bằng AVG và gán vào biến OUTPUT.

🔹 Kết quả:
Biến nhận OUTPUT chứa điểm trung bình của sinh viên sau khi thực thi.

Ảnh 11. SP trả Result Set

Lệnh SQL:

CREATE PROCEDURE sp_DanhSachDiem

AS

BEGIN
   
    SELECT SV.TenSV, MH.TenMH, D.Diem
   
    FROM SinhVien SV
   
    JOIN Diem D ON SV.MaSV = D.MaSV
   
    JOIN MonHoc MH ON MH.MaMH = D.MaMH;

END;
<img width="1908" height="968" alt="Screenshot 2026-05-03 122916" src="https://github.com/user-attachments/assets/bd37969e-4946-4650-b421-cdbc17cb07ed" />

EXEC sp_DanhSachDiem;
<img width="1865" height="932" alt="Screenshot 2026-05-03 123232" src="https://github.com/user-attachments/assets/70504c41-1ef7-415e-b2c1-d222c9af4a42" />

🔹 Mô tả:
Ảnh này minh họa Stored Procedure trả về danh sách dữ liệu từ nhiều bảng.

🔹 Lệnh SQL:
Procedure sử dụng SELECT kết hợp JOIN giữa các bảng để lấy thông tin sinh viên, môn học và điểm.

🔹 Kết quả:
Trả về bảng dữ liệu gồm tên sinh viên, tên môn học và điểm tương ứng.

# PHẦN 4: TRIGGER

Ảnh 12. Trigger A → B

Khi thêm điểm → cập nhật học bổng

CREATE TRIGGER trg_CapNhatHocBong

ON Diem

AFTER INSERT

AS

BEGIN

    UPDATE SinhVien
    
    SET HocBong = HocBong + 100000
    
    WHERE MaSV IN (SELECT MaSV FROM inserted);

END;
<img width="1892" height="991" alt="Screenshot 2026-05-03 130041" src="https://github.com/user-attachments/assets/667e226c-4dff-494a-a744-387adda17aee" />

🔹 Tên ảnh: Trigger cập nhật học bổng

🔹 Mô tả:
Ảnh này tạo trigger tự động cập nhật học bổng khi thêm điểm.

🔹 Lệnh SQL:
Trigger AFTER INSERT trên bảng Diem, cập nhật bảng SinhVien.

🔹 Kết quả:
Khi thêm điểm, học bổng được tăng tự động.

2. Trigger vòng lặp A ↔ B

Nếu tạo trigger ngược lại:

Dễ gây loop vô hạn

SQL Server báo lỗi:

Lỗi: Maximum nesting level exceeded

Nhận xét:

Không nên thiết kế trigger 2 chiều

Dễ gây lỗi logic & giảm hiệu năng

# PHẦN 5: CURSOR VÀ DUYỆT DỮ LIỆU

Ảnh 13: Dùng Cursor

 Tăng học bổng cho từng SV nếu điểm TB > 8

 Lệnh SQL:

 DECLARE cur CURSOR FOR

SELECT MaSV FROM SinhVien;

DECLARE @MaSV INT;

DECLARE @DTB FLOAT;

OPEN cur;

FETCH NEXT FROM cur INTO @MaSV;

WHILE @@FETCH_STATUS = 0

BEGIN

    SET @DTB = dbo.fn_TinhDiemTB(@MaSV);

    IF @DTB > 8
    
        UPDATE SinhVien
        
        SET HocBong = HocBong + 500000
        
        WHERE MaSV = @MaSV;

    FETCH NEXT FROM cur INTO @MaSV;

END;

CLOSE cur;

DEALLOCATE cur;

<img width="1902" height="983" alt="Screenshot 2026-05-03 130058" src="https://github.com/user-attachments/assets/b07b0d65-4642-42c6-b54f-1644ce783c23" />

🔹 Mô tả:
Ảnh này sử dụng cursor để duyệt từng sinh viên.

🔹 Lệnh SQL:
Cursor lặp qua từng MaSV và cập nhật học bổng nếu đủ điều kiện.

🔹 Kết quả:
Dữ liệu được cập nhật theo từng bản ghi.

Ảnh 14: Không dùng Cursor

Lệnh SQL:

UPDATE SinhVien

SET HocBong = HocBong + 500000

WHERE MaSV IN (
 
    SELECT MaSV
    
    FROM Diem
   
    GROUP BY MaSV
   
    HAVING AVG(Diem) > 8
    
);

<img width="1898" height="952" alt="Screenshot 2026-05-03 130117" src="https://github.com/user-attachments/assets/6d59003e-261b-4847-b0bb-de67ae6248bd" />
So sánh:

Giải thích:
Cursor: chậm (duyệt từng dòng)
SQL thuần: nhanh hơn (set-based)

Khi nào cần Cursor?

Khi:

Xử lý tuần tự

Logic phụ thuộc từng dòng trước

Ví dụ khó thay thế:

Tính lãi ngân hàng theo từng tháng phụ thuộc tháng trước
<img width="1891" height="999" alt="Screenshot 2026-05-03 130416" src="https://github.com/user-attachments/assets/221f7746-c5de-49d3-a45e-29a090d3b13e" />

- Cursor chỉ nên dùng khi cần xử lý tuần tự hoặc phụ thuộc giữa các dòng.
- Trong đa số trường hợp, SQL set-based luôn tối ưu hơn về hiệu năng.
- Việc hạn chế sử dụng Cursor giúp hệ thống chạy nhanh và hiệu quả hơn.
