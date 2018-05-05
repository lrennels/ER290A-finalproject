## Define Supply:  This file adds the various supply nodes to the supply_node
## list, which is ordered randomly.  Supplies are assumed to be monthly values.

supply_nodes = []

###----- Create Inflow 1 -----###
push!(supply_nodes, create_supply_node(
    filepath = "NYuba_Inflow_Month.csv", 
    name = "inflow1", 
    supply_units = "CFS", 
    ID = 1)
)
supply_nodes[1]["inflow"][:ID] = supply_nodes[1]["name"]
###---------------------------###

###----- Create Inflow 2 -----###
push!(supply_nodes, create_supply_node(
    filepath = "NYuba_Inflow_Month2.csv", 
    name = "inflow2", 
    supply_units = "CFS", 
    ID = 2)
)
supply_nodes[2]["inflow"][:ID] = supply_nodes[2]["name"]
###---------------------------###

###----- Create Inflow 3 -----###
push!(supply_nodes, create_supply_node(
    filepath = "NYuba_Inflow_Month3.csv", 
    name = "inflow3", 
    supply_units = "CFS", 
    ID = 3)
)
supply_nodes[3]["inflow"][:ID] = supply_nodes[3]["name"]
###---------------------------###

