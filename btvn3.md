# BÁO CÁO BÀI TẬP VỀ NHÀ 03: THIẾT KẾ VÀ CÀI ĐẶT CSDL QUẢN LÝ CẦM ĐỒ

Môn học: Hệ quản trị CSDL

Lớp: 59KMT

Giảng viên hướng dẫn: Đỗ Duy Cốp

Sinh viên thực hiện: Nguyễn Văn Duy

MSSV: K235480106010

# 1. Mô tả bài toán
 
Hệ thống quản lý các hợp đồng vay tiền thế chấp tài sản. Điểm đặc thù của hệ thống là cơ chế tính lãi linh hoạt: Lãi đơn (5.000đ/1.000.000đ gốc/ngày) áp dụng trước khi đến hạn, và Lãi kép áp dụng trên (Gốc + Lãi tích lũy) khi quá hạn mốc Deadline 1. Hệ thống quản lý danh mục tài sản thế chấp và xử lý thanh lý đồ khi quá hạn. Mọi biến động dòng tiền và trạng thái hợp đồng đều được lưu vết chi tiết (Audit Log) bao gồm cả thông tin người thu tiền (Mã nhân viên).

# 3. Thiết kế Cơ sở dữ liệu (Nhiệm vụ 1)

# 2.1. Sơ đồ thực thể quan hệ (ERD)
<img width="1402" height="1122" alt="ChatGPT Image May 12, 2026, 12_50_23 PM" src="https://github.com/user-attachments/assets/f1298334-ead1-4112-869d-aa4d34e45409" />

# 3. Các sự kiện nghiệp vụ (Events)

# 3.1. Event 1: Đăng ký hợp đồng mới
<img width="1890" height="1001" alt="Screenshot 2026-05-12 105412" src="https://github.com/user-attachments/assets/3286fa9a-d89d-4ca6-8979-3465d21f497d" />

Đoạn mã SQL: 

CREATE PROC sp_TaoHopDong

(
 
    @MaKH INT,
    
    @SoTienGoc DECIMAL(18,2),
    
    @NgayVay DATE,
    
    @Deadline1 DATE,
    
    @Deadline2 DATE

)

AS

BEGIN

    INSERT INTO HopDong

    (
    
        MaKH,
        
        SoTienGoc,
        
        NgayVay,
        
        Deadline1,
        
        Deadline2,
        
        TrangThai
    
    )
    
    VALUES
    
    (
    
        @MaKH,
        
        @SoTienGoc,
        
        @NgayVay,
        
        @Deadline1,
        
        @Deadline2,
        
        N'Đang vay'
   
    );
    
END;

# Ý nghĩa

Event này dùng để:

Tạo hợp đồng vay tiền mới

Thêm tài sản thế chấp vào hợp đồng


# 3.1.1 Thêm tài sản vào hợp đồng
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3c973caf-c816-4e0d-a786-a6978c12394e" />

Đoạn mã SQL :

CREATE PROC sp_ThemTaiSan

(

    @MaHD INT,
    
    @TenTaiSan NVARCHAR(100),
    
    @GiaTriDinhGia DECIMAL(18,2)
    
)

AS

BEGIN

    INSERT INTO TaiSan
    
    (
    
        TenTaiSan,
        
        GiaTriDinhGia,
        
        TrangThai
        
    )
    
    VALUES
    
    (
    
        @TenTaiSan,
        
        @GiaTriDinhGia,
        
        N'Đang cầm cố'
        
    );

    DECLARE @MaTS INT = SCOPE_IDENTITY();
    
    INSERT INTO ChiTietHopDong
    
    VALUES(@MaHD, @MaTS);

END;

# 3.1.2 Thêm Dữ liệu khách hàng mẫu
<img width="1890" height="1007" alt="image" src="https://github.com/user-attachments/assets/7c09c71b-cc18-4627-b5bd-d1379a230933" />

Đoạn mã SQL:

INSERT INTO KhachHang (HoTen, SDT, CCCD, DiaChi)

VALUES

(N'Nguyễn Văn A','0988888888','111111111111',N'Hà Nội'),

(N'Nguyễn Văn B','0977777777','222222222222',N'Thái Nguyên'),

(N'Nguyễn Văn C','0966666666','333333333333',N'Bắc Ninh');

# 3.1.3 Tạo hợp đồng mẫu
<img width="1902" height="1007" alt="image" src="https://github.com/user-attachments/assets/962f8484-831e-47a9-8fe9-c1d79189ca46" />
EXEC sp_TaoHopDong

    1,
    
    10000000,
    
    '2026-05-01',
    
    '2026-05-10',
    
    '2026-05-20';

EXEC sp_TaoHopDong

    2,
    
    15000000,
    
    '2026-05-02',
    
    '2026-05-12',
    
    '2026-05-22';

# 3.1.4 Thêm tài sản mẫu
<img width="1898" height="996" alt="image" src="https://github.com/user-attachments/assets/109c499d-029f-40e2-a624-f5fdd28a8b3f" />

EXEC sp_ThemTaiSan

    4,
    
    N'Iphone 15',
    
    12000000;
    
EXEC sp_ThemTaiSan

    4,
    
    N'Laptop Dell',
    
    15000000;
    
EXEC sp_ThemTaiSan

    4,
    
    N'Xe máy Vision',
    
    25000000;


    
# 3.2. Event 2: Tính toán công nợ
<img width="1895" height="985" alt="Screenshot 2026-05-12 141448" src="https://github.com/user-attachments/assets/76d2af27-0469-4bef-9494-98a592cf2013" />

Đoạn mã SQL:

CREATE FUNCTION fn_CalcMoneyContract

(
    @MaHD INT,
    
    @TargetDate DATE
)

RETURNS DECIMAL(18,2)

AS
BEGIN

    DECLARE
    
        @TienGoc DECIMAL(18,2),
        
        @NgayVay DATE,
        
        @Deadline1 DATE,

        @SoNgay INT,
        
        @SoNgayLaiDon INT,
        
        @SoNgayLaiKep INT,

        @TienSauLaiDon DECIMAL(18,2),
        
        @TongTien DECIMAL(18,2),

        @Lai FLOAT = 0.005;

    SELECT
    
        @TienGoc = SoTienGoc,
        
        @NgayVay = NgayVay,
        
        @Deadline1 = Deadline1
        
    FROM HopDong
    
    WHERE MaHD = @MaHD;

    SET @SoNgay = DATEDIFF(DAY, @NgayVay, @TargetDate);

    IF @TargetDate <= @Deadline1
    
    BEGIN
    

        SET @TongTien =
        
            @TienGoc +
            
            (@TienGoc * @Lai * @SoNgay);

    END

    ELSE
    
    BEGIN

        SET @SoNgayLaiDon =
        
            DATEDIFF(DAY, @NgayVay, @Deadline1);

        SET @SoNgayLaiKep =
        
            DATEDIFF(DAY, @Deadline1, @TargetDate);

        SET @TienSauLaiDon =
        
            @TienGoc +
            
            (@TienGoc * @Lai * @SoNgayLaiDon);

        SET @TongTien =
        
            @TienSauLaiDon *
            
            POWER((1 + @Lai), @SoNgayLaiKep);

    END

    RETURN @TongTien;

END;

# Ý nghĩa

Event này dùng để:

Tính tổng tiền khách phải trả tại một thời điểm

Bao gồm:

  Tiền gốc

  Lãi suất

# Giai đoạn 1: 

Trước Deadline1
  
Tính lãi đơn

Công thức:

Tiền gốc + (tiền gốc × 0.5% × số ngày)

# Giai đoạn 2:

Sau Deadline1

Chia làm 2 phần:

Trước Deadline1 → lãi đơn

Sau Deadline1 → lãi kép

# 3.3. Event 3: Xử lý trả nợ 
<img width="1890" height="957" alt="image" src="https://github.com/user-attachments/assets/636e84d4-c2fb-4735-af02-d20d3db8cd36" />

Đoạn mã SQL:

CREATE PROC sp_ThanhToan

(

    @MaHD INT,
    
    @SoTienTra DECIMAL(18,2),
    
    @NguoiThu NVARCHAR(100)
    
)

AS

BEGIN

    DECLARE
    
        @TongNo DECIMAL(18,2),
        
        @DaTra DECIMAL(18,2),
        
        @ConNo DECIMAL(18,2),
        
        @TrangThai NVARCHAR(50);

    SELECT @TrangThai = TrangThai
    
    FROM HopDong
    
    WHERE MaHD = @MaHD;

    IF @TrangThai = N'Đã thanh lý'
    
    BEGIN
    
        PRINT N'Tài sản đã thanh lý';
        
        RETURN;
        
    END
    
    SET @TongNo =
    
        dbo.fn_CalcMoneyContract(@MaHD, GETDATE());
        
    SELECT
    
        @DaTra = ISNULL(SUM(SoTienTra),0)
        
    FROM ThanhToan
    WHERE MaHD = @MaHD;

    SET @ConNo =
        @TongNo - @DaTra - @SoTienTra;

    INSERT INTO ThanhToan
    
    (
    
        MaHD,
        
        NgayTra,
        
        SoTienTra,
      
        NguoiThu
        
    )
    
    VALUES
    
    (
    
        @MaHD,
        
        GETDATE(),
        
        @SoTienTra,
        
        @NguoiThu
    );
    

    IF @ConNo <= 0
    
    BEGIN

        UPDATE HopDong
        
        SET TrangThai = N'Đã thanh toán'
        
        WHERE MaHD = @MaHD;

        UPDATE TaiSan
        
        SET TrangThai = N'Đã trả khách'
        
        WHERE MaTS IN
        
        (
        
            SELECT MaTS
            
            FROM ChiTietHopDong
            
            WHERE MaHD = @MaHD
            
        );

    END

    ELSE
    
    BEGIN
    

        UPDATE HopDong
        
        SET TrangThai = N'Đang trả góp'
        
        WHERE MaHD = @MaHD;

        PRINT N'Còn nợ: ' + CAST(@ConNo AS NVARCHAR);

    END

END;

# Ý nghĩa

Xử lý khi khách hàng thanh toán tiền.

1. Kiểm tra hợp đồng

Nếu hợp đồng đã “Đã thanh lý” → không cho trả nữa

3. Tính toán nợ
   
Lấy tổng nợ từ function

Trừ đi số tiền đã trả trước đó

Trừ tiếp số tiền vừa trả

4. Lưu lịch sử thanh toán

Ghi vào bảng ThanhToan

5. Cập nhật trạng thái

Nếu trả đủ tiền:

Hợp đồng → "Đã thanh toán"

Tài sản → "Đã trả khách"

Nếu chưa đủ:

Hợp đồng → "Đang trả góp"

# 3.3.1. Nhân viên 
<img width="1907" height="967" alt="image" src="https://github.com/user-attachments/assets/5741d268-5cd1-4855-b9fd-5ef9e20cbb84" />

<img width="1891" height="967" alt="image" src="https://github.com/user-attachments/assets/a53227e5-3ea1-4a4e-8af5-273b8086e7a0" />

Đoạn mã SQL:

INSERT INTO ThanhToan

(

    MaHD,
    
    NgayTra,
    
    SoTienTra,
    
    NguoiThu
    
)

VALUES

(4, GETDATE(), 2000000, N'Nhân viên A'),

(4, GETDATE(), 3000000, N'Nhân viên B'),

(4, GETDATE(), 1500000, N'Nhân viên C');

# Ý nghĩa:

Hợp đồng MaHD = 4

Có 3 lần thanh toán khác nhau

Mỗi lần do nhân viên khác thu tiền

Tất cả đều cùng ngày (GETDATE())

# 3.4. Event 4: Truy vấn danh sách nợ xấu 
<img width="1891" height="1002" alt="image" src="https://github.com/user-attachments/assets/e72924f4-3af2-4bd2-924d-f99c33d703cc" />

Đoạn mã SQL:

SELECT

    kh.HoTen,
    
    kh.SDT,

    hd.SoTienGoc,

    DATEDIFF
    
    (
    
        DAY,
        
        hd.Deadline1,
        
        GETDATE()
        
    ) AS SoNgayQuaHan,
    

    dbo.fn_CalcMoneyContract
    
    (
        hd.MaHD,
        
        GETDATE()
        
    ) AS TongNoHienTai,

    dbo.fn_CalcMoneyContract
    
    (
        hd.MaHD,
        
        DATEADD(MONTH,1,GETDATE())
        
    ) AS TongNoSau1Thang

FROM HopDong hd

JOIN KhachHang kh

ON hd.MaKH = kh.MaKH

WHERE

    GETDATE() > hd.Deadline1

    AND hd.TrangThai
    
    NOT IN
    
    (
    
        N'Đã thanh toán',
        
        N'Đã thanh lý'
    );

# Ý nghĩa

Hiển thị:

Những hợp đồng đã quá hạn nhưng chưa thanh toán

Hoạt động

Lấy dữ liệu:

Khách hàng

Số tiền gốc

Số ngày quá hạn

Tổng nợ hiện tại

Dự đoán nợ sau 1 tháng

Điều kiện:

Quá Deadline1

Chưa thanh toán hết

# 3.5 Event 5: Quản lý thanh lý tài sản

# 3.5.1Trigger quá hạn
<img width="1887" height="932" alt="image" src="https://github.com/user-attachments/assets/349e153f-7952-4ecc-b59e-40748ebdb89f" />

Đoạn mã SQL:

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

Nếu qua Deadline1 → chuyển:

 "Quá hạn"

 Ý nghĩa:

Tự động đánh dấu hợp đồng bị trễ hạn

# 3.5.2 Trigger sẵn sàng thanh lý
<img width="1852" height="956" alt="image" src="https://github.com/user-attachments/assets/9538fe17-47d3-43df-9649-b8260fb790ad" />

Đoạn mã SQL: 

CREATE TRIGGER trg_SanSangThanhLy

ON HopDong

AFTER UPDATE

AS

BEGIN

    UPDATE TaiSan
    
    SET TrangThai = N'Sẵn sàng thanh lý'
    
    WHERE MaTS IN
    
    (
    
        SELECT ct.MaTS
        
        FROM ChiTietHopDong ct
        
        JOIN HopDong hd
        
        ON ct.MaHD = hd.MaHD

        WHERE
        
            hd.TrangThai = N'Quá hạn'
            
            AND GETDATE() > hd.Deadline2
    );

END;

# Ý nghĩa:

Khi hợp đồng bị update

Nếu:

Hợp đồng quá hạn

Qua Deadline2

Tài sản → "Sẵn sàng thanh lý"

Chuẩn bị đem tài sản đi bán

# 3.5.3 Trigger đã bán thanh lý
<img width="1882" height="977" alt="image" src="https://github.com/user-attachments/assets/3cf44484-f9eb-410c-8e04-fc757ad4d8bb" />

Đoạn mã SQL:

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

# Ý nghĩa:

Khi hợp đồng đổi trạng thái

Nếu hợp đồng = "Đã thanh lý"

Tài sản → "Đã bán thanh lý"

Tài sản đã bị bán để thu hồi nợ

# 3.5.4 Gia hạn hợp đồng
<img width="1891" height="995" alt="image" src="https://github.com/user-attachments/assets/9c4df414-2a40-45e5-8008-0f51ccb0931a" />

CREATE PROC sp_GiaHanHopDong

(

    @MaHD INT,
    
    @Deadline1Moi DATE,
    
    @Deadline2Moi DATE
    
)

AS

BEGIN

    UPDATE HopDong
    
    SET
    
        Deadline1 = @Deadline1Moi,
        
        Deadline2 = @Deadline2Moi,
        
        TrangThai = N'Đang vay'
        
    WHERE MaHD = @MaHD;

END;

# Ý nghĩa 

Gia hạn hợp đồng cho phép:

Thay đổi lại thời hạn thanh toán (Deadline1, Deadline2)

Đưa hợp đồng về trạng thái “Đang vay”

Giúp khách hàng có thêm thời gian trả nợ

# 4. Kiểm tra dữ liệu

<img width="1891" height="960" alt="image" src="https://github.com/user-attachments/assets/bfa76cfa-381d-4b4a-887b-80614198693f" />

Đoạn mã SQL: 

SELECT * FROM KhachHang;

SELECT * FROM HopDong;

SELECT * FROM TaiSan;

SELECT * FROM ThanhToan;

# Ý nghĩa: 
Xem toàn bộ dữ liệu trong từng bảng

Kiểm tra hệ thống đã insert đúng chưa

Kiểm tra trigger / procedure có hoạt động không

#Hết
