% xlim([1 12]);
% xticks(1:12);
%1a and 1b

%edges1a(1)=[];

%edges1b(1)=[];

edges1a_low=[1,2,3,4,5];
edges1a_high=[6,7,8,9,10,12];
edges1b_high=[50,150,200,300,400,500];
edges1b_low=[400,500,600,700,800,900];

%edges1b_low=[50   150   250   350   450   580];
%edges1b_high=[400,550,700,850,1000,1100];

delaysjoint_low =[  0.2 0.35 0.5 0.69 0.86 0.96   ; %kmeans 1
                    0.26 0.4 0.55 0.74 0.89 0.98   ; %kmeans 0.75
                    0.3 0.45 0.6 0.78 0.92 1   ; %kmeans 0.5
                ];
            
controllersjoint_low =[0.22 0.33 0.45 0.65 0.78 0.9   ; %kmeans 1
                       0.28 0.39 0.5 0.7 0.83 0.95   ; %kmeans 0.75
                       0.3 0.43 0.55 0.75 0.88 1     ; %kmeans 0.5
                   ];
               
delaysjoint_high =[  0.17 0.4 0.53 0.68 0.83 0.95   ; %kmeans 1
                     0.23 0.44  0.58 0.73  0.88 0.97   ; %kmeans 0.75
                     0.25 0.49 0.62 0.78 0.93 1   ; %kmeans 0.5
                   ];
            
controllersjoint_high =[  0.25 0.42 0.57 0.74 0.84 1   ; %kmeans 1
                          0.29 0.46  0.62 0.78  0.87 1   ; %kmeans 0.75
                          0.32 0.51 0.67 0.81 0.92 1   ; %kmeans 0.5
                       ];
                   
delaysjoint_highonos =[  0.14 0.37 0.5 0.64 0.8 0.93   ; %kmeans 1
                         0.2 0.42  0.55 0.7  0.84 0.97   ; %kmeans 0.75
                         0.256 0.49 0.62 0.78 0.94 1   ; %kmeans 0.5
                   ];
               
delaysjoint_lowonos =[  0.22 0.37 0.52 0.7 0.87 0.95   ; %kmeans 1
                        0.26 0.4 0.55 0.74 0.9 0.98   ; %kmeans 0.75
                        0.3 0.42 0.6 0.79 0.93 1   ; %kmeans 0.5
                      ];
vals1adat1=delaysjoint_high(1,:);
vals1adat2=delaysjoint_high(2,:);
vals1adat3=delaysjoint_high(3,:);
plot(edges1b_high,vals1adat1,'-','LineWidth',2);
hold on;
plot(edges1b_high,vals1adat2,'--','LineWidth',2);
plot(edges1b_high,vals1adat3,':+','LineWidth',2);
hold off
%title('Average controller-to-switch after 25 snaphsots')
ylabel('Cumulative portion of measurement points')
%xlabel('Controller-to-switch delay (slots)')
%ylabel('Cumulative portion of measurement points','fontsize',14)
xlabel('Controller-to-switch delay (slots)','fontsize',16)
%xlabel('Number of controllers','fontsize',16)
%lgd=legend( {'Joint','Periodic (Interval=10)','Static'}');
%lgd=legend({'Greedy(100%)','Greedy (75%)','Greedy (50%)'}');
lgd=legend({'\beta =1','\beta =0.75','\beta =0.5'}');
legend('Location','southeast')
%legend('Markersize','18')
lgd.FontSize = 12;
%set(legend,'box','off')
%set(gca,'xlim',1,12)

%set(gca,'XTick',0:5)
%set(gca,'XTickLabel',0:5)
xlim([edges1b_high(1), edges1b_high(end)]);
%set(gca,'XTick',0:100:900)
%set(gca,'XTickLabel',0:100:900)
f=figure(1)
%print -f -depsc -tiff cdf_jointdelay_high.eps