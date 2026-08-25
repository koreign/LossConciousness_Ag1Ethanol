function nnmax = run_stat_EVPripples%load file located in DataAnalysis Remake 201703

savefolder = '/Users/Koreign/Documents/0 - IBS/1 - SW Spindles/Data Analysis Remake 201703/Avg Traces and peak plot per mice/';
%4 variables
% resStimAvg individual
% resStimavgTable pooled
% resStimPhase individual
% resStimPhaseTable pooled
close all
clc

%rose plot for all conditions (phase circ plot)
load('SOOptoStim-RippleLockedAvg.mat')
title = {'IN-FC' 'OUT-FC' 'OUT-FC-Detect' 'NoStim-FC-IN' 'NoStim-FC-OUT' 'ARC-FC-IN' 'ARC-FC-OUT' 'ARC-FC-OUT-Detect' 'ARC-NoStim-IN' 'ARC-NoStim-OUT'};
gcolor = {[1 0 0] [64 181 29]/255 [16 181 10]/255 [0.5 0.5 0.5] [0.5 0.5 0.5] ...
    [0 0 1] [0.1 0.6 1] [0.1 0.6 1] [0.5 0.5 0.5] [0.5 0.5 0.5]};

for cond = 1:size(resRippleAvg,1)
    for chan = 1
        hf = figure('name',title{1,cond},'position',[440   429   428   369]);
        switch chan
            case 1
               ylim0 = [-3.5 3.5];
            case 2
               ylim0 = [-3 2]; 
            case 3
               ylim0 = [-0.35 0.3];
        end
        
        m = resRippleAvg{cond,chan}.grandavgMean/1000';%average of average/grand average
        mindv = resRippleAvg{cond,chan}.avg/1000';%individual mice average
        sem = resRippleAvg{cond,chan}.grandavgSEM';
        time = resRippleAvg{cond,chan}.time';
        
        %shadedp_in(time,m-sem,m+sem,gcolor{1,cond});
        hold on
        line(time, mindv,'color',gcolor{1,cond},'linewidth',1)
        line(time,m,'color','k','linewidth',2)
        xlim([-0.05 0.05])
        ylim(ylim0)
        set(gca,'xtick',[-0.05 0 0.05],'xticklabel',{'-0.05' '0.0' '0.05'})
        
        %set('Facecolor',gcolor{1,cond},'edgecolor',gcolor{1,cond});
        sdf(hf,'Arial600_12f')
        saveas(hf,[savefolder title{1,cond} 'ripplocked_chan' num2str(chan) '.tiff'])
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


