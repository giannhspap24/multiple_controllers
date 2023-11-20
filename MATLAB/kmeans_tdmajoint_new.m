function [final_controllers,final_associations,final_TDMAscheme,totaloverhead,control_flows] = kmeans_tdmajoint_new(data_flows,G,Gtest,Cliques,links,TDMA_size)
    
    K=1; %number of controllers
    centers = randperm(numnodes(G), 1);
    TDMAschemes={}; %store all TDMAs until now
    controlplacement={};
    controlassociations={};
    control_requirements={};
    stop=false;
    limit=ceil(numnodes(G)/3);
    % initialize the cluster assignments
    assignments = zeros(1, numnodes(G));
    associations = zeros(1, numnodes(G));
    while (K<numnodes(G)) &&(stop==false)
     

    % loop until convergence
    while true
        % assign nodes to clusters based on the closest center
        for i = 1:numnodes(G)
            dist1 = distances(G, i, centers);
            [~, idx] = min(dist1);
            assignments(i) = idx;
            associations(i) = centers(idx); %this is added
        end

        % calculate the cost of the current clustering
        costs = zeros(1, K);
        for i = 1:K
            idx = find(assignments == i);
            subg = subgraph(G, idx);
            dist2 = distances(subg);
            costs(i) = sum(sum(dist2)); %edited
        end
        total_cost = sum(costs);

        % initialize the new centers
        new_centers = zeros(1, K);
        for i = 1:K
            idx = find(assignments == i);
            subg = subgraph(G, idx);
            [~, longest_node] = max(degree(subg));
            new_centers(i) = idx(longest_node); %edited
            
            idxnew = find(associations == centers(i)); %which switch this controller is associated with
            associations(idxnew) = new_centers(i); %this is added also, number to replace centers(i) with new_centers(i)
        end

        % check for convergence
        if isequal(new_centers, centers)
            break
        end

        % update the centers
        %insert the longest node in all of the clusters
        centers = new_centers;
    end
    %insert the longest node in all of the clusters
     %centers = new_centers;
     
    
     
     % until here the revised mehtod to get the centroids
     
     %associations=assignments;
     controllers=centers;
     
     allflows=[]; % to sum data and control flows
     [link_requirements,totaloverhead,totaloverhead_ctrsw] = computeOverhead_2(Gtest,links,associations,controllers);

    %after compute the requirements of each link for control traffic and
    %check if TDMA suitable is derived
     %slotRS=36;
     control_flows=zeros(size(links,1),3);
     for i=1:size(links,1)
        %link_requirements(i)=ceil(link_requirements(i)/100); %convert them to slots
         control_flows(i,1)=str2double(links{i,1});
         control_flows(i,2)=str2double(links{i,2});
         control_flows(i,3)=link_requirements(i); %convert them to slots
     end
     control_requirements{1,end+1}=control_flows;
     %concatenate data and control flows to derive frame
     allflows=cat(1,data_flows,control_flows);
     TDMA=create_frame_with_flows_multiple_rates_unfixed_ICMCIS(allflows,Cliques,links,G);

     TDMAschemes{1,end+1}=TDMA;
     controlplacement{1,end+1}=controllers;
     controlassociations{1,end+1}=associations;
     
      if(size(TDMA,1)>TDMA_size || K>limit) %if exceeds frame size, stop the algorithm
         stop=true;
      else
          %ADD THE LONGEST CENTRE
          K=K+1;
          maxxdist=zeros(1,numnodes(G));
          for i = 1:numnodes(G)
              maxxdist(i)=length(shortestpath(G,i,centers(assignments(i))));
          end
          [~,index]=max(maxxdist);
          centers(end+1)=index;
     
       end
    end %end while
    
    if(K==1)
        final_controllers=controlplacement{1,K};
        final_associations=controlassociations{1,K};
        final_TDMAscheme=TDMAschemes{1,K};
        control_flows=control_requirements{1,K};
        %final_TDMAscheme=create_frame_with_flows_multiple_rates_unfixed_ICMCIS_new(allflows,Cliques,links,G,250);
    else
        disp(K)
        disp(size(TDMAschemes{1,end-1},1))
        disp(size(TDMAschemes{1,end},1))
        
        final_controllers=controlplacement{1,K-1};
        final_associations=controlassociations{1,K-1};
        final_TDMAscheme=TDMAschemes{1,K-1};
        control_flows=control_requirements{1,K-1};
        %final_TDMAscheme=create_frame_with_flows_multiple_rates_unfixed_ICMCIS(allflows,Cliques,links,G,250);
    end
    
end

