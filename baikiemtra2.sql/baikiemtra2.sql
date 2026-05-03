DECLARE @SoTien FLOAT = 1000000;
DECLARE @Thang INT = 1;

WHILE @Thang <= 12
BEGIN
    SET @SoTien = @SoTien * 1.01; -- lãi 1%
    PRINT N'Tháng ' + CAST(@Thang AS NVARCHAR) + ': ' + CAST(@SoTien AS NVARCHAR);

    SET @Thang = @Thang + 1;
END;