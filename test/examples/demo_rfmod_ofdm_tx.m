clear all
close all
clc
%profile on
LL=100;
for nn=1:LL,
    pRF.fs=30e6;
    pRF.CFO=50;
    pOFDM.Nfft=512*2;
    pOFDM.Ncp=16;
    pOFDM.tx_num_sym=1;
    pOFDM.bbMap=-50:50;
    pOFDM.tx_qam_type='all_ones';
    pOFDM=ofdm_tx(pOFDM);
    xx=pOFDM.tx_ofdm_waveform;
    [yy, pRF]=rfmod(xx, pRF);
    pOFDM.tx_ofdm_waveform=yy;
    pOFDM=ofdm_rx(pOFDM);
 
    AA(nn)=mean(pOFDM.rx_qam_sym);
 
    figure(1) 
    subplot(221), logpsd(pOFDM.tx_ofdm_waveform)
    subplot(222), plot(pOFDM.rx_qam_sym, 'r.'), axis([-1 1 -1 1]), hold on
    subplot(223), plot(pOFDM.evm_db), ylim([-400 100])
    subplot(224), plot(AA, 'r.'),  axis([-1 1 -1 1]), hold on
end

T_symbol=(pOFDM.Nfft+pOFDM.Ncp)/pRF.fs;
BB=unwrap(angle(AA))/(2*pi)/T_symbol;
dBB=df(BB); 
dBB=dBB(2:end);

figure(2)
plot(dBB, 'bo-'), hold on

% profile report
% profile off
