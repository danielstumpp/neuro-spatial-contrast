
%% load data 
clear
close all
load('results.mat');
%%
% constants
global title_size
global label_size
global number_size
global line_width

title_size = 14;
label_size = 12;
number_size = 11;
line_width = 1.25;


%% Active Rows Vs. Absolute Thresh
figure;
% plot regression
p = polyfit(absolute_threshs, absolute_active_rows.*100, 3);
x = linspace(0,max(absolute_threshs),250);
y = polyval(p,x);
plot(x, y, '--r', 'LineWidth',1.25);

% put data up
hold on;
scatter(absolute_threshs, absolute_active_rows.*100,'sk','filled'); 

% text and formatting
standards('Active Rows vs. Absolute Threshold', 'Absolute Threshold', 'Active Rows')
grid on;
legend({'3^{rd} order regression'});
ytickformat('%g%%')
xtickformat('%.3f')

set(gca, 'FontSize', 14);

% export
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 5.715, 3], ...
    'PaperUnits', 'Inches', 'PaperSize', [5.715, 3]);
exportgraphics(gcf, 'pdfs/active_rows_vs abs_thresh.pdf');

%% Active Rows Vs. Relative Thresh
figure;
% plot regression
p = polyfit(relative_threshs, relative_active_rows.*100, 3);
x = linspace(0,max(relative_threshs),250);
y = polyval(p,x);
plot(x, y, '--r', 'LineWidth',1.25);

% put data up
hold on;
scatter(relative_threshs, relative_active_rows.*100,'sk','filled'); 

% text and formatting
standards('Active Rows vs. Relative Threshold', 'Relative Threshold', 'Active Rows')
grid on;
legend({'3^{rd} order regression'});
ytickformat('%g%%')
xtickformat('%.3f')
set(gca, 'FontSize', 14);

% export
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 5.715, 3], ...
    'PaperUnits', 'Inches', 'PaperSize', [5.715, 3]);
exportgraphics(gcf, 'pdfs/active_rows_vs rel_thresh.pdf');


%% Absolute vs. event Rate
figure;
% plot regression
p = polyfit(absolute_threshs, absolute_events.*100.*3./baseline_events, 3);
x = linspace(0,max(absolute_threshs),250);
y = polyval(p,x);
plot(x, y, '--r', 'LineWidth',1.25);

% put data up
hold on;
scatter(absolute_threshs, absolute_events.*100.*3./baseline_events,'sk','filled'); 

% text and formatting
standards('Event Activity vs. Absolute Threshold', 'Absolute Threshold', 'Event Activity')
grid on;
legend({'3^{rd} order regression'});
ytickformat('%.2g%%')
xtickformat('%.3f')
set(gca, 'FontSize', 14);
% export
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 5.715, 3], ...
    'PaperUnits', 'Inches', 'PaperSize', [5.715, 3]);
exportgraphics(gcf, 'pdfs/events_vs abs_thresh.pdf');


%% Relative vs. event Rate
figure;
% plot regression
p = polyfit(relative_threshs, relative_events.*100.*3./baseline_events, 3);
x = linspace(0,max(relative_threshs),250);
y = polyval(p,x);
plot(x, y, '--r', 'LineWidth',1.25);

% put data up
hold on;
scatter(relative_threshs, relative_events.*100.*3./baseline_events,'sk','filled'); 

% text and formatting
standards('Event Activity vs. Relative Threshold', 'Relative Threshold', 'Event Activity')
grid on;
legend({'3^{rd} order regression'});
ytickformat('%.2g%%')
xtickformat('%.3f')
set(gca, 'FontSize', 14);
% export
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 5.715, 3], ...
    'PaperUnits', 'Inches', 'PaperSize', [5.715, 3]);
exportgraphics(gcf, 'pdfs/events_vs rel_thresh.pdf');

%% Absolute F1-Score vs. Network Size
figure;
mkrs = {'-o','-x','-+','-s','-d','->','-t'};
plot(parameters, baseline_f1,'--^k','LineWidth',line_width); hold on;
for i=1:size(absolute_f1,2)
    plot(parameters, absolute_f1(:,i), mkrs{i}, 'LineWidth',line_width);
end
hold off;
% text and formatting
standards('Absolute Macro F1-Score vs. Network Size', 'Network Parameters', 'Macro F1-Score')
grid on;

ylim([.45,1])
xlim([0, 7.5e5])
ytickformat("%.2f")


legend({'RGB Baseline', 'Absolute 0.0025', 'Absolute 0.0075',...
        'Absolute 0.01', 'Absolute 0.02', 'Absolute 0.03', 'Absolute 0.04'}, ...
        'Location', 'southeast', 'FontSize', label_size);

% export
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 7 3.8], ...
    'PaperUnits', 'Inches', 'PaperSize', [7, 3.8]);
exportgraphics(gcf, 'pdfs/abs_f1_vs network_params.pdf');


%% Relative F1-Score vs. Network Size
figure;
mkrs = {'-o','-x','-+','-s','-d','->','-*','-h'};
plot(parameters, baseline_f1,'--^k','LineWidth',line_width); hold on;
for i=1:size(relative_f1,2)
    plot(parameters, relative_f1(:,i), mkrs{i}, 'LineWidth',line_width);
end
hold off;
% text and formatting
standards('Relative Macro F1-Score vs. Network Size', 'Network Parameters', 'Macro F1-Score')
grid on;

ylim([.55,1])
xlim([0, 7.5e5])
ytickformat("%.2f")


legend({'RGB Baseline', 'Relative 0.005', 'Relative 0.010',...
        'Relative 0.050', 'Relative 0.075', 'Relative 0.100', 'Relative 0.150', 'Relative 0.200'}, ...
        'Location', 'southeast', 'FontSize', label_size);

% export
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 7 3.8], ...
    'PaperUnits', 'Inches', 'PaperSize', [7, 3.8]);
exportgraphics(gcf, 'pdfs/rel_f1_vs network_params.pdf');

%% F1-Score vs. Event Rate
figure;

plot(absolute_events.*100.*3./baseline_events, absolute_f1(end,:),'-o','LineWidth',line_width); hold on;
plot(relative_events.*100.*3./baseline_events, relative_f1(end,:), '-d','LineWidth',line_width);
yline(baseline_f1(end),'--g','LineWidth',line_width)

hold off;
% text and formatting
standards('Macro F1-Score vs. Event Activity', 'Event Activity', 'Macro F1-Score')
grid on;
ytickformat('%.2f');
xtickformat('%g%%');

legend({'SC-Absolute','SC-Relative', 'RGB-Baseline'},'location','southeast')

% export
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 5.715, 3], ...
    'PaperUnits', 'Inches', 'PaperSize', [5.715, 3]);
exportgraphics(gcf, 'pdfs/f1_vs_event_rate.pdf');

%% functions 

function  standards(ttl, xlab, ylab)
    global title_size
    global label_size

    set(gca, 'FontName', 'times new roman');
    set(gca, 'FontWeight','bold');
    title(ttl, 'FontSize', title_size);
    xlabel(xlab, 'FontSize', label_size);
    ylabel(ylab, 'FontSize', label_size);
end
