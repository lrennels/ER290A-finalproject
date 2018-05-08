## Final Project ##
## Lisa Rennels and Nick Depsky
## ER 290A 

#cd("/Users/nicholasdepsky/Dropbox/Berkeley_tings/Spring 2018/ER 290A/ER290A-finalproject")
cd("/Users/lisarennels/Documents/UC Berkeley ERG/ENERES 290A/Final Project/ER290A-finalproject")

####-- DEFINE DATE PERIOD --------------------------------------------------####
const year_start = 1990
const year_stop = 2017
const tstep = 12 # Options: 12 - Monthly Only for now
const modays = [31, 28, 31, 30 ,31, 30, 31, 31, 30 ,31, 30 , 31]

####--VARIOUS HELPER FUNCTIONS ---------------------------------------------####
include("helper_functions.jl");

####-- DEFINE SUPPLY -------------------------------------------------------####
#returns demand_nodes, a list of dictionaries defining the demand nodes
include("DefineSupply.jl")

####-- DEFINE DEMAND -------------------------------------------------------####
#returns supply_nodes, a list of dictionaries defining the supply nodes
include("DefineDemand.jl")

####-- DEFINE INFRASTRUCTURE -----------------------------------------------####
include("DefineInfrastructure.jl")

####-- RUN DRIP ------------------------------------------------------------####
include("DRIP_deterministic.jl")

results = DRIP_deterministic(demand_nodes, supply_nodes, reservoir_nodes, 
    collect(year_start:year_stop));

####-- RUN GRAPHICS---------------------------------------------------------####
splot()
dplot()
