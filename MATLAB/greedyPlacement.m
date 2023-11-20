function [controllersGreedy,assignmentGreedy,TDMAGreedy,control_flows] = greedyPlacement( D,Wc,Wd,data_flows,G,Gtest,Cliques,links,TDMA_size)

    gamma=1;
    stop=false;
    control_requirements={};
    TDMAschemes={}; %store all TDMAs until now
    controlplacement={};
    controlassociations={};
    N=length(D);
    K=1;
    [cost,placement,assignment]=ran_greedy( D,Wc,Wd,gamma);
    while (gamma>0.05) &&(stop==false)
        I=500; %loops of the greedy algorithm
        LP=0; % whether to conduct linear programming
        % results of randomized greedy algorithm
        %[cost1,placement1,assignment1]=ran_greedy( gamma*dist2+D,Wc,Wd,gamma);
        
        for i=1:1:I
            %[cost,placement,assignment]=ran_greedy( gamma*dist2+D,Wc,Wd,gamma);
            [cost1,placement1,assignment1]=ran_greedy( D,Wc,Wd,gamma);
            if cost<cost1
                cost1=cost;
                placement1=placement;
                assignment1=assignment;
            end
        end

        as=zeros(N,N);
        for i=1:N
            as(assignment1(i),i)=1;
        end
        controllersGreedy=find(placement1==1);
        assignmentGreedy=assignment1;
        
        allflows=[]; % to sum data and control flows
        [link_requirements,totaloverhead,totaloverhead_ctrsw,totaloverhead_ctrctr] = computeOverhead_2(Gtest,links,assignmentGreedy,controllersGreedy);
        %after compute the requirements of each link for control traffic and
        %check if TDMA suitable is derived
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
         controlplacement{1,end+1}=controllersGreedy;
         controlassociations{1,end+1}=assignmentGreedy;        
         limit=ceil(numnodes(G)/3);
           
          if(size(TDMA,1)>TDMA_size || length(controllersGreedy)>(numnodes(G)/3)) %if exceeds frame size, stop the algorithm
             stop=true;
             %disp(gamma)
             %disp(size(TDMA,1))
          else
              gamma=gamma-0.02;
              %disp(gamma)
              %disp(size(TDMA,1))
              K=K+1;
          end
         
    end
    %K=gamma/0.05;
    %disp("THE k IS "+K)
    %disp(size(controlplacement,2))
    if(K>1)
        controllersGreedy=controlplacement{1,end-1};
        assignmentGreedy=controlassociations{1,end-1};
        control_flows=control_requirements{1,end-1};
        TDMAGreedy=TDMAschemes{1,end-1};
        %TDMAGreedy=create_frame_with_flows_multiple_rates_unfixed_ICMCIS(allflows,Cliques,links,G,250);
    else
        controllersGreedy=controlplacement{1,end};
        assignmentGreedy=controlassociations{1,end};
        control_flows=control_requirements{1,end};
        TDMAGreedy=TDMAschemes{1,end};
        %TDMAGreedy=create_frame_with_flows_multiple_rates_unfixed_ICMCIS(allflows,Cliques,links,G,250);
    end
    
end

