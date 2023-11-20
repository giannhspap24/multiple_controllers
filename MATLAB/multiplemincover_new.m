function [slots] = multiplemincover_new(NN) 
    %Be careful with the input:!!
    %NN(m x n)= m: maximal sets, n: links
    %Find the maximal sets that cover all links
    %Multiple Minimum cover start
    linelen=size(NN,1);
    templens=zeros(1,size(NN,1)); %count the number of the controlled elements of each controller
    tempcontrollers=[];
    for i=1:linelen
        templens(i)=sum(NN(i,:)>0); %count the numbers of aces(controlled elements) in Neighborhood table,
    end
    %till here have the covers and their length.
    %head to min cover
    %Testcheckcover1=checkcover(tempcover)
    tempchecker=0;
    while(tempchecker==0)
        if(tempchecker==0)
              [val,idx]=max(templens);
              tempcontrollers(end+1)=idx;   
               for k=1:size(NN,2) %gia kathe stoixeio tou idx maximal set
                  if(NN(idx,k)>0) % ean anikei to link sto maximal set pou epileksame
                      for i=1:size(NN,1) %adeiase oles tis stiles twn eisaxthentwn links
                          if(NN(i,k)>0)
                            NN(i,k)=NN(i,k)-1;
                          end
                      end
                        %NN(:,k)=NN(:,k)-1;
                  end
               end
             %updatetemplens
               for u=1:linelen
                    templens(u)=sum(NN(u,:)>0); %count the numbers of links each maximal set covers
               end
         end % end if tempchecker
        tempcover=sum(NN(:,:));
        tempchecker=sum(tempcover)<1; %check if we have a cover, sum==0;
    end %endwhile
    %Minimum cover end%
    slots=tempcontrollers; %return the slots
end

