function run_stats_Behaviorfig1fig6
plotbe = 1;
close all
clc
figfol = '/Users/Koreign/Documents/0 - IBS/1 - SW Spindles/Data Analysis Remake 201703/Figure boxplot remake/';
if plotbe == 1
    %for pvr-mhchR2, 3 groups (IN, OUT, NO) - Fig1e
    display('==========    PVMHCHR2 FC    ===============')
    load('BehaviorFC_PVtg.mat')%on mac: IBS-spindle-PVcre remake data
    gcolor = {[1 0 0] [64 181 29]/255 [0 0 0]};
    for c = 1:3
        groups = {INFCtg(:,c) OUTFCtg(:,c) NOFCtg(:,c)};
        [h1,h2] = scattermean_plot(groups,gcolor,'Freezing %');
        %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
        set(h2,'position',[87   306   335   453])
%         h3 = get(h2,'children');%get gca of boxplot
%         set(h3,'ylim',[0 100])
        figure(h2),ylim([0 100])
        saveas(h2,[figfol 'boxplot_FCtg' num2str(c) '.tiff'])
        %kruskal wallis anova
        %     A = [INFCtg(:,c);OUTFCtg(:,c);NOFCtg(:,c)];
        %     gr = [ones(8,1);2*ones(8,1);3*ones(10,1)];
        %     [pk,ktable,kwstats] = kruskalwallis(A,gr,'off');
        %     kwstats
        %     normality test
        %     [~,pn1,knstats1] = kstest(NOFCtg(:,c))
        %     [~,pn2,knstats2] = kstest(INFCtg(:,c))
        %     [~,pn3,knstats3] = kstest(OUTFCtg(:,c))
        %     multicomparison rnaksum
        %     [p1,~,stats1] = ranksum(INFCtg(:,c),OUTFCtg(:,c));
        %     [p2,~,stats2] = ranksum(NOFCtg(:,c),INFCtg(:,c));
        %     [p3,~,stats3] = ranksum(NOFCtg(:,c),OUTFCtg(:,c));
        %     sumtable = {'vs' 'p' 'rK' 'n1' 'n2';...
        %         'INvsOUT' p1 stats1.ranksum 8 8;...
        %         'NOvsIN'  p2 stats2.ranksum 10 8;...
        %         'NOvsOUT' p3 stats3.ranksum 10 8}
    end
    
    
    
    %for pvr-mhchR2, 3 groups (IN, OUT, NO) - Fig1e
    display('==========    PVMHCHR2 OPR    ===============')
    load('BehaviorOPR_PVtg.mat')%on mac: IBS-spindle-PVcre remake data
    gcolor = {[1 0 0] [0 1 0] [0 0 0]};
    gcolor = {[1 0 0] [64 181 29]/255 [0 0 0]};
    orderc = [4 7];%select pooled sampling exploration(%), and delta% (% point)
    %convert in %
    IN = IN*100;
    OUT = OUT*100;
    NO = NO*100;
    ylimopr = [30 60;-50 60];
    for c = 1:2
        groups = {IN(:,orderc(c)) OUT(:,orderc(c)) NO(:,orderc(c))};
        [h1,h2] = scattermean_plot(groups,gcolor,'Delta preference (%)');
        %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
        figure(h2),ylim(ylimopr(c,:))
        saveas(h2,[figfol 'boxplot_OPRtg' num2str(c) '.tiff'])
        %kruskal wallis anova
        %     A = [IN(:,orderc(c));OUT(:,orderc(c));NO(:,orderc(c))];
        %     gr = [ones(8,1);2*ones(7,1);3*ones(11,1)];
        %     [pk,ktable,kwstats] = kruskalwallis(A,gr,'off');
        %     kwstats
        %     %normality test
        %     [~,pn1,knstats1] = kstest(NO(:,orderc(c)))
        %     [~,pn2,knstats2] = kstest(IN(:,orderc(c)))
        %     [~,pn3,knstats3] = kstest(OUT(:,orderc(c)))
        %     %multicomparison rnaksum
        %     [p1,~,stats1] = ranksum(IN(:,orderc(c)),OUT(:,orderc(c)));
        %     [p2,~,stats2] = ranksum(NO(:,orderc(c)),IN(:,orderc(c)));
        %     [p3,~,stats3] = ranksum(NO(:,orderc(c)),OUT(:,orderc(c)));
        %     sumtable = {'vs' 'p' 'rK' 'n1' 'n2';...
        %                 'INvsOUT' p1 stats1.ranksum 8 8;...
        %                 'NOvsIN'  p2 stats2.ranksum 10 8;...
        %                 'NOvsOUT' p3 stats3.ranksum 10 8}
    end
    
    
    
    %for pvcre, 4 groups (IN-CHR, IN-ARCH, OUT-ARCH, NO) - Fig6a
    display('==========    PVcre IN OUT    ===============')
    load('BehaviorFC_PVcre.mat')%on mac: IBS-spindle-PVcre remake data
    gcolor = {[0 0 1] [0.1 0.6 1] [0 0 0] [1 1 1]};%INCHR [1 0 0] CHR(:,c)
    for c = 1:3
        groups = {ARC(:,c) ARCOUT(:,c) NO(:,c) CHR(:,c)};
        [h1,h2] = scattermean_plot(groups,gcolor,'Freezing %');
        figure(h2)
        set(gcf,'position',[87   306   335   453]),
        ylim([0 50])
        %saveas(h1,[figfol 'scatter_FCcre' num2str(c) '.tiff'])
        saveas(h2,[figfol 'boxplot_FCcre_Fig6Behavior' num2str(c) '.tiff'])
        %kruskal wallis anova
%         A = [CHR(:,c);ARC(:,c);ARCOUT(:,c);NO(:,c)];
%         gr = [ones(7,1);2*ones(8,1);3*ones(7,1);4*ones(9,1)];
%         [pk,ktable,kwstats] = kruskalwallis(A,gr,'off');
%         pk
%         kwstats
%         %normality test
%         [~,pn1,knstats1] = kstest(NO(:,c))
%         [~,pn2,knstats2] = kstest(CHR(:,c))
%         [~,pn3,knstats3] = kstest(ARC(:,c))
%         [~,pn4,knstats4] = kstest(ARCOUT(:,c))
%         %multicomparison rnaksum
%         [p1,~,stats1] = ranksum(CHR(:,c),ARC(:,c));
%         [p2,~,stats2] = ranksum(CHR(:,c),NO(:,c));
%         [p3,~,stats3] = ranksum(CHR(:,c),ARCOUT(:,c));
%         [p4,~,stats4] = ranksum(ARC(:,c),NO(:,c));
%         [p5,~,stats5] = ranksum(ARC(:,c),ARCOUT(:,c));
%         [p6,~,stats6] = ranksum(NO(:,c),ARCOUT(:,c));
%         
%         sumtable = {'vs' 'p' 'rK' 'n1' 'n2';...
%             'CHvsAR' p1 stats1.ranksum 7 8;...
%             'CHvsNO'  p2 stats2.ranksum 7 9;...
%             'CHvsAO' p3 stats3.ranksum 7 5;...
%             'ARvsNO' p4 stats4.ranksum 8 9;...
%             'ARvsAO' p5 stats5.ranksum 8 5;...
%             'NOvsAO' p6 stats6.ranksum 9 5}
%         
%         %multicomparison rnaksum
%         [~,p1,~,stats1] = ttest2(CHR(:,c),ARC(:,c));
%         [~,p2,~,stats2] = ttest2(CHR(:,c),NO(:,c));
%         [~,p3,~,stats3] = ttest2(CHR(:,c),ARCOUT(:,c));
%         [~,p4,~,stats4] = ttest2(ARC(:,c),NO(:,c));
%         [~,p5,~,stats5] = ttest2(ARC(:,c),ARCOUT(:,c));
%         [~,p6,~,stats6] = ttest2(NO(:,c),ARCOUT(:,c));
%         
%         sumtable2 = {'vs' 'p' 't' 'df';...
%             'CHvsAR' p1 stats1.tstat stats1.df;...
%             'CHvsNO'  p2 stats2.tstat stats2.df;...
%             'CHvsAO' p3 stats3.tstat stats3.df;...
%             'ARvsNO' p4 stats4.tstat stats4.df;...
%             'ARvsAO' p5 stats5.tstat stats5.df;...
%             'NOvsAO' p6 stats6.tstat stats6.df}
    end
    
    
    %for pvcre, 2 groups (IN-GFP-20Hz, IN-CHR2-20Hz) - FigS control stim
    display('==========    PVcre IN GFP CHR2 20Hz    ===============')
    load('Behavior_FC_PvcreGFPCHR2_20Hz.mat')%on mac: IBS-spindle-PVcre remake data
    gcolor = {[255 104 0]/255 [255 204 51]/255};
    for c = 1:3
        groups = {GFPIN20hz(:,c) CHR2IN20hz(:,c)};
        [h1,h2] = scattermean_plot(groups,gcolor,'Freezing %');
        figure(h2),ylim([0 60])
        %saveas(h1,['scatter_FCcre' num2str(c) '.tiff'])
        saveas(h2,[figfol 'boxplot_FCcreGFPCHR20Hz_Behavior_' num2str(c) '.tiff'])
        
    end
    
    %for pvcre, 2 groups (IN-GFP-20Hz, IN-CHR2-20Hz) - FigS control stim
    display('==========    PVcre IN GFP CHR2 20Hz    ===============')
    load('FigCTR20Hz.mat')%FRO PAR CA1
    gcolor = {[255 104 0]/255 [255 204 51]/255};
    for c = 1:3
        groups = {GFP20IN(:,c)*100 CHR20IN(:,c)*100};
        [h1,h2] = scattermean_plot(groups,gcolor,'Spindle Incidence %');
        figure(h2),ylim([0 60])
        %saveas(h1,['scatter_FCcre' num2str(c) '.tiff'])
        saveas(h2,[figfol 'boxplot_FCcreGFPCHR20Hz_Spindincidence_' num2str(c) '.tiff'])
        
    end
    clear
end


%% fig 6 pvcre ::arch
figfold = '/Users/Koreign/Documents/0 - IBS/1 - SW Spindles/Data Analysis Remake 201703/Figure boxplot remake/';
display('==========    PVcre::AAV-DIO-ARCH-GFP (OIcreARC) FC spindle incidence   ===============')
load('Fig6c_slow.mat')%FRO PAR CA1
gcolor = {[0 0 1] [0 0 0] [0.1 0.6 1] [0.5 0.5 0.5];[0 0 1] [0 0 0] [0.1 0.6 1] [0.5 0.5 0.5]};
for c = 1:3
    groups = {fig6c_IN(:,c)*100 fig6c_NOIN(:,c)*100 fig6c_OUT(:,c)*100 fig6c_NOOUT(:,c)*100};
    [h1,h2] = scattermean_plot(groups,gcolor,'Spindle incidence rate (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 60])
    saveas(h2,[figfold 'boxplot_FCcreARCH_FIg6_SPinIncidence_' num2str(c) '.tiff'])
end

display('==========    PVcre::AAV-DIO-ARCH-GFP (OIcreARC) FC SO-spindle coupling   ===============')
load('Fig6cc_slow.mat')%FRO PAR CA1
gcolor = {[0 0 1] [0.1 0.6 1] [0 0 0];[0 0 1] [0.1 0.6 1] [0 0 0]};
for c = 1:3
    groups = {fig6cc_IN(:,c)*100 fig6cc_OUT(:,c)*100 fig6cc_NO(:,c)*100};
    [h1,h2] = scattermean_plot(groups,gcolor,'SO-Spindle coupling (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 60])
    saveas(h2,[figfold 'boxplot_FCcreARCH_FIg6_SOspindleCOupling_' num2str(c) '.tiff'])
end

display('==========    PVcre::AAV-DIO-ARCH-GFP (OIcreARC) FC ripple incidence   ===============')
load('Fig6rip.mat')%FRO PAR CA1
gcolor = {[0 0 1] [0 0 0] [0.1 0.6 1] [0.5 0.5 0.5];[0 0 1] [0 0 0] [0.1 0.6 1] [0.5 0.5 0.5]};
    groups = {fig6rip_IN*100 fig6rip_NOIN*100 fig6rip_OUT*100 fig6rip_NOOUT*100};
    [h1,h2] = scattermean_plot(groups,gcolor,'Ripple Incidence (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 60])
    saveas(h2,[figfold 'boxplot_FCcreARCH_FIg6_rippleincidence.tiff'])

display('==========    PVcre::AAV-DIO-ARCH-GFP (OIcreARC) FC Spindle-ripple incidence   ===============')
load('Fig6Srip_slow.mat')%FRO PAR CA1
gcolor = {[0 0 1] [0 0 0] [0.1 0.6 1] [0.5 0.5 0.5];[0 0 1] [0 0 0] [0.1 0.6 1] [0.5 0.5 0.5]};
for c = 1:3
    groups = {fig6Srip_IN(:,c)*100 fig6Srip_NOIN(:,c)*100 fig6Srip_OUT(:,c)*100 fig6Srip_NOOUT(:,c)*100};
    [h1,h2] = scattermean_plot(groups,gcolor,'Spindle-Ripple Incidence (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 30])
    saveas(h2,[figfold 'boxplot_FCcreARCH_FIg6_SpinRippleincidence_' num2str(c) '.tiff'])
end

display('==========    PVcre::AAV-DIO-ARCH-GFP (OIcreARC) FC SO-Spindle-ripple coupling   ===============')
load('Fig6ccc_slow.mat')%FRO PAR CA1
gcolor = {[0 0 1] [0.1 0.6 1] [0 0 0];[0 0 1] [0.1 0.6 1] [0 0 0]};
for c = 1:3
    groups = {fig6ccc_IN(:,c)*100 fig6ccc_OUT(:,c)*100 fig6ccc_NO(:,c)*100};
    [h1,h2] = scattermean_plot(groups,gcolor,'SO-Spindle-Ripple coupling (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 30])
    saveas(h2,[figfold 'boxplot_FCcreARCH_FIg6_SOSpinRipple_' num2str(c) '.tiff'])
end

display('==========    PVcre::AAV-DIO-ARCH-GFP (OIcreARC) FC SO incidence   ===============')
load('Fig6SO.mat')%FRO PAR
gcolor = {[0 0 1] [0 0 0] [0.1 0.6 1] [0.5 0.5 0.5];[0 0 1] [0 0 0] [0.1 0.6 1] [0.5 0.5 0.5]};
for c = 1:2
    groups = {fig6SO_IN(:,c)*100 fig6SO_NOIN(:,c)*100 fig6SO_OUT(:,c)*100 fig6SO_NOOUT(:,c)*100};
    [h1,h2] = scattermean_plot(groups,gcolor,'SO incidence rate (%)');
    %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
    set(h2,'position',[87   306   335   453])
    set(gca,'ylim',[0 55])
    saveas(h2,[figfold 'boxplot_FCcreARCH_FIg6_SOincidence_' num2str(c) '.tiff'])
end