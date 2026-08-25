clear

%% Load data
dirSave = '';
load(strcat(dirSave,'SOOptoStim-StimLockedAvg_EEG_2'));


%% FRO IN vs. OUT
FROINOUTFig = figure();
FROINOUTFig.PaperUnits = 'centimeters';
FROINOUTFig.PaperPosition = [0 0 3 3];

% EEG
ax1 = subplot(3,1,1:2);
hold on;
INSEM   = plot([resStimAvg{1,1}.time'; resStimAvg{1,1}.time'], [resStimAvg{1,1}.grandavgMean' + resStimAvg{1,1}.grandavgSEM'; resStimAvg{1,1}.grandavgMean' - resStimAvg{1,1}.grandavgSEM'], '-', 'LineWidth',0.5,'Color',[1 0 0]);
OUTSEM  = plot([resStimAvg{2,1}.time'; resStimAvg{2,1}.time'], [resStimAvg{2,1}.grandavgMean' + resStimAvg{2,1}.grandavgSEM'; resStimAvg{2,1}.grandavgMean' - resStimAvg{2,1}.grandavgSEM'], '-', 'LineWidth',0.5,'Color',[64/255 181/255 29/255]);
IN      = plot(resStimAvg{1,1}.time, resStimAvg{1,1}.grandavgMean,'LineWidth',1,'Color',[1 100/255 100/255]);
OUT     = plot(resStimAvg{2,1}.time, resStimAvg{2,1}.grandavgMean,'LineWidth',1,'Color',[120/255 220/255 80/255]);
hold off;

uistack(IN, 'top');
uistack(OUT, 'top');

xlim([-0.4 0.75]);
set(gca,'XTick',[-0.25 0 0.25 0.5 0.75],'TickDir','out');
set(gca,'XTickLabel',{'', '', '', '', ''},'FontSize',8);

ylim([-5000 2500]);
set(gca,'YTick',[-4000 -2000 0 2000],'TickDir','out');
set(gca,'YTickLabel',{'-4', '-2', '0', '2'},'FontSize',8);

% P-values
ax2 = subplot(3,1,3);

pVal = stats{1,1}.pValPerm;
pValSig = find(pVal < 0.05);
pVal(pValSig,:) = stats{1,1}.pVal(pValSig,:);

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

% size of first subplot
% size1 = get(ax1,'position');
% size2 = get(ax2,'position');
% 
% size1(1,1) = size1(1,1)+0.118;
% size1(3,1) = size1(3,1)- 0.1;
% set(ax1,'position',size1);
% 
% size2(3,1) = size2(3,1) + 0.2;
% set(ax2,'position',size2);
sdf(gcf,'Arial600_12f')
saveas(gcf,'test2.pdf')
%print(strcat(dirSave,'SOOptoStim-StimLockedAvg-FROInOut2'),'-dtiff','-r600');
close(FROINOUTFig);



