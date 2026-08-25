function run_stats_SpiTrhough_CA1ripple
%need to separate OPR form FC
close all
clc

figfold = '/Users/Koreign/Documents/0 - IBS/1 - SW Spindles/Data Analysis Remake 201703/FigureS5 - 20170503 Hongi/';

%% Fig S6 Spindle trhugh- ripple nesting (bar-box)
plotopt = 1;
reglabel = {'FRO' 'PAR' 'CA1'};
if plotopt == 1
    %Coherent Incidence
    display('==========    PVMHCHR2 FC spi tr CA1 rip  ===============')
    load('SpiTrhough_CA1ripple.mat')
    gcolor = {[1 0.69 0.39] [1 0 0] [1 0.69 0.39] [1 1 1] 0.5*[1 1 1] [0 0 0] 0.5*[1 1 1] [1 1 1] [0.4 1 0.6] [64 181 29]/255 [0.4 1 0.6] [1 1 1] 0.5*[1 1 1] [0 0 0] 0.5*[1 1 1]};
    %grouping
    idxIN = find(FRO(:,4) == 2);
    idxOUT = find(FRO(:,4) == 3);
    idxNOIN = find(FRO(:,4) == 1);
    idxNOOUT = find(FRO(:,4) == 4);
    
    for reg = 1:3 %FRO PAR CA1
        switch reg
            case 1
                A = FRO*100;
            case 2
                A = PAR*100;
            case 3
                A = CA1*100;
        end
        groups = {A(idxIN,1) A(idxIN,2) A(idxIN,3) -1 A(idxNOIN,1) A(idxNOIN,2) A(idxNOIN,3) -1 A(idxOUT,1) A(idxOUT,2) A(idxOUT,3) -1 A(idxNOOUT,1) A(idxNOOUT,2) A(idxNOOUT,3)};
        [h1,h2] = scattermean_plot(groups,gcolor,' ');
        %     saveas(h1,['scatter_FCtg' num2str(c) '.tiff'])
        set(h2,'position',[186   310   522   477])
        set(gca,'ylim',[0 4.5])
        saveas(h2,[figfold 'boxplot_FCtg_S5_' reglabel{1,reg} '.tiff'])
        
        
    end
    
end



