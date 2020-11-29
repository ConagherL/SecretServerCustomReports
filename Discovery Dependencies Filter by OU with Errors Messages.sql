select CONVERT(datetime,l.LastScanDate,101) AS 'Last Scan Date',
	ds.Name AS 'Acccount Domain',
	o.OrganizationUnitName AS 'OU',
	c.ComputerName AS 'Server Name',
	cd.AccountName AS 'Account Name',
	cd.DependencyName AS 'Dependency Name',
	st.SecretDependencyTemplateName AS 'Scan Name',
	l.LastScanStatus AS 'Last Scan Status',
	CASE 
			WHEN  d.SecretDependencyId IS NULL THEN 'No Secret Associated'
			WHEN  d.SecretDependencyId >= 1 THEN s.SecretName
			END AS [Secret Name]
FROM tbsecret s
LEFT JOIN tbSecretDependency d
	ON d.SecretId = s.SecretID
LEFT JOIN tbComputerDependency cd
	ON cd.SecretId = s.SecretID
RIGHT JOIN tbComputer c
	on c.ComputerId	= cd.ComputerID
LEFT JOIN tbDiscoverySource ds
	ON ds.DiscoverySourceId = c.DiscoverySourceId
JOIN tbComputerScanLastStatus l
	ON l.ComputerId = c.ComputerId
RIGHT JOIN tbSecretDependencyTemplate st
	ON st.SecretDependencyTypeId = cd.SecretDependencyTypeID
RIGHT JOIN tbOrganizationUnit o
	ON o.DiscoverySourceId = c.DiscoverySourceId
WHERE l.LastScanDate IS NOT NULL and l.LastScanSuccess = 0
ORDER BY l.LastScanDate, ds.Name, o.OrganizationUnitName, c.ComputerName, cd.AccountName,cd.DependencyName, st.SecretDependencyTemplateName,l.LastScanStatus asc






