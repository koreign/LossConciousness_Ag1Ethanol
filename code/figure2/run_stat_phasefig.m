function memoCirc = run_stat_phasefig
%load file located in DataAnalysis Remake 201703
load('SOOptoStim-StimLockedAvg.mat')
savefolder = '/Users/Koreign/Documents/0 - IBS/1 - SW Spindles/Data Analysis Remake 201703/Figure Polar Plots/';
%4 variables
% resStimAvg individual
% resStimavgTable pooled
% resStimPhase individual
% resStimPhaseTable pooled
close all
clc

%rose plot for all conditions (phase circ plot)

title = {'IN-FC' 'OUT-FC' 'OUT-FC-Detect' 'NoStim-FC-IN' 'NoStim-FC-OUT' 'ARC-FC-IN' 'CH-FC-IN' 'ARC-FC-OUT' 'ARC-FC-OUT-Detect' 'ARC-NoStim-IN' 'ARC-NoStim-OUT'};
gcolor = {[1 0 0] [64 181 29]/255 [16 181 10]/255 [0.5 0.5 0.5] [0.5 0.5 0.5] ...
    [0 0 1] [1 0 0] [0.1 0.6 1] [0.1 0.6 1] [0.5 0.5 0.5] [0.5 0.5 0.5]};
memoCirc = zeros(size(title,2),5);%for each condition, mean circ, p, z rayleigh test
angleFC = [];
kappaG = [];
idxFC = [];
idxG = [];

hf1 = figure('name','OS FC');compass(0,0);
hf2 = figure('name','ARC FC');compass(0,0);
for cond = 1:size(resStimPhaseTable,1)
    hf = figure('name',title{1,cond});
    if cond <6
        Nlim = 1;
    else
        Nlim = 1;
    end
    mAA = resStimPhase{cond,1};%all individual mice
    kAA = [];
    for mm = 1:size(mAA.mouse,1)
        kAA  = [kAA circ_kappa(mAA.mouse{mm,1}(1,:))];
    end
    
    AA = resStimPhaseTable{cond,1}(1,:);%circ_ang2rad();
    [~,~,nnmax] = rose2(AA,20,gcolor{1,cond},Nlim);
    hold on
    mc = circ_mean(AA,[],2);
    kc = circ_r(AA,[],[],2);
    kappa = circ_kappa(AA);
    
    [kc2 mc2] = circ_axialmean(AA,[],2);
    
    [pc,zc] = circ_rtest(AA);
    [pc2,zc2] = circ_otest(AA);
    [pc3,zc3] = circ_vtest(AA,mc);
    
    
    memoCirc(cond,:) = [mc, kc, kappa,pc, pc3];
    zm = kc*exp(1i*mc);
    line([0 real(zm)], [0, imag(zm)],'color','k','linewidth',4)
    %set('Facecolor',gcolor{1,cond},'edgecolor',gcolor{1,cond});
    sdf(hf,'Arial600_20f')
    saveas(hf,[savefolder title{1,cond} '_phase' num2str(nnmax) '.tiff'])
    
    
    
    if cond <6
        figure(hf1),hold on,
        zm = kc*exp(1i*mc);
        if cond == 3 | cond == 5
            line([0 real(zm)], [0, imag(zm)],'color',gcolor{1,cond},'linewidth',2,'linestyle',':')
        else
            line([0 real(zm)], [0, imag(zm)],'color',gcolor{1,cond},'linewidth',2)
        end
        hold off
        
        angleFC = [angleFC resStimPhaseTable{cond,1}(1,:)];
        idxFC = [idxFC cond*ones(1,length(resStimPhaseTable{cond,1}(1,:)))];
        
        kappaG = [kappaG kAA];
        idxG = [idxG cond*ones(1,length(kAA))];
    else
        figure(hf2),hold on,
        zm = kc*exp(1i*mc);
        if cond == 9 | cond == 11
            line([0 real(zm)], [0, imag(zm)],'color',gcolor{1,cond},'linewidth',2,'linestyle',':')
        else
            line([0 real(zm)], [0, imag(zm)],'color',gcolor{1,cond},'linewidth',2)
        end
        hold off
    end
end
close all

%anova test on kappa values
[Pkappa, tablekappa] = anova1(kappaG,idxG);
tablekappa

%wwtest for FC pvmh
[p table] = circ_wwtest(angleFC,idxFC);
holm([kappaG' idxG'])
%multiple comparison kuiper test
labels = {'IN' 'OUT' 'OUTdet' 'NoIN' 'NoOUT'};
resTable = [{' '} labels {' '}];

for i = 1:5
    for j = 1:5
        [p ff] = circ_ktest(resStimPhaseTable{i,1}(1,:),resStimPhaseTable{j,1}(1,:));
        resTable{i+1,j+1} = p;
    end
end
resTable(:,1) = [{' '};labels']


function [tout,rout,nnmax] = rose2(varargin)
%ROSE   Angle histogram plot.
%   ROSE(THETA) plots the angle histogram for the angles in THETA.
%   The angles in the vector THETA must be specified in radians.
%
%   ROSE(THETA,N) where N is a scalar, uses N equally spaced bins
%   from 0 to 2*PI.  The default value for N is 20.
%
%   ROSE(THETA,X) where X is a vector, draws the histogram using the
%   bins specified in X. Where the values of x specify the center
%   angle of each bin.
%
%   ROSE(AX,...) plots into AX instead of GCA.
%
%   H = ROSE(...) returns a vector of line handles.
%
%   [T,R] = ROSE(...) returns the vectors T and R such that
%   POLAR(T,R) is the histogram.  No plot is drawn.
%
%   See also HIST, POLAR, COMPASS.

%   Clay M. Thompson 7-9-91
%   Copyright 1984-2005 The MathWorks, Inc.
%   $Revision: 5.14.4.4 $  $Date: 2005/04/28 19:56:53 $

%%[cax,args,nargs] = axescheck(varargin{:});
%error(nargchk(1,4,nargs,'struct'));

% theta = args{1};
%
% if nargs > 1,
%     x = args{2};
%
% end

theta = varargin{1};
if nargin >1
    x = varargin{2};
end

if nargin >2
    gcolor = varargin{3};
    if nargin >3
        Nlim = varargin{4};
    else
        Nlim = [];
    end
else
    gcolor = [1 0 0];
end

if ischar(theta)
    error(id('NonNumericInput'),'Input arguments must be numeric.');
end
theta = rem(rem(theta,2*pi)+2*pi,2*pi); % Make sure 0 <= theta <= 2*pi
if nargin==1,
    x = (0:19)*pi/10+pi/20;
    
elseif nargin>=2,
    if ischar(x)
        error(id('NonNumericInput'),'Input arguments must be numeric.');
    end
    if length(x)==1,
        x = (0:x-1)*2*pi/x + pi/x;
    else
        x = sort(rem(x(:)',2*pi));
    end
    
end
if ischar(x) || ischar(theta)
    error(id('NonNumericInput'),'Input arguments must be numeric.');
end

% Determine bin edges and get histogram
edges = sort(rem([(x(2:end)+x(1:end-1))/2 (x(end)+x(1)+2*pi)/2],2*pi));
edges = [edges edges(1)+2*pi];
nn = histc(rem(theta+2*pi-edges(1),2*pi),edges-edges(1));
%normalize
nnmax = max(nn);
nn = nn/nnmax;
%
nn(end-1) = nn(end-1)+nn(end);
nn(end) = [];

% Form radius values for histogram triangle
if min(size(nn))==1, % Vector
    nn = nn(:);
end
[m,n] = size(nn);
mm = 4*m;
r = zeros(mm,n);
r(2:4:mm,:) = nn;
r(3:4:mm,:) = nn;

% Form theta values for histogram triangle from triangle centers (xx)
zz = edges;

t = zeros(mm,1);
t(2:4:mm) = zz(1:m);
t(3:4:mm) = zz(2:m+1);

if ~isempty(Nlim)
    max_lim = Nlim;
    x_fake=[0 max_lim 0 -max_lim];
    y_fake=[max_lim 0 -max_lim 0];
    h_fake=compass(x_fake,y_fake);
    hold on;
end


if nargout<4
    %     if ~isempty(cax)
    %         h = polar(cax,t,r);
    %     else
    %         h = polar(t,r);
    %     end
    h = polar(t,r);
    [a,b] = pol2cart(t,r);     % convert histogram line to polar coordinates
    A = reshape(a,4,numel(x)); % reshape 4*N-element x vector into N columns
    B = reshape(b,4,numel(x)); % reshape 4*N-element y vector into N columns
    patch(A,B,gcolor)         % plot N patches based on the columns of A and B
    
    if ~isempty(Nlim)
        set(h_fake,'Visible','off');
    end
    
    if min(size(nn))==1,
        tout = t'; rout = r';
    else
        tout = t; rout = r;
    end
    
    if nargout==1, tout = h; end
    return
    
else
    if min(size(nn))==1,
        tout = t'; rout = r';
    else
        tout = t; rout = r;
    end
end



function str=id(str)
str = ['MATLAB:rose:' str];


