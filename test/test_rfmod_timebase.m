function [t1, t2, d1, d2, ee]=test_rfmod_timebase(fs, SFO, L_map, M_loop)
% Core test function for the time base calculation
% in rfmod.m
pRF.fs=fs;
pRF.SFO=SFO;
t1=[];
t2=[];
for nn=1:M_loop
    mm=mod(nn-1, length(L_map))+1;
    LL=L_map(mm);
    xx=ones(LL,1);
    [xx, pRF]=rfmod(xx, pRF);
    t1=[t1; pRF.timebase_tx];
    t2=[t2; pRF.timebase_rx];
end
d1=filter([1 -1], 1, t1);
d2=filter([1 -1], 1, t2);
ee=t2-t1;