function [freeslots,occurencescounters,loadedcounters1,dataflowlinks] = computeFreeSlots_ICC(TDMA,Gnew,links,flows,data_flows)

    occurencescounters=zeros(length(links),1);
    for li=1:length(links)
         for i=1:size(TDMA,1)
            for j=1:size(TDMA,2)
                temp=TDMA{i,j};
                if(isequal(links{li,1},num2str(temp(1)))>0) && (isequal(links{li,2},num2str(temp(2)))>0)
                    occurencescounters(li)=occurencescounters(li)+1;
                end
            end    
         end
    end
    
    loadedcounters1=zeros(length(links),1);
    
    for flo=1:size(flows,1)
        splitted_path_new={};
        splitted_path=shortestpath(Gnew,flows(flo,1),flows(flo,2));
        for ii=2:length(splitted_path) %create the splitted path new
            splitted_path_new{end+1}=[splitted_path(ii-1),splitted_path(ii)];
        end
        for sz=1:size(splitted_path_new,2)
            temp=splitted_path_new{1,sz};
            for li=1:size(links,1)
                if(isequal(links{li,1},num2str(temp(1)))>0) && (isequal(links{li,2},num2str(temp(2)))>0)
                    loadedcounters1(li)=loadedcounters1(li)+flows(flo,3);
                end
            end
        end
    end
    freeslots=zeros(length(links),1);
    for i=1:size(occurencescounters,1)
        freeslots(i)=occurencescounters(i)-loadedcounters1(i);
    end
    %totalfree=occurencescounters-loadedcounters1;
    %remove negative values of total free slots of links
%     for j=1:size(links,1)
%         if(totalfree(j)<1)
%             totalfree(j)=1;
%         end
%     end
    %freeslots=totalfree;
    
    %Compute data flow path links occurences
    dataflowlinks=zeros(length(links),1);
    
    for flo=1:size(data_flows,1)
        splitted_path_new={};
        splitted_path=shortestpath(Gnew,data_flows(flo,1),data_flows(flo,2));
        for ii=2:length(splitted_path) %create the splitted path new
            splitted_path_new{end+1}=[splitted_path(ii-1),splitted_path(ii)];
        end
        for sz=1:size(splitted_path_new,2)
            temp=splitted_path_new{1,sz};
            for li=1:size(links,1)
                if(isequal(links{li,1},num2str(temp(1)))>0) && (isequal(links{li,2},num2str(temp(2)))>0)
                    dataflowlinks(li)=dataflowlinks(li)+data_flows(flo,3);
                end
            end
        end
    end
end

