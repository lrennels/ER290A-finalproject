## Define reservoirs:  This file adds the various demand nodes to the demand_node
## list, which is ordered randomly.  Demands are assumed to be monthly values.

reservoir_nodes = []

push!(reservoir_nodes, create_reservoir(
    name = "Lake Merritt", 
    storage_capacity = 100_000., 
    top_of_conservation = [85_000.,85_000.,85_000.,90_000.,95_000.,100_000.,100_000.,100_000.,100_000.,95_000.,90_000.,85_000.], 
    storage_units = "AF")
)
