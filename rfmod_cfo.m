function pRF=rfmod_cfo(pRF)
xx=pRF.waveform;
tt=pRF.timebase_tx;
ff=pRF.CFO;
cx=exp(j*2*pi*ff*tt);
xx=xx.*cx;
pRF.waveform=xx;
end