%function pass=test_rfmod_timebase(graphic)
clear all
close all
clc
graphic=0;
LL_map=[1, 2, 10, 22, 41, 12]*101;
pRF.SFO=1e-6;
pRF.fs=1000e6;
pRF.dummy=nan;
tt_tx=[];
tt_rx=[];
total_tx_time=0;
total_rx_time=0;
M_loop=100;
for nn=1:M_loop
    mm=mod(nn-1, length(LL_map))+1;
    LL=LL_map(mm);
    xx=ones(LL,1);
    [xx, pRF]=rfmod(xx, pRF);
    tt_tx=[tt_tx; pRF.timebase_tx];
    tt_rx=[tt_rx; pRF.timebase_rx];
end

pp(1)=sum(abs(tt_tx-tt_rx))<1e-10;
 