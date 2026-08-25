clear

%% Load data
dirSave = '';
load(strcat(dirSave,'SOOptoStim-SpiTrLocked-CA1Ripple-EvtCorr-SlSpiEvts'));


%% USE THIS!!
arrComp         = [1 2; 1 4; 2 5];                                          % vector containing the comparisons, i.e. IN(1) vs. OUT(2), IN(1) vs. NoSTIM-IN (4) and OUT(2) vs. NoSTIM-OUT(5)

arrColorSEM    = {[1 100/255 100/255],         [120/255 220/255 80/255];   % light red vs. light green
                   [1 100/255 100/255],         [0.5 0.5 0.5];              % light red vs. grey
                   [120/255 220/255 80/255],    [0.5 0.5 0.5]};             % light green vs. grey

arrColorMean     = {[1 0 0],                 [64/255 181/255 29/255];    % red vs. dark-green
                   [1 0 0],                 [0 0 0];                    % red vs. black
                   [64/255 181/255 29/255], [0 0 0]};                   % dark-green vs. black
           
arrYLim         = [0 2; 0 2; 0 2];                                % array setting the y-limits for each channel

arrYTicks       = {[0 1 2], {'0', '1', '2'};                 % array setting the y-ticks for each channel
                   [0 1 2], {'0', '1', '2'};
                   [0 1 2], {'0', '1', '2'}};
chlabel = {'FRO' 'PAR' 'CA1'};
for iCh = 1 : 3      % loop across FRO, PAR and CA1 channels
   for iComp = 1 : 3    % loop across 3 comparisons (IN vs. OUT, IN vs. NoStim-IN and OUT vs. NoStim-OUT) 
        fig                 = figure();
        %fig.PaperUnits      = 'centimeters';
        %fig.PaperPosition   = [0 0 3 4];

        % EEG-trace 1
        ax1 = subplot(5,1,1:2);
        hold on;
        trace1SEM   = area(resSpiTrRippleAvg{arrComp(iComp,1),iCh}.time(1:end-1,1),...
                           (resSpiTrRippleAvg{arrComp(iComp,1),iCh}.grandavgMean + resSpiTrRippleAvg{arrComp(iComp,1),iCh}.grandavgSEM)*100,...
                           'FaceColor',arrColorSEM{iComp,1},'EdgeColor',arrColorSEM{iComp,1});
        trace1Mean  = area(resSpiTrRippleAvg{arrComp(iComp,1),iCh}.time(1:end-1,1), resSpiTrRippleAvg{arrComp(iComp,1),iCh}.grandavgMean*100,'FaceColor',arrColorMean{iComp,1},'EdgeColor',arrColorMean{iComp,1});               
        hold off;

        uistack(trace1Mean, 'top');

        xlim([-0.5 0.5]);
        set(gca,'XTick',[-0.5 -0.25 0 0.25 0.5],'TickDir','out');
        set(gca,'XTickLabel',{'', '', '', '', '', ''},'FontSize',8);
        
        ylim(arrYLim(iCh,:));
        set(gca,'YTick',arrYTicks{iCh,1},'TickDir','out');
        set(gca,'YTickLabel',arrYTicks{iCh,2},'FontSize',8);
        set(gca,'LineWidth',2,'xcolor',[0.5 0.5 0.5],'ycolor',[0.5 0.5 0.5]);
        
        % EEG-trace 2
        ax2 = subplot(5,1,3:4);
        hold on;
        trace2SEM   = area(resSpiTrRippleAvg{arrComp(iComp,2),iCh}.time(1:end-1,1),...
                           (resSpiTrRippleAvg{arrComp(iComp,2),iCh}.grandavgMean + resSpiTrRippleAvg{arrComp(iComp,2),iCh}.grandavgSEM)*100,...
                           'FaceColor',arrColorSEM{iComp,2},'EdgeColor',arrColorSEM{iComp,2});
        trace2Mean  = area(resSpiTrRippleAvg{arrComp(iComp,2),iCh}.time(1:end-1,1), resSpiTrRippleAvg{arrComp(iComp,2),iCh}.grandavgMean*100,'FaceColor',arrColorMean{iComp,2},'EdgeColor',arrColorMean{iComp,2});
        hold off;

        uistack(trace2Mean, 'top');

        xlim([-0.5 0.5]);
        set(gca,'XTick',[-0.5 -0.25 0 0.25 0.5],'TickDir','out');
        set(gca,'XTickLabel',{'', '', '', '', '', ''},'FontSize',8);

        ylim(arrYLim(iCh,:));
        set(gca,'YTick',arrYTicks{iCh,1},'TickDir','out');
        set(gca,'YTickLabel',arrYTicks{iCh,2},'FontSize',8);
        set(gca,'LineWidth',2,'xcolor',[0.5 0.5 0.5],'ycolor',[0.5 0.5 0.5]);
        % P-values
        ax3 = subplot(5,1,5);

        pVal = stats{iComp,iCh}.pValPerm;
        pValSig = find(pVal < 0.05);
        pVal(pValSig,:) = stats{iComp,iCh}.pVal(pValSig,:);

        stat = bar(resSpiTrRippleAvg{1,1}.time(1:end-1,1),pVal,'BaseValue',0.05,'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5]);

        uistack(stat, 'bottom');
        set(gca, 'box', 'off')

        xlim([-0.5 0.5]);
        set(gca,'XTick',[-0.5 -0.25 0 0.25 0.5],'TickDir','out');
        set(gca,'XTickLabel',{'-0.5', '-0.25', '0', '0.25', '0.5'},'FontSize',8);

        ylim([0 0.05]);
        set(gca,'YTick',[0, 0.05],'TickDir','out');
        set(gca,'YTickLabel',{'0.00', '0.05'},'FontSize',8);
        set(gca,'Ydir','reverse'); 
        set(gca,'LineWidth',2,'xcolor',[0.5 0.5 0.5],'ycolor',[0.5 0.5 0.5]);
        
        %manage subplot spacing
        ax1p = get(ax1,'position');
        ax2p = get(ax2,'position');
        ax3p = get(ax3,'position');
        set(ax2,'Position',[ax2p(1) ax1p(2)-.1-ax2p(4) ax2p(3:end)]) %using position of subplot1 put subplot2next to it.  
        set(ax3,'Position',[ax3p(1) ax2p(2)-.1-ax3p(4) ax3p(3:end)]) %using position of subplot1 put subplot2next to it.  
        xlabel('s')
        
        set(gcf,'position',[439   275   600   470])
        sdf(gcf,'Helvetica600_30f')
        tightfig(gcf)
        saveas(gcf,[chlabel{1,iCh} '_' num2str(iComp) '.pdf'])
   end
end

