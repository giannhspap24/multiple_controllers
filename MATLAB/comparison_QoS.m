comp_matrix={};
sizeTDMAs=[];
numcontrollers=[];
flows_mixes={};
sizeTDMAs50_th=[];
sizeTDMAs75_th=[];
sizeTDMAs100_th=[];
sizeTDMAs85_th=[];
sizeTDMAs60_th=[];
numcontrollers100_th=[];
numcontrollers75_th=[];
numcontrollers50_th=[];
numcontrollers85_th=[];
numcontrollers60_th=[];
index=0;
tempjoint=[];
tempjoint_ordered100_th=[]; %dataqos=100
tempjoint_ordered75_th=[];   %dataqos=75
tempjoint_ordered50_th=[];  %dataqos=50
tempjoint_ordered85_th=[];   %dataqos=75
tempjoint_ordered60_th=[];  %dataqos=50
tempjoint_ordered100_worst_th=[]; %dataqos=100
tempjoint_ordered75_worst_th=[];   %dataqos=75
tempjoint_ordered50_worst_th=[];  %dataqos=50
tempjoint_ordered85_worst_th=[];   %dataqos=75
tempjoint_ordered60_worst_th=[];  %dataqos=50
indexx=0;
avoid=[19,20];
tic
for numgraphs=1:1
    
    if(ismember(numgraphs,avoid)<1)
     indexx=indexx+1;
     %tic;
     %[G,Gtest] = create_random_graph_RGG_sparse(nodes);
     %G=graphs_undirected{1,index};
     %Gtest=graphs_directed{1,index};
     %[Cliques2,links,CM] = createMaximalSets_new(Gtest);
     G=setofG{1,numgraphs};
     Gtest=setofGtest{1,numgraphs};
     [Cliques2,links,~] = createMaximalSets_new(Gtest);
     Cliques_new=csvread([num2str(numgraphs),'.csv']);
     
%      times_elapsed_MIS(end+1)=toc;
%      graphs_undirected{1,end+1}=G;
%      graphs_directed{1,end+1}=Gtest;
%      comp_matrix{1,end+1}=CM;
%      disp('Graph created')
        %A=rand(100); % a random matrix
        
        Cliques_new=cat(1,Cliques_new,Cliques2);
        %Cliques_new=Cliques2;
        %idx = randsample(1:size(A,1),n) ;
        %C= A(idx,:);
    %for qos=1:3
    for mixes=1:1
        %for data qos= 100%
         [allflows] = newhighflows_100_th(indexx);
         data_flows=allflows{1,1};
         [final_controllers,final_associations,final_TDMAscheme,~,control_flows] = kmeans_tdmajoint_new(data_flows,G,Gtest,Cliques_new,links,250);
         %if(size(final_TDMAscheme,1)<260)
         both_flows=cat(1,data_flows,control_flows);
         [freeslots1,occurencescounters,loadedcounters1]=computeFreeSlots_ICC(final_TDMAscheme,Gtest,links,both_flows);
         %freeslots1=computeFreeSlots_ICC(final_TDMAscheme,Gtest,links,both_flows);
         TDMA_control=create_control_frame_with_flows_fixed_size_ICC(final_TDMAscheme,links,loadedcounters1);
         TDMA_control_ordered= multiplemincover_chain(Gtest,final_controllers,final_associations,TDMA_control,size(TDMA_control,1));
         flows_mixes{1,end+1}=allflows;
         sizeTDMAs100_th(end+1)=size(final_TDMAscheme,1);
         numcontrollers100_th(end+1)=length(final_controllers);
         temp=[];
         for i=1:length(final_associations)
            %tempjoint(end+1)=computeDelayTDMAafter(Gtest,final_associations(i),i,TDMA_control);
            temp(end+1)=computeDelayTDMAafter(Gtest,final_associations(i),i,TDMA_control_ordered);
         end
            tempjoint_ordered100_th(end+1)=mean(temp);
            tempjoint_ordered100_worst_th(end+1)=max(temp);
            %end
         disp(numgraphs+" "+100+" "+mixes)
         
         %for data qos= 75%
         [allflows] = newhighflows_75_th(indexx);
         data_flows=allflows{1,1};
         [final_controllers,final_associations,final_TDMAscheme,~,control_flows] = kmeans_tdmajoint_new(data_flows,G,Gtest,Cliques_new,links,250);
         %if(size(final_TDMAscheme,1)<260)
         both_flows=cat(1,data_flows,control_flows);
         [freeslots1,occurencescounters,loadedcounters1]=computeFreeSlots_ICC(final_TDMAscheme,Gtest,links,both_flows);
         TDMA_control=create_control_frame_with_flows_fixed_size_ICC(final_TDMAscheme,links,freeslots1);
         TDMA_control_ordered= multiplemincover_chain(Gtest,final_controllers,final_associations,TDMA_control,size(TDMA_control,1));
         %flows_mixes{1,end+1}=allflows;
         sizeTDMAs75_th(end+1)=size(final_TDMAscheme,1);
         numcontrollers75_th(end+1)=length(final_controllers);
         temp=[];
         for i=1:length(final_associations)
            %tempjoint(end+1)=computeDelayTDMAafter(Gtest,final_associations(i),i,TDMA_control);
            temp(end+1)=computeDelayTDMAafter(Gtest,final_associations(i),i,TDMA_control_ordered);
         end
            tempjoint_ordered75_th(end+1)=mean(temp);
            tempjoint_ordered75_worst_th(end+1)=max(temp);
            %end
         disp(numgraphs+" "+75+" "+mixes)
         
         [allflows] = newhighflows_50_th(indexx);
         data_flows=allflows{1,1};
         [final_controllers,final_associations,final_TDMAscheme,~,control_flows]= kmeans_tdmajoint_new(data_flows,G,Gtest,Cliques_new,links,250);
         %if(size(final_TDMAscheme,1)<260)
         both_flows=cat(1,data_flows,control_flows);
         freeslots1=computeFreeSlots_ICC(final_TDMAscheme,Gtest,links,both_flows);
         TDMA_control=create_control_frame_with_flows_fixed_size_ICC(final_TDMAscheme,links,freeslots1);
         TDMA_control_ordered= multiplemincover_chain(Gtest,final_controllers,final_associations,TDMA_control,size(TDMA_control,1));
         flows_mixes{1,end+1}=allflows;
         sizeTDMAs50_th(end+1)=size(final_TDMAscheme,1);
         numcontrollers50_th(end+1)=length(final_controllers);
         %tic
         temp=[];
         for i=1:length(final_associations)
            %tempjoint(end+1)=computeDelayTDMAafter(Gtest,final_associations(i),i,TDMA_control);
            temp(end+1)=computeDelayTDMAafter(Gtest,final_associations(i),i,TDMA_control_ordered);
         end
         %toc
            tempjoint_ordered50_th(end+1)=mean(temp);
            tempjoint_ordered50_worst_th(end+1)=max(temp);
            %end
         disp(nodes+" "+50+" "+mixes)
         indexx=indexx+1;
    end
    %end
     %save('theta_1-7')
    end
end
toc
% temp100=[];
% temp75=[];
% temp50=[];
% for i=1:40:1241
%     temp100(end+1)=mean(tempjoint_ordered100(i:i+39));
%     temp75(end+1)=mean(tempjoint_ordered75(i:i+39));
%     temp50(end+1)=mean(tempjoint_ordered50(i:i+39));
% end
%https://www.mathworks.com/matlabcentral/answers/258354-how-to-run-2-script-m-at-the-same-time-in-matlab
%parallel execution of scripts