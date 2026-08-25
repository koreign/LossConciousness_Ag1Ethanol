function SWdetection_arduino4Blue(a,stimtype,syscom)
% Dr. C latchoumane, v4
% Online SW detection
% features:
% 1. count detection and return current samplinf freq
% 2. SW detection + 2sec deactivate (+LED ON)
% 3. auto deactivate during high emg / high eeg amplitude (5sec + LED ON)
%
% the function only returns a TTL for detection
% a=arduino('COM4');or
% a = ArduinoSystemCheck('COM4',1);

time = 1:320;
timets = zeros(1,length(time));
L = length(time);
memo = zeros(2,length(time));%memo channel acquisition
fmemo = zeros(1,length(time));%emag temp summation
fsmemo = zeros(1,length(time));%memo of freq sampling average
event= memo(1,:);

basethre = [350 50 50];
emgthre0 = 50;%max for emg inactivity (sometimes needs 50 for sys2 blue)
thre0 = basethre(1);
thre = thre0;

%detection signal and TTL
flagdetect = 1;
C0 = tic;%cputime;
Cstar = C0;

TTLLED = 12;
TTLMS8 = 7;%used to be 13
TTLNLX = 8;
a.pinMode(TTLLED,'output');%LED for deactivation signaling
a.pinMode(TTLMS8,'output');%TTL for detection (NLX + MASTER8)
a.pinMode(TTLNLX,'output');%TTL for detection (NLX only)

%option to alternate detection only (pin8)/detection + laser (pin13/7)
%0: (IN) Detection + Laser, 1: Detect+Laser Alternate, 2: Detection
%NOlaser, 3: (OUT) Detection + Laser
stimlabel = {'IN' 'IN-ALT' 'DET ONLY' 'OUT'};
optionONOFF = stimtype;
flagONOFF = 0;
flagOUT = 0;

%plotting parameters
fs = 64;
mmmemo = [255 0];%minmax sensor for calibration
mmmemo = [0 1023];%minmax sensor for calibration
rmean = 50;

%power spectrum
nfft = 256;
fx = fs/2*linspace(0,1,nfft/2+1);
%[~,fx] = periodogram(detrend(dataArray2),hamming(length(dataArray2)),nfft,Fs);
Pxx0 = zeros(sum(fx<=20),length(memo));

%detection counter
count = 0;
DurDisable = 2;%original disabling time (after detection)

        figurename = ['Blue System on ' num2str(syscom) ',STIM=' stimlabel{1,stimtype+1}];
        colorf = 'b';
        syscolorname = 'BLUE';

hf = figure('name',figurename);
%hui = uicontrol(hf,'style','edit');
,pause,
while (double(get(gcf,'CurrentCharacter'))~=27),
    %for i = 1:10000
    sCs = tic;
    a0 = analogRead(a,0);
    a1 = analogRead(a,1)/10;%range = 0-1023->10 = 0-102
    %a2 = analogRead(a,2);
    %a3 = analogRead(a,3)/10;%range = 0-1023->10 = 0-102
    soCs = toc(sCs);
    
    memo(:,1:end-1) = memo(:,2:end);%store previous memory
    fmemo(:,1:end-1) = fmemo(:,2:end);%store previous memory
    event(1,1:end-1) = event(1,2:end);%store previous memory
    timets(1,1:end-1) = timets(1,2:end);%store time stamps
    
    fsmemo(1,1:end-1) = fsmemo(1,2:end);%store previous fs memory
    
    %update memo of sensor
    memo(:,end) = [a0;a1];%digital offset 0 -mean(memo(1,1:end-1))+250
    fmemo(:,end) = sum(abs([memo(2,end-100:end-1) a1]-rmean))/10;
    fsmemo(1,end) = fs;
    Cs = toc(Cstar);
    timets(1,end) = Cs;
    
    
    
    % end detection after 6h
    if Cs>=(6*60*60)
        break
    end
    %update calibration
    %     mim = min(memo);
    %     mam = max(memo);
    %     if mim<mmmemo(1)
    %         mmmemo(1) = mim;
    %     end
    %     if mam>mmmemo(2)
    %         mmmemo(2) = mam;
    %     end
    %update running mean
    %     rmean = median(memo);
    %     memo=memo-rmean+512;
    
    % downcrossing low detection
    rmean = mean(memo(2,:));
    refthre = mean(memo(1,:))-3*std(memo(1,:));
    emgthre = mean(fmemo(1,:))-1*std(fmemo(1,:));
    Cnow = toc(C0);
    dC = floor(Cnow);
    if dC>=DurDisable&flagOUT==0
        flagdetect = 1;
        digitalWrite(a,12,0);
    end
    
    % too large movements in the rec
    %20140330: eeg seems large: min thre 300, large movement 250 - 0 range
    % [minthre relatthre refthre] = [350 250 200]
    if (refthre<=thre & thre<=basethre(2))|refthre<=basethre(3)|fmemo(1,end)>=emgthre0
        flagdetect = 0;
        DurDisable = 10;
        C0 = tic;
        digitalWrite(a,TTLLED,1);%led
    end
    %detect
    if flagdetect == 1
        if memo(1,end-1)<=thre
            dmemo = memo(1,end-1)-memo(1,end);
            if dmemo<=0
                switch optionONOFF
                    case 0%INPHASE detection + laser
                        digitalWrite(a,TTLMS8,1);%TTL to NLX
                        %Laser TTL is generated only if Master-8 Is ON
                        event(1,end-1) = 1;%update
                        digitalWrite(a,TTLLED,1);%led
                        
                        flagdetect = 0;
                        DurDisable = 2;
                        C0 = tic;
                        
                        count = count+1;
                        display(['Detections: ' num2str(count)])
                        display(['current fs: ' num2str(fs) ' (Hz)'])
                    case 1%alternate detection in one mice, Everyother
                        if flagONOFF == 0
                            digitalWrite(a,TTLMS8,1);%TTL to NLX
                            flagONOFF = 1;
                        else
                            digitalWrite(a,TTLNLX,1);%TTL to NLX
                            flagONOFF = 0;
                        end
                        event(1,end-1) = 1;%update
                        digitalWrite(a,TTLLED,1);%led
                        
                        flagdetect = 0;
                        DurDisable = 2;
                        C0 = tic;
                        
                        count = count+1;
                        display(['Detections: ' num2str(count)])
                        display(['current fs: ' num2str(fs) ' (Hz)'])
                    case 2%just detection + NO laser
                        digitalWrite(a,8,1);%TTL to NLX
                        %NO TTL sent to Master-8 then NO Laser TTL is
                        %generated
                        event(1,end-1) = 1;%update
                        digitalWrite(a,TTLLED,1);%led
                        
                        flagdetect = 0;
                        DurDisable = 2;
                        C0 = tic;
                        
                        count = count+1;
                        display(['Detections: ' num2str(count)])
                        display(['current fs: ' num2str(fs) ' (Hz)'])
                    case 3%OUTPHASE detection + laser
                        if flagOUT == 0
                            digitalWrite(a,TTLNLX,1);%TTL to NLX
                            flagOUT = 1;
                            CsOUT = tic;
                            TimeOUT = 0.5+rand/2;
                            
                            flagdetect = 0;
                            DurDisable = 2;
                            C0 = tic;
                        end
                end
                
                
            end
        end
    end
    %update threshold
    if min(memo(1,:))<=thre(1)
        thre = min(memo(1,:));
    else
        thre = thre0;
    end
    
    %OUTPHASE stimulation conditions
    if flagOUT ==1
        CnowOUT = toc(CsOUT);
        if  CnowOUT>=TimeOUT
            digitalWrite(a,TTLMS8,1);%TTL to MS8
            flagOUT = 0;
            
            event(1,end-1) = 1;%update
            digitalWrite(a,TTLLED,1);%led
            
            flagdetect = 0;
            DurDisable = 2;
            C0 = tic;
            
            count = count+1;
            display(['Detections: ' num2str(count)])
            display(['current fs: ' num2str(fs) ' (Hz)'])
        end
    end
    
    %Pxx0 = movpow(memo,nfft,fx);
    drawnow
    %time0 = time/fs;
    time0 = (timets-timets(1));
    %
    plot(time0,memo(1,:),'k'),hold on,
    plot(time0,memo(2,:),'b')
    plot(time0,fmemo(1,:),'r')
    idxe = find(event(1,:) ==1);
    if ~isempty(idxe)
        line([1;1]*time0(idxe),100*[0;1]*ones(1,length(idxe)))
    end
    line([time0(1) time0(end)],mean(memo(1,:))*[1 1],'linestyle','--','color','k'),
    line([time0(1) time0(end)],thre(1)*[1 1],'linestyle','--','color','b'),
    line([time0(1) time0(end)],refthre*[1 1],'linestyle','--','color','r'),
    text(5,900,['fs: ' num2str(round(mean(fsmemo)*10)/10) '(Hz)'])
    text(5,850,['stim#: ' num2str(count)])
    if flagdetect == 1
        text(1,950,[syscolorname ' System ON ' ])
    else
        text(1,950,[syscolorname ' System OFF '])
    end
    ylim([mmmemo(1) mmmemo(2)]),hold off
    
    %xlim([0 7])
    drawnow
    %     subplot(2,1,2)
    %     imagesc(time/fs,fx(fx<20),Pxx0(fx<20,:))
    %     drawnow
    
    
    digitalWrite(a,TTLMS8,0);
    digitalWrite(a,TTLNLX,0);
    %pause(0.02)
    
    if ((soCs)~=0)
        fs0 = 1/(soCs);
        if fs0~=fs
            fs = fs0;
        end
    end
    
end
close all
CC = clock;
countfile = ['Count_' num2str(CC(1)) num2str(CC(2)) num2str(CC(3)) '_' num2str(CC(4)) 'H' num2str(CC(5)) 'M' num2str(CC(3)) 'S'];
eval([countfile '= count;']);
lsfile = ls('total_count.mat');
if isempty(lsfile)
    save('total_count',countfile)
else
    save('total_count',countfile,'-append')
end

function Pxx0 = movpow(X,nfft,fx)
wind = 100;
Pxx0 = zeros(length(fx),length(X));
for i = 1:wind:length(X)-wind
    x = X(1,[i:i+wind]);
    Pxx = fft(detrend(x),nfft);
    Pxx = 2*abs(Pxx(1,1:(nfft/2+1))/length(x))';
    Pxx = 100*Pxx/sum(Pxx);
    Pxx0(:,[i+1:i+wind]) = Pxx*ones(1,wind);
end
