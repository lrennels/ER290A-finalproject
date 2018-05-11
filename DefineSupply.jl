## Define Supply:  This file adds the various supply nodes to the supply_node
## list, which is ordered randomly.  Supplies are assumed to be monthly values.

supply_nodes = []

###----- Create Inflow 1 -----###
push!(supply_nodes, create_supply_node(
    filepath = "NYuba_Inflow_Month.csv", 
    name = "Headflow", 
    supply_units = "CMS", 
    Loc = 1)
)
###---------------------------###

###----- Create Inflow 2 -----###
push!(supply_nodes, create_supply_node(
    filepath = "NYuba_Inflow_Month2.csv", 
    name = "Tributary 1", 
    supply_units = "CMS", 
    Loc = 3)
)
###---------------------------###

# Create Data Frame of All Supply Node Flows
function sdf(supply_nodes, start_year, stop_year)
    for s in 1:length(supply_nodes)
        if (s == 1)
            out = deepcopy(supply_nodes[1]["inflow"])
            out[:Name] = supply_nodes[1]["name"]
            out[:Loc] = supply_nodes[1]["Loc"]
        else
            add = deepcopy(supply_nodes[s]["inflow"])
            add[:Name] = supply_nodes[s]["name"]
            add[:Loc] = supply_nodes[s]["Loc"]
            append!(out,add)
        end
    end
    out = out[(Dates.year(out[:Date]).>=start_year)&(Dates.year(out[:Date]).<=stop_year),:]
    return out
end
 

