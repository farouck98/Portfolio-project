-- Nombre total de demande de pr�t
select COUNT(id) as nombre_total_demande_pret from bankloandata

--nombre total de demandes de pr�t effectu�es au mois de d�cembre
SELECT COUNT(id) AS Demandes_MTD FROM bankloandata
WHERE MONTH(date_emission) = 12

--nombre total de demandes de pr�t effectu�es le mois pr�c�dent(Ici Novembre)
SELECT COUNT(id) AS Demandes_PMTD FROM bankloandata
WHERE MONTH(date_emission) = 11

-----------------------------------------------------------------------------------

--montant total de pr�t financ� par la banque
SELECT SUM(montant_pret) AS Montant_Total_Financ� FROM bankloandata

--montant total de pr�t financ� par la banque au mois de d�cembre
SELECT SUM(montant_pret) AS Montant_Total_Finance_MTD FROM bankloandata
WHERE MONTH(date_emission) = 12

--montant total de pr�t financ� par la banque au mois de novembre
SELECT SUM(montant_pret) AS Montant_Total_Finance_PMTD FROM bankloandata
WHERE MONTH(date_emission) = 11

----------------------------------------------------------------------------

--montant total re�u
SELECT SUM(paiement_total) AS Montant_Total_Collect� FROM bankloandata

--montant total re�u au mois de d�cembre
SELECT SUM(paiement_total) AS Montant_Total_Collecte_MTD FROM bankloandata
WHERE MONTH(date_emission) = 12

--montant total re�u au mois de novembre
SELECT SUM(paiement_total) AS Montant_Total_Collecte_PMTD FROM bankloandata
WHERE MONTH(date_emission) = 11

-----------------------------------------------------------------------------
--Taux d'int�r�t moyen 
SELECT AVG(taux_interett)*100 AS Avg_Int_Rate FROM bankloandata

--Taux d'int�r�t moyen au mois de d�cembre
SELECT AVG(taux_interett)*100 AS Avg_Int_Rate FROM bankloandata
WHERE MONTH(date_emission) = 12

--Taux d'int�r�t moyen au mois de novembre
SELECT AVG(taux_interett)*100 AS Avg_Int_Rate FROM bankloandata
WHERE MONTH(date_emission) = 11

---------------------------------------------------------------------------------------
--Ratio moyen d'endettement (DTI) :
SELECT AVG(dti)*100 AS Avg_DTI FROM bankloandata

--Ratio moyen d'endettement (DTI) au mois de d�cembre
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM bankloandata
WHERE MONTH(date_emission) = 12

--Ratio moyen d'endettement (DTI) au mois de novembre
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM bankloandata
WHERE MONTH(date_emission) = 11

---------------------------------------------------------------------

--LES BONS PRETS
--Pourcentage de pr�ts enti�rement rembours�s ou en cours :

SELECT
    (COUNT(CASE WHEN statut_pret = 'Enti�rement rembours�' OR statut_pret = 'En cours' THEN id END) * 100.0) / 
    COUNT(id) AS Good_Loan_Percentage
FROM bankloandata

--Nombre de de pr�ts enti�rement rembours�s ou en cours :
SELECT COUNT(id) AS Good_Loan_Applications FROM bankloandata
WHERE statut_pret = 'Enti�rement rembours�' OR statut_pret = 'En cours'


----LES MAUVAIS PRETS
--Pourcentage de pr�tS NON REMBOURSES  :

SELECT
    (COUNT(CASE WHEN statut_pret = 'Irr�couvrable' THEN id END) * 100.0) / 
    COUNT(id) AS Bad_Loan_Percentage
FROM bankloandata

-- R�sum�
SELECT
    statut_pret,
    COUNT(id) AS NombrePret,
    SUM(paiement_total) AS Total_Montant_re�u,
    SUM(montant_pret) AS Total_Montant_Financ�,
    AVG(taux_interet * 100) AS Taux_interet,
    AVG(dti * 100) AS DTI
FROM bankloandata
GROUP BY statut_pret



---APER�U DU RAPPORT DES PRET BANCAIRES:

--PAR MOIS
SELECT 
    MONTH(date_emission) AS Month_Number, 
    DATENAME(MONTH, date_emission) AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(montant_pret) AS Total_Funded_Amount,
    SUM(paiement_total) AS Total_Amount_Received
FROM bankloandata
GROUP BY MONTH(date_emission), DATENAME(MONTH, date_emission)
ORDER BY MONTH(date_emission)

--PAR ETAT
SELECT 
    etat_residence AS ETAT, 
    COUNT(id) AS Nombre_total_de_pret,
    SUM(montant_pret) AS Total_Funded_Amount,
    SUM(paiement_total) AS Total_Amount_Received
FROM bankloandata
GROUP BY etat_residence
ORDER BY etat_residence

--Filtre par cat�gorie (par exemple, grade A) :
SELECT 
    but AS OBJET_DU_PRET, 
    COUNT(id) AS Nombre_de_demande_de_pret,
    SUM(montant_pret) AS Montant_total_pret,
    SUM(paiement_total) AS Montant_total_re�u
FROM bankloandata
WHERE classement = 'A'
GROUP BY but
ORDER BY but








