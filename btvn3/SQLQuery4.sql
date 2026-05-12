SELECT KH.*
FROM KH
JOIN GD ON KH.id = GD.idkh
WHERE GD.da_thanh_toan = 0;
SELECT KH.*, GD.deadline
FROM KH
JOIN GD ON KH.id = GD.idkh
WHERE GD.da_thanh_toan = 0
AND GD.deadline < GETDATE();