## Final Project ##
#cd("/Users/nicholasdepsky/Dropbox/Berkeley_tings/Spring 2018/ER 290A/ER290A-finalproject")
cd("/Users/lisarennels/Documents/UC Berkeley ERG/ENERES 290A/Final/ER290A-finalproject")

using Queryverse

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
