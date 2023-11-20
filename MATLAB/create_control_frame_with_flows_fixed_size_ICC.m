function [TDMA] = create_control_frame_with_flows_fixed_size_ICC(inputTDMA,links,loadedcounters1,frame_size)

    %COMPUTE OCCURENCES
%     occurencescounters=zeros(length(links),1);
%     for li=1:length(links)
%          for i=1:size(inputTDMA,1)
%             for j=1:size(inputTDMA,2)
%                 temp=inputTDMA{i,j};
%                 if(isequal(links{li,1},num2str(temp(1)))>0) && (isequal(links{li,2},num2str(temp(2)))>0)
%                     occurencescounters(li)=occurencescounters(li)+1;
%                 end
%             end    
%          end
%     end
    %data traffic slots compute
    %dataoccurences=zeros(size(freeslots1,1),1);
    %dataoccurences=minus(occurencescounters,freeslots1);
    dataoccurences=loadedcounters1;
    %bale toulaxiston ena slot
%     for i=1:length(dataoccurences)
%         if(dataoccurences(i)<1)
%             dataoccurences(i)=0;
%         end
%     end
    %disp(dataoccurences)
    %AS ADEIASW TO FRAME apo ta data slots twn links
    %An den simmetexei kapoio link se data flows, eimaste mia xara
    for i=1:size(inputTDMA,1)
        for j=1:size(inputTDMA,2)
            temp=inputTDMA{i,j};
            for linkindex=1:size(links,1) %traverse each link and make it [0,0] if dataoccurences>1
                if (isequal(links{linkindex,1},num2str(temp(1)))>0) && (isequal(links{linkindex,2},num2str(temp(2)))>0)
                    if(dataoccurences(linkindex)>0)
                        dataoccurences(linkindex)=dataoccurences(linkindex)-1;
                        inputTDMA{i,j}=[0,0];       
                    end
                end
            end
        end    
    end
    
    if(size(inputTDMA,1)<frame_size)
        for i=size(inputTDMA,1)+1:frame_size
            for j=1:size(inputTDMA,2)
                inputTDMA{i,j}=[0,0];
            end
        end
    end
    TDMA=inputTDMA;
end

