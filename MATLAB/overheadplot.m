%dist(15,:)=[];
%dist(:,15)=[];
%G=digraph(barcelona);
%node_names = cellstr(num2str((1 : 60)')); %assign node names, replace 14 with number of nodes

%G.Nodes=node_names;
%associations=[1 1 1 1 1 1 1 1 1 1 1 1 1 1];
%controllers=mincover(barcelona,60);
%[Cliques,links] = createMaximalSets(G);
%compute paths
num_nodes=30;
%[G1,Gtest1] = create_randomgraph_new(num_nodes);
LN=[]; %Latency Neighborhood
for i=1:numnodes(G1)
    for j=1:numnodes(G1)
        LN(i,j)=length(shortestpath(G1,i,j))-1;
    end    
end

% NN=zeros(num_nodes,num_nodes);
% for i=1:num_nodes
%     for j=1:num_nodes
%          if(length(shortestpath(G1,i,j))<3) %threshold
%              NN(i,j)=1;
%          end
%     end
% end
%controllers2=mincover(NN,60);
%place controllers with the naive method k center

totaloverheadlist=[];
totaloverhead_ctrswlist=[];
totaloverhead_ctrctrlist=[];
totaloverheadlistqin=[];
totaloverhead_ctrswlistqin=[];
totaloverhead_ctrctrlistqin=[];
totalmean=[];
totalmax=[];
totalzeros=[];
for K=1:1:12 % K controllers
    %K=8;
    for u=1:1 %this thing needs fix. Fixed with kmeans_tdmajoint_new function
        [idx,C] = kmedoids(LN,K);
        controllersnaive=[];
        for i=1:K
            temp=C(i,:);
            controllersnaive(end+1)=find(temp==0);
        end
    end
    associationsnaive=idx;
    for i=1:length(controllersnaive)
        associationsnaive(associationsnaive==i)=str2num(string(G1.Nodes{controllersnaive(i),1}));
    end
    
    [link_requirements,totaloverhead,totaloverhead_ctrsw,totaloverhead_ctrctr] = computeOverhead_3(G1,links,associationsnaive,controllersnaive);
    [link_requirements,totaloverheadqin,totaloverhead_ctrswqin,totaloverhead_ctrctrqin] = computeOverhead_2(G1,links,associationsnaive,controllersnaive);

    totaloverheadlist(end+1)=totaloverhead;
    totaloverhead_ctrswlist(end+1)=totaloverhead_ctrsw;
    %totaloverhead_ctrctrlist(end+1)=totaloverhead-totaloverhead_ctrsw;
    totaloverhead_ctrctrlist(end+1)=totaloverhead_ctrctr;
    
    totaloverheadlistqin(end+1)=totaloverheadqin;
    totaloverhead_ctrswlistqin(end+1)=totaloverhead_ctrswqin;
    %totaloverhead_ctrctrlist(end+1)=totaloverhead-totaloverhead_ctrsw;
    totaloverhead_ctrctrlistqin(end+1)=totaloverhead_ctrctrqin;
    
    totalmean(end+1)=mean(link_requirements);
    totalmax(end+1)=max(link_requirements);
    totalzeros(end+1)=sum(link_requirements==0);
    disp(K)
end

%update when final controllers are elected
% associations=idx;
% for i=1:length(NN)
%     paths=[];
%     for j=1:length(controllers2)
%        paths(end+1)=length(shortestpath(G,i,controllers2(j)));
%        [M,II]=min(paths);
%        associations(i)=controllers(II);
%     end
% end
% [link_requirements,totaloverhead] = computeOverhead_3(G,links,associations,controllers2);
% sum(link_requirements==0);

%for 30 nodes
% totaloverhead_ctrctrlist=[0 150 330 500 600 750 950 1160];
% totaloverhead_ctrswlist=[320 400 310 280 270 240 230 210];
% totaloverheadlist=[320 550 640 780 870 1000 1200 1380];

%for 60 nodes
% totaloverhead_ctrctrlist=[0 460 440 760 950 1000 1270 1320 1450 1650 2000 2300];
% totaloverhead_ctrswlist=[540 460 480 440 410 385 370 360 340 330 315 300];
% totaloverheadlist=[540 910 930 1200 1360 1400 1680 1780 1850 2000 2315 2600];

% %for 90 nodes
% totaloverhead_ctrctrlist=[0,736,704,1216,1520,1600,2032,2112,2320,2640,3200,3680,3900];
% totaloverhead_ctrswlist=[864,736,768,704,656,616,592,576,544,528,504,480, 460];
% totaloverheadlist=[864,1472,1472,1920,2176,2216,2624,2688,2864,3168,3704,4160, 4400];
% %x=1:1:12;
% x=[1 2 3 4 5 6 7 8 10 12 14 16 18];
% p1=plot(x,totaloverheadlist1,'-^')
% xticks(x)
% hold on
% p2=plot(x,totaloverhead_ctrctrlist1,'-o')
% xticks(x)
% p3=plot(x,totaloverhead_ctrswlist1,'-s')
% xticks(x)
% %p4=plot(x,totaloverhead_ctrctrlist,'--')
% %p5=plot(x,totaloverhead_ctrswlist,'-.')
% %p6=plot(x,totaloverhead_ctrswlist,':')
% hold off
% h=[p1(1);p2;p3(1)]
% legend(h,'Total overhead','Ctr-Ctr','Ctr-Sw','Location','northwest')
% %h=[p1(1);p2;p3(1);p4(1);p5;p6(1)]
% %legend(h,'Total overhead','Ctr-Ctr','Ctr-Sw','Total overheadqin','CTR-CTRQIN','CTR-SWqin','Location','northwest')
% xlabel('Number of controllers')
% ylabel('Network overhead (Kbps)')
%print -f -depsc -tiff overhead90.eps

%the gamma
% x=0.1:0.1:1;
% p1=plot(x,[ 1 1 2 2 3 4 6 7 8 9],'-^')
% xticks(x)
% hold on
% p2=plot(x,[ 2 2 3 3 4 5 8 10 11 13],'-o')
% xticks(x)
% p3=plot(x,[ 3 5 6 7 8 10 12 13 15 17],'-s')
% xticks(x)
% %p4=plot(x,totaloverhead_ctrctrlist,'--')
% %p5=plot(x,totaloverhead_ctrswlist,'-.')
% %p6=plot(x,totaloverhead_ctrswlist,':')
% hold off
% h=[p1(1);p2;p3(1)]
% legend(h,'30 nodes','60 nodes','90 nodes','Location','northwest')
% %h=[p1(1);p2;p3(1);p4(1);p5;p6(1)]
% %legend(h,'Total overhead','Ctr-Ctr','Ctr-Sw','Total overheadqin','CTR-CTRQIN','CTR-SWqin','Location','northwest')
% xlabel('?')
% ylabel('Number of controllers')
% print -f -depsc -tiff gammavalues.eps

