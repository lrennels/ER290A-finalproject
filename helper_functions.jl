##  function to add a demand node to the list of demand nodes
##
##  arguments: name, size, rate, size_units, rate_units
##  output:  the node dictionary
function create_demand_node(; node_type::String = "default_type", name::String = "default_name", 
    size::Float64= -999., rate::Float64 = -999., size_units::String = "default_units", 
    demand_units::String = "demand_units");

    return Dict("name" => name, "size" => size, "rate" => rate,    
    "size_units" => size_units, "demand_units" => demand_units); 
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
