## Define Supply:  This file adds the various supply nodes to the supply_node
## list, which is ordered randomly.  Supplies are assumed to be monthly values.
supply_nodes = []
push!(supply_nodes, create_supply_node("NYuba_Inflow_Month.csv", name = "inflow1", supply_units = "CFS"))
