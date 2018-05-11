## Define reservoirs:  This file adds the various demand nodes to the reservoir_nodes
## list, which is ordered randomly.  Units are assumed to be monthly values.

reservoir_nodes = []

###----- Create Demand 1 -----###
push!(reservoir_nodes, create_reservoir(
    name = "Lake Merritt", 
    storage_capacity = 400., 
    init_storage = 250.,
    top_of_conservation = [400.,400.,400.,400.,400.,400.,400.,400.,400.,400.,400.,400.], 
    storage_units = "MM3",
    Loc = 2)
)
###---------------------------###

# Create Data Frame of All Reservoirs
function rdf(reservoir_nodes, start_year, stop_year)
    nyears = stop_year - start_year + 1
    dates = Date.(sort(repmat(years,12)),repmat(1:12,nyears))
    out=[]
    for i in 1:length(reservoir_nodes)
        if (i == 1)
            out = DataFrame(
                Date = copy(dates), 
                Name = reservoir_nodes[i]["name"],
                StorageCap = fill(deepcopy(reservoir_nodes[i]["storage_capacity"]),length(dates)), 
                TOC = repmat(deepcopy(reservoir_nodes[i]["top_of_conservation"]),nyears),
                Storage = fill(0,length(dates)),
                Units = reservoir_nodes[i]["storage_units"],
                Loc = reservoir_nodes[i]["Loc"])
            out[:Storage][1] = reservoir_nodes[i]["init_storage"]
        else
            add = DataFrame(
                Date = copy(dates), 
                Name = reservoir_nodes[i]["name"],
                StorageCap = fill(deepcopy(reservoir_nodes[i]["storage_capacity"]),length(dates)), 
                TOC = repmat(deepcopy(reservoir_nodes[i]["top_of_conservation"]),nyears),
                Storage = fill(0,length(dates)),
                Units = reservoir_nodes[i]["storage_units"],
                Loc = reservoir_nodes[i]["Loc"])
            out = append!(out,add)
        end
    end
    return out
end