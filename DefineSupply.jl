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
    Loc = 2)
)
###---------------------------###

# Create Data Frame of All Supply Node Flows
function sdf(supply_nodes, start_year, stop_year)
    dictcopy = deepcopy(supply_nodes)
    for i in 1:length(dictcopy)
        if (i == 1)
            out = DataFrame(
                Date = dictcopy[i]["inflow"][:Date],
                Name = dictcopy[i]["name"],
                Quantity = dictcopy[i]["inflow"][:CMS],
                Units = dictcopy[i]["supply_units"],
                Loc = dictcopy[i]["Loc"]
            )
        else
            add = DataFrame(
                Date = dictcopy[i]["inflow"][:Date],
                Name = dictcopy[i]["name"],
                Quantity = dictcopy[i]["inflow"][:CMS],
                Units = dictcopy[i]["supply_units"],
                Loc = dictcopy[i]["Loc"]
            )
            append!(out,add)
        end
    end
    out = out[(Dates.year(out[:Date]).>=start_year)&(Dates.year(out[:Date]).<=stop_year),:]
    return out
end
 

