% times_elapsed_MIS=[];
% times_elapsed_CP=[];
% graphs_directed={};
% graphs_undirected={};
% comp_matrix={};
% sizeTDMAs=[];
% numcontrollers=[];
% flows_mixes={};


index=0;
tempjoint=[];
tempjoint_ordered=[];
for nodes=20:10:50
    for numgraphs=1:10
         index=index+1;
         tic;
         [G,Gtest] = create_random_graph_RGG_sparse(nodes);
         %G=graphs_undirected{1,index};
         %Gtest=graphs_directed{1,index};
         [Cliques2,links,CM] = createMaximalSets_new(Gtest);
         times_elapsed_MIS(end+1)=toc;
         graphs_undirected{1,end+1}=G;
         graphs_directed{1,end+1}=Gtest;
         comp_matrix{1,end+1}=CM;
         disp('Graph created')
         
        for mixes=1:2
             [allflows] = generate_rflows(nodes,1);
             [final_controllers,final_associations,final_TDMAscheme,totaloverhead] = kmeans_tdmajoint_new(allflows{1,1},G,Gtest,Cliques2,links,400);
             %if(size(final_TDMAscheme,1)<260)
                 tic;
                 freeslots1=computeFreeSlots_ICC(final_TDMAscheme,Gtest,links,data_flows);
                 TDMA_control=create_control_frame_with_flows_fixed_size_ICC(final_TDMAscheme,links,freeslots1);
                 TDMA_control_ordered= multiplemincover_chain(Gtest,final_controllers,final_associations,TDMA_control,size(TDMA_control,1));
                 times_elapsed_CP(end+1)=toc;
                 flows_mixes{1,end+1}=allflows;
                 sizeTDMAs(end+1)=size(final_TDMAscheme,1);
                 numcontrollers(end+1)=length(final_controllers);
%                  for i=1:length(final_associations)
%                     %tempjoint(end+1)=computeDelayTDMAafter(Gtest,final_associations(i),i,TDMA_control);
%                     tempjoint_ordered(end+1)=computeDelayTDMAafter(Gtest,final_associations(i),i,TDMA_control_ordered);
%                  end
             %end
             disp(nodes+" "+numgraphs+""+mixes)
        end
        
    end
end

%https://www.mathworks.com/matlabcentral/answers/258354-how-to-run-2-script-m-at-the-same-time-in-matlab
%parallel execution of scripts