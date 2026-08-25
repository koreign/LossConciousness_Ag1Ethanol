function run_stat_figPvcreGFPCHR2
close all
clc
savefold = '/Users/Koreign/Documents/0 - IBS/1 - SW Spindles/Data Analysis Remake 201703/Figure FC PvcreGFPCH/';
%for pvcre, 4 groups (GFP-IN-spind, ChR2-IN-spind, GFP-IN-20Hz, ChR2-IN-20Hz, ) - FigS
display('==========    PVcre GFP/CHR2    ===============')
load('Behavior_FCPVcreGFPCHR2.mat')%on mac: IBS-spindle-PVcre remake data
gcolor = {[0.2 0.6 0.8] [0 0 1] [0.1 0.6 0.1] [0 1 0]};
for c = 1:3
    groups = {GFPINspind(:,c) CHR2INspind(:,c) GFPIN20hz(:,c) CHR2IN20hz(:,c)};
    [h1,h2] = scattermean_plot(groups,gcolor,'Freezing %');
    figure(h2),ylim([0 60])
    saveas(h1,[savefold 'scatter_FCcre' num2str(c) '.tiff'])
    saveas(h2,[savefold 'boxplot_FCcre_FigSBehaviorGFPCHR2' num2str(c) '.tiff'])
    %kruskal wallis anova
    A = [GFPINspind(:,c);CHR2INspind(:,c);GFPIN20hz(:,c);CHR2IN20hz(:,c)];
    gr = [ones(1,1);2*ones(8,1);3*ones(5,1);4*ones(5,1)];
    [pk,ktable,kwstats] = kruskalwallis(A,gr,'off');
    pk
    kwstats
    %multicomparison rnaksum
    [p1,~,stats1] = ranksum(GFPINspind(:,c),CHR2INspind(:,c));
    [p2,~,stats2] = ranksum(GFPIN20hz(:,c),CHR2IN20hz(:,c));
    [p3,~,stats3] = ranksum(CHR2INspind(:,c),CHR2IN20hz(:,c));
    [p4,~,stats4] = ranksum(GFPINspind(:,c),GFPIN20hz(:,c));
    
    sumtable = {'vs' 'p' 'rK' 'n1' 'n2';...
        'GFPspinvsCHspin' p1 stats1.ranksum 7 8;...
        'GFP20vsCH20'  p2 stats2.ranksum 7 9;...
        'CHspinvsCH20' p3 stats3.ranksum 7 5;...
        'GFPspinvsGFP20' p4 stats4.ranksum 8 9}
end





clear