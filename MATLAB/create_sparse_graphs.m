% directed_graphs={};
% undirected_graphs={};
% index=0;
% comp_matrix={};
% for nodes=20:10:50
%     for numgraphs=1:7
%         index=index+1;
%          [G,Gtest] = create_random_graph_RGG_sparse(nodes);
%          %G=graphs_undirected{1,index};
%          %Gtest=graphs_directed{1,index};
%          [Cliques2,links,CM] = createMaximalSets_new(Gtest);
%          undirected_graphs{1,end+1}=G;
%          directed_graphs{1,end+1}=Gtest;
%          comp_matrix{1,end+1}=CM;
%          disp(numgraphs)
%          disp(nodes)
%     end
% end% Define the number of nodes and the lower/upper bounds for edges
% setofG={};
% setofGtest={};


for graphh=16:80
	%[G,Gtest] = create_random_graph_RGGA(num_nodes);
	

    numNodes = 40;             % Change this to your desired number of nodes
    lowerBoundEdges = 5;       % Change this to your desired lower bound
    upperBoundEdges = 50;      % Change this to your desired upper bound
    connected = 0;

% Create an adjacency matrix with all zeros
    while (connected == 0)
        adjacencyMatrix = zeros(numNodes);

        % Randomly determine the number of edges within the bounds
        numEdges = randi([lowerBoundEdges, upperBoundEdges]);

        % Generate random edge pairs, ensuring (i, j) and (j, i) both exist
        edgePairs = zeros(numEdges, 2);
        edgeWeights = randi([1, 3], 1, numEdges); % Random edge weights (1, 2, or 3)

        for k = 1:numEdges
            while true
                i = randi(numNodes);
                j = randi(numNodes);
                if i ~= j && adjacencyMatrix(i, j) == 0 && adjacencyMatrix(j, i) == 0
                    edgePairs(k, :) = [i, j];
                    adjacencyMatrix(i, j) = edgeWeights(k);
                    adjacencyMatrix(j, i) = edgeWeights(k); % Ensure symmetric weights
                    break;
                end
            end
        end

        % Create a directed graph from the adjacency matrix
        G_directed = digraph(adjacencyMatrix);
        G_undirected=graph(adjacencyMatrix);
        node_names = cellstr(num2str((1 : numNodes)'));
        G_directed.Nodes=node_names;
        G_undirected.Nodes=node_names;
        % Check if the graph is connected
        components = conncomp(G_directed);

        % Check if there is only one component
        if (max(components) == 1)
            connected = 1;
        else
            connected = 0;
        end
    end
    setofG{1,end+1}=G_undirected;
	setofGtest{1,end+1}=G_directed;
	[Cliquessubset,links,CM] = createMaximalSets_new(G_directed);
	csvwrite([num2str(graphh),'.txt'],CM)
    csvwrite([num2str(graphh),'.txt'],adjacencyMatrix)
    disp(graphh)
end
save('13_10_2023_80graphs')

for graphh=16:80
    G=setofG{1,graphh};
    Gtest=setofGtest{1,graphh};
    [Cliquessubset,links,CM] = createMaximalSets_new(Gtest);
	csvwrite(['CM',num2str(graphh),'.txt'],CM)
end
% Plot the directed graph with edge weights
%plot(G_directed, 'Layout', 'force', 'NodeLabel', {}, 'EdgeLabel', G_directed.Edges.Weight);
%title('Random Directed Graph with (i, j) and (j, i) edges and Random Edge Weights (1, 2, or 3)');
