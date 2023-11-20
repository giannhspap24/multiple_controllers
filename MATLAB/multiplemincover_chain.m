function [TDMA] = multiplemincover_chain(Gnew,controllers,associations,inputTDMA,frame_size)
    %Multiple Minimum cover start%
    %linelen=14;
    TDMA=inputTDMA;
    already_assigned=[];
     
    %Enter control paths, compute them once at the start
    switches3=setdiff([1:numnodes(Gnew)],controllers);
    splitted_path_new={};
    for i=1:length(switches3)
        splitted_path=shortestpath(Gnew,associations(i),switches3(i));
        for j=2:length(splitted_path) %create the splitted path new
            splitted_path_new{i,j-1}=[splitted_path(j-1),splitted_path(j)];
        end
    end
%     
%     Counter_paths_progressed=zeros(size(inputTDMA,1),1);
%     cursors=ones(length(switches3),1);
%     %Update counter of paths that are progressed
%     for path=1:size(cursors,1)
%         for i=1:size(inputTDMA,1)
%            if(sum(already_assigned==i)>0) 
%                paths_progressed=0;
%                for j=1:size(inputTDMA,2)
%                     if(isequal(splitted_path_new{path,cursors(path)},TDMA{i,j})>0)
%                        paths_progressed=paths_progressed+ 1;%check if link is contained in slot
%                     end
%                end
%                Counter_paths_progressed(i)=Counter_paths_progressed(i)+paths_progressed;
%            else
%                Counter_paths_progressed(i)=0;
%            end
%         end
%     end
%     [val,idx]=max(Counter_paths_progressed);
%     %make the slot assignment to the new TDMA and then remove it from the
%     %available ones
% 
%     %But also we need to move the cursors..!
%     already_assigned(end+1)=idx;
%     for j=1:size(inputTDMA,2)
%        TDMA{length(already_assigned),j}=inputTDMA{idx,j};
%        for i=1:length(switches3)
%            if(isequal(splitted_path_new{i,cursors(i)},inputTDMA{idx,j})>0)
%                cursors(i)=cursors(i)+1;
%            end
%        end
%     end
%     
%     %remove a path that has been totally assigned all links o the end
%     for i=1:size(splitted_path_new,1)
%        splitted_path=shortestpath(Gnew,controller,switches3(i));
%        if(cursors(i)==length(splitted_path)-1)
%            splitted_path_new(i,:)=[];
%            cursors(i)=0;
%        end
%     end
%     
    
    %begin the loop here, until all control paths are completed
    cursors=ones(size(splitted_path_new,1),1);
    control_counters=1;
    while(control_counters<frame_size)
        
        Counter_paths_progressed=zeros(size(inputTDMA,1),1);
        %Update counter of paths that are progressed
        for path=1:size(cursors,1)
            if(cursors(path)>0)
                for i=1:size(inputTDMA,1)
                   if(sum(already_assigned==i)<1) 
                       paths_progressed=0;
                       for j=1:size(inputTDMA,2)
                           %disp(splitted_path_new{path,cursors(path)})
                            if(isequal(splitted_path_new{path,cursors(path)},inputTDMA{i,j})>0)
                               paths_progressed=paths_progressed+ 1;%check if link is contained in slot
                            end
                       end
                       Counter_paths_progressed(i)=Counter_paths_progressed(i)+paths_progressed;
                   else
                       Counter_paths_progressed(i)=-1;
                   end
                end
            end
        end
        [val,idx]=max(Counter_paths_progressed);
        %disp(Counter_paths_progressed)
        %make the slot assignment to the new TDMA and then remove it from the
        %But also we need to move the cursors..!
        already_assigned(end+1)=idx;
        for j=1:size(inputTDMA,2)
            TDMA{length(already_assigned),j}=inputTDMA{idx,j};
            for i=1:size(cursors,1)
                if(cursors(i)>0)
                    if(isequal(splitted_path_new{i,cursors(i)},inputTDMA{idx,j})>0)
                        cursors(i)=cursors(i)+1;
                        %disp(cursors)
                    end
                end
            end
        end
        
        %remove a path that has been totally assigned all links to the end
        for i=1:size(cursors,1)
            if(cursors(i)>0)
                %temp=splitted_path_new{i,end-1};
                splitted_path=shortestpath(Gnew,associations(i),switches3(i));
                if(cursors(i)==length(splitted_path)-1)
                    %here find index of path in splitted path new
%                     index_dest=1;
%                     temp=splitted_path_new{i,index_dest};
%                     disp(temp)
%                     while(temp(2)~=index_dest)
%                         
%                         temp=splitted_path_new{i,index_dest};
%                         index_dest=index_dest+1;
%                         disp(temp)
%                     end
%                     splitted_path_new(index_dest,:)=[];
                    cursors(i)=1; % return from start the cursor and remake new chain
                end
            end
        end
        control_counters=control_counters+1;
        %disp(control_counters)
    end
    %disp(control_counters)
end

