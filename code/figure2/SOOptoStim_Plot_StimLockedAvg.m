clear

%% Load data
dirSave = '';
load(strcat(dirSave,'SOOptoStim-StimLockedAvg_EEG_2'));


%% USE THIS!!
arrComp         = [1 2; 1 4; 2 5];                                          % vector containing the comparisons, i.e. IN(1) vs. OUT(2), IN(1) vs. NoSTIM-IN (4) and OUT(2) vs. NoSTIM-OUT(5)

arrColorMean    = {[1 100/255 100/255],         [120/255 220/255 80/255];   % light red vs. light green
                   [1 100/255 100/255],         [0.5 0.5 0.5];              % light red vs. grey
                   [120/255 220/255 80/255],    [0.5 0.5 0.5]};             % light green vs. grey

arrColorSEM     = {[1 0 0],                 [64/255 181/255 29/255];    % red vs. dark-green
                   [1 0 0],                 [0 0 0];                    % red vs. black
                   [64/255 181/255 29/255], [0 0 0]};                   % dark-green vs. black
           
arrYLim         = [-6000 2500; -1250 500; -200 200];                                % array setting the y-limits for each channel

arrYTicks       = {[-4000 -2000 0 2000],    {'-4', '-2', '0', '2'};                 % array setting the y-ticks for each channel
                   [-1000 -500 0 500],      {'-1', '-0.5', '0', '0.5'};
                   [-200 -100 0 100 200],   {'-0.2', '-0.1', '0', '0.1', '2'}};

for iCh = 1 : 3         % loop across FRO, PAR and CA1 channels
   for iComp = 1 : 3    % loop across 3 comparisons (IN vs. OUT, IN vs. NoStim-IN and OUT vs. NoStim-OUT) 
        fig                 = figure();
        fig.PaperUnits      = 'centimeters';
        fig.PaperPosition   = [0 0 3 3];

        % EEG
        ax1 = subplot(3,1,1:2);
        hold on;
        trace1SEM   = plot([resStimAvg{arrComp(iComp,1),iCh}.time'; resStimAvg{arrComp(iComp,1),iCh}.time'],...
                           [resStimAvg{arrComp(iComp,1),iCh}.grandavgMean' + resStimAvg{arrComp(iComp,1),iCh}.grandavgSEM'; resStimAvg{arrComp(iComp,1),iCh}.grandavgMean' - resStimAvg{arrComp(iComp,1),iCh}.grandavgSEM'],...
                           '-', 'LineWidth',0.5,'Color',arrColorSEM{iComp,1});
        trace2SEM   = plot([resStimAvg{arrComp(iComp,2),iCh}.time'; resStimAvg{arrComp(iComp,2),iCh}.time'],...
                           [resStimAvg{arrComp(iComp,2),iCh}.grandavgMean' + resStimAvg{arrComp(iComp,2),iCh}.grandavgSEM'; resStimAvg{arrComp(iComp,2),iCh}.grandavgMean' - resStimAvg{arrComp(iComp,2),iCh}.grandavgSEM'],...
                           '-', 'LineWidth',0.5,'Color',arrColorSEM{iComp,2});
        trace1Mean  = plot(resStimAvg{arrComp(iComp,1),iCh}.time, resStimAvg{arrComp(iComp,1),iCh}.grandavgMean,'LineWidth',1,'Color',arrColorMean{iComp,1});
        trace2Mean  = plot(resStimAvg{arrComp(iComp,2),iCh}.time, resStimAvg{arrComp(iComp,2),iCh}.grandavgMean,'LineWidth',1,'Color',arrColorMean{iComp,2});
        
        hold off;

        uistack(trace2SEM, 'bottom');
        uistack(trace1Mean, 'top');
        uistack(trace2Mean, 'top');

        xlim([-0.4 0.75]);
        set(gca,'XTick',[-0.25 0 0.25 0.5 0.75],'TickDir','out');
        set(gca,'XTickLabel',{'', '', '', '', ''},'FontSize',8);

        ylim(arrYLim(iCh,:));
        set(gca,'YTick',arrYTicks{iCh,1},'TickDir','out');
        set(gca,'YTickLabel',arrYTicks{iCh,2},'FontSize',8);

        % P-values
        ax2 = subplot(3,1,3);

        pVal = stats{iComp,iCh}.pValPerm;
        pValSig = find(pVal < 0.1);
        pVal(pValSig,:) = stats{iComp,iCh}.pVal(pValSig,:);

        stat = area(resStimAvg{1,1}.time,pVal,0.05,'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5]);

        uistack(stat, 'bottom');
        set(gca, 'box', 'off')

        xlim([-0.4 0.75]);
        set(gca,'XTick',[-0.25 0 0.25 0.5 0.75],'TickDir','out');
        set(gca,'XTickLabel',{'', '0', '', '0.5', ''},'FontSize',8);

        ylim([0 0.05]);
        set(gca,'YTick',[0, 0.05],'TickDir','out');
        set(gca,'YTickLabel',{'0', '0.05'},'FontSize',8);
        set(gca,'Ydir','reverse'); 
   end
end

