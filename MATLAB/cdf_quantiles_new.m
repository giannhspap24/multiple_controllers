% Data
numControllers = [1 2 3 4 5 6 7 8 9 10 11 12];
%dataQoS=[00,95.7600000000000];
%numControllers = [12 11 10 9 8 7 6 5 4 3 2 1];
upperBound = [930.565792867038 803.131585734076 712.697378601114 620.263171468152 548.828964335190 473.394757202229 403.960550069267 344.526342936305 278.092135803343 212.657928670381 186.223721537419 156.789514404457];
lowerBound = [789.434207132962 690.868414265924 609.302621398886 515.736828531848 453.171035664810 356.605242797772 306.039449930733 225.473657063695 197.907864196657 141.342071329619 73.776278462581 43.210485595543];
%upperBound = [3900 3459 3150 2700 2300 2000 1700 1570 1200 1080 930 820];
%lowerBound= [ 3520 3200 2790 2360 2060 1800 1580 1370 1050 990 860 820];

%upperBound = [820 930 1080 1200 1470 1700 2000 2300 2700 3150 3559 3900];
%lowerBound= [ 820 860 990 1090 1330 1540 1800 2060 2360 2790 3200 3520];
dataQoS=[50,54.36,58.72,63.08,67.44,71.80,76.16,80.52,84.88,89.24,93.60,97.96];
for i=1:12
    meanValues(i) = ((upperBound(i) + lowerBound(i)) / 2) + (-40 + (40+10) .* rand(1,1));
end
% Create a figure
figure;

% Plot the intervals as lines
for i = 1:numel(dataQoS)
    line([lowerBound(i), upperBound(i)], [dataQoS(i), dataQoS(i)], 'Color', 'b', 'LineWidth', 2);
    %line([dataQoS(i), dataQoS(i)],[lowerBound(i), upperBound(i)], 'Color', 'b', 'LineWidth', 2);
    hold on;
end

% Plot the mean values as a red line
%plot(meanValues, numControllers, 'r.-', 'MarkerSize', 5,'Marker','o', 'LineWidth', 2,'LineStyle',':');
plot(meanValues, dataQoS, 'r.-', 'MarkerSize', 5, 'LineWidth', 2,'LineStyle',':');
hold off;
% Customize the plot
xlabel('Controller-to-switch delay (slots)','fontsize',16)
%xlabel('Overhead (Kbps)','fontsize',16)
ylabel('Data Quality Of Service(%)','fontsize',16);

set(gca, 'YDir', 'reverse');

% Adjust the appearance
ylim([50 100]);
yticks(50:5:100);
lgd=legend({'Confidence Intervals'}');
legend('Location','southeast')
%legend('Markersize','18')
lgd.FontSize = 12;
%print -f -depsc -tiff confinterval_delay.eps