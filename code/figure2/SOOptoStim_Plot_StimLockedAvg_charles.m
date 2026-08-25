clear
close all
%% Load data
dirSave = '';
load(strcat(dirSave,'SOOptoStim-StimLockedAvg_EEG_2'));


%% USE THIS!!
arrComp         = [1 2; 1 4; 2 5];                                          % vector containing the comparisons, i.e. IN(1) vs. OUT(2), IN(1) vs. NoSTIM-IN (4) and OUT(2) vs. NoSTIM-OUT(5)

arrColorMean    = {[1 100/255 100/255],         [120/255 220/255 80/255];   % light red vs. light green
                   [1 100/255 100/255],         [0.5 0.5 0.5];              % light red vs. grey
                   [120/255 220/255 80/255],    [0.5 0.5 0.5]};             % light green vs. grey
               
% arrColorMean    = {[0 0 0],         [0 0 0];   % light red vs. light green
%                    [0 0 0],         [1 1 1];              % light red vs. grey
%                    [0 0 0],         [1 1 1]};             % light green vs. grey

arrColorSEM     = {[1 0 0],                 [64/255 181/255 29/255];    % red vs. dark-green
                   [1 0 0],                 [0 0 0];                    % red vs. black
                   [64/255 181/255 29/255], [0 0 0]};                   % dark-green vs. black
           
arrYLim         = [-5000 2500; -1250 500; -150 200];                                % array setting the y-limits for each channel

arrYTicks       = {[-4000 -2000 0 2000],    {'-4', '-2', '0', '2'};                 % array setting the y-ticks for each channel
                   [-1000 -500 0 500],      {'-1', '-0.5', '0', '0.5'};
                   [-200 -100 0 100 200],   {'-0.2', '-0.1', '0', '0.1', '2'}};
chlabel = {'FRO' 'PAR' 'CA1'};

               
for iCh = 1 : 3         % loop across FRO, PAR and CA1 channels
   for iComp = 1 : 3    % loop across 3 comparisons (IN vs. OUT, IN vs. NoStim-IN and OUT vs. NoStim-OUT) 
        hfig                 = figure();
        %fig.PaperUnits      = 'centimeters';
        %fig.PaperPosition   = [0 0 3 3];

        % EEG
        ax1 = subplot(4,1,1:3);
        hold on;
        trace1SEM   = plot([resStimAvg{arrComp(iComp,1),iCh}.time'; resStimAvg{arrComp(iComp,1),iCh}.time'],...
                           [resStimAvg{arrComp(iComp,1),iCh}.grandavgMean' + resStimAvg{arrComp(iComp,1),iCh}.grandavgSEM'; resStimAvg{arrComp(iComp,1),iCh}.grandavgMean' - resStimAvg{arrComp(iComp,1),iCh}.grandavgSEM'],...
                           '-', 'LineWidth',0.5,'Color',arrColorSEM{iComp,1});
        trace2SEM   = plot([resStimAvg{arrComp(iComp,2),iCh}.time'; resStimAvg{arrComp(iComp,2),iCh}.time'],...
                           [resStimAvg{arrComp(iComp,2),iCh}.grandavgMean' + resStimAvg{arrComp(iComp,2),iCh}.grandavgSEM'; resStimAvg{arrComp(iComp,2),iCh}.grandavgMean' - resStimAvg{arrComp(iComp,2),iCh}.grandavgSEM'],...
                           '-', 'LineWidth',0.5,'Color',arrColorSEM{iComp,2});
        trace1Mean  = plot(resStimAvg{arrComp(iComp,1),iCh}.time, resStimAvg{arrComp(iComp,1),iCh}.grandavgMean,'LineWidth',2,'Color',arrColorMean{iComp,1});
        trace2Mean  = plot(resStimAvg{arrComp(iComp,2),iCh}.time, resStimAvg{arrComp(iComp,2),iCh}.grandavgMean,'LineWidth',2,'Color',arrColorMean{iComp,2});
        
%         shadedp(resStimAvg{arrComp(iComp,1),iCh}.time,...
%             resStimAvg{arrComp(iComp,1),iCh}.grandavgMean' - resStimAvg{arrComp(iComp,1),iCh}.grandavgSEM',...
%             resStimAvg{arrComp(iComp,1),iCh}.grandavgMean' + resStimAvg{arrComp(iComp,1),iCh}.grandavgSEM',arrColorSEM{iComp,1},1)
%         shadedp(resStimAvg{arrComp(iComp,2),iCh}.time,...
%             resStimAvg{arrComp(iComp,2),iCh}.grandavgMean' - resStimAvg{arrComp(iComp,2),iCh}.grandavgSEM',...
%             resStimAvg{arrComp(iComp,2),iCh}.grandavgMean' + resStimAvg{arrComp(iComp,2),iCh}.grandavgSEM',arrColorSEM{iComp,2},1)
%         trace1Mean  = plot(resStimAvg{arrComp(iComp,1),iCh}.time, resStimAvg{arrComp(iComp,1),iCh}.grandavgMean,'LineWidth',1,'Color',arrColorMean{iComp,1});
%         trace2Mean  = plot(resStimAvg{arrComp(iComp,2),iCh}.time, resStimAvg{arrComp(iComp,2),iCh}.grandavgMean,'LineWidth',1,'Color',arrColorMean{iComp,2});
        line([0 0],arrYLim(iCh,:),'color','k','linestyle','--','linewidth',2)
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
        if iCh ==0
            ylabel('mV')
        end
        
        set(gca,'LineWidth',2,'xcolor',[0.5 0.5 0.5],'ycolor',[0.5 0.5 0.5]);
        % P-values
        ax2 = subplot(4,1,4);

        pVal = stats{iComp,iCh}.pValPerm;
        pValSig = find(pVal < 0.1);
        pVal(pValSig,:) = stats{iComp,iCh}.pVal(pValSig,:);
        

        stat = area(resStimAvg{1,1}.time,pVal,0.05,'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5]);

        uistack(stat, 'bottom');
        set(gca, 'box', 'off')

        xlim([-0.4 0.75]);
        set(gca,'XTick',[-0.25 0 0.25 0.5 0.75],'TickDir','out');
        set(gca,'XTickLabel',{'', '0.0', '', '0.5', ''},'FontSize',8);

        ylim([0 0.05]);
        set(gca,'YTick',[0, 0.05],'TickDir','out');
        set(gca,'YTickLabel',{'0.00', '0.05'},'FontSize',8);
        set(gca,'Ydir','reverse'); 
        set(gca,'LineWidth',2,'xcolor',[0.5 0.5 0.5],'ycolor',[0.5 0.5 0.5]);
        if iCh ==0
            ylabel('P')
        end
        sdf(hfig,'Helvetica600_40f')
        tightfig(hfig)
        saveas(hfig,[chlabel{1,iCh} '_' num2str(iComp) '.tif'])
   end
end


% %% FRO IN vs. OUT
% FROINOUTFig = figure();
% FROINOUTFig.PaperUnits = 'centimeters';
% FROINOUTFig.PaperPosition = [0 0 3 3];
% 
% % EEG
% ax1 = subplot(3,1,1:2);
% hold on;
% INSEM   = plot([resStimAvg{1,1}.time'; resStimAvg{1,1}.time'], [resStimAvg{1,1}.grandavgMean' + resStimAvg{1,1}.grandavgSEM'; resStimAvg{1,1}.grandavgMean' - resStimAvg{1,1}.grandavgSEM'], '-', 'LineWidth',0.5,'Color',[1 0 0]);
% OUTSEM  = plot([resStimAvg{2,1}.time'; resStimAvg{2,1}.time'], [resStimAvg{2,1}.grandavgMean' + resStimAvg{2,1}.grandavgSEM'; resStimAvg{2,1}.grandavgMean' - resStimAvg{2,1}.grandavgSEM'], '-', 'LineWidth',0.5,'Color',[64/255 181/255 29/255]);
% IN      = plot(resStimAvg{1,1}.time, resStimAvg{1,1}.grandavgMean,'LineWidth',1,'Color',[1 100/255 100/255]);
% OUT     = plot(resStimAvg{2,1}.time, resStimAvg{2,1}.grandavgMean,'LineWidth',1,'Color',[120/255 220/255 80/255]);
% hold off;
% 
% uistack(IN, 'top');
% uistack(OUT, 'top');
% 
% xlim([-0.4 0.75]);
% set(gca,'XTick',[-0.25 0 0.25 0.5 0.75],'TickDir','out');
% set(gca,'XTickLabel',{'', '', '', '', ''},'FontSize',8);
% 
% ylim([-5000 2500]);
% set(gca,'YTick',[-4000 -2000 0 2000],'TickDir','out');
% set(gca,'YTickLabel',{'-4', '-2', '0', '2'},'FontSize',8);
% 
% % P-values
% ax2 = subplot(3,1,3);
% 
% pVal = stats{1,1}.pValPerm;
% pValSig = find(pVal < 0.05);
% pVal(pValSig,:) = stats{1,1}.pVal(pValSig,:);
% 
% stat = area(resStimAvg{1,1}.time,pVal,0.05,'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5]);
% 
% uistack(stat, 'bottom');
% set(gca, 'box', 'off')
% 
% xlim([-0.4 0.75]);
% set(gca,'XTick',[-0.25 0 0.25 0.5 0.75],'TickDir','out');
% set(gca,'XTickLabel',{'', '0', '', '0.5', ''},'FontSize',8);
% 
% ylim([0 0.05]);
% set(gca,'YTick',[0, 0.05],'TickDir','out');
% set(gca,'YTickLabel',{'0', '0.05'},'FontSize',8);
% set(gca,'Ydir','reverse');
% 
% % size of first subplot
% % size1 = get(ax1,'position');
% % size2 = get(ax2,'position');
% % 
% % size1(1,1) = size1(1,1)+0.118;
% % size1(1,3) = size1(1,3)-0.12;
% % set(ax1,'position',size1);
% 
% print(strcat(dirSave,'SOOptoStim-StimLockedAvg-FROInOut'),'-dtiff','-r600');
% close(FROINOUTFig);
% 
% 
% %% FRO IN vs. NoStim-IN
% FROINNoSTIMFig = figure();
% FROINNoSTIMFig.PaperUnits = 'centimeters';
% FROINNoSTIMFig.PaperPosition = [0 0 3 3];
% 
% % EEG
% ax1 = subplot(3,1,1:2);
% hold on;
% INSEM       = plot([resStimAvg{1,1}.time'; resStimAvg{1,1}.time'], [resStimAvg{1,1}.grandavgMean' + resStimAvg{1,1}.grandavgSEM'; resStimAvg{1,1}.grandavgMean' - resStimAvg{1,1}.grandavgSEM'], '-', 'LineWidth',0.5,'Color',[1 0 0]);
% NoSTIMSEM   = plot([resStimAvg{4,1}.time'; resStimAvg{4,1}.time'], [resStimAvg{4,1}.grandavgMean' + resStimAvg{4,1}.grandavgSEM'; resStimAvg{4,1}.grandavgMean' - resStimAvg{4,1}.grandavgSEM'], '-', 'LineWidth',0.5,'Color',[0 0 0]);
% IN          = plot(resStimAvg{1,1}.time, resStimAvg{1,1}.grandavgMean,'LineWidth',1,'Color',[1 100/255 100/255]);
% NoSTIM      = plot(resStimAvg{4,1}.time, resStimAvg{4,1}.grandavgMean,'LineWidth',1,'Color',[0.5 0.5 0.5]);
% hold off;
% 
% uistack(IN, 'top');
% uistack(NoSTIM, 'top');
% 
% xlim([-0.4 0.75]);
% set(gca,'XTick',[-0.25 0 0.25 0.5 0.75],'TickDir','out');
% set(gca,'XTickLabel',{'', '', '', '', ''},'FontSize',8);
% 
% ylim([-5000 2500]);
% set(gca,'YTick',[-4000 -2000 0 2000],'TickDir','out');
% set(gca,'YTickLabel',{'-4', '-2', '0', '2'},'FontSize',8);
% 
% % P-values
% ax2 = subplot(3,1,3);
% 
% pVal = stats{2,1}.pValPerm;
% pValSig = find(pVal < 0.05);
% pVal(pValSig,:) = stats{2,1}.pVal(pValSig,:);
% 
% stat = area(resStimAvg{1,1}.time,pVal,0.05,'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5]);
% 
% uistack(stat, 'bottom');
% set(gca, 'box', 'off')
% 
% xlim([-0.4 0.75]);
% set(gca,'XTick',[-0.25 0 0.25 0.5 0.75],'TickDir','out');
% set(gca,'XTickLabel',{'', '0', '', '0.5', ''},'FontSize',8);
% 
% ylim([0 0.05]);
% set(gca,'YTick',[0, 0.05],'TickDir','out');
% set(gca,'YTickLabel',{'0', '0.05'},'FontSize',8);
% set(gca,'Ydir','reverse');
% 
% % size of first subplot
% % size1 = get(ax1,'position');
% % size2 = get(ax2,'position');
% % 
% % size1(1,1) = size1(1,1)+0.118;
% % size1(1,3) = size1(1,3)-0.12;
% % set(ax1,'position',size1);
% 
% % print(strcat(dirSave,'SOOptoStim-StimLockedAvg-FROInOut'),'-dtiff','-r600');
% % close(FROINNoSTIMFig);
% 
% %% FRO OUT vs. NoStim-OUT
% FROOUTNoSTIMFig = figure();
% FROOUTNoSTIMFig.PaperUnits = 'centimeters';
% FROOUTNoSTIMFig.PaperPosition = [0 0 3 3];
% 
% % EEG
% ax1 = subplot(3,1,1:2);
% hold on;
% OUTSEM       = plot([resStimAvg{2,1}.time'; resStimAvg{2,1}.time'], [resStimAvg{2,1}.grandavgMean' + resStimAvg{2,1}.grandavgSEM'; resStimAvg{2,1}.grandavgMean' - resStimAvg{2,1}.grandavgSEM'], '-', 'LineWidth',0.5,'Color',[64/255 181/255 29/255]);
% NoSTIMSEM   = plot([resStimAvg{5,1}.time'; resStimAvg{5,1}.time'], [resStimAvg{5,1}.grandavgMean' + resStimAvg{5,1}.grandavgSEM'; resStimAvg{5,1}.grandavgMean' - resStimAvg{5,1}.grandavgSEM'], '-', 'LineWidth',0.5,'Color',[0 0 0]);
% OUT          = plot(resStimAvg{2,1}.time, resStimAvg{2,1}.grandavgMean,'LineWidth',1,'Color',[120/255 220/255 80/255]);
% NoSTIM      = plot(resStimAvg{5,1}.time, resStimAvg{5,1}.grandavgMean,'LineWidth',1,'Color',[0.5 0.5 0.5]);
% hold off;
% 
% uistack(OUT, 'top');
% uistack(NoSTIM, 'top');
% 
% xlim([-0.4 0.75]);
% set(gca,'XTick',[-0.25 0 0.25 0.5 0.75],'TickDir','out');
% set(gca,'XTickLabel',{'', '', '', '', ''},'FontSize',8);
% 
% ylim([-5000 2500]);
% set(gca,'YTick',[-4000 -2000 0 2000],'TickDir','out');
% set(gca,'YTickLabel',{'-4', '-2', '0', '2'},'FontSize',8);
% 
% % P-values
% ax2 = subplot(3,1,3);
% 
% pVal = stats{3,1}.pValPerm;
% pValSig = find(pVal < 0.05);
% pVal(pValSig,:) = stats{3,1}.pVal(pValSig,:);
% 
% stat = area(resStimAvg{1,1}.time,pVal,0.05,'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5]);
% 
% uistack(stat, 'bottom');
% set(gca, 'box', 'off')
% 
% xlim([-0.4 0.75]);
% set(gca,'XTick',[-0.25 0 0.25 0.5 0.75],'TickDir','out');
% set(gca,'XTickLabel',{'', '0', '', '0.5', ''},'FontSize',8);
% 
% ylim([0 0.05]);
% set(gca,'YTick',[0, 0.05],'TickDir','out');
% set(gca,'YTickLabel',{'0', '0.05'},'FontSize',8);
% set(gca,'Ydir','reverse');
% 
