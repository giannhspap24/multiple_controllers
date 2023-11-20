% Create a vector of data (replace with your own data)
% Generate example data (replace with your own data)

% data1 = numcontrollers100;  % First dataset
% data2 = numcontrollers75;  % Second dataset (shifted for illustration)
% data3 = numcontrollers50;  % Third dataset (shifted for illustration)
%tempjoint_ordered100
data1=[];
data2=[];
data3=[];
data4=[];
data5=[];
controllers100=[];
controllers75=[];
controllers50=[];
controllers85=[];
controllers60=[];

for i=1:length(tempjoint_ordered50)
    
    %if((sizeTXOPspercentage(i)>0.12) &&(sizeTDMAs100(i)>230))
     %if(sizeTDMAs85_th(i)>24)
       % data2(end+1)=tempjoint_ordered85(i);
        data2(end+1)=tempjoint_ordered75(i);
        %data4(end+1)=tempjoint_ordered60(i);
        data3(end+1)=tempjoint_ordered50(i);
        if((tempjoint_ordered100(i)>45) && (tempjoint_ordered100(i)<122) )
            data1(end+1)=tempjoint_ordered100(i);
        end
        
        controllers100(end+1)=numcontrollers100(i);
        controllers75(end+1)=numcontrollers75(i);
        controllers50(end+1)=numcontrollers50(i);
        %controllers85(end+1)=numcontrollers85(i);
        %controllers60(end+1)=numcontrollers60(i);
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

% for i=1:length(x1)
%     x1(i)=x1(i)+9.5;
% end
% for i=1:length(x2)
%     x2(i)=x2(i)+8.5;
% end
% for i=1:length(x3)
%     x3(i)=x3(i)+7.5;
% end
% for i=1:length(f3)
%     if((f3(i)>0.94) && (f3(i)<0.990) )
%     f3(i)=f3(i)+0.004;
%     end
% end

% for i=1:length(f1)
%     if((f1(i)>0.50) && (f1(i)<0.970) )
%         f1(i)=f1(i)-0.05;
%     end
% end
% for i=1:length(f2)
%     if((f2(i)>0.70) && (f2(i)<0.970) )
%     f2(i)=f2(i)-0.02;
%     end
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
%plot(x1, f1, 'r', x2, f2, 'g', x3, f3, 'b');

plot(x1,f1,'-','LineWidth',3);
hold on;
plot(x2,f2,'--','LineWidth',3);
plot(x3,f3,':','LineWidth',3);
%hold on;
%plot(x4,f4,'-.','LineWidth',2);
hold off
%xlabel('Number of controllers');
xlabel('Controller-to-switch delay (slots)','fontsize',16);
ylabel('Cumulative portion of measurement points (%)','fontsize',12);
legend({'\beta =1','\beta =0.75','\beta =0.5'});

% Increase the size of the legend
lgd = legend('Location', 'southeast');
legend boxoff
set(lgd, 'FontSize', 16);
xlim([min(data3), 120]);
x=10;
% set(gca,'XTick',(floor(min(data3)/x)-1)*x:x:(ceil(max(data1)/x)+1)*x)
% set(gca,'XTickLabel',(floor(min(data3)/x)-1)*x:x:(ceil(max(data1)/x)+1)*x)
set(gca,'XTick',(floor(min(data3)/x)-1)*x:120)
set(gca,'XTickLabel',(floor(min(data3)/x)-1)*x:120)
%lgd.FontSize = 12;
f=figure(1)
% set(gca,'XTick',(floor(min(data3)/10)-1)*10:10:130)
% set(gca,'XTickLabel',(floor(min(data3)/10)-1)*10:10:130)
% Optionally, add a grid
%grid on;
%print -f -depsc -tiff cdf_jointdelay_high_new.eps