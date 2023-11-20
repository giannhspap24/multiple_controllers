%worst case delays
prc=[55,75,95,98,99];
data1=[];
data2=[];
data3=[];
data4=[];
data5=[];
%for i=1:length(overhead100)
%     disp(ceil(prctile(tempjoint_ordered100_worst_th,prc(i))))
%     disp(prctile(tempjoint_ordered75_worst_th,prc(i)))
%     disp(prctile(tempjoint_ordered50_worst_th,prc(i)))

%     disp(ceil(mean(data1)))
%     disp(ceil(mean(data2)))
%     disp(ceil(mean(data3)))
%     disp(ceil(mean(data4)))
%     disp(ceil(mean(data5)))
%     
data1=[];
data2=[];
data3=[];
data4=[];
data5=[];
for i=1:length(tempjoint_ordered50)
%     disp(ceil(prctile(tempjoint_ordered100_worst_th,prc(i))))
%     disp(prctile(tempjoint_ordered75_worst_th,prc(i)))
%     disp(prctile(tempjoint_ordered50_worst_th,prc(i)))

%     disp(ceil(mean(data1)))
%     disp(ceil(mean(data2)))
%     disp(ceil(mean(data3)))
%     disp(ceil(mean(data4)))
%     disp(ceil(mean(data5)))
%     
    if((tempjoint_ordered100(i)>prctile(tempjoint_ordered100,5)) && (tempjoint_ordered100(i)<prctile(tempjoint_ordered100,95)))
        data1(end+1)=tempjoint_ordered100(i);
    end
%     if((tempjoint_ordered85(i)>prctile(tempjoint_ordered85,5)) && (tempjoint_ordered85(i)<prctile(tempjoint_ordered85,95)))
%         data2(end+1)=tempjoint_ordered100(i)-tempjoint_ordered85(i);
%     end
    if((tempjoint_ordered75(i)>prctile(tempjoint_ordered75,5)) && (tempjoint_ordered75(i)<prctile(tempjoint_ordered75,95)))
        data3(end+1)=tempjoint_ordered100(i)-tempjoint_ordered75(i);
    end
%     if((tempjoint_ordered60(i)>prctile(tempjoint_ordered60,5)) && (tempjoint_ordered60(i)<prctile(tempjoint_ordered60,95)))
%         data4(end+1)=tempjoint_ordered100(i)-tempjoint_ordered60(i);
%     end
    if((tempjoint_ordered50(i)>prctile(tempjoint_ordered50,5)) && (tempjoint_ordered50(i)<prctile(tempjoint_ordered50,95)))
        data5(end+1)=tempjoint_ordered100(i)-tempjoint_ordered50(i);
    end
    %disp(i)

    %disp(i)
end

% end worst case delays

% Start differences
dataQoS = [0.50, 0.63, 0.75, 0.85, 1];

data85=[];
data75=[];
data63=[];
data50=[];
controllers100=[];
%for i = 1:numel(dataQoS)
    for j=1:length(tempjoint_ordered100)
        if((sizeTXOPspercentage(j)>0.02) &&(sizeTDMAs100(j)>24))
%             data85(end+1)=-1*(overhead100(j)-overhead85(j));
%             data75(end+1)=-1 *(overhead100(j)-overhead75(j));
%             data63(end+1)=-1*(overhead100(j)-overhead60(j));
%             data50(end+1)=-1*(overhead100(j)-overhead50(j));
            data85(end+1)=(tempjoint_ordered100(j)-tempjoint_ordered85(j));
            data75(end+1)=(tempjoint_ordered100(j)-tempjoint_ordered75(j));
            data63(end+1)=(tempjoint_ordered100(j)-tempjoint_ordered60(j));
            data50(end+1)=(tempjoint_ordered100(j)-tempjoint_ordered50(j));
            controllers100(end+1)=numcontrollers100(j);
        end
    end
    
    data85= data85(data85 > 0);
    data75= data75(data75 > 0);
    data63= data63(data63 > 0);
    data50= data50(data50 > 0);
    
    
[f1, x1] = ecdf(data85);
[f2, x2] = ecdf(data75);
[f3, x3] = ecdf(data63);
[f4, x4] = ecdf(data50);



plot(x1,f1,'-','LineWidth',2);
hold on;
plot(x2,f2,'--','LineWidth',2);
plot(x3,f3,':','LineWidth',2);
hold on;
plot(x4,f4,'-.','LineWidth',2);
hold off
%xlabel('Number of controllers');
xlabel('Controller-to-switch delay(slots)','fontsize',16);
ylabel('Cumulative portion of measurement points','fontsize',13);
%title('Cumulative Distribution Functions (CDFs)');
%legend({'\beta =1','\beta =0.75','\beta =0.5'}');
%legend('Location','southeast')
%legend.FontSize = 12;
legend({'\beta =1','\beta =0.75','\beta =0.5'}, 'Location', 'southeast', 'FontSize', 12);

% Increase the size of the legend
lgd = legend('Location', 'southeast');
legend boxoff
set(lgd, 'FontSize', 16);

%tempdata=[];
%tempdata(end+1)=
% xlim([min(data3), max(data1)]);
% x=20;
% set(gca,'XTick',(floor(min(data3)/x)-1)*x:x:(ceil(max(data1)/x)+1)*x)
% set(gca,'XTickLabel',(floor(min(data3)/x)-1)*x:x:(ceil(max(data1)/x)+1)*x)
%lgd.FontSize = 12;
f=figure(1)


