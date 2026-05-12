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