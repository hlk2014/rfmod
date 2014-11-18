function [CFO_est, pQAM, pRF]=test_rfmod_qam_tx_CFO_validation(fs, CFO, ovs, N_symbol)
% This is the code test function for CFO setting using QAM transmission
% chain.
% Li-Ke Huang 2011/01/06.
pQAM.tx_ovs=ovs;
pQAM.tx_filter_length=40;
pQAM.tx_num_sym=N_symbol;
pQAM.tx_qam_type='all_ones';
pRF.awgn.snr=1000;
pRF.fs=fs;
pRF.CFO=CFO;
N_loop=200;
for nn=1:N_loop
    pQAM=qam_tx(pQAM);
    [pQAM.tx_qam_waveform, pRF]=rfmod(pQAM.tx_qam_waveform, pRF);
    pQAM=qam_rx(pQAM);
    AA(nn)=mean(pQAM.rx_qam_sym);
%     figure(1)
%     subplot(221)
%     plot(pQAM.rx_qam_waveform*sqrt(pQAM.tx_ovs),'g'), hold on
%     plot(pQAM.rx_qam_sym, 'r.'), axis([-1 1 -1 1])
%     subplot(222)
%     logpsd(pQAM.tx_qam_waveform), hold on
%     logpsd(pQAM.rx_qam_waveform, 'g')
%     subplot(223)
%     xx=pQAM.rx_qam_waveform;
%     XX=reshape(xx, pQAM.tx_ovs*4, length(xx)/pQAM.tx_ovs/4);
%     plot(real(XX(:, 20:end)), 'g')
%     subplot(224)
%     plot(pQAM.evm_db), grid on
%     pause(0.01)
end
T_period=pQAM.tx_num_sym*pQAM.tx_ovs/pRF.fs;
BB=unwrap(angle(AA))/(2*pi)/T_period;
dBB=filter([1 -1], 1, BB); 
dBB=dBB(10:end);
CFO_est=mean(dBB);
%figure(2), clf, plot(dBB, 'bo-')