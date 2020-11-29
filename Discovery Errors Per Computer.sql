Select status, computerid, count (*) as numberOfErrors from tbComputerScanLog 
where Success = 0  and ScanDate between #STARTDATE and #ENDDATE 
Group By ComputerId, status