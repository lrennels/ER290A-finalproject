## Final Project ##

####------- DEFINE DATE PERIOD -------####
year_start = 2018
year_stop = 1990
tstep = 12 # Options: 12 - Monthly Only for now
#####---------------------------------####

include("helper_functions.jl");

####------------------------------ DEFINE SUPPLY ---------------------------####
#returns demand_nodes, a list of dictionaries defining the demand nodes
include("DefineSupply.jl")

####------------------------------ DEFINE DEMAND ---------------------------####
#returns supply_nodes, a list of dictionaries defining the supply nodes
include("DefineDemand.jl")

####---------------------------DEFINE INFRASTRUCTURE -----------------------####
include("DefineInfrastructure.jl")
####------------------------------------------------------------------------####

####---------------------------------RUN DRIP-------------------------------####

####------------------------------------------------------------------------####

####---------------------------------RUN GRAPHICS---------------------------####

####------------------------------------------------------------------------####
