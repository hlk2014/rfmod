clear all
close all
clc

dbstop if error
pQAM.tx_ovs=4;
pQAM.tx_filter_length=40;
pQAM.tx_num_sym=200;
pRF.awgn.snr=300;
pRF.dummy=nan;
pRF.fs=1e6;
%pRF.SFO=10e-6;
pRF.CFO=4;
for nn=1:100
    pQAM=qam_tx(pQAM);
    [pQAM.tx_qam_waveform, pRF]=rfmod(pQAM.tx_qam_waveform, pRF);
    pQAM=qam_rx(pQAM);
    figure(1), clf
    subplot(221)
    plot(pQAM.rx_qam_waveform*sqrt(pQAM.tx_ovs),'g'), hold on
    plot(pQAM.rx_qam_sym, 'r.')
    subplot(222)
    logpsd(pQAM.tx_qam_waveform), hold on
    logpsd(pQAM.rx_qam_waveform, 'g')
    subplot(223)
    ovs=pQAM.tx_ovs;
    xx=pQAM.rx_qam_waveform;
    XX=reshape(xx, ovs*4, length(xx)/ovs/4);
    plot(real(XX(:, 20:end)), 'g')
    subplot(224)
    plot(pQAM.evm_db)
    grid on
    pause(0.1)
end