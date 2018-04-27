## Define Demand:  This file adds the various demand nodes to the demand_node
## list, which is ordered randomly.  Demands are assumed to be monthly values.

demand_nodes = []

push!(demand_nodes, create_demand_node(node_type = "city", name = "Berkeley", 
    size = 150_000., rate = 10., size_units = "people", demand_units = "m3"))
push!(demand_nodes, create_demand_node(node_type = "farm", name = "Anaya's Farm", 
    size = 300_000., rate = 5., size_units = "ha", demand_units = "m3"))
push!(demand_nodes, create_demand_node(node_type = "IFR", name = "Trout", 
    size = 1., rate = 100_000., size_units = "NA", demand_units = "m3"))
push!(demand_nodes, create_demand_node(node_type = "hydropower", name = "ERG", 
    size = 1., rate = 40_000., size_units = "NA", demand_units = "kWh"))
