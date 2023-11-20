% Group data for clients and their fathers
%high load delay here so it is the father


data1_new = [17,20,22,24]; %0.85
data2_new = [25,28,28,28];
data3_new = [30,30,31,40];
data4_new = [31,44,61,70];
data5_new=[80,120,122,145];

data1 = [8,12,12,15];
data2 = [17,22,22,22];
data3 = [23,26,26,28];
data4 = [28,30,33,37];
data5=[35,40,44,70];
% X-axis labels (categories)
categories = {'20', '40', '60','80','100'};


categories = {'20', '40', '60','80','100'};
clientData = [data1; data2; data3;data4;data5];
fatherData = [data1_new; data2_new; data3_new;data4_new;data5_new];

% Define standard colors for the bars
clientColors = {'w', 'w', 'w','w'};
fatherColors = {'r', 'r', 'r','r'};
% Create the grouped bar plot
figure;

% Initialize an array to store the legends
legends = cell(1, 4);
x = 1:numel(categories);
widths=[0.1,3.5,2,1];
styles=['-' , '--' , ':' , '-.'];
barWidth=0.2;
for i = 1:numel(categories)
    xPosition = x(i);
    
    % Plot bars for clients
    for j = 1:4
        clientValue = clientData(i, j);
        fatherValue = fatherData(i, j);
        
        
        
        % Set the legend labels for the client part
        
        
        % Plot the difference (father's part) with a different color
        bar(xPosition + (j - 1) * barWidth, fatherValue, barWidth, 'FaceColor', fatherColors{j},'LineStyle', styles(j),'LineWidth', 3.5);
        %h = bar(xPosition + (j - 1) * barWidth, fatherValue, barWidth, 'FaceColor', 'none', 'EdgeColor', 'k', 'EdgePattern', [5 5]);
        if(i==j)
            legends{i} = ['Client ' num2str(i)];
            %legends{j} = ['Client ' num2str(j) ' (' clientColors{j} ' Color)'];
        end
        hold on;
        % Plot the bar for the client with its respective color
        bar(xPosition + (j - 1) * barWidth, clientValue, barWidth, 'FaceColor', clientColors{j},'LineWidth',0.1);
        
        hold on;
    end
    
end

% Set labels and a custom legend
xlabel('Percentile (N)', 'fontsize', 16)
%ylabel('Overhead (kbps)', 'fontsize', 16);
set(gca,'YTick',0:20:150)
set(gca,'YTickLabel',0:20:150)
ylabel('Delay (slots)', 'fontsize', 16);
set(gca, 'XTick', x);
set(gca, 'XTickLabel', categories);

% Create a custom legend with only the client labels
h = zeros(1, 4);
legendMarkers = cell(1, 4);
betas=[0.85,0.75,0.62,0.5];
for i = 1:4
    h(i) = bar(NaN);
    legendMarkers{i} = ['\beta =' num2str(betas(i))];
    set(h(i), 'FaceColor', clientColors{i},'LineStyle', ':','LineWidth', widths(i));
end
legend(h, legendMarkers, 'Location', 'northwest');
set(lgd, 'FontSize', 14);
legend boxoff
%print -f -depsc -tiff confinterval_delays_new.eps
