## This file defines a deterministic algorithm for DRIP, and can be used as a 
#skeleton as we decide how to include optimization components 

## ASSUMPTION 1:  All supply is upstream of all demand - we may want to alter 
## this with some sort of distance variable for all the nodes, but might be 
## unnecesarily complicated for now

function DRIP_deterministic(demand_nodes::Array{}, supply_nodes,::Array{}, 
    reservoir_nodes::Array{}, years::Array{})
        
    #parse the demand nodes by priority by creating an array of arrays of dictionaries
    #where each outer array index stands for the priority, and holds an array
    #of dictionaries, each belonging to a demand node of that priority
    max_demand_priority = 0
    for node = 1:length(demand_nodes)
        max_demand_priority = max(max_demand_priority, supply_nodes[node]["priority"])
    end

    priority_demand_nodes = Array{Array{}}(max_demand_priority, 1)
    for node = 1:length(demand_nodes)
        priority = supply_nodes[node]["priority"]
        push!(priority_demand_nodes[priority], supply_nodes[node])
    end

    #track the total current supply
    current_supply= 0.

    #track how much of each demand node gets filled
    fill = zeros(length(demand_nodes,1))

    for m = 1:length(years) * 12

        #add the monthly supply to the current_supply
        for node = 1:length(supply_nodes)
            current_supply += supply_nodes[node]["inflow"][:CFS][m]
        end

        #loop over the demand
        for p = 1:max_demand_priority

            #calculate the total demand for this priority set
            total_demand = 0.
            for node = 1:length(priority_demand_nodes[p])
                total_demand += priority_demand_nodes[p][node]["size"]
            end

            #if there is enough supply, allocate all of it to these nodes, 
            #subtract from current_supply, mark these demand nodes as taken
            #care of 100%, and move on
            if current_supply >= total_demand
                current_supply -= total_demand
                fill[priority_demand_nodes[p][node]["ID"]] = 1

            #if there is not enough supply, allocate it equally between these 
            #nodes, mark these nodes as taken care of x%, and break out of loop
            else

            end

        end

    end
    return fill
end
