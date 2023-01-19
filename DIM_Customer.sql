-- Cleaned DIM_Customers Table --
SELECT 
  c.customerkey AS CustomerKey, 
  --      ,[GeographyKey]
  --      ,[CustomerAlternateKey]
  --      ,[Title]
  c.firstname AS FirstName, 
  --      ,[MiddleName]
  c.lastname AS LastName, 
  CONCAT(c.firstname, SPACE(1), lastname) AS FullName, 
  --      ,[NameStyle]
  --      ,[BirthDate]
  --      ,[MaritalStatus]
  --      ,[Suffix]
  CASE c.gender 
	WHEN 'M' THEN 'Male' 
	WHEN 'F' THEN 'Female' 
	ELSE 'NA'
  END AS Gender,
  --      ,[EmailAddress],
  --      ,[YearlyIncome]
  --      ,[TotalChildren]
  --      ,[NumberChildrenAtHome]
  --      ,[EnglishEducation]
  --      ,[SpanishEducation]
  --      ,[FrenchEducation]
  --      ,[EnglishOccupation]
  --      ,[SpanishOccupation]
  --      ,[FrenchOccupation]
  --      ,[HouseOwnerFlag]
  --      ,[NumberCarsOwned]
  --      ,[AddressLine1]
  --      ,[AddressLine2]
  RIGHT(c.phone, 4) as ShortPhoneNum, -- Last 4 digits of the full phone number
  c.datefirstpurchase AS DateFirstPurchase, 
  --      ,[CommuteDistance]
  g.city AS CustomerCity -- Joined in Customer City from Geography Table
FROM 
  [dbo].[DimCustomer] as c
	LEFT JOIN [dbo].[DimGeography] AS g ON c.geographykey = g.geographykey 
ORDER BY 
  CustomerKey  -- Ordered List by CustomerKey