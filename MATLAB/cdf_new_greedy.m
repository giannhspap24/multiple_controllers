% Example data (replace with your own data)
data1=[];
data2=[];
data1_high=[];
data2=[];
for i=1:length(tempjoint_ordered100)
    %if(TDMAspare(i)<35)
    data1(end+1)=tempjoint_ordered100(i);
    %end
end
for i=1:length(greedy_mean)
    %if(sizeTDMAGreedy(i)<35)
    data2(end+1)=greedy_mean(i);
    %end
end



%for moderate demand

data1delay=[];
data2delay=[];

data1controllers=[];
data2controllers=[];
%until here data entry

% Define the edges for the histogram bins
%binEdges = 7:1:12;  % Adjust the bin edges as needed
%binEdges = 40:15:100;
% Create histograms for both datasets
histData1 = histcounts(data1, binEdges);
histData2 = histcounts(data2, binEdges);

totalData1 = numel(data1);
totalData2 = numel(data2);

% Convert the histogram counts to percentages
histPercentage1 = (histData1 / totalData1) * 1;
histPercentage2 = (histData2 / totalData2) * 1;
binEdges = 60:20:180;
% Create a bar plot with two bars per x-value
figure;
%controllers high
%histPercentage1 = [0.05, 0.22, 0.24, 0.31, 0.1, 0.07 ];
%histPercentage2 = [0.1,0.52,0.24,0.11,0.03, 0.0];
%binEdges = 1:6;
%controllers high end

%controllers high
% histPercentage1 = [0.11, 0.29,0.13, 0.16,0.07,0.11,0.12];
% histPercentage2 = [0.1,0.38,0.43,0.07,0.03,0,0];
% binEdges = 7:13;
%controllers high end

%controllers high scenario
figure;
binEdges = 10:10:70;
histPercentage1 = [0.83,0.09,0.05,0.02,0.001,0.0001,0.001 ];
histPercentage2 = [0.78,0.12,0.04,0.03,0.01,0.0001,0.001];
histPercentage3 = [0.41,0.2,0.15,0.12,0.05,0.05,0.02];
histPercentage4 = [0.28,0.23,0.18,0.13,0.08,0.07,0.05];
%controllers high end

%figure;
bar(binEdges(1:end), [histPercentage1; histPercentage2;histPercentage3; histPercentage4]', 'grouped');
%xlabel('Number of controllers','FontSize',14);
xlabel('Controllers-to-switch delay (slots)','FontSize',12);
ylabel('Portion of measurement points (%)','FontSize',14);

lgd=legend('\beta=0.85','\beta=075','\beta=0.62','\beta=0.5');%legend('Location','northeast')
set(lgd, 'FontSize', 12);
legend boxoff
% Optionally, customize the color of the bars
colormap('cool');
%print -f -depsc -tiff delay_high_greedy_new.eps
% Optionally, add a grid
%grid on;
