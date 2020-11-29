SELECT distinct s.secretname,
		s.Created,
		SP.SecretPolicyNAME as [Secret Policy],
		st.SecretTypename as [Template Name],
		tbsite.siteName as [site],
		gsp.[Permissions],
		gdn.DisplayName AS [Person or Group]
  FROM [tbSecret] s
  LEFT join tbSecretPolicy sp ON s.secretpolicyid = sp.secretpolicyid
  LEFT join tbSecretType st ON s.secrettypeid = st.secrettypeid
  left Join tbsite on s.siteid = tbsite.siteid
      INNER JOIN tbGroupSecretPermission sgp WITH (NOLOCK)
        ON s.SecretId = sgp.SecretId
      INNER JOIN tbUserGroup ug WITH (NOLOCK)
        ON sgp.GroupId = ug.GroupId
      INNER JOIN vGroupSecretPermissions gsp
        ON sgp.GroupId = gsp.GroupId AND s.SecretID = gsp.SecretId
    INNER JOIN vGroupDisplayName gdn WITH (NOLOCK)
        ON gsp.GroupId = gdn.GroupId
  where S.active=1 and S.folderid is null
  order by secretname