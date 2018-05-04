## Final Project ##
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
