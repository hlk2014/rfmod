function SNR_est=test_rfmod_qam_tx_timing_error_CORE(fs, ovs, timing_error)
%
SFO=0;
CFO=0;
pQAM.tx_ovs=ovs;
pQAM.tx_filter_length=40;
pQAM.tx_num_sym=200;
pQAM.tx_qam_type='qpsk';
pRF.dummy=nan;
pRF.fs=fs;
pRF.SFO=SFO;
pRF.CFO=CFO;
pRF.timing_error=timing_error;
N_loop=100;
for nn=1:N_loop
    pQAM=qam_tx(pQAM);
    [pQAM.tx_qam_waveform, pRF]=rfmod(pQAM.tx_qam_waveform, pRF);
    pQAM=qam_rx(pQAM);
    AA(nn)=snrmes(pQAM.rx_qam_sym);
%     figure(1)
%     subplot(221)
%     plot(pQAM.rx_qam_sym, 'r.')
%     subplot(222)
%     logpsd(pQAM.tx_qam_waveform), hold on, logpsd(pQAM.rx_qam_waveform, 'g'), hold off
%     subplot(223)
%     xx=pQAM.rx_qam_waveform;
%     XX=reshape(xx, pQAM.tx_ovs*4, length(xx)/pQAM.tx_ovs/4);
%     plot(real(XX(:, 20:end)), 'g'), hold on, plot([5 5], [-10, 10], 'r'), ylim([-1 1]), hold off
%     subplot(224)
%     plot(AA), grid on
%     pause(eps)
end
SNR_est=mean(AA);

