function [retval] = computeDelayTDMAafter(Gnew,src,dest,TDMA)

    worst_TDMA=TDMA;
    splitted_path=shortestpath(Gnew,Gnew.Nodes{src,1},Gnew.Nodes{dest,1});
    splitted_path=str2double(splitted_path);
    splitted_path_new={};
    for i=1:length(splitted_path)-1 %create the splitted path new
        worst_TDMA=[worst_TDMA;TDMA];
    end
    
    for i=2:length(splitted_path) %create the splitted path new
       splitted_path_new{end+1}=[splitted_path(i-1),splitted_path(i)];
    end
    
  if(src~=dest)
        if(length(splitted_path>1))
            counter_distance_all=0;
            for slot=1:size(TDMA,1) %parse each one slot and count delays3
                cursor_path=1; %whick path link i have traversed
                path_completed=0;
                index=slot;
                while(path_completed<1)
                    for j=1:size(worst_TDMA,2)
                        if(index<size(worst_TDMA,1)-1)
                            if(cursor_path==size(splitted_path_new,2))
                                if(isequal(splitted_path_new{1,cursor_path},worst_TDMA{index,j})>0) %if equals with last path link, then path completed
                                   path_completed=1;
                                   %counter_distance=counter_distance+1;
                                   %disp("path_completed")
                                end
                            end
                       else
                           path_completed=1;

                        end
                        if(cursor_path<size(splitted_path_new,2))
                            if(index<size(worst_TDMA,1)-1)
                                if(path_completed<1)
                                    %disp("index:"+index)
                                    %disp("cursor:"+cursor_path)
                                    if(isequal(splitted_path_new{1,cursor_path},worst_TDMA{index,j})>0)
                                       cursor_path=cursor_path+1;
                                    end
                                end
                            else
                                path_completed=1;
                            end
                        end
                    end
                    index=index+1;
                     %disp("slot:"+slot)
                     %disp("index:"+index)
                     %disp("size:"+size(worst_TDMA,1))
                     %disp("cursor:"+cursor_path)
                end
                difference=index-slot;
                counter_distance_all=counter_distance_all+difference; %keep the distance for that slot
            end
        else%if i==j then
            counter_distance_all=108;
        end
    else
        counter_distance_all=0;
    end
    retval=counter_distance_all/size(TDMA,1);
end

