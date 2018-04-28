##  function to add a demand node to the list of demand nodes
##
##  arguments: name, size, rate, size_units, rate_units
##  output:  the node dictionary
function create_demand_node(; node_type::String = "default_type", name::String = "default_name", 
    size::Float64= -999., rate::Float64 = -999., size_units::String = "default_units", 
    demand_units::String = "demand_units", priority::Int64 = 999);

    return Dict("name" => name, "size" => size, "rate" => rate,    
    "size_units" => size_units, "demand_units" => demand_units, priority => priority); 
end

##  function to add a supply node to the list of suppl nodes
##
##  arguments: name, size, rate, size_units, rate_units
##  output:  the node dictionary
function create_supply_node(filepath::String; name::String = "default_name", 
    supply_units::String = "supply_units");

    inflow = DataFrame(load(filepath));
    return Dict("name" => name, "inflow" => inflow, "supply_units" => supply_units);
end

##  function to add a reservoir to the list of objects
##
##  arguments: name, storage capacity, top of conservation
##  output:  the node dictionary
function create_reservoir(filepath::String; name::String = "default_name", 
    storage_capacity::Float64 = -999.,
    top_of_conservation::Array = fill(-999.,12),
    storage_units::String = "storage_units");

    return Dict("name" => name, "storage_capacity" => storage_capacity, "top_of_conservation" => top_of_conservation, "storage_units" => storage_units);
end
