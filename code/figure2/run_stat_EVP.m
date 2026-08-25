function nnmax = run_stat_EVP%load file located in DataAnalysis Remake 201703

savefolder = '/Users/Koreign/Documents/0 - IBS/1 - SW Spindles/Data Analysis Remake 201703/Figure EVP/';
%4 variables
% resStimAvg individual
% resStimavgTable pooled
% resStimPhase individual
% resStimPhaseTable pooled
close all
clc

%rose plot for all conditions (phase circ plot)
load('SOOptoStim-StimLockedAvg_2.mat')
title = {'IN-FC' 'OUT-FC' 'OUT-FC-Detect' 'NoStim-FC-IN' 'NoStim-FC-OUT' 'ARC-FC-IN' 'ARC-FC-OUT' 'ARC-FC-OUT-Detect' 'ARC-NoStim-IN' 'ARC-NoStim-OUT'};
gcolor = {[1 0 0] [64 181 29]/255 [16 181 10]/255 [0.5 0.5 0.5] [0.5 0.5 0.5] ...
    [0 0 1] [0.1 0.6 1] [0.1 0.6 1] [0.5 0.5 0.5] [0.5 0.5 0.5]};

for cond = 1:size(resStimAvg,1)
    for chan = 1:3
        hf = figure('name',title{1,cond});
        switch chan
            case 1
               ylim0 = [-9 5];
            case 2
               ylim0 = [-3 2]; 
            case 3
               ylim0 = [-0.35 0.3];
        end
        
        m = resStimAvg{cond,chan}.grandavgMean/1000';%average of average/grand average
        mindv = resStimAvg{cond,chan}.avg/1000';%individual mice average
        sem = resStimAvg{cond,chan}.grandavgSEM';
        time = resStimAvg{cond,chan}.time';
        
        %shadedp_in(time,m-sem,m+sem,gcolor{1,cond});
        hold on
        line(time, mindv,'color',gcolor{1,cond},'linewidth',1)
        line(time,m,'color','k','linewidth',4)
        xlim([time(1) time(end)])
        ylim(ylim0)
        set(gca,'xtick',[-0.25 0 0.25 0.5 0.75],'xticklabel',{' ' '0.0' ' ' '0.5' ' '})
        
        %set('Facecolor',gcolor{1,cond},'edgecolor',gcolor{1,cond});
        sdf(hf,'Arial600_12f')
        saveas(hf,[savefolder title{1,cond} '_chan' num2str(chan) '.tiff'])
    end
    
    
    
end
close all

function shadedp_in(x,y1,y2,colorc,alpha0)
y = [y1; (y2-y1)]'; 
ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha(2), 'FaceColor', colorc)
set(ha, 'LineStyle', 'none')
if nargin == 5
    alpha(alpha0)
end


