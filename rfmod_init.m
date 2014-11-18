function pRF=rfmod_init(pRF)
if ~isfield(pRF, 'init_flag'),
    pRF.init_flag=1;
else
    return;
end
if ~isfield(pRF, 'fs')
    pRF.fs=1.0;
end
if ~isfield(pRF, 'SFO')
    pRF.SFO=0.0;
end
if ~isfield(pRF, 'CFO')
    pRF.CFO=0.0;
end
if ~isfield(pRF, 'awgn')
    pRF.awgn.snr=1000.0;
end
if ~isfield(pRF, 'timing_error')
    pRF.timing_error=0.0;
end
pRF.timebase_tx=0;
pRF.timebase_rx=0;
end