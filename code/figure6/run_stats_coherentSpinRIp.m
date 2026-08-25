function run_stats_coherentSpinRIp
%need to separate OPR form FC
close all
clc

figfold = '/Users/Koreign/Documents/0 - IBS/1 - SW Spindles/Data Analysis Remake 201703/Figure boxplot remake/';

%% Fig 5 coherent
plotopt = 1;
if plotopt == 1
    %Coherent Incidence
    display('==========    PVMHCHR2 FC coherent incidence  ===============')
    load('Fig_cohInci.mat')
    
    %FRO&PAR FRO&CA1 PAR&CA1 and FRO&PAR&CA1 triple
    gcolor = {[1 0 0] [64 181 29]/255 [0 0 0] [1 1 1] [1 0 0] [64 181 29]/255 [0 0 0] [1 1 1] [1 0 0] [64 181 29]/255 [0 0 0] [1 1 1] [1 0 0] [64 181 29]/255 [0 0 0]};
    %grouping
    idxIN = find(groupOS == 2);
    idxOUT = find(groupOS == 3);
    idxOUTd = find(groupOS == 5);
    idxNOIN = find(groupOS == 1);
    idxNOOUT = find(groupOS == 2);
    A = coh_OSFCany;
    groups = {A(idxIN,1) A(idxOUTd,1) A(idxNOIN,1) [0] A(idxIN,2) A(idxOUTd,2) A(idxNOIN,2) [0] A(idxIN,3) A(idxOUTd,3) A(idxNOIN,3) [0] A(idxIN,4) A(idxOUTd,4) A(idxNOIN,4)};
    [h1,h2] = scattermean_plot(groups,gcolor,'Spindle incidence rate (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   783   453])
    set(gca,'ylim',[0 30])
    saveas(h2,[figfold 'boxplot_FCtg_CohFROPARCA1Spindle.tiff'])
    
    
    %FRO&PAR FRO&CA1 PAR&CA1 and FRO&PAR&CA1 triple with ripples
    groups = {A(idxIN,1+4) A(idxOUTd,1+4) A(idxNOIN,1+4) [0] A(idxIN,2+4) A(idxOUTd,2+4) A(idxNOIN,2+4) [0] A(idxIN,3+4) A(idxOUTd,3+4) A(idxNOIN,3+4) [0] A(idxIN,4+4) A(idxOUTd,4+4) A(idxNOIN,4+4)};
    [h1,h2] = scattermean_plot(groups,gcolor,'Spindle incidence rate (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   783   453])
    set(gca,'ylim',[0 6])
    saveas(h2,[figfold 'boxplot_FCtg_CohFROPARCA1SpindleRipples.tiff'])
    
    %clear
    close all
end
% Fig correlation
load('Corr_OSFC_Coh.mat')

%FRO&CA1 spindle
gcolor = {[0 0 0] [1 0 0] [64 181 29]/255};  
h2 = figure('name','cor1','position',[303   469   374   294]);
hold on,
for gg = 1:3
    plot(contx(group == gg,1),FROCA1spin(group ==gg,1),'ko','markerfacecolor',gcolor{1,gg},'markeredgecolor',gcolor{1,gg},'markersize',5)
    idx = find(group == gg&~isnan(contx)&~isnan(FROCA1spin));
    pg(gg,:) = polyfit(contx(idx,1),FROCA1spin(idx,1),1);
end
idx = find(~isnan(contx)&~isnan(FROCA1spin));
pgall = polyfit(contx(idx,1),FROCA1spin(idx,1),1);
mX = min(contx):max(contx);
mYIN = pg(2,1)*mX+pg(2,2);
mYall = pgall(1,1)*mX+pgall(1,2);
line(mX,mYall,'color',0.5*[1 1 1],'linewidth',1)
line(mX,mYIN,'color',[1 0 0],'linewidth',1)
sdf(h2,'Arial600_12f')
saveas(h2,[figfold 'corr_FCtg_FROCA1Coh.tiff'])

%FRO&CA1 spindle + ripple
gcolor = {[0 0 0] [1 0 0] [64 181 29]/255};  
h2 = figure('name','cor2','position',[303   469   374   294]);
hold on,
for gg = 1:3
    plot(contx(group == gg,1),FROCA1spinRipp(group ==gg,1),'ko','markerfacecolor',gcolor{1,gg},'markeredgecolor',gcolor{1,gg},'markersize',5)
    idx = find(group == gg&~isnan(contx)&~isnan(FROCA1spinRipp));
    pg(gg,:) = polyfit(contx(idx,1),FROCA1spinRipp(idx,1),1);
end
idx = find(~isnan(contx)&~isnan(FROCA1spinRipp));
pgall = polyfit(contx(idx,1),FROCA1spinRipp(idx,1),1);
mX = min(contx):max(contx);
mYIN = pg(2,1)*mX+pg(2,2);
mYall = pgall(1,1)*mX+pgall(1,2);
line(mX,mYall,'color',0.5*[1 1 1],'linewidth',1)
line(mX,mYIN,'color',[1 0 0],'linewidth',1)
sdf(h2,'Arial600_12f')
saveas(h2,[figfold 'corr_FCtg_FROCA1Cohrip.tiff'])


%FRO SO-spindle
gcolor = {[0 0 0] [1 0 0] [64 181 29]/255};  
h2 = figure('name','cor0','position',[303   469   374   294]);
hold on,
for gg = 1:3
    plot(contx(group == gg,1),FROSOSPIN(group ==gg,1),'ko','markerfacecolor',gcolor{1,gg},'markeredgecolor',gcolor{1,gg},'markersize',5)
    idx = find(group == gg&~isnan(contx)&~isnan(FROSOSPIN));
    pg(gg,:) = polyfit(contx(idx,1),FROSOSPIN(idx,1),1);
end
idx = find(~isnan(contx)&~isnan(FROSOSPIN));
pgall = polyfit(contx(idx,1),FROSOSPIN(idx,1),1);
mX = min(contx):max(contx);
mYIN = pg(2,1)*mX+pg(2,2);
mYall = pgall(1,1)*mX+pgall(1,2);
line(mX,mYall,'color',0.5*[1 1 1],'linewidth',1)
line(mX,mYIN,'color',[1 0 0],'linewidth',1)
sdf(h2,'Arial600_12f')
saveas(h2,[figfold 'corr_FCtg_FROSOSPIN.tiff'])


