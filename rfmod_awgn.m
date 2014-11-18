function pRF=rfmod_awgn(pRF)
SNR=pRF.awgn.snr;
if SNR>200.0
    return;
end
xx=pRF.waveform;
nn=crandn(size(xx))*(10^(-SNR/20));
yy=xx+nn;
pRF.waveform=yy;
end