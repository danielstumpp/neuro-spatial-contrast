clear;
close all;

load('red1.mat');


%% Categorical Test Acc
figure;
plot(abse,abs_cacc, 'd--', rele, rel_cacc,  'o--', 'LineWidth',1.2);
yline(baseline_cacc,'g-.','LineWidth',1.2);
set(gca, 'LineWidth',1.2, 'FontWeight','bold');
ylim([min(abs_cacc) - .1,1]);
legend({'absolute','relative','rgb baseline'},'Location','southeast');
title('Categorical Test Accuracy','FontSize',16);
ylabel('Accuracy');
xlabel('Fraction of Pixels Active');



%% Categorical Test Top-5 Acc
figure;
plot(abse,abs_t5, 'd--', rele, rel_t5,  'o--', 'LineWidth',1.2);
yline(baseline_t5,'g-.','LineWidth',1.2);
set(gca, 'LineWidth',1.2, 'FontWeight','bold');
ylim([min(abs_t5) - .1,1]);
legend({'absolute','relative','rgb baseline'},'Location','southeast');
title('Categorical Test Top-5','FontSize',16);
ylabel('Accuracy');
xlabel('Fraction of Pixels Active');


%% Top-3 Acc
figure;
plot(abse,abs_t3, 'd--', rele, rel_t3,  'o--', 'LineWidth',1.2);
yline(baseline_t3,'g-.','LineWidth',1.2);
set(gca, 'LineWidth',1.2, 'FontWeight','bold');
ylim([min(abs_t3) - .1,1]);
legend({'absolute','relative','rgb baseline'},'Location','southeast');
title('Categorical Test Top-3','FontSize',16);
ylabel('Accuracy');
xlabel('Fraction of Pixels Active');
