clear all
close all
clc
warning off
LL=50;
pRF.fs=30.72e6;
pOFDM.Nfft=2048*2;
pOFDM.Ncp=144;
pOFDM.tx_num_sym=1;
pOFDM.bbMap=-1200:1200;
pOFDM.tx_qam_type='16qam';
xx1=[];
xx2=[];
pOFDM.tx_dft_spread='off';
for nn=1:LL,
    pOFDM=ofdm_tx(pOFDM);
    xx=pOFDM.tx_ofdm_waveform;
    [yy, pRF]=rfmod(xx, pRF);
    pOFDM.tx_ofdm_waveform=yy;
    pOFDM=ofdm_rx(pOFDM);
    xx1=[xx1; pOFDM.tx_ofdm_waveform];
end
pOFDM.tx_dft_spread='on';
for nn=1:LL,
    pOFDM=ofdm_tx(pOFDM);
    xx=pOFDM.tx_ofdm_waveform;
    [yy, pRF]=rfmod(xx, pRF);
    pOFDM.tx_ofdm_waveform=yy;
    pOFDM=ofdm_rx(pOFDM);
    xx2=[xx2; pOFDM.tx_ofdm_waveform];
    if 0
        figure(1)
        subplot(221), logpsd(pOFDM.tx_ofdm_waveform)
        subplot(222), plot(pOFDM.rx_qam_sym, 'r.'), axis([-1 1 -1 1]), hold on
        subplot(223), plot(pOFDM.evm_db), ylim([-400 100])
    end
end
[H1, d1]=getpdf(abs(xx1)); CF1=getcrestfactor(xx1);
[H2, d2]=getpdf(abs(xx2)); CF2=getcrestfactor(xx2);
figure(2)
semilogy(20*log10(d1), H1, 'b', 'linewidth', 3), grid on, hold on
semilogy(20*log10(d2), H2, 'r', 'linewidth', 3), legend(num2str(CF1), num2str(CF2))