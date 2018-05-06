## Final Project ##

####------- DEFINE DATE PERIOD -------####
year_start = 1990
year_stop = 2017
tstep = 12 # Options: 12 - Monthly Only for now
#####---------------------------------####
=======
#cd("/Users/nicholasdepsky/Dropbox/Berkeley_tings/Spring 2018/ER 290A/ER290A-finalproject")
cd("/Users/lisarennels/Documents/UC Berkeley ERG/ENERES 290A/Final Project/ER290A-finalproject")

include("helper_functions.jl");

####------------------------------ DEFINE SUPPLY ---------------------------####
#returns demand_nodes, a list of dictionaries defining the demand nodes
include("DefineSupply.jl")

####------------------------------ DEFINE DEMAND ---------------------------####
#returns supply_nodes, a list of dictionaries defining the supply nodes
include("DefineDemand.jl")

####---------------------------DEFINE INFRASTRUCTURE -----------------------####
include("DefineInfrastructure.jl")

####---------------------------------RUN DRIP-------------------------------####
include("DRIP_deterministic.jl")

####---------------------------------RUN DRIP-------------------------------####
const numyears = length(collect(year_start:year_stop))
results = DRIP_deterministic(demand_nodes, supply_nodes, reservoir_nodes, numyears);

####------------------------------------------------------------------------####

####---------------------------------RUN GRAPHICS---------------------------####

####------------------------------------------------------------------------####
