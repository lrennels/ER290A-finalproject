## Define Demand:  This file adds the various demand nodes to the demand_node
## list, which is ordered randomly.  Demands are assumed to be monthly values.

demand_nodes = []

###----- Create Demand 1 -----###
push!(demand_nodes, create_demand_node(
    months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept",
    "Oct", "Nov", "Dec" ],
    demand_type = "city", 
    name = "City: Berkeley", 
    size = 400_000.,
    rate =  10e2 * [3.,3.,3.,3.,3.,3.,3.,3.,3.,3.,3.,3.],
    size_units = "people", 
    demand_units = "MM3", 
    priority = 1, 
    Loc = 1)
)
###---------------------------###

###----- Create Demand 2 -----###
push!(demand_nodes, create_demand_node(
    months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept",
    "Oct", "Nov", "Dec" ],
    demand_type = "farm", 
    name = "Farm: Anaya's Farm", 
    size = 100_000., 
    rate = 10e3 * [2., 2., 3., 5., 7., 8., 10., 8.5, 6., 4., 2.5, 2.], 
    size_units = "km2", 
    demand_units = "MM3", 
    priority = 1, 
    Loc = 2)
)
###---------------------------###

###----- Create Demand 3 -----###
push!(demand_nodes, create_demand_node(
    months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept",
    "Oct", "Nov", "Dec" ],
    demand_type = "hydropower", 
    name = "hydropower: ERG", 
    size = 1., 
    rate =  3*10e7 * [2., 2., 3., 5., 7., 8., 10., 8.5, 6., 4., 2.5, 2.], 
    size_units = "NA", 
    demand_units = "MM3", 
    priority = 2,
    Loc = 3)
)
###---------------------------###

###----- Create Demand 4 -----###
push!(demand_nodes, create_demand_node(
    months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept",
    "Oct", "Nov", "Dec" ],
    demand_type = "IFR", 
    name = "IFS: Trout", 
    size = 1., 
    rate = 1e9*fill(1, 12), 
    size_units = "NA", 
    demand_units = "MM3", 
    priority = 1, 
    Loc = 4)
)
###---------------------------###

# Create Data Frame of All Demands
function ddf(demand_nodes, start_year, stop_year)
    dictcopy = deepcopy(demand_nodes)
    nyears = stop_year - start_year + 1
    dates = Date.(sort(repmat(start_year:stop_year,12)),repmat(1:12,nyears))
    out=[]
    for i in 1:length(dictcopy)
        if (i == 1)
            out = DataFrame(
                Date = copy(dates), 
                Name = dictcopy[i]["name"],
                Quantity = repmat(dictcopy[i]["rate"]*dictcopy[i]["size"],nyears), 
                Units = dictcopy[i]["demand_units"],
                Loc = dictcopy[i]["Loc"])
        else
            add = DataFrame(
                Date = copy(dates), 
                Name = dictcopy[i]["name"],
                Quantity = repmat(dictcopy[i]["rate"]*dictcopy[i]["size"],nyears), 
                Units = dictcopy[i]["demand_units"],
                Loc = dictcopy[i]["Loc"])
            out = append!(out,add)
        end
    end
    return out
end