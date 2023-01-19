-- Cleaned FACT_InternetSales Table --
with a as
(
	SELECT 
	  [ProductKey], 
	  [OrderDateKey], 
	  [DueDateKey], 
	  [ShipDateKey], 
	  [CustomerKey], 
	  --  ,[PromotionKey]
	  --  ,[CurrencyKey]
	  --  ,[SalesTerritoryKey]
	  [SalesOrderNumber], 
	  --  [SalesOrderLineNumber], 
	  --  ,[RevisionNumber]
	  --  ,[OrderQuantity], 
	  --  ,[UnitPrice], 
	  --  ,[ExtendedAmount]
	  --  ,[UnitPriceDiscountPct]
	  --  ,[DiscountAmount] 
	  --  ,[ProductStandardCost]
	  --  ,[TotalProductCost] 
	  [SalesAmount] as GrossSales,
	  (SalesAmount - TotalProductCost - TaxAmt - Freight) as NetProfit,
	  --  ,[TaxAmt]
	  --  ,[Freight]
	  --  ,[CarrierTrackingNumber] 
	  --  ,[CustomerPONumber] 
	  CAST([OrderDate] as date) as OrderDate, 
	  CAST([DueDate] as date) as DueDate, 
	  CAST([ShipDate] as date) as ShipDate,
	  CASE 
		WHEN CAST(DueDate as date) < CAST(ShipDate as date) THEN 'Overdue'
		WHEN CAST(DueDate as date) > CAST(ShipDate as date) THEN 'On time'
	  END AS Shipping_status
	FROM 
	  [AdventureWorksDW2019].[dbo].[FactInternetSales]
), 

b as 
(
	SELECT
	  *, 
	  SUM (NetProfit) OVER (PARTITION BY CustomerKey) AS CustNetProfit, -- Total net profit for a single customer key (customer)
	  SUM (NetProfit) OVER () AS TotalNetProfit, -- (Grand) total net profit 
	  100 * (NetProfit / SUM (NetProfit) OVER (PARTITION BY CustomerKey)) as PctCustTotal -- -- % of the current value in the customer total net profit
	FROM
	  a
)

select
  [OrderDate], 
  [ShipDate], 
  [DueDate],
  [ProductKey], 
  [OrderDateKey], 
  [DueDateKey], 
  [ShipDateKey], 
  [CustomerKey],
  [SalesOrderNumber],
  GrossSales, 
  NetProfit, 
  shipping_status, 
  CustNetProfit,
  TotalNetProfit,
  PctCustTotal
from b
order by CustomerKey 