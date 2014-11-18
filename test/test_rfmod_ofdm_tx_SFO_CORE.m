function [SFO_est, pOFDM, pRF]=test_rfmod_ofdm_tx_SFO_CORE(SFO)
dummy=0;
LL=100;
for nn=1:LL,
    pRF.fs=100e6;
    pRF.CFO=0;
    pRF.SFO=SFO;
    pOFDM.Nfft=512*4*2;
    pOFDM.Ncp=16*4;
    pOFDM.tx_num_sym=1;
    pOFDM.bbMap=-100:100;
    pOFDM.tx_qam_type='all_ones';
    pOFDM=ofdm_tx(pOFDM);
    xx=pOFDM.tx_ofdm_waveform;
    [yy, pRF]=rfmod(xx, pRF);
    pOFDM.tx_ofdm_waveform=yy;
    pOFDM=ofdm_rx(pOFDM);
    if 0
        figure(1)
        subplot(221), logpsd(pOFDM.tx_ofdm_waveform)
        subplot(222), plot(pOFDM.rx_qam_sym, 'r.'), axis([-1 1 -1 1]), hold on
        subplot(223), plot(pOFDM.evm_db), ylim([-400 100])
    end
end
dd=df(angle(pOFDM.rx_qam_sym));
dd=dd(4:end-4);
dd=dd/(2*pi);
dd_mean=mean(dd);
Total_num_samples_simulated=(pOFDM.Nfft+ pOFDM.Ncp)*LL;
SFO_est=dd_mean/(Total_num_samples_simulated/pOFDM.Nfft);

