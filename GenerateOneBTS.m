clc,clear,close all

U0 = 10;
I0 = 10;
Seed = randi([1 2^31-1]);
HubHt = 90;
Ny = 11;
Nz = 11;
Ly = 140;  
Lz = 140;
dt = 0.05;
T = 600;
xLu = 340.2;
xLv = 113.4;
xLw = 27.72;
Lc = 340.2;
a = 12;
shearExp = 0.2;
Thema = 800;      % Wake velocity width
Cs = 25000;       % Wake velocity depth
wake_pos = 61;    % Wake centre location
%% TEST WIND FIELD GENERATION

tic
[WF,WFtower,t,dy,dz,Y,Z,Zbottom,Ztower] = TurbulentWindFieldGenerator(U0,I0,Seed,HubHt,Ny,Nz,Ly,Lz,dt,T,xLu,xLv,xLw,Lc,a,shearExp,wake_pos,Thema,Cs);
toc

%% WRITE FAST-COMPATIBLE BTS FILE

WindFileStruct.WF = WF;
WindFileStruct.WFtower = WFtower;
WindFileStruct.Ntower = numel(Ztower);
WindFileStruct.Nz = Nz;
WindFileStruct.Ny = Ny;
WindFileStruct.N = numel(t);
WindFileStruct.dz = dz;
WindFileStruct.dy = dy;
WindFileStruct.dt = (t(2) - t(1));
WindFileStruct.U0 = U0;
WindFileStruct.HubHt = HubHt;
WindFileStruct.Zbottom = Zbottom;
WindFileStruct.fileID = 'TestTurbulentWindGeneration';
WindFileStruct.Version = ['Dummy Turbulent Wind Generator' datestr(clock,0)];

writeBTSfile(WindFileStruct);
run xiu.m