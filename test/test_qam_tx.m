function [pQAM, pRF]=test_qam_tx(pQAM, pRF, graphic)
% Core test function for the QAM transmission chain
% including the RF imparinment modelling.
for nn=1:10
    pQAM=qam_tx(pQAM);
    xx=pQAM.tx_qam_waveform;
    [yy, pRF]=rfmod(xx, pRF);
    pQAM.tx_qam_waveform=yy;
    pQAM=qam_rx(pQAM);
    if graphic==1
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
end