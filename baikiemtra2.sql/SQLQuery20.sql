UPDATE SinhVien
SET HocBong = HocBong + 500000
WHERE MaSV IN (
    SELECT MaSV
    FROM Diem
    GROUP BY MaSV
    HAVING AVG(Diem) > 8
);