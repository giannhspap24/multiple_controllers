% lw = Gtest40.Edges.Weight;
% edgestyle = cell(size(lw));
% edgestyle(lw == 1) = {':'};
% edgestyle(lw == 2) = {'-'};
% edgestyle(lw == 3) = {'--'};
% 
% % Plot the graph with specified line styles and edge colors
% h = plot(Gtest40,'XData',x_coords,'YData',y_coords,'LineStyle',edgestyle,'LineWidth',3*Gtest40.Edges.Weight./max(Gtest40.Edges.Weight));
% h.NodeLabel = {};
% 
% % Increase the marker size of nodes
% h.MarkerSize = 4; % Adjust the size as needed
% axis off;
% 
% f=figure(1)
% print -f -depsc -tiff graph40nodes.eps
% 
% Sample data (replace with your actual data)
%numControllers = [100, 94, 88, 84, 80,76,72,68,64,60,56,50];
numControllers = [0.50, 0.62,0.75,0.85,1];
overheadData=[96 80 52 29 0];
delayData=[-29 -25 -19 -3 0];

overheadData80=[60 52 42 22 0];
delayData80=[-16 -10.4 -5.4 -1.8 0];
% overheadData=[21 18.6 16.85 15.1 13.34 11.6 8.85 7.1 5.35 3.6 1.85 0.1];
% delayData=[-14.46 -13.3	-12.14	-11.418	-10.324	-9.096 -6.636	-5.108	-4.524	-2.804	-1.696	0];

%overheadData=[21 18.6 16.85 15.1 13.34 11.6 8.85 7.1 5.35 3.6 1.85 0.1];
%overheadData80=[23 19.6 17.85 15.1 14.34 11.6 9.85 8.1 6.35 4.6 2.85 0.1];

%delayData=[-14.46400 -13.30400	-12.14400	-11.41800	-10.32400	-9.09600	-6.636	-5.108	-4.524	-2.804	-1.696	0];
%delayData80=[-17.46400 -16.30400	-15.14400	-13.41800	-12.32400	-11.9600	-10.636	 -9.808	-4.524	-2.804	-1.696	0];

%delayData=[0	-2.8	-4.7	-5.7	-6.9	-7.3	-7.8	-8.2	-8.65	-9.2	-9.7 -10.2];
%delayData=[0 2.8 4.7 5.7	6.9	7.3	7.8	8.2	8.65 9.2	9.7 10.2];
% for i=1:12
%     delayData(i)=100-delayData(i);
% end
%overheadData = [792,820,897,1100,1387,1700,1970,2205,2480,3002,3700,4300]; % Replace with your overhead data
%delayData = [940,802,711,618,546,470,400,340,273,207,180,150]; % Replace with your delay data

% Create the figure
figure;

% Plot the overhead data on the primary y-axis
yyaxis left;
plot(numControllers, overheadData80, '-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('\beta','fontsize',12);
ylabel('Overhead (+%)','fontsize',12);
ylim([min(overheadData80) ,  max(overheadData80)]);
xlim([0.50,1])
%title('Tradeoff Curve between Overhead and Delay');

% Create a second y-axis for delay data (scaled to match overhead)
yyaxis right;
%plot(numControllers, delayData * max(overheadData) / max(delayData), '-s', 'LineWidth', 2, 'MarkerSize', 8);
plot(numControllers, delayData80 , '-s', 'LineWidth', 2, 'MarkerSize', 8);
ylabel('Delay (-%)','fontsize',12);
%ylim([min(delayData) * max(overheadData) / max(delayData), max(delayData) * max(overheadData) / max(delayData)]);
ylim([min(delayData80) ,  max(delayData80)]);
% Customize legends
%legend({'\beta =1','\beta =0.75','\beta =0.5'}, 'Location', 'southeast', 'FontSize', 12);
legend('Overhead', 'Delay','Location', 'North');
% Increase the size of the legend
lgd = legend('Location', 'North');
legend boxoff
set(lgd, 'FontSize', 12);
legend boxoff
%print -f -depsc -tiff tradeoffcurve_new.eps