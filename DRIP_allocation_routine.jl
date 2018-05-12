## This file defines a deterministic algorithm for DRIP, and can be used as a 
#skeleton as we decide how to include optimization components 

## ASSUMPTION 1:  All supply is upstream of all demand - we may want to alter 
## this with some sort of distance variable for all the nodes, but might be 
## unnecesarily complicated for now

function DRIP_allocation_routine(demand_nodes::Array{}, supply_nodes::Array{}, 
    reservoir_nodes::Array{}, numyears::Int64)
        
    #get maximum priority number
    max_demand_priority = 0
    for node = 1:length(demand_nodes)
        max_demand_priority = max(max_demand_priority, demand_nodes[node]["priority"])
    end

    #sort demand nodes
    demand_nodes= sort(demand_nodes, by = x -> x["priority"])

    #track the total current supply
    current_supply= 0.

    #track how much of each demand node gets demand_frac_filleded
    demand_frac_filled = zeros(length(demand_nodes))

    for m = 1:numyears * 12

        s_index = m
        m_index = m%12 
        if m_index == 0
            m_index = 12
        end

        #add the monthly supply to the current_supply, assuming the supply is in
        #cubic feet per second
        for node = 1:length(supply_nodes)
            current_supply += supply_nodes[node]["inflow"][:CMS][s_index] * 60*60*24*modays[m_index]
        end

        #loop over the demand
        current_node = 1
        for p = 1:max_demand_priority

            current_set = []
            while current_node <= length(demand_nodes) && demand_nodes[current_node]["priority"] == p
                push!(current_set, demand_nodes[current_node])
                current_node += 1
            end

            #calculate the total demand for this priority set, and get all of the
            #Locs for the priority set to use later
            total_demand = 0.
            Locs = []
            for node = 1:length(current_set)
                total_demand += current_set[node]["size"] * current_set[node]["rate"][m_index]
                push!(Locs, current_set[node]["Loc"])
            end

            #if there is enough supply, allocate all of it to these nodes, 
            #subtract from current_supply, mark these demand nodes as taken
            #care of 100%, and move on
            if current_supply >= total_demand
                current_supply -= total_demand
                demand_frac_filled[Locs] = 1

            #if there is not enough supply, allocate it equally between these 
            #nodes, mark these nodes as taken care of x%, and break out of loop
            else
                demand_frac_filled[Locs] = current_supply / total_demand
                current_supply = 0.
                
            end
        end
    end
    return demand_frac_filled
end
