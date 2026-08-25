clear

%% Load data
load('SOOptoStim-RepTraces.mat');
plotspin = 1;

close all
darkgreen = [64/255 181/255 29/255];
if plotspin == 1
    %% IN trace
    INFig = figure('position',[301 166 1024 768]);
    INFig.PaperUnits = 'centimeters';
    INFig.PaperPosition = [0 0 15 3];
    ylimS = [min([IN(:,1);OUT(:,1);NoSTIM(:,1)]) 8000];%[min([IN(:,1);OUT(:,1);NoSTIM(:,1)]) max([IN(:,1);OUT(:,1);NoSTIM(:,1)])];
    ylimSF = [min([IN(:,2);OUT(:,2);NoSTIM(:,2)]) max([IN(:,2);OUT(:,2);NoSTIM(:,2)])];
    
    for sp = 1:3
        switch sp
            case 1
                SP = IN;
            case 2
                SP = OUT;
            case 3
                SP = NoSTIM;
        end
        subplot(9,1,(sp-1)*3+[1:2]);
        plot(1:20000,SP(1:end-1,1),'LineWidth',1,'Color',[0 0 0]);
        hold on
        %
        dfstim = diff([0;SP(:,6);0]);
        sta = find(dfstim == 1);
        sto = find(dfstim == -1)-1;
        switch sp
            case 1
                for ss = 1:length(sta)
                    line([sta(ss) sto(ss)],7000*[1 1],'color','b','linewidth',2)
                    plot(sta(ss),6200,'v','markerfacecolor',darkgreen,'markeredgecolor',darkgreen,'markersize',6)
                end
            case 2
                for ss = 1:length(sta)
                    if mod(ss,2)
                        
                        plot(sta(ss),6200,'v','markerfacecolor',darkgreen,'markeredgecolor',darkgreen,'markersize',6)
                    else
                        line([sta(ss) sto(ss)],7000*[1 1],'color','b','linewidth',2)
                        plot(sta(ss),6200,'v','markerfacecolor','w','markeredgecolor',darkgreen,'markersize',6)
                    end
                end
            case 3
                for ss = 1:length(sta)
                    if mod(ss,2)
                        
                        plot(sta(ss),6200,'v','markerfacecolor',darkgreen,'markeredgecolor',darkgreen,'markersize',6)
                    else
                        plot(sta(ss),6200,'v','markerfacecolor','w','markeredgecolor',darkgreen,'markersize',6)
                    end
                end 
        end
        if sp == 0
        hold on
        line(0*[1 1],[-7000 -2000],'color','k')
        line([0 2000],[-7000 -7000],'color','k')
        end
        ylim([ylimS]);
        set(gca, 'Visible','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
        
        subplot(9,1,(sp-1)*3+3);
        hold on;
        plot(1:20000,SP(1:end-1,2),'LineWidth',1,'Color',[0.5 0.5 0.5]);
        plot([1 20000],[SP(1,4) SP(1,4)],'LineWidth',0.5,'Color',[0 0 0]);
        plot([1 20000],[SP(1,5) SP(1,5)],'LineWidth',0.5,'Color',[0 0 0]);
        %
        %         dfstim = diff([0;SP(:,7);0]);
        %         sta = find(dfstim == 1);
        %         sto = find(dfstim == -1)-1;
        %         for ss = 1:length(sta)
        %             line([sta(ss) sto(ss)],ylimSF(1)*[1 1],'color','r','linewidth',2)%,'linestyle','--')
        %         end
        if sp == 0
            hold on
            line(0*[1 1],[-3000 -1000],'color','k')
            line([0 2000],[-3000 -3000],'color','k')
        end
        xlim([0 20000])
        %hold off;
        ylim([ylimSF]);
        set(gca, 'Visible','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
        
        
        
    end
    tightfig(gcf)
    sdf(gcf,'Arial600_12f')
    saveas(gcf,'SpindleTrace_charles.pdf');
    close(INFig);
end
close all

plotrip = 0;
if plotrip == 1
%% Ripple detection
RippDetectFig = figure();
RippDetectFig.PaperUnits = 'centimeters';
RippDetectFig.PaperPosition = [0 0 5 3];

subplot(2,1,1);
plot(100:350,Ripple2(100:350,1),'LineWidth',1,'Color',[0 0 0]);
ylim([min(Ripple2(:,1)) max(Ripple2(:,1))]);
set(gca, 'Visible','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])

subplot(2,1,2);
hold on;
plot(100:350,Ripple2(100:350,2),'LineWidth',1,'Color',[0.5 0.5 0.5]);
plot(100:350,Ripple2(100:350,3),'LineWidth',1,'Color',[1 0 0]);
range=axis;
plot([range(1) range(2)],[Ripple2(1,4) Ripple2(1,4)],'LineWidth',0.5,'Color',[0 0 0]);
plot([range(1) range(2)],[Ripple2(1,5) Ripple2(1,5)],'LineWidth',0.5,'Color',[0 0 0]);
hold off;
ylim([min(Ripple2(:,2)) max(Ripple2(:,2))]);
set(gca, 'Visible','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])

sdf(gcf,'Arial600_12f')
tightfig(gcf)
saveas(gcf,'RippleDetectTrace_charles.pdf');
%saveas(RippDetectFig,'D:\GoogleDrive\OptoStim\Updated Figures and Text\RepresentativeTraces\RippleDetectTrace','tif');
%close(RippDetectFig);


Ripple0Fig = figure('position',[301 166 1024 768]);
ylimR = [min([Ripple1(:,1);Ripple2(:,1);Ripple3(:,1)]) max([Ripple1(:,1);Ripple2(:,1);Ripple3(:,1)])];
ylimF = [min([Ripple1(:,2);Ripple2(:,2);Ripple3(:,2)]) max([Ripple1(:,2);Ripple2(:,2);Ripple3(:,2)])];
for rp = 1:3
    %% Ripple trace #1
    Ripple0 = eval(['Ripple' num2str(rp)]);
    %Ripple0Fig.PaperUnits = 'centimeters';
    %Ripple0Fig.PaperPosition = [0 0 10 3];
    
    subplot(6,1,(rp-1)*2+1);
    plot(1:2000,Ripple0(1:2000,1),'LineWidth',1,'Color',[0 0 0]);
    ylim(ylimF);
    set(gca, 'Visible','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
%     if rp == 1
%     hold on
%     line(2000*[1 1],[-2000 0],'color','k')
%     line([1900 2000],[-2000 -2000],'color','k')
%     end
    
    subplot(6,1,(rp-1)*2+2);
    hold on;
    plot(1:2000,Ripple0(1:2000,2),'LineWidth',1,'Color',[0.5 0.5 0.5]);
    plot([1 2000],[Ripple0(1,4) Ripple0(1,4)],'LineWidth',0.5,'Color',[0 0 0]);
    plot([1 2000],[Ripple0(1,5) Ripple0(1,5)],'LineWidth',0.5,'Color',[0 0 0]);
    if rp == 1
    hold on
    line(2000*[1 1],[-2000 0],'color','k')
    line([1900 2000],[-2000 -2000],'color','k')
    end
    hold off;
    ylim([ylimF]);
    set(gca, 'Visible','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
    
    %close(Ripple0Fig);
end
tightfig(gcf)
sdf(Ripple0Fig,'Arial600_12f')
saveas(Ripple0Fig,['RippleTrace_merged_charles_scale.pdf']);
end
