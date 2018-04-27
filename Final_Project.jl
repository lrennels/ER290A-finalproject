## Final Project ##

include("helper_functions.jl");

####------------------------------ DEFINE SUPPLY --------------------------------####
inflow = open("NYuba_cfs.csv")
####-----------------------------------------------------------------------------####

####------------------------------ DEFINE INFRASTRUCTURE ------------------------####

####-----------------------------------------------------------------------------####

####------------------------------ DEFINE DEMAND --------------------------------####

#returns demand_nodes, a list of dictionaries defining the demand nodes
include("DefineDemand.jl")

####-----------------------------------------------------------------------------####

city_pop = 1e4 # number of people in city
city_dem_cap = # per capita city demand
