SELECT
	comp.ComputerId
	,ca.CreatedDate
	,ca.AccountName
	,comp.ComputerName
	,comp.ComputerVersion
	,comp.FoundDate
	,comp.LastPolledDate
	,comp.LastErrorMessage
	,ca.ComputerAccountId
	,comp.DistinguishedName
FROM
	tbComputerAccount ca
JOIN
	tbComputer comp
	ON ca.ComputerId = comp.ComputerId
LEFT OUTER JOIN
	tbSecret sec
	ON ca.ComputerAccountId = sec.ComputerAccountId
WHERE
	sec.SecretID IS NULL