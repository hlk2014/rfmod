function [yy, pRF]=rfmod(xx, pRF)
pRF.waveform=xx;
pRF=rfmod_init(pRF);
pRF=rfmod_timebase(pRF);
pRF=rfmod_cfo(pRF);
pRF=rfmod_sfo(pRF);
pRF=rfmod_awgn(pRF);
yy=pRF.waveform;
end

function pRF=rfmod_timebase(pRF)
Ts=1/pRF.fs;
LL=length(pRF.waveform);
tt_tx=(1:LL)*Ts;
tt_tx=tt_tx(:);

% The new sampling frequency is (1+pRF.SFO)*fs. Therefore the new sampling
% period is 1/((1+pRF.SFO)*fs) which is Ts( 1 - pRF.SFO/(1+pRF.SFO) )
samplePeriodError = -pRF.SFO/(1+pRF.SFO);
tt_rx=tt_tx*(1+samplePeriodError);

pRF.timebase_tx=pRF.timebase_tx(end)+tt_tx;
pRF.timebase_rx=pRF.timebase_rx(end)+tt_rx;
end