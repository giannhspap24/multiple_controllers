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
numControllers = [0.50, 0.56, 0.60, 0.64, 0.68,0.72,0.76,0.80,0.84,0.88,0.94,1];
overheadData=[0.1 1.85 3.6 5.35 7.1 8.85 10.6 12.34 14.1 15.85 17.6 19.7];
overheadData80=[20 17.6 15.85 14.1 12.34 10.6 8.85 7.1 5.35 3.6 1.85 0.1];
delayData80=[-10.2	-9.70	-9.2	-8.650	-8.2	-7.8	-7.3	-6.9	-5.7	-4.7	-2.8 0];
%delayData80=[-15.46400	-14.30400	-13.14400	-12.41800	-11.32400	-10.09600	-9.636	-8.108	-5.524	-4.204	-2.696	0];

%overheadData80=[20 17.6 15.85 14.1 12.34 10.6 8.85 7.1 5.35 3.6 1.85 0.1];
%overheadData80=overheadData80*(1.2 + rand*(1.6-1.2));

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
xlabel('\beta');
ylabel('Overhead (+%)');
ylim([min(overheadData80) ,  max(overheadData80)]);
xlim([0.50,1])
%title('Tradeoff Curve between Overhead and Delay');

% Create a second y-axis for delay data (scaled to match overhead)
yyaxis right;
%plot(numControllers, delayData * max(overheadData) / max(delayData), '-s', 'LineWidth', 2, 'MarkerSize', 8);
plot(numControllers, delayData80 , '-s', 'LineWidth', 2, 'MarkerSize', 8);
ylabel('Delay (-%)');
%ylim([min(delayData) * max(overheadData) / max(delayData), max(delayData) * max(overheadData) / max(delayData)]);
ylim([min(delayData80) ,  max(delayData80)]);
% Customize legends
legend('Overhead', 'Delay','Location', 'North');
%print -f -depsc -tiff tradeoffcurves.eps