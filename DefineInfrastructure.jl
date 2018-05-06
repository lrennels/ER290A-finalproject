## Define reservoirs:  This file adds the various demand nodes to the reservoir_nodes
## list, which is ordered randomly.  Units are assumed to be monthly values.

reservoir_nodes = []

push!(reservoir_nodes, create_reservoir(
    name = "Lake Merritt", 
    storage_capacity = 100_000., 
    top_of_conservation = [85_000.,85_000.,85_000.,90_000.,95_000.,100_000.,100_000.,100_000.,100_000.,95_000.,90_000.,85_000.], 
    storage_units = "AF")
)

# Reservoir Input Data Plot
resinplot = function()
    res = deepcopy(supply_nodes[1]["storage_capacity"])
    if length(supply_nodes) > 1
        for s in 2:length(supply_nodes)
            append!(sup,supply_nodes[s]["inflow"])
        end
    end
    sup |> vl"""
    {
        "title": "Streamflow",
        "mark": "area",
        "background": "white",
        "encoding": {
            "x": {"field": "Date","type": "temporal"},
            "y": {"field": "CFS","type": "Quantitative"},
            "color": {"field": "ID", "type": "nominal"},
            "opacity":{"value": 0.8}
        },
        "width": 500,
        "height": 300
    }
    """
end
