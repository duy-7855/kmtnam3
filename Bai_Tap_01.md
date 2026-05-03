
# kmtnam3
# THỰC HÀNH HỆ QUẢN TRỊ CƠ SỞ DỮ LIỆU - BÀI SỐ 1

# Thông Tin Sinh Viên 

Họ Tên : Nguyễn Văn Duy
 
  Mã sinh viên: K235480106010

Lớp: K59.KMT

Học phần: Hệ quản trị dữ liệu

# CHI TIẾT CÁC BƯỚC THỰC HIỆN

# 1. Cài đặt và cấu hình môi trường (Yêu cầu 1 - 5)
Thực hiện cài đặt SQL Server 2025 Standard Developer Edition, SSMS và cấu hình TCP/IP Port 1433 để chuẩn bị môi trường thực hành.

1.1 Trạng thái cài đặt SQL Server thành công

Trạng thái cài đặt SQL Server thành công.
<img width="1920" height="1080" alt="Screenshot (1)" src="https://github.com/user-attachments/assets/005ea2bf-0d44-418b-ba30-410a087b8d38" />

1.2 Kích hoạt giao thức TCP/IP trong SQL Server Configuration Manager

Thực hiện bật giao thức TCP/IP trong SQL Server Configuration Manager.

Enable TCP/IP
<img width="1920" height="1080" alt="Screenshot (6)" src="https://github.com/user-attachments/assets/3cefb31b-5a10-4096-a389-efdcf0a033b9" />
1.3 Cài đặt SQL Server Management Studio (SSMS)

Thực hiện cài đặt phần mềm SSMS.
<img width="1920" height="1080" alt="Screenshot (5)" src="https://github.com/user-attachments/assets/d783fec8-9b4a-4455-912e-961117fc5a10" />
1.4 Đăng nhập vào SQL Server bằng SSMS

Kết quả đăng nhập thành công
<img width="1920" height="1080" alt="Screenshot (8)" src="https://github.com/user-attachments/assets/12302801-8cca-4d4a-b6c7-4250b802f466" />
# 2. Tạo Cơ sở dữ liệu (Yêu cầu 6)

Tạo Database duy và thiết lập nơi lưu trữ các tệp vật lý nhằm tối ưu hóa hiệu suất và quản lý dữ liệu dễ dàng hơn.

2.1 Cấu hình Path cho tệp .mdf (Data) và .ldf (Log)
<img width="1920" height="1080" alt="Screenshot (9)" src="https://github.com/user-attachments/assets/17aac55e-65d7-4721-94f9-844edde86986" />

Khởi tạo cấu trúc bảng (Yêu cầu 7)

Tạo bảng quanlysinhvien với các trường dữ liệu phù hợp để lưu thông tin sinh viên.

Câu lệnh SQL

CREATE TABLE quanlysinhvien (
    masv VARCHAR(20) PRIMARY KEY,
    
    hotensv NVARCHAR(100),
    
    malop VARCHAR(20),
    
    ngaysinh NVARCHAR(20),
    
    noisinh NVARCHAR(100),
    
    diachi NVARCHAR(200)
    
);
<img width="1920" height="1080" alt="Screenshot (10)" src="https://github.com/user-attachments/assets/e695e0ef-8394-4536-a8b0-d683e7716f6b" />

Nạp dữ liệu từ tệp CSV (Yêu cầu 8)

Sử dụng lệnh BULK INSERT để nạp dữ liệu từ file svtnut.csv vào bảng quanlysinhvien.

Câu lệnh SQL 

bulk insert quanlysinhvien

from 'C:\svtnut.csv'

with (

    firstrow = 2,
    
    format = 'CSV',
    
    codepage = '65001'
    
);

<img width="1920" height="1080" alt="Screenshot (11)" src="https://github.com/user-attachments/assets/9a2d742d-16ff-40a3-b90d-c5cd9dab2f6e" />

# 3. Kiểm tra và Ghi danh cá nhân (Yêu cầu 9 - 10)

Xác nhận tổng số dòng trong cơ sở dữ liệu và thêm bản ghi chứa thông tin cá nhân của sinh viên thực hiện bài Lab.

3.1 Kiểm tra số lượng dòng bằng COUNT()

Câu Lệnh SQL

select count(*) from quanlysinhvien;
<img width="1920" height="1080" alt="Screenshot (12)" src="https://github.com/user-attachments/assets/18e3f913-12ee-41f8-bfc0-b1fb10a2c204" />
3.2 Thêm bản ghi sinh viên Nguyễn Văn Duy

Câu lệnh SQL

insert into quanlysinhvien (masv, hotensv, malop, ngaysinh, noisinh, diachi)

values ('K235480106010', N'Nguyen Van Duy', N'K59.KMT', '2005-08-07', N'Thanh Hoá', N'Việt Nam');
<img width="1920" height="1080" alt="Screenshot (15)" src="https://github.com/user-attachments/assets/9cc836ea-10bc-487e-8097-706d226969f7" />

# 4. Xử lý dữ liệu và Tạo bảng phụ (Yêu cầu 11 – 13)

4.1 Cập nhật dữ liệu NULL → "Sao Hỏa"

Câu lệnh SQL

UPDATE quanlysinhvien

SET noisinh = N'Sao Hoả'

WHERE noisinh IS NULL

  AND diachi IS NULL;

  Cập nhật trường noisinh thành "Sao Hỏa" với các bản ghi có cả noisinh và diachi đều NULL.
<img width="1920" height="1080" alt="Screenshot (16)" src="https://github.com/user-attachments/assets/29895fea-f11f-4aab-9297-0b1ae18ec046" />

4.2 Tạo bảng SaoHoa bằng SELECT INTO

Câu lệnh SQL

SELECT *

INTO SaoHoa

FROM quanlysinhvien 

WHERE noisinh = N'Sao Hoả';
<img width="1920" height="1080" alt="Screenshot (17)" src="https://github.com/user-attachments/assets/31c56631-c4b2-40c6-9d07-8f648c88fcec" />

4.3 Xóa sinh viên theo họ trong bảng SaoHoa

Xóa các sinh viên có họ Nguyễn trong bảng SaoHoa.

Câu lệnh SQL

DELETE FROM SaoHoa

WHERE hotensv LIKE N'Nguyễn%';
<img width="1920" height="1080" alt="Screenshot (18)" src="https://github.com/user-attachments/assets/ea3b69b2-825b-4992-9845-d5e5e5285c7c" />

# 5. Xuất Script tổng hợp (Yêu cầu 14)
   
Sử dụng tính năng Generate Scripts để sao lưu toàn bộ cấu trúc bảng và dữ liệu (Schema and Data) ra tệp tin script.

5.2 Xuất file dulieu.sql thành công
<img width="1920" height="1080" alt="Screenshot (19)" src="https://github.com/user-attachments/assets/884f1332-6727-4fdc-ab08-71e8c8ba6328" />

# 6. Xóa Database và kiểm tra tệp vật lý (Yêu cầu 15)
   
Thực hiện xóa Database trên giao diện SSMS và kiểm tra thư mục lưu trữ để xác nhận các tệp .mdf và .ldf đã được xóa sạch khỏi ổ đĩa.

6.1 Kiểm tra thư mục dữ liệu sau khi xóa
<img width="1920" height="1080" alt="Screenshot (20)" src="https://github.com/user-attachments/assets/7436afc3-065c-4c6c-aee6-9c2adbb29675" />

<img width="1920" height="1080" alt="Screenshot (21)" src="https://github.com/user-attachments/assets/547d9edd-1bc8-4a24-a01c-3e7110d4a2fc" />

# 7. Phục hồi dữ liệu từ file Script (Yêu cầu 16)
    
Mở file script đã xuất và chạy lại toàn bộ câu lệnh để khôi phục cơ sở dữ liệu và kiểm chứng kết quả.

7.1 Kết quả phục hồi dữ liệu

Dữ liệu được phục hồi nguyên vẹn sau khi thực thi script.
<img width="1920" height="1080" alt="Screenshot (22)" src="https://github.com/user-attachments/assets/28db3fb6-0884-4a6e-a360-807116c79a66" />
<img width="1920" height="1080" alt="Screenshot (23)" src="https://github.com/user-attachments/assets/8cbc6a56-1657-4435-9f4e-4e5f614abf68" />

# KẾT THÚC BÁO CÁO
