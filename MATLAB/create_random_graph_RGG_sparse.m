function [G,Gtest] = create_random_graph_RGG_sparse(num_nodes)
    % Define the number of nodes in the graph
    %num_nodes = 30;
    connected=0;
    while (connected==0)
        x_coords=[];
        y_coords=[];
        % Generate random x and y coordinates for each node
        for i=1:num_nodes
            %xynodes(i,1)=rand(2,2);
            %xynodes(i,2)=rand(2,2);
            x_coords(i) = 0 + (num_nodes-0).*rand(1,1);
            y_coords(i) = 0 + (num_nodes-0).*rand(1,1);
        end
        %x_coords = rand(1,num_nodes);
        %y_coords = rand(1,num_nodes);

        % Calculate the Euclidean distances between all pairs of nodes
        distances = pdist([x_coords' y_coords']);

        % Construct the adjacency matrix of the graph and assign edge weights based
        % on Euclidean distance
        adj_matrix = squareform(distances);
        %adj_matrix = 1./adj_matrix; % Invert distances to get weights
        adj_matrix(isinf(adj_matrix)) = 0; % Set weight to zero for self-loops
        G = graph(adj_matrix);
        node_names = cellstr(num2str((1 : num_nodes)'));
        G.Nodes=node_names;
        %here is me
        %threshold=0.4;
        edgesremove=[];
        for i=1:size(G.Edges,1)
            if(distances(i)>11) %8,9
                G.Edges{i,2}=0;
                edgesremove(end+1)=i;
            end
             if(distances(i)<11) %8,9
                G.Edges{i,2}=1;
                %edgesremove(end+1)=i;
             end
            if(distances(i)<6) %4,6
                G.Edges{i,2}=2;
                %edgesremove(end+1)=i;
            end
            if(distances(i)<4.73) %4.73, 2.9
                G.Edges{i,2}=3;
                %edgesremove(end+1)=i;
            end
        end

        %here end me
        % Plot the graph using the coordinates as node positions and edge weights as
        % line widths

        G=rmedge(G,edgesremove);

        connected=1;
        components = conncomp(G);

        % check if there is only one component
        if (max(components) == 1)&&(numedges( G )<(num_nodes*1.5)) &&(numedges( G )>40)
            
            connected=1;
        else
            connected=0;
        end
    end
    %Gtest=addnode([1:num_nodes]);

    temp1=[]; %source
    temp2=[]; %destination
    temp3=[]; %weights
    for i=1:size(G.Edges,1)
        temp=G.Edges{i,1};
        %for j=1:2
        temp1(end+1)=str2num(cell2mat(temp(1)));
        temp2(end+1)=str2num(cell2mat(temp(2)));
        temp1(end+1)=str2num(cell2mat(temp(2)));
        temp2(end+1)=str2num(cell2mat(temp(1)));
        temp3(end+1)=G.Edges{i,2};
        temp3(end+1)=G.Edges{i,2};
    %         Gtest = addedge(Gtest,temp(1),temp(2),G.Edges{i,2});
    %         Gtest = addedge(Gtest,temp(2),temp(1),G.Edges{i,2});
        %end
    end  
    Gtest=digraph(temp1,temp2,temp3);
    node_names = cellstr(num2str((1 : num_nodes)'));
    Gtest.Nodes=node_names;

% lw = Gtest.Edges.Weight;
% edgestyle = cell(size(lw));
% edgestyle(lw == 1) = {':'};
% edgestyle(lw == 2) = {'--'};
% edgestyle(lw == 3) = {'-'};
% plot(Gtest,'XData',x_coords,'YData',y_coords,'EdgeCData', Gtest.Edges.Weight,'LineStyle',edgestyle,'LineWidth',2.5);
% axis off
% colorbar
% %colormap(flip(gray))
% colormap parula

%plot(Gtest,'XData',x_coords,'YData',y_coords,'LineWidth',2*Gtest.Edges.Weight./max(Gtest.Edges.Weight));
%f=figure(1)
%print -f -depsc -tiff graphthermal40nodesc.eps
end

