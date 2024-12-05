 --Nombre total de clients
 SELECT COUNT(*) from telecom_data
 
 
 -- nombre de clients par genre et leur pourcentage par rapport au total des clients
 SELECT 
    Gender, 
    COUNT(Gender) as TotalCount,
    COUNT(Gender) * 1.0 / (SELECT COUNT(*) FROM telecom_data) * 100 as Percentage
FROM 
    telecom_data
GROUP BY 
    Gender;


-- nombre de clients pour chaque type de contrat et leur pourcentage par rapport au total des clients.
SELECT 
    Contract, 
    COUNT(Contract) as TotalCount,
    COUNT(Contract) * 1.0 / (SELECT COUNT(*) FROM telecom_data) * 100 as Percentage
FROM 
    telecom_data
GROUP BY 
    Contract;

/*nombre total de clients pour chaque statut, somme des revenus générés par les clients pour chaque statut, 
La part des revenus (en pourcentage) pour chaque statut, par rapport aux revenus totaux de tous les clients.*/
SELECT 
    Customer_Status, 
    Count(Customer_Status) as TotalCount, 
    Sum(Total_Revenue) as TotalRev,
    Sum(Total_Revenue) / (Select sum(Total_Revenue) from telecom_data) * 100 as RevPercentage
FROM 
    telecom_data
GROUP BY 
    Customer_Status;

--Nombre total de clients par ville et leur pourcentage sur le total des clients
SELECT City,
	   COUNT(City) as TotalCount,
	   Count(City) * 1.0 / (Select Count(*) from telecom_data) as Percentage
FROM telecom_data
GROUP BY City
Order by Percentage desc

--Vérification des valeurs nulles
SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,

    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,

    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,

    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,

    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,

    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,

    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,

    SUM(CASE WHEN Offer IS NULL THEN 1 ELSE 0 END) AS Offer_Null_Count,

    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,

    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,

    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,

    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,

    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,

    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,

    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,

    SUM(CASE WHEN Premium_Tech_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Tech_Support_Null_Count,

    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,

    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,

    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,

    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,

    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,

    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,

    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,

    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,

    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,

    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,

    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,

    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,

    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,

    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,

    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,

    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count

FROM telecom_data;

--Supprimer les valeurs nulles et insérer les nouvelles données


SELECT 
    Customer_ID,
    Gender,
    Age,
    Married,
    City,
    Number_of_Referrals,
    Tenure_in_Months,
    ISNULL(Offer, 'None') AS Offer,
    Phone_Service,
    ISNULL(Multiple_Lines, 'No') As Multiple_Lines,
    Internet_Service,
    ISNULL(Internet_Type, 'None') AS Internet_Type,
    ISNULL(Online_Security, 'No') AS Online_Security,
    ISNULL(Online_Backup, 'No') AS Online_Backup,
    ISNULL(Device_Protection_Plan, 'No') AS Device_Protection_Plan,
    ISNULL(Premium_Tech_Support, 'No') AS Premium_Tech_Support,
    ISNULL(Streaming_TV, 'No') AS Streaming_TV,
    ISNULL(Streaming_Movies, 'No') AS Streaming_Movies,
    ISNULL(Streaming_Music, 'No') AS Streaming_Music,
    ISNULL(Unlimited_Data, 'No') AS Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    ISNULL(Churn_Category, 'Others') AS Churn_Category,
    ISNULL(Churn_Reason , 'Others') AS Churn_Reason

INTO [telecomanalysis].[dbo].[prod_Churn]
FROM [telecomanalysis].[dbo].[telecom_data];


--Créer une vue pour power Bi
Create View vw_TelecomData as
    select * from prod_Churn where Customer_Status In ('Churned', 'Stayed')

Create View vw_JoinData as
    select * from prod_Churn where Customer_Status = 'Joined'
select * from telecom_data




/*

SELECT
    CASE
        WHEN Age < 30 THEN 'Moins de 30 ans'
        WHEN Age BETWEEN 30 AND 50 THEN 'Entre 30-50 ans'
        ELSE 'Plus de 50 ans'
    END AS Age_Group,
    COUNT(*) AS Total
FROM telecom_data
GROUP BY 
    CASE
        WHEN Age < 30 THEN 'Moins de 30 ans'
        WHEN Age BETWEEN 30 AND 50 THEN 'Entre 30-50 ans'
        ELSE 'Plus de 50 ans'
    END;
--Répartition par statut de client
select Customer_Status, COUNT(*) as Total_Clients
from telecom_data
GROUP BY Customer_Status

--Taux de résiliation global
SELECT 
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM telecom_data)) AS Churn_Rate
FROM telecom_data
WHERE Customer_Status = 'Churned';

select * from telecom_data
*/