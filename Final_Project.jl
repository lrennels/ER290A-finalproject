## Final Project ##
cd("/Users/nicholasdepsky/Dropbox/Berkeley_tings/Spring 2018/ER 290A/ER290A-finalproject")
using Queryverse

include("helper_functions.jl");

####------------------------------ DEFINE SUPPLY --------------------------------####
inflow = create_supply_node("NYuba_Inflow_Month.csv", name = "inflow1", supply_units = "CFS")
####-----------------------------------------------------------------------------####

####------------------------------ DEFINE INFRASTRUCTURE ------------------------####

####-----------------------------------------------------------------------------####

####------------------------------ DEFINE DEMAND --------------------------------####

#returns demand_nodes, a list of dictionaries defining the demand nodes
include("DefineDemand.jl")

####-----------------------------------------------------------------------------####

