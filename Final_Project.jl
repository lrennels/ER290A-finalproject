## Final Project ##
## Lisa Rennels and Nick Depsky
## ER 290A 

#cd("/Users/nicholasdepsky/Dropbox/Berkeley_tings/Spring 2018/ER 290A/ER290A-finalproject")
cd("/Users/lisarennels/Documents/UC Berkeley ERG/ENERES 290A/Final Project/ER290A-finalproject")

####-- DEFINE DATE PERIOD --------------------------------------------------####
const start_year = 1990
const stop_year = 2017
const tstep = 12 # Options: 12 - Monthly Only for now
const modays = [31, 28, 31, 30 ,31, 30, 31, 31, 30 ,31, 30 , 31]

####--VARIOUS HELPER FUNCTIONS ---------------------------------------------####
include("helper_functions.jl");

####-- DEFINE SUPPLY -------------------------------------------------------####
#returns 
#   - supply_nodes, a list of dictionaries defining the demand nodes
#   - supply, a dataframe of the supply

include("DefineSupply.jl")
supply = sdf(supply_nodes, start_year, stop_year)

####-- DEFINE DEMAND -------------------------------------------------------####
#returns 
#   - demand_nodes, a list of dictionaries defining the demand nodes
#   - demand, a dataframe of the supplyinclude("DefineDemand.jl")

include("DefineDemand.jl")
demand = ddf(demand_nodes, start_year, stop_year)

####-- DEFINE INFRASTRUCTURE -----------------------------------------------####
#returns 
#   - reservoir_nodes, a list of dictionaries defining the demand nodes
#   - demand, a dataframe of the supplyinclude("DefineDemand.jl")

include("DefineInfrastructure.jl")
reservoirs = rdf(reservoir_nodes, start_year, stop_year)

####-- RUN DRIP ------------------------------------------------------------####
include("DRIP_allocation_routine.jl")
#returns 
#   - results, a vector of demand fractions filled, one per demand node
results = DRIP_allocation_routine(demand_nodes, supply_nodes, reservoir_nodes,
(stop_year - start_year + 1));

####-- RUN GRAPHICS---------------------------------------------------------####
splot(supply)
dplot(demand)
rplot(reservoirs)
