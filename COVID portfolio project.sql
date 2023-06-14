DROP TABLE IF EXISTS #Percentagepopulationvaccinated

--SELECT * 

--FROM Portfolioproject..[Covid death]

--Where continent is not NULL

--order by 3,4


--SELECT * 

--FROM Portfolioproject..[Covid vaccination]

--Where continent is not NULL

--order by 3,4



--SELECT location, date, total_cases, new_cases, total_deaths, population

--FROM Portfolioproject..[Covid death]

--Where continent is not NULL

--order by 1,2


 ------Total cases vs Total deaths

 ------THIS IS THE PROBABILTY OF DEATH IF ANYONE GOT INFECTED BY CORONA VIRUS IN AFRICA 

--SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS deathpercentage

--FROM Portfolioproject..[Covid death]

--Where continent is not NULL AND location like '%africa%'

--order by 1,2



-------- TOTAL CASES VS POPULATION
---------shows percentage of population got infected by corona virus in Africa

--SELECT location, date, population,total_cases, (total_cases/population)*100 AS infectedpercentage

--FROM Portfolioproject..[Covid death]

----Where location like '%africa%'

--order by 1,2


------COUNTRY WITH HIGHEST INFECTION RATE COMPARE TO POPULATION

--SELECT location,population,MAX(total_cases) as Highestinfectedcount, MAX((total_cases/population))*100 AS percentpopulationinfected

--FROM Portfolioproject..[Covid death]

----Where location like '%africa%'
--Group by location,population

--order by percentpopulationinfected desc



------ COUNTRIES WITH HIGHEST DEATH COUNT COMPARE TO POPULATION


--SELECT location,population,MAX(cast(total_deaths as int)) as totaldeathcount

--FROM Portfolioproject..[Covid death]

--Where continent is not NULL

--Group by location,population

--order by totaldeathcount desc



------HAVE A LOOK BY LOCATION

--SELECT location,MAX(cast(total_deaths as int)) as totaldeathcount

--FROM Portfolioproject..[Covid death]

--Where continent is not NULL

--Group by location,population

--order by totaldeathcount desc



----CONTINENT WITH HIGHEST DEATH COUNT

--SELECT continent,MAX(cast(total_deaths as int)) as totaldeathcount

--FROM Portfolioproject..[Covid death]

--Where continent is not NULL

--Group by continent

--order by totaldeathcount desc



---- GLOBAL NUMBERS

 

--SELECT date, SUM(new_cases) as totalcases, SUM(cast(new_deaths as int)) as totaldeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as deathpercentage


--from Portfolioproject..[Covid death]


--Where continent is not NULL AND location like '%africa%'

--Group by date

--order by 1,2



--SELECT *


--FROM Portfolioproject..[Covid vaccination]


---------TOTAL POPULATION VS VACCINATION


--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations

--FROM [Covid vaccination] AS vac

--join [Covid death] AS dea ON

--vac.location = dea.location and
--vac.date = dea.date

--where dea.continent is NOT NULL

--order by 2,3


--------TOTAL POPULATION VS VACCINATION

--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,

--SUM(convert(bigint,vac.new_vaccinations)) OVER (partition by dea.location)

--FROM [Covid death] as dea

--JOIN [Covid vaccination] AS vac on

--dea.location = vac.location

--and dea.date = vac.date

--where dea.continent is not NULL

--order by 2,3



--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,

--SUM(cast(vac.new_vaccinations as bigint)) OVER (partition by dea.location order by dea.location, dea.date) as Rollingpeoplevaccinated

--FROM [Covid death] as dea

--JOIN [Covid vaccination] AS vac on

--dea.location = vac.location

--and dea.date = vac.date

--where dea.continent is not NULL

--order by 2,3



---------------USING CTE------



--WITH popvsvac (continent,location,date, population, new_vaccinations,Rollingpeoplevaccinated)

--as

--(

--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,

--SUM(cast(vac.new_vaccinations as bigint)) OVER (partition by dea.location order by dea.location, dea.date) as Rollingpeoplevaccinated

--FROM [Covid death] as dea

--JOIN [Covid vaccination] AS vac on

--dea.location = vac.location

--and dea.date = vac.date

--where dea.continent is not NULL

------order by 2,3

--)


--Select *, (Rollingpeoplevaccinated)/(population)*100

--from popvsvac



------USING CTE WITHOUTH DATE

--WITH popvsvac (continent,location, population, new_vaccinations,Rollingpeoplevaccinated)

--as

--(

--SELECT dea.continent, dea.location, dea.population, vac.new_vaccinations,

--SUM(cast(vac.new_vaccinations as bigint)) OVER (partition by dea.location order by dea.location) as Rollingpeoplevaccinated

--FROM [Covid death] as dea

--JOIN [Covid vaccination] AS vac on

--dea.location = vac.location

--and dea.date = vac.date

--where dea.continent is not NULL

------order by 2,3

----)


--Select continent,location, population, new_vaccinations,Rollingpeoplevaccinated, (Rollingpeoplevaccinated)/(population)*100

--from popvsvac



-------#TEMP TABLE

CREATE TABLE #Percentagepopulationvaccinated(

continent nvarchar(255),
location nvarchar(255),
Date datetime,
population numeric,
new_vaccinations numeric,
Rollingpeoplevaccinated numeric

)


INSERT INTO #Percentagepopulationvaccinated

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,

SUM(cast(vac.new_vaccinations as bigint)) OVER (partition by dea.location order by dea.location, dea.date) as Rollingpeoplevaccinated

FROM [Covid death] as dea

JOIN [Covid vaccination] AS vac on

dea.location = vac.location

and dea.date = vac.date

where dea.continent is not NULL


Select *, (Rollingpeoplevaccinated)/(population)*100

from #Percentagepopulationvaccinated



-------CREATING VIEW FOR

CREATE VIEW Percentagepopulationvaccinated

AS

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,

SUM(cast(vac.new_vaccinations as bigint)) OVER (partition by dea.location order by dea.location, dea.date) as Rollingpeoplevaccinated

FROM [Covid death] as dea

JOIN [Covid vaccination] AS vac on

dea.location = vac.location

and dea.date = vac.date

where dea.continent is not NULL



SELECT *

FROM Percentagepopulationvaccinated