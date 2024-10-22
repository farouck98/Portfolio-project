

Select *
From PortofolioProjects..CovidDeaths
Where continent is not null
order by 3,4

--Select *
--From PortofolioProjects..CovidVaccinations
--order by 3,4

-- Sélectionnez les données avec lesquelles nous allons commencer

Select location, date, total_cases, new_cases, total_deaths, population
From PortofolioProjects..CovidDeaths
Where continent is not null
order by 1,2

-- Total cases vs Total Deaths dans un pays en particulier(France)

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortofolioProjects..CovidDeaths
Where location like '%France%'
order by 1,2

-- Total Cases vs Population dans un pays en particulier(France)

Select location, date, population, total_cases, (total_cases/population)*100 as DeathPercentage
From PortofolioProjects..CovidDeaths
Where location like '%France%'
order by 1,2

-- Pays avec le taux d'infection le plus élevé par rapport à la population


Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From PortofolioProjects..CovidDeaths
Group by location, population
order by PercentPopulationInfected desc

-- Pays avec le plus grand nombre de décès par population


Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortofolioProjects..CovidDeaths
where continent is not null
Group by location
order by TotalDeathCount desc

-- Affichage des continents avec le plus grand nombre de décès par population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortofolioProjects..CovidDeaths
where continent is not null
Group by continent
order by TotalDeathCount desc

-- CHIFFRES MONDIAUX


Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_Cases)*100 as DeathPercentage
From PortofolioProjects..CovidDeaths
where continent is not null 
order by 1,2

-- Population totale et vaccinations
-- Affiche le pourcentage de la population qui a reçu au moins un vaccin Covid

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortofolioProjects..CovidDeaths dea
Join PortofolioProjects..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

-- Utilisation de CTE pour effectuer un calcul sur la (Partition by) dans la requête précédente

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortofolioProjects..CovidDeaths dea
Join PortofolioProjects..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

-- Utilisation de la table temporaire pour effectuer un calcul sur la partition dans la requête précédente

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortofolioProjects..CovidDeaths dea
Join PortofolioProjects..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

-- Création d'une vue pour stocker des données pour des visualisations ultérieures

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortofolioProjects..CovidDeaths dea
Join PortofolioProjects..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 