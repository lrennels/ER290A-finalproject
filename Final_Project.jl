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
include("DRIP_deterministic.jl")

####------------------------------------------------------------------------####

####---------------------------------RUN DRIP-------------------------------####
const years = collect(1990:2017)
results = DRIP_deterministic(demand_nodes, supply_nodes, reservoir_nodes, years);

####------------------------------------------------------------------------####

####---------------------------------RUN GRAPHICS---------------------------####

####------------------------------------------------------------------------####
