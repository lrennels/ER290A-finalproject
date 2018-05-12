## Define reservoirs:  This file adds the various demand nodes to the reservoir_nodes
## list, which is ordered randomly.  Units are assumed to be monthly values.

reservoir_nodes = []

###----- Create Reservoir 1 -----###
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
    dictcopy = deepcopy(reservoir_nodes)
    nyears = stop_year - start_year + 1
    dates = Date.(sort(repmat(start_year:stop_year,12)),repmat(1:12,nyears))
    out=[]
    for i in 1:length(dictcopy)
        if (i == 1)
            out = DataFrame(
                Date = copy(dates), 
                Name = dictcopy[i]["name"],
                StorageCap = fill(dictcopy[i]["storage_capacity"],length(dates)), 
                TOC = repmat(dictcopy[i]["top_of_conservation"],nyears),
                RESULTS_Storage = fill(0,length(dates)),
                Units = dictcopy[i]["storage_units"],
                Loc = dictcopy[i]["Loc"])
        else
            add = DataFrame(
                Date = copy(dates), 
                Name = dictcopy[i]["name"],
                StorageCap = fill(dictcopy[i]["storage_capacity"],length(dates)), 
                TOC = repmat(dictcopy[i]["top_of_conservation"],nyears),
                RESULTS_Storage = fill(0,length(dates)),
                Units = dictcopy[i]["storage_units"],
                Loc = dictcopy[i]["Loc"])
            out = append!(out,add)
        end
    end
    return out
end