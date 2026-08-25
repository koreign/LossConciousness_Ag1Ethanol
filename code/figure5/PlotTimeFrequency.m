%% Script to plot time-frequency plots of rippleband activity time-locked to the central spindle trough

load('SOOptoStim-TF-SpiLockedRipplePwr-BrdBdSpiEvts-scaleSDEnv2-35-750msPost.mat')
%or 
load('SOOptoStim-TF-SpiLockedRipplePwr-SlSpiEvts-scaleSDEnv2-35-750msPost.mat')


for iCond = 1 : numCond
    figure();
    for jCh = 1 : numCh
       subplot(1,3,jCh)
       
       cfg = [];
       cfg.channel = jCh;
       cfg.zlim = [-0.3 1];
       ft_singleplotTFR(cfg, resTF_SpiLockedRipplePwr{iCond,1}.grandavg);
       
    end
end