## Define Demand:  This file adds the various demand nodes to the demand_node
## list, which is ordered randomly.  Demands are assumed to be monthly values.

demand_nodes = []

###----- Create Demand 1 -----###
push!(demand_nodes, create_demand_node(
    months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept",
    "Oct", "Nov", "Dec" ],
    node_type = "city", 
    name = "City: Berkeley", 
    size = 150_000.,
    rate =  10e2 * [5., 5. , 5., 5., 5., 5., 5., 5., 5., 5., 5., 5.],
    size_units = "people", 
    demand_units = "CFS", 
    priority = 1, 
    ID = 1)
)
###---------------------------###

###----- Create Demand 2 -----###
push!(demand_nodes, create_demand_node(
    months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept",
    "Oct", "Nov", "Dec" ],
    node_type = "farm", 
    name = "Farm: Anaya's Farm", 
    size = 300_000., 
    rate = 10e2 * [5., 6. , 7., 8., 9., 10., 10., 9., 8., 7., 6., 5.], 
    size_units = "ha", 
    demand_units = "CFS", 
    priority = 2, 
    ID = 2)
)
###---------------------------###

###----- Create Demand 3 -----###
push!(demand_nodes, create_demand_node(
    months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept",
    "Oct", "Nov", "Dec" ],
    node_type = "hydropower", 
    name = "hydropower: ERG", 
    size = 1., 
    rate =  10e7 * [10., 11. , 12., 11., 12., 13., 13., 12., 11., 10., 9., 9.], 
    size_units = "NA", 
    demand_units = "CFS", 
    priority = 2,
    ID = 3)
)
###---------------------------###

###----- Create Demand 4 -----###
push!(demand_nodes, create_demand_node(
    months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept",
    "Oct", "Nov", "Dec" ],
    node_type = "IFR", 
    name = "IFS: Trout", 
    size = 1., 
    rate =  10e7 * fill(6., 12), 
    size_units = "NA", 
    demand_units = "CFS", 
    priority = 3, 
    ID = 4)
)
###---------------------------###
