function run_stats_Behaviorfig3fig4fig5
%need to separate OPR form FC
close all
clc
OPR = {1:8 1:7 1:9};
FC = {9:17 8:17 10:22};
figfold = '/Users/Koreign/Documents/0 - IBS/1 - SW Spindles/Data Analysis Remake 201703/Figure boxplot remake/';

%% Fig 3
%Spindle incidence rate
display('==========    PVMHCHR2 FC Spindle incidence  ===============')
load('Fig3a_slow.mat')%FRO PAR CA1
gcolor = {[1 0 0] [1 0.69 0.39] [64 181 29]/255 [0.4 1 0.6];[1 0 0] [0 0 0] [0 1 0] [0 0 0]};
for c = 1:3
    groups = {fig3a_IN(:,c)*100 fig3a_NOIN(:,c)*100 fig3a_OUT(:,c)*100 fig3a_NOOUT(:,c)*100};
    [h1,h2] = scattermean_plot(groups,gcolor,'Spindle incidence rate (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 80])
    saveas(h2,[figfold 'boxplot_FCtg_FIg3a' num2str(c) '.tiff'])
end

display('==========    PVMHCHR2 FC SO spindle ratio  ===============')
load('Fig3b_slow.mat')%FRO PAR CA1
gcolor = {[1 0 0] [64 181 29]/255 [0 0 0];[1 0 0] [0 1 0] [0 0 0]};
for c = 1:2%FRO PAR
    groups = {fig3b_IN(:,c) fig3b_OUT(:,c) fig3b_NO(:,c)};
    [h1,h2] = scattermean_plot(groups,gcolor,'Overall So-spindle ration (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 10])
    saveas(h2,[figfold 'boxplot_FCtg_FIg3b' num2str(c) '.tiff'])
end

display('==========    PVMHCHR2 FC SO-spindle coupling  ===============')
load('Fig3c_slow.mat')%FRO PAR CA1
gcolor = {[1 0 0] [64 181 29]/255 [0 0 0];[1 0 0] [0 1 0] [1 1 1]};
for c = 1:3%FRO PAR CA1
    groups = {fig3c_IN(:,c)*100 fig3c_OUT(:,c)*100 fig3c_NO(:,c)*100};
    [h1,h2] = scattermean_plot(groups,gcolor,'SO-Spindle coupling (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 80])
    saveas(h2,[figfold 'boxplot_FCtg_FIg3c' num2str(c) '.tiff'])
end



figfold = '/Users/Koreign/Documents/0 - IBS/1 - SW Spindles/Data Analysis Remake 201703/Figure boxplot remake/';

%% Fig 4
%SO incidence rate
display('==========    PVMHCHR2 FC    ===============')
load('Fig4b.mat')%FRO PAR
gcolor = {[1 0 0] [1 0.69 0.39] [64 181 29]/255 [0.4 1 0.6];[1 0 0] [1 1 1] [0 1 0] [1 1 1]};
for c = 1:2
    groups = {fig4b_IN(:,c)*100 fig4b_NOIN(:,c)*100 fig4b_OUT(:,c)*100 fig4b_NOOUT(:,c)*100};
    [h1,h2] = scattermean_plot(groups,gcolor,'SO incidence rate (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 60])
    saveas(h2,[figfold 'boxplot_FCtg_FIg4b' num2str(c) '.tiff'])
end
clear

figfold = '/Users/Koreign/Documents/0 - IBS/1 - SW Spindles/Data Analysis Remake 201703/Figure boxplot remake/';

%% Fig5
%ripple incidence rate
display('==========    PVMHCHR2 FC ripple incidence rate   ===============')
load('Fig5c.mat')%
gcolor = {[1 0 0] [1 0.69 0.39] [64 181 29]/255 [0.4 1 0.6];[1 0 0] [1 1 1] [0 1 0] [1 1 1]};
groups = {fig5c_IN*100 fig5c_NOIN*100 fig5c_OUT*100 fig5c_NOOUT*100};
[h1,h2] = scattermean_plot(groups,gcolor,'Ripple incidence rate (%)');
%     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
set(h2,'position',[87   306   335   453])
set(gca,'ylim',[0 40])
saveas(h2,[figfold 'boxplot_FCtg_FIg5c.tiff'])
% set(h2,'position',[87   306   335   453])
%     set(gca,'ylim',[0 60])



%Ripples nested within spindles
display('==========    PVMHCHR2 FC ripple spindle co-occurrence  ===============')
load('Fig5d_slow.mat')%
gcolor = {[1 0 0] [1 0.69 0.39] [64 181 29]/255 [0.4 1 0.6];[1 0 0] [1 1 1] [0 1 0] [1 1 1]};
for c = 1:3%FRO PAR CA1
    groups = {fig5d_IN(:,c)*100 fig5d_NOIN(:,c)*100 fig5d_OUT(:,c)*100 fig5d_NOOUT(:,c)*100};
    [h1,h2] = scattermean_plot(groups,gcolor,'Ripples nested within spindles (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 30])
    saveas(h2,[figfold 'boxplot_FCtg_FIg5d_' num2str(c) '.tiff'])
end

%Slow oscillation-ripple-spindle density
display('==========    PVMHCHR2 FC  SO-spindel-ripple coupling  ===============')
load('Fig5e_slow.mat')%
gcolor = {[1 0 0] [64 181 29]/255 [0 0 0];[1 0 0] [0 1 0] [0 0 0]};
for c = 1:2
    groups = {fig5e_IN(:,c)*100 fig5e_OUT(:,c)*100 fig5e_NO(:,c)*100};
    [h1,h2] = scattermean_plot(groups,gcolor,'Slow oscillation-ripple-spindle density (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 20])
    saveas(h2,[figfold 'boxplot_FCtg_FIg5e' num2str(c) '.tiff'])
end

clear



