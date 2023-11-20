%Create graphs and write to files the compatibiy matrices(which represent compatibility graphs), to feed them into the .py script to compute the fullsets.
%Cliquessubset is the maximal sets produced with the greedy algorithm
%The python script writes the fullset of MCLSs into the cliques.csv. Then you just need to read the csv.
setofG={};
setofGtest={};
num_nodes=40;
for graph=1:100 %number of graphs
	[G,Gtest] = create_random_graph_RGGA(num_nodes);
	setofG{1,end+1}=G;
	setofGtest{1,end+1}=Gtest;
	[~,links,CM] = createMaximalSets_new(Gtest);
	csvwrite(['CM',num2str(graph),'.csv'],adj)
end

%The traffic mix is created below
newhighflows_100={}; %data qos=100
newhighflows_75={};  %data qos=75
newhighflows_50={};  %data qos=100
nodes=40;
for iterator=1:20000 %number of flows

    number_flows=randi([6 17],1,1);
    flows=zeros(number_flows,3);
    for i=1:number_flows
        flows(i,3)=randi([1 5],1,1); 
        flows(i,1)=randi([1 nodes],1,1);
        flows(i,2)=randi([1 nodes],1,1);
        while(flows(i,1)==flows(i,2))
            flows(i,1)=randi([1 nodes],1,1);
            flows(i,2)=randi([1 nodes],1,1);
        end
    end
    newhighflows_100{1,iterator}=flows;
	flow75=flows;
	flow50=flows;
	for i=1:number_flows
		flow75(i,3)=ceil(flows(i,3)*0.75);
		flow50(i,3)=ceil(flows(i,3)*0.50);
	end
	newhighflows_75{1,iterator}=flows75;
	newhighflows_50{1,iterator}=flows50;
 end
 
 