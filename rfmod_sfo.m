function pRF=rfmod_sfo(pRF)
xx=pRF.waveform;
tx=pRF.timebase_tx;
ty=pRF.timebase_rx;
ty=ty+pRF.timing_error/pRF.fs;
yy=interp1(tx,xx,ty,'linear','extrap');
pRF.waveform=yy;
end