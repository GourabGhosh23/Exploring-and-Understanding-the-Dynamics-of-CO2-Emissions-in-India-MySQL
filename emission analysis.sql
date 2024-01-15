#Lets determine the year wise trend of co2 in India

select year, co2 from emission;

#### from the output overall we can say that the co2 emission of India has only increased since 1970. ###

#Lets analyse the reason behind it. Lets explore co2 per capita

select year, co2_per_capita from emission;

### per capita co2 is also increasing every year since 1970

### Lets check out the population growth in india since 1970

select 
    t1.year,
    t1.population,
    (t1.population - t2.population) / t2.population * 100 as population_percentage_difference
from 
    emission t1
join 
    emission t2 on t1.year = t2.year + 1
order by 
    t1.year;
    
### From this query we can see that the growth percentage of Indian population growth has been decreasing significantly
### since 2000.

#Lets explore different type of co2 emission

select year, coal_co2, oil_co2, gas_co2 from emission;

#### from this query it is evident that the use of coal is getting increased every year and simultaneously co2 is also increasing
#### This very concerning

### Now lets find out top 5 years where co2 emission was the highest

select year, co2
from emission
order by co2 desc 
limit 5;

#### Though this data is till 2018 but it is still very concerning because as the year progresses we should be able to
#### limit CO2 emission but in retrospection we are getting an increasing CO2 emission

# Lets find out the top 5 years when CO2 per capita was highest

select year, co2_per_capita
from emission
order by co2_per_capita desc
limit 5;

#### Insight is same as the query before this

# Lets find out the share of type of emissions

select 
    year,
    (sum(coal_co2) / sum(co2)) * 100 as coal_share,
    (sum(oil_co2) / sum(co2)) * 100 as oil_share,
    (sum(gas_co2) / sum(co2)) * 100 as gas_share
from 
    emission
group by
    year
order by 
    year;
    
#### Share of coal haas slightly decreased over the years
#### Share of oil and gas has increased significantly over the years
#### There's slight correlation between oil share and coal share. Whenever oil share increases slightly, the coal share is decreasing. 
#### From here, maybe it can be concluded that we are trying to replace coal with oil (which is a well known fact) in the last 10 years.
#### Gas share increased significantly in the period of 2010, 2011 but it has decreased ever since.

# Now lets explore the energy consumption aspect

select 
    year,
    co2,
    primary_energy_consumption
from 
    emission
order by primary_energy_consumption desc;

#### This is a well known fact that energy consumption is one of the main reasons for CO2 emission
#### That is reflected in this query

# Now temperature change by co2

select
    year,
    temperature_change_from_co2,
    (temperature_change_from_co2 - lag(temperature_change_from_co2) over (order by year)) / lag(temperature_change_from_co2) over (order by year) * 100 as temperature_increase_percentage
from
    emission
order by
    year;
    
#### A bitter sweet insight can be derived from this query. The percentage of temperature increase is decreasing for the last few years.


