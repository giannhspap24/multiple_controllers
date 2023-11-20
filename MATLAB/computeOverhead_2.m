function [link_requirements,totaloverhead,totaloverhead_ctrsw,totaloverhead_ctrctr] = computeOverhead_2(Gnew,links,associations,controllers)
    %Kandoo parameters
        w1=12;
        w1back=4;
        w2=36; 
        w3=7; 

    %Onos parameters
%      w1=19; %ctrsw
%      w1back=4; %swctr
%      w2=45; %ctrctr
%      w3=7; %rvar(per switch)
%      
    link_requirements=zeros(size(links,1),1);
    totaloverhead_ctrsw=0;
    %totaloverhead_ctrsw=[];
    for u=1:numnodes(Gnew)
        splitted_path=shortestpath(Gnew,associations(u),u);
        splitted_path_new={};
        for i=2:length(splitted_path) %create the splitted path new
            splitted_path_new{end+1}=[splitted_path(i-1),splitted_path(i)];
        end
        for j=1:size(splitted_path_new,2)
            index_of_link=0;
            temp=splitted_path_new{1,j};
            for i=1:size(links,1)
                if (isequal(links{i,1},num2str(temp(1)))>0) && (isequal(links{i,2},num2str(temp(2)))>0)
                    link_requirements(i)=link_requirements(i)+w1; %add the rate requirement
                end
            end
        end
        totaloverhead_ctrsw=totaloverhead_ctrsw+(w1*length(splitted_path));
       
    end
    
    for u=1:numnodes(Gnew)
        splitted_path=shortestpath(Gnew,u,associations(u));
        splitted_path_new={};
        for i=2:length(splitted_path) %create the splitted path new
            splitted_path_new{end+1}=[splitted_path(i-1),splitted_path(i)];
        end
        for j=1:size(splitted_path_new,2)
            index_of_link=0;
            temp=splitted_path_new{1,j};
            for i=1:size(links,1)
                if (isequal(links{i,1},num2str(temp(1)))>0) && (isequal(links{i,2},num2str(temp(2)))>0)
                    link_requirements(i)=link_requirements(i)+w1back; %add the rate requirement
                end
            end
        end
        %ctrtosw=ctrtosw+(length(shortestpath(Gnew,associations(i),i))-1);
    end
    
    %totaloverhead_ctrsw=sum(link_requirements);
    %disp(ctrtosw)
    %controllers=unique(associations);
    %controllers=nchoosek(controllers,2);
    %disp(controllers)
    totaloverhead_ctrctr=0;
    for u=1:length(controllers) %needs change
        for uu=1:length(controllers)
            splitted_path=shortestpath(Gnew,controllers(u),controllers(uu));
            N= sum(associations==controllers(u));%switches of node u
            splitted_path_new={};
            for i=2:length(splitted_path) %create the splitted path new
                splitted_path_new{end+1}=[splitted_path(i-1),splitted_path(i)];
            end
            for j=1:size(splitted_path_new,2)
                index_of_link=0;
                temp=splitted_path_new{1,j};
                for i=1:size(links,1)
                    if (isequal(links{i,1},num2str(temp(1)))>0) && (isequal(links{i,2},num2str(temp(2)))>0)
                        link_requirements(i)=link_requirements(i)+w2 +(w3*N); %add the rate requirement
                    end
                end
            end
            totaloverhead_ctrctr=totaloverhead_ctrctr+(w2*length(splitted_path)) +(w3*N);
        end
        %ctrtosw=ctrtosw+(length(shortestpath(Gnew,associations(i),i))-1);
    end
    %ctrtoctr=ctrtoctr*2;
    %totaloverhead=sum(link_requirements);
    totaloverhead=totaloverhead_ctrctr+totaloverhead_ctrsw;
    
    slotRs=36;
    for i=1:size(links,1)
        link_requirements(i)=ceil(link_requirements(i)/slotRs);
    end
    for i=1:height(Gnew.Edges)
        links{i,3}=Gnew.Edges{i,2};
    end
    for i=1:length(links)
        if(links{i,3}==1)
            link_requirements(i)=link_requirements(i)*1;
        elseif(links{i,3}==2)
            link_requirements(i)=link_requirements(i)*1;
        else
            link_requirements(i)=link_requirements(i)*1;
        end
    end
end

