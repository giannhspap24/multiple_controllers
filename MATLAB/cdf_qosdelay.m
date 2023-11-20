% xlim([1 12]);
% xticks(1:12);
%1a and 1b
edges1a=0:50:300;
%edges1a(1)=[];
edges1b=0:10:120;
%edges1b(1)=[];
vals2a = [ 0 0.32 0.53 0.63 0.72 0.82 1  ; %greedy 1
           0 0.3 0.51 0.6 0.7 1 1 ; %greedy 0.75
           %0 0.37 0.61 0.68 0.77 0.86 0.95 1 1 1 1 ; %oredring
          ];
      
      
edges1a=[1,2,3,4,5,6,8,10,12];
edges1b=[0,100,200,300,400,500,600,700,800,900];
delaysgr =[     0 0.1 0.25 0.35 0.46 0.55 0.65 0.82 0.95 1  ; %greedy 1
                0 0.14 0.28 0.39 0.49 0.58 0.69 0.88 1 1  ; %greedy 0.75
                0 0.19 0.31 0.42 0.52 0.62 0.73 0.92 1 1  ; %greedy 0.5
                ];
            
% controllersgr =[ 0.2  0.27 0.36 0.46 0.59 0.705 0.87 1 1  ; %greedy 1
%                  0.17 0.24 0.33 0.43 0.56 0.675 0.82 0.94 1  ; %greedy 0.75
%                  0.13 0.21 0.29 0.39 0.53 0.645 0.8 0.92 1  ; %greedy 0.5
%                 ];
%             
controllersgr =[ 0.13 0.21 0.29 0.39 0.53 0.645 0.8 0.92 1  ; %greedy 1
                 0.17 0.24 0.33 0.43 0.56 0.675 0.82 0.94 1  ; %greedy 0.75
                 0.2  0.27 0.36 0.46 0.59 0.705 0.87 1 1  ; %greedy 0.5
    ];
delaysjoint =[  0 0.11 0.2 0.32 0.4 0.5 0.66 0.81 0.9 0.97  ; %kmeans 1
                0 0.14 0.26 0.37 0.46 0.57 0.72 0.85 0.94 1  ; %kmeans 0.75
                0 0.19 0.31 0.42 0.54 0.65 0.78 0.9 1 1  ; %kmeans 0.5
                ];
            
controllersjoint =[   0.2 0.25 0.34 0.42 0.5 0.6 0.75 0.91 1  ; %kmeans 1
                      0.24 0.3 0.39 0.48 0.59 0.7 0.86 0.95 1  ; %kmeans 0.75
                      0.27 0.35 0.48 0.58 0.69 0.8 0.93 1 1  ; %kmeans 0.5
                   ];
vals1adat1=controllersjoint(1,:);
vals1adat2=controllersjoint(2,:);
vals1adat3=controllersjoint(3,:);
plot(edges1a,vals1adat1,'-','LineWidth',2);
hold on;
plot(edges1a,vals1adat2,'--','LineWidth',2);
plot(edges1a,vals1adat3,':+','LineWidth',2);
hold off
%title('Average controller-to-switch after 25 snaphsots')
%ylabel('Cumulative portion of measurement points')
%xlabel('Controller-to-switch delay (slots)')
ylabel('Cumulative portion of measurement points','fontsize',14)
%xlabel('Controller-to-switch delay (slots)','fontsize',16)
xlabel('Number of controllers','fontsize',16)
%lgd=legend( {'Joint','Periodic (Interval=10)','Static'}');
%lgd=legend({'Greedy(100%)','Greedy (75%)','Greedy (50%)'}');
lgd=legend({'100%','75%','50%'}');
legend('Location','southeast')
%legend('Markersize','18')
lgd.FontSize = 12;



%set(legend,'box','off')
%set(gca,'xlim',1,12)

set(gca,'XTick',0:12)
set(gca,'XTickLabel',0:12)
xlim([edges1a(1), edges1a(end)]);
%set(gca,'XTick',0:100:900)
%set(gca,'XTickLabel',0:100:900)
f=figure(1)
%print -f -depsc -tiff cdf_jointcontrollers_new1.eps