function [TDMA] = create_frame_with_flows_multiple_rates_unfixed_ICMCIS(flows,Cliques,links,Gnew)
    
    slots=[];
    Wcliques=Cliques;
    splitted_path_new={};
    
    for flo=1:size(flows,1)
        splitted_path=shortestpath(Gnew,flows(flo,1),flows(flo,2));
        for i=2:length(splitted_path) %create the splitted path new
            splitted_path_new{end+1}=[splitted_path(i-1),splitted_path(i)];
        end
        for j=1:size(splitted_path_new,2)
            index_of_link=0;
            temp=splitted_path_new{1,j};
            for i=1:size(links,1)
                if (isequal(links{i,1},num2str(temp(1)))>0) && (isequal(links{i,2},num2str(temp(2)))>0)
                    index_of_link=i; % get this slot to construct a frame
                    for u=1:size(Wcliques,1)
                        if(Cliques(u,index_of_link)>0)
                            Wcliques(u,index_of_link)=Wcliques(u,index_of_link)+flows(flo,3);
                        end
                    end
                    %unique_links(end+1)=index_of_link;
                end
            end
        end
        splitted_path=[];
        splitted_path_new={};
    end
%      for i=1:size(Wcliques,1)
%         for j=1:size(Wcliques,2)
%             if(Wcliques(i,j)>1)
%                 Wcliques(i,j)=Wcliques(i,j)-1;
%             end
%         end
%     end
    %Wcliques is updated, we need to remove links though that do not participate in flows

    %slots1=multiplemincover(Wcliques,size(links,1));
    %HERE need to mofigy here the Wcliques as the ceiling of data rate of each
    %link!! (links,3)=linkstate
    for i=1:height(Gnew.Edges)
        links{i,3}=Gnew.Edges{i,2};
    end
    for i=1:length(links)
        if(links{i,3}==1)
            links{i,3}=1;
        elseif(links{i,3}==2)
            links{i,3}=2;
        elseif(links{i,3}==3)
            links{i,3}=3;
        elseif(links{i,3}==4)
            links{i,3}=1;
        else
            links{i,3}=1;
        end
    end
    %wcliques update
    for i=1:size(Wcliques,1)
        for j=1:size(Wcliques,2)
            if(Wcliques(i,j)>1) % if link in involved into data flows, take under consideration its link state
                Wcliques(i,j)=Wcliques(i,j)*links{j,3};
            end
        end
    end
    %slots=multiplemincover(Wcliques,size(links,1));
    slots=multiplemincover_new(Wcliques);
    %slots2=multiplemincover(Left_links,size(links,1));
    %slots=[slots1,slots2];
    slots=slots(randperm(length(slots)));
    TDMA={};
    for i=1:length(slots)
        k=1;
        counter=1;
        while(k<size(Cliques,2)+1)
            if(Cliques(slots(i),k)>0)
                temp=[];
                temp(end+1)=str2double(links{k,1});
                temp(end+1)=str2double(links{k,2});
                TDMA{i,counter}=temp;
                counter=counter+1;
            end
            k=k+1;
        end
    end
    for i=1:size(TDMA,1)
        for j=1:size(TDMA,2)
            if(size(TDMA{i,j},2)<1)
                TDMA{i,j}=[0,0]; %FILL WITH [0,0] the TDMA where it is empty matrix
            end
        end    
    end
    
end

