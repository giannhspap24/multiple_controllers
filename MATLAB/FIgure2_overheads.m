totaloverheadlist=[];
totaloverhead_ctrswlist=[];
totaloverhead_ctrctrlist=[];

G40=setofG{1,1};
[~,links,~] = createLinks(setofGtest{1,1});
assignments = zeros(1, numnodes(G40));
associations = zeros(1, numnodes(G40));

for K=1:8 % K controllers
    
    centers = randperm(numnodes(G40), K);
    % loop until convergence
    while true
        % assign nodes to clusters based on the closest center
        for i = 1:numnodes(G40)
            dist1 = distances(G40, i, centers);
            [~, idx] = min(dist1);
            assignments(i) = idx;
            associations(i) = centers(idx); %this is added
        end

        % calculate the cost of the current clustering
        costs = zeros(1, K);
        for i = 1:K
            idx = find(assignments == i);
            subg = subgraph(G40, idx);
            dist2 = distances(subg);
            costs(i) = sum(sum(dist2)); %edited
        end
        total_cost = sum(costs);

        % initialize the new centers
        new_centers = zeros(1, K);
        for i = 1:K
            idx = find(assignments == i);
            subg = subgraph(G40, idx);
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
    controllersnaive=centers;
    associationsnaive=associations;
   
    
    [link_requirements,totaloverhead,totaloverhead_ctrsw,totaloverhead_ctrctr] = computeOverhead_2(G40,links,associationsnaive,controllersnaive);

    totaloverheadlist(end+1)=totaloverhead;
    totaloverhead_ctrswlist(end+1)=totaloverhead_ctrsw;
    totaloverhead_ctrctrlist(end+1)=totaloverhead_ctrctr;
    
 
    disp(K)
end
figure;
x=1:8; %Until number of number controllers
% Plot all control overhead vectors in the same plot with different colors
plot(x, totaloverheadlist, '-o', 'DisplayName', 'Total','LineWidth',2);
hold on;
plot(x, totaloverhead_ctrswlist, '-x', 'DisplayName', 'CtSw','LineWidth',2);
plot(x, totaloverhead_ctrctrlist, '-s', 'DisplayName', 'CtC','LineWidth',2);

legend('Total overhead','CtSw','CtC','Location','northwest')
xlabel('Number of controllers');
ylabel('Overhead(Kbps)');
%grid on;  % Add grid lines

