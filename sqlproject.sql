SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [portfolio project].[dbo].[nashvillehousing]

  select * from [portfolio project].dbo.nashvillehousing

  -- Standardize Date Format

  select saledateconverted, convert(date, SaleDate)
  from [portfolio project].dbo.nashvillehousing

  update [portfolio project].dbo.Nashvillehousing set saledate = convert(date, SaleDate)

  -- If it doesn't Update properly

  alter table [portfolio project].dbo.nashvillehousing add saledateconverted date;

  update nashvillehousing set saledateconverted = CONVERT(date, saledate)

  -- Populate Property Address data

  select * from [portfolio project].dbo.Nashvillehousing --where PropertyAddress is null 
  order by ParcelID

  select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress )
  from [portfolio project].dbo.Nashvillehousing a
   join [portfolio project].dbo.Nashvillehousing b on a.ParcelID = b.ParcelID
   and a.[UniqueID ]<>b.[UniqueID ]
   where a.PropertyAddress is null

   update a
   set PropertyAddress = isnull(a.PropertyAddress,b.PropertyAddress )
   from [portfolio project].dbo.Nashvillehousing a
   join [portfolio project].dbo.Nashvillehousing b on a.ParcelID = b.ParcelID
   and a.[UniqueID ]<>b.[UniqueID ]
    where a.PropertyAddress is null

	-- Breaking out Address into Individual Columns (Address, City, State)

	select PropertyAddress from 
	[portfolio project].dbo.Nashvillehousing order by ParcelID

	select SUBSTRING(PropertyAddress, 1, Charindex(',',  PropertyAddress) -1) as address
	 ,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
	from [portfolio project].dbo.Nashvillehousing

	
  alter table [portfolio project].dbo.nashvillehousing add Propertysplitaddress nvarchar(255);

  update [portfolio project].dbo.nashvillehousing set Propertysplitaddress  = SUBSTRING(PropertyAddress, 1, Charindex(',',  PropertyAddress) -1);

    alter table [portfolio project].dbo.nashvillehousing add Propertysplitcity nvarchar(255);

	  update [portfolio project].dbo.nashvillehousing set Propertysplitcity  = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

	  select * from [portfolio project].dbo.nashvillehousing


	  select
	  PARSENAME(replace(owneraddress, ',', '.'), 3 )
	  ,PARSENAME(replace(owneraddress, ',', '.'), 2)
	  ,PARSENAME(replace(owneraddress, ',', '.'), 1) 
	  from [portfolio project].dbo.nashvillehousing 


	  ALTER TABLE[portfolio project].dbo.nashvillehousing 
Add OwnerSplitAddress Nvarchar(255);

Update[portfolio project].dbo.nashvillehousing 
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE[portfolio project].dbo.nashvillehousing 
Add OwnerSplitCity Nvarchar(255);

Update [portfolio project].dbo.nashvillehousing 
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE [portfolio project].dbo.nashvillehousing 
Add OwnerSplitState Nvarchar(255);

Update [portfolio project].dbo.nashvillehousing 
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

select * from [portfolio project].dbo.nashvillehousing 



-- Change Y and N to Yes and No in "Sold as Vacant" field

select distinct(Soldasvacant), count(Soldasvacant)
from [portfolio project].dbo.nashvillehousing 
group by Soldasvacant
order by 2

select soldasvacant
,case when soldasvacant = 'Y' then 'Yes'
     when soldasvacant = 'N' then 'No'
	 else soldasvacant 
	 end
from [portfolio project].dbo.nashvillehousing 

update [portfolio project].dbo.nashvillehousing 
set SoldAsVacant= case when soldasvacant = 'Y' then 'Yes'
     when soldasvacant = 'N' then 'No'
	 else soldasvacant 
	 end

	 -- Delete unused columns

	 select * from [portfolio project].dbo.nashvillehousing

	 alter table [portfolio project].dbo.nashvillehousing
	 drop column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate