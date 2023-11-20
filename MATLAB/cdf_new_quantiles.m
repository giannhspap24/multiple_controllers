% Data
dataQoS = [0.50, 0.63, 0.75, 0.85, 1];

%numControllers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
%upperBound = [930.565792867038, 803.131585734076, 712.697378601114, 620.263171468152, 548.828964335190, 473.394757202229, 403.960550069267, 344.526342936305, 278.092135803343, 212.657928670381, 186.223721537419, 156.789514404457];
%lowerBound = [789.434207132962, 690.868414265924, 609.302621398886, 515.736828531848, 453.171035664810, 356.605242797772, 306.039449930733, 225.473657063695, 197.907864196657, 141.342071329619, 73.776278462581, 43.210485595543];
% upperBound = [930.565792867038, 803.131585734076, 712.697378601114, 620.263171468152, 548.828964335190, 473.394757202229, 403.960550069267, 344.526342936305, 278.092135803343, 212.657928670381, 186.223721537419, 156.789514404457];
% lowerBound = [789.434207132962, 690.868414265924, 609.302621398886, 515.736828531848, 453.171035664810, 356.605242797772, 306.039449930733, 225.473657063695, 197.907864196657, 141.342071329619, 73.776278462581, 43.210485595543];

%for i = 1:numel(dataQoS)
%     upperBound(i)=[] ;
%     lowerBound(i)=[] ;
%end
data85=[];
data75=[];
data63=[];
data50=[];

%for i = 1:numel(dataQoS)
    for j=1:length(tempjoint_ordered100_th)
        if(sizeTDMAs100_th(j)<250)
            data85(end+1)=tempjoint_ordered100_th(j)-tempjoint_ordered85_th(j);
            data75(end+1)=tempjoint_ordered100_th(j)-tempjoint_ordered75_th(j);
            data63(end+1)=tempjoint_ordered100_th(j)-tempjoint_ordered60_th(j);
            data50(end+1)=tempjoint_ordered100_th(j)-tempjoint_ordered50_th(j);
        end
    end
%     upperBound(i)= max(data85);
%     lowerBound(i)= min(data85);
%     upperBound_high(i)= (12-i)*180+  (9 + (13-10) .* rand(1,1));
%     lowerBound_high(i)=  (12-i)*180 +  (7 + (10-7) .* rand(1,1));
%end
    data85= data85(data85 > 0);
    data75= data75(data75 > 0);
    data63= data63(data63 > 0);
    data50= data50(data50 > 0);
%     
    upperBound=[];
    lowerBound=[];
    meanValues=[];
   upperBound (1)= 0;
    lowerBound(1)= 0;
    upperBound(2)= max(data85);
    lowerBound(2)= min(data85);
    upperBound(3)= max(data75);
    lowerBound(3)= min(data75);
    upperBound(4)= max(data63);
    lowerBound(4)= min(data63);
    upperBound(5)= max(data50);
    lowerBound(5)= min(data50);
    meanValues(1)=0;
    meanValues(2)=mean(data85);
    meanValues(3)=mean(data75);
    meanValues(4)=mean(data63);
    meanValues(5)=mean(data50);
% upperBound(11)=upperBound(11)/2;
% lowerBound(12)=lowerBound(11)/2;

% upperBound(12)=0;
% lowerBound(12)=0;
% meanValues(12)=0;
% upperBound_high(12)=0;
% lowerBound_high(12)=0;
% meanValues_high(12)=0;
% for i=1:numel(dataQoS)
%     meanValues(i) = ((upperBound(i) + lowerBound(i)) / 2) + (-1 + (1+1) .* rand(1,1));
%     %meanValues_high(i) = ((upperBound_high(i) + lowerBound_high(i)) / 2) + (-1 + (1+1) .* rand(1,1));
% end
% Create a figure
figure;

% Plot the intervals as lines
% for i = 1:numel(dataQoS)
%     line([dataQoS(i), dataQoS(i)], [lowerBound(i), upperBound(i)], 'Color', 'b', 'LineWidth', 2);
%     hold on;
% end
err=[];
for i = 1:numel(dataQoS)
    err(i)=upperBound(i)-lowerBound(i);
    %err_high(i)=upperBound_high(i)-lowerBound_high(i);
end

errorbar(dataQoS, meanValues,err, '-o', 'LineWidth', 2, 'MarkerSize', 8);
hold on;
% errorbar(dataQoS, meanValues_high,err_high, '-o', 'LineWidth', 2, 'MarkerSize', 8);
% hold on;

% Plot the mean values as a red line with red marker
plot(dataQoS, meanValues, 'r.-', 'MarkerSize', 5, 'LineWidth', 2, 'LineStyle', ':');
hold on;

% Plot the mean values as a red line with red marker
%plot(dataQoS, meanValues_high, 'b.-', 'MarkerSize', 5, 'LineWidth', 2, 'LineStyle', ':');
%hold off;

% Customize the plot
xlabel('\beta', 'fontsize', 16)
%ylabel('Controller-to-switch delay (slots)', 'fontsize', 16);
ylabel('Overhead (kbps)', 'fontsize', 16);

% Adjust the appearance
% ylim([0 ceil((upperBound(1)+err(1)))])
% xlim([0.5 1]);
% xticks(0.5:0.05:1);

% Create a custom legend
% lgd = legend({'Moderate load','High load'}');
% legend('Location', 'northeast')
% lgd.FontSize = 12;

% Set the legend icon for "Mean Values" to a red line
%legend('Mean Values', 'Location', 'southeast', 'TextColor', 'r');
%print -f -depsc -tiff confinterval_overhead_moderate.eps