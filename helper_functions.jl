##  function to add a demand node to the list of demand nodes
##
##  arguments: name, size, rate, size_units, rate_units
##  output:  the node dictionary

using Queryverse

function res_init(reservoir_nodes)
    res_inits = fill(0,length(reservoir_nodes))
    for r = 1:length(reservoir_nodes)
        res_inits[r] = reservoir_nodes[r]["init_storage"]
    end
    return res_inits
end

function create_demand_node(;
    demand_type::String = "default_type", 
    name::String = "default_name", 
    size::Float64= -999., 
    rate::Array{} = [], 
    size_units::String = "default_units", 
    demand_units::String = "demand_units", 
    priority::Int64 = 999, 
    Loc::Int64 = 999, 
    months::Array{} = []);

    return Dict("demand_type" => demand_type, "name" => name, "size" => size, "rate" => rate,    
    "size_units" => size_units, "demand_units" => demand_units, "priority" => priority, 
    "Loc" => Loc, "months" => months); 
end

##  function to add a supply node to the list of supply nodes
##
##  arguments: name, size, rate, size_units, rate_units
##  output:  the node dictionary
function create_supply_node(;
    filepath::String = "filepath", 
    name::String = "default_name", 
    supply_units::String = "supply_units", 
    Loc::Int64 = 999)

    inflow = DataFrame(load(filepath))
    return Dict("name" => name, "inflow" => inflow, "supply_units" => supply_units, 
    "Loc" => Loc)
end

##  function to add a reservoir to the list of objects
##
##  arguments: name, storage capacity, top of conservation
##  output:  the node dictionary
function create_reservoir(;
    name::String = "default_name", 
    storage_capacity::Float64 = -999., 
    init_storage::Float64 = -999.,
    top_of_conservation::Array = fill(-999.,12), 
    storage_units::String = "storage_units", 
    Loc::Int64 = -999);

    return Dict("name" => name, "storage_capacity" => storage_capacity, "init_storage" => init_storage,
    "top_of_conservation" => top_of_conservation, "storage_units" => storage_units, 
    "Loc" => Loc);
end

###----------------------- PLOTTING FUNCTIONS ------------------------###
# Supply Plot (supply_nodes)
splot = function(sup,year1,year2)
    sup2 = deepcopy(sup[(Dates.year(sup[:Date]).>=year1)&(Dates.year(sup[:Date]).<=year2),:])
    sup2 |> vl"""
    {
        "title": "Streamflow",
        "mark": "area",
        "background": "white",
        "encoding": {
            "x": {"field": "Date","type": "temporal"},
            "y": {"field": "Quantity","type": "Quantitative"},
            "color": {"field": "Name", "type": "nominal"},
            "opacity":{"value": 0.8}
        },
        "width": 500,
        "height": 300
    }
    """
end

#Demand Plot (demand_nodes)
dplot = function(dem,year1,year2)
    dem2 = deepcopy(dem[(Dates.year(dem[:Date]).>=year1)&(Dates.year(dem[:Date]).<=year2),:])
    dem2 |> vl"""
    {
        "title": "Demand",
        "mark": "area",
        "background": "white",
        "encoding": {
            "x": {"field": "Date", "type": "temporal"},
            "y": {"field":"Quantity", "type": "Quantitative"},
            "color": {"field": "Name", "type": "nominal"},
            "opacity":{"value": 0.8}
        },
        "width": 500,
        "height": 300
    }
    """
end

# Reservoir Plots
rplot = function(res,year1,year2)
    res2 = deepcopy(res[(Dates.year(res[:Date]).>=year1)&(Dates.year(res[:Date]).<=year2),:])
    res2 |> vl"""
    {
        "title": "Demand",
        "mark": "area",
        "background": "white",
        "encoding": {
            "x": {"field": "Date", "type": "temporal"},
            "y": {"field":"Quantity", "type": "Quantitative"},
            "color": {"field": "Name", "type": "nominal"},
            "opacity":{"value": 0.8}
        },
        "width": 500,
        "height": 300
    }
    """
end