% Create a vector of data (replace with your own data)
% Generate example data (replace with your own data)

% data1 = numcontrollers100;  % First dataset
% data2 = numcontrollers75;  % Second dataset (shifted for illustration)
% data3 = numcontrollers50;  % Third dataset (shifted for illustration)

data1=[];
data2=[];
data3=[];
data4=[];
data5=[];
for i=1:length(tempjoint_ordered85_th)
    
    %if(sizeTDMAs100_th(i)<220)
    
    data2(end+1)=tempjoint_ordered85_th(i);
    data3(end+1)=tempjoint_ordered75_th(i);
    data4(end+1)=tempjoint_ordered60_th(i);
    data5(end+1)=tempjoint_ordered50_th(i);
        %if((tempjoint_ordered100(i)>44) && (tempjoint_ordered100(i)<1220) )
            data1(end+1)=tempjoint_ordered100(i);
        %end
    %end
%     if(sizeTDMAs75(i)>222)
%     data2(end+1)=tempjoint_ordered75(i);
%     end
%     if(sizeTDMAs50(i)>217)
%     data3(end+1)=tempjoint_ordered50(i);
%     end
end
% data1 = numcontrollers100;  % First dataset
% data2 = numcontrollers75;  % Second dataset (shifted for illustration)
% data3 = numcontrollers50;  % Third dataset (shifted for illustration)

% Compute the CDF for each dataset
[f1, x1] = ecdf(data1);
[f2, x2] = ecdf(data2);
[f3, x3] = ecdf(data3);
[f4, x4] = ecdf(data4);
[f5, x5] = ecdf(data5);
% for i=1:length(x1)
%     x1(i)=x1(i)-1.5;
% end
% for i=1:length(x2)
%     x2(i)=x2(i)-1.5;
% end
% for i=1:length(x3)
%     x3(i)=x3(i)-1.5;
% end
% for i=1:4107
%     if(f1(i)>f3(i))
%         disp(i)
%     end    
%     x1(i)=x1(i)+8.5;
% end
% for i=1:4107
%     if(f1(i)>f3(i))
%         disp(i)
%     end    
%     x1(i)=x1(i)+8.5;
% end
% for i=1500:4107
%     if(f1(i)>0.86)
%         x1(i)=x3(i)+4.2;
%     end    
%     
% end
% Plot the CDFs
plot(x1, f1, 'r', x2, f2, 'g', x3, f3, 'b', x4, f4, 'y',x5,f5,'o');
%xlabel('Number of controllers');
xlabel('Controller-to-switch delay(slots)');
ylabel('Cumulative portion of measurement points');
%title('Cumulative Distribution Functions (CDFs)');
legend({'\beta =1','\beta =0.82','\beta =0.75','\beta =0.6'}');
legend('Location','southeast')
xlim([min(data3), max(data1)]);
set(gca,'XTick',(floor(min(data3)/10)-1)*10:10:(ceil(max(data1)/10)+1)*10)
set(gca,'XTickLabel',(floor(min(data3)/10)-1)*10:10:(ceil(max(data1)/10)+1)*10)
% set(gca,'XTick',(floor(min(data3)/10)-1)*10:10:130)
% set(gca,'XTickLabel',(floor(min(data3)/10)-1)*10:10:130)
% Optionally, add a grid
%grid on;
