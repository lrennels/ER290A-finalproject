## This file defines a WIP version of the DRIP allocation routine that involves
## more complex algorithms and prepares for an optimization step.

## ---------------------------------------------------------------------------##
## WIP WORK ON OPTIMIZABLE MODEL ---------------------------------------------##
## ---------------------------------------------------------------------------##

#initialize variables
res_tm1 = rcopy[:RESULTS_Storage][t-1]
inflow = 0
withd = 0
dem = 0
sup = 0

#configure the Excel Optim model into Julia
for l in 1:length(locs)

    #configure model for first node
    if l == 1
        
        if locs[l] in slocs # If supply node
            if scopy[scopy[:Loc].==locs[l],:][:Units][t] == "CMS"
                sup = scopy[scopy[:Loc].==locs[l],:][:Quantity][t]*60*60*24*mdays
                [Dates.month(dates[t])] # convert to MM3
            else
                sup = scopy[scopy[:Loc].==locs[l],:][:Quantity][t]
            end

        elseif locs[l] in dlocs # If demand node
            if dcopy[dcopy[:Loc].==locs[l],:][:Units][t] == "CMS"
                dem = dcopy[dcopy[:Loc].==locs[l],:][:Quantity][t]*60*60*24*mdays
                [Dates.month(dates[t])] # convert to MM3
            else
                dem = dcopy[dcopy[:Loc].==locs[l],:][:Quantity][t]
            end

        elseif locs[l] in rlocs # If reservoir node
            if t == 1
                sup = res_inits[find(rlocs .== locs[l])]
            else
                sup = rcopy[:RESULTS_Storage][t-1]
            end           
        end
        
    #not in the first location   
    else

    end
end

#create objective function
function dem_covg_obj(withdrawal_frac)
end

# Function to determine how much water reservoir should store/release
function resbal(t,l)
end

## ---------------------------------------------------------------------------##
## ORIGINAL WORK, ENHANCED ----- ---------------------------------------------##
## ---------------------------------------------------------------------------##

function DRIP_allocation(demand, supply, reservoirs, res_inits, start_year, stop_year, year_ts = 12)

    dcopy = deepcopy(demand)
    dcopy[:RESULTS_DemandMet] = -999.
    dcopy[:RESULTS_DemandUnmet] = -999.
    dcopy[:RESULTS_PctCoverage] = -999.
    dcopy[:RESULTS_PctShortage] = -999.

    scopy = deepcopy(supply)

    rcopy = deepcopy(reservoirs)
    rcopy[:RESULTS_Inflow] = -999.
    rcopy[:RESULTS_Outflow] = -999.

    nyears = stop_year - start_year + 1
    dates = Date.(sort(repmat(start_year:stop_year,12)),repmat(1:12,nyears))
    lyears = 1800:4:2200

    # find all locations of demand, supply, reservoir nodes (1 = furthest upstream)
    locs = sort(unique(vcat(dcopy[:Loc], scopy[:Loc], rcopy[:Loc])))
    slocs = unique(scopy[:Loc])
    dlocs = unique(dcopy[:Loc])
    rlocs = unique(rcopy[:Loc])

    # create stream reach flows matrix (reprsents flow at end of reach)
    reach_flow = fill(0.,length(dates),length(locs))

    for t = 1:length(dates)
        if (Dates.year(dates[t]) in lyears)
            mdays = [31,29,31,30,31,30,31,31,30,31,30,31]
        else
            mdays = [31,28,31,30,31,30,31,31,30,31,30,31]
        end

        for l = 1:length(locs)
            #Define Inflow from upstream reach
            if (l == 1)
                inflow = 0 # inflow from upstream reach is 0 for top reach
            else
                inflow = reach_flow[t,l-1] # takes streamflow 
            end

            ## Define withdrawals for demand nodes or reservoirs within reach
            # If current node is not a demand or reservoir node, and is upstream of any reservoirs
            if (!(locs[l] in dlocs) && locs[l] < minimum(rlocs))
                deliv = 0
                resb = 0
            elseif ()

            end
            
            #Define supply to reach
            if (scopy[scopy[:Loc].==l,:][:Units][t] == "CMS")
                sup = scopy[scopy[:Loc].==locs[l],:][:Quantity][t]*60*60*24*mdays[Dates.month(dates[t])]
            else
                sup = scopy[:Quantity][t]
            end
            reach_flow[t,l] = inflow + sup - deliv + resb
        end
    end
end
        
    #get maximum priority number
    max_demand_priority = 0
    for node = 1:length(demand_nodes)
        max_demand_priority = max(max_demand_priority, demand_nodes[node]["priority"])
    end

    #sort demand nodes
    demand_nodes= sort(demand_nodes, by = x -> x["priority"])

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
        #track the total current supply
        current_supply= 0.
        for node = 1:length(supply_nodes)
            current_supply += supply_nodes[node]["inflow"][:CMS][s_index] * 60*60*24*modays[m_index]
        end

        #loop over the demand priorities
        current_node = 1
        for p = 1:max_demand_priority
            current_set = []
            while current_node <= length(demand_nodes) && demand_nodes[current_node]["priority"] == p
                push!(current_set, demand_nodes[current_node])
                current_node += 1
            end

            #calculate the total demand for this priority set, and get all of the
            #IDs for the priority set to use later
            total_demand = 0.
            IDs = []
            for node = 1:length(current_set)
                total_demand += current_set[node]["size"] * current_set[node]["rate"][m_index]
                push!(IDs, current_set[node]["ID"])
            end

            #if there is enough supply, allocate all of it to these nodes, 
            #subtract from current_supply, mark these demand nodes as taken
            #care of 100%, and move on
            if current_supply >= total_demand
                current_supply -= total_demand
                demand_frac_filled[IDs] = 1

            #if there is not enough supply, allocate it equally between these 
            #nodes, mark these nodes as taken care of x%, and break out of loop
            else
                demand_frac_filled[IDs] = current_supply / total_demand
                current_supply = 0.
                
            end
        end
    return demand_frac_filled
end
