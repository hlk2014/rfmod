function [SFO_est, pQAM, pRF]=test_rfmod_qam_tx_SFO_validation_CORE ...
    (graphic, fs, SFO, ovs, tx_num_sym, N_loop, SNR_threshold)
% The core test function for SFO validation using QAM transmission chain.
% This is based on the number of sample drifted over the simulated time 
% period due to the SFO
% Li-Ke Huang 2011/01/10.
pQAM.tx_ovs=ovs;
pQAM.tx_filter_length=10;
pQAM.tx_num_sym=tx_num_sym;
pQAM.tx_qam_type='qpsk';
pRF.dummy=nan;
pRF.fs=fs;
pRF.SFO=SFO;
pRF.CFO=0;
%N_loop=1000;
for nn=1:N_loop
    pQAM=qam_tx(pQAM);
    [pQAM.tx_qam_waveform, pRF]=rfmod(pQAM.tx_qam_waveform, pRF);
    pQAM=qam_rx(pQAM);
    AA(nn)=snrmes(pQAM.rx_qam_sym);
    if graphic==1
        nn
        figure(1)
        subplot(221)
        plot(pQAM.rx_qam_sym, 'r.')
        subplot(222)
        logpsd(pQAM.tx_qam_waveform), hold on, logpsd(pQAM.rx_qam_waveform, 'g'), hold off
        subplot(223)
        xx=pQAM.rx_qam_waveform;
        XX=reshape(xx, pQAM.tx_ovs*4, length(xx)/pQAM.tx_ovs/4);
        plot(real(XX(:, 20:end)), 'g'), hold on, plot([5 5], [-10, 10], 'r'), ylim([-1 1]), hold off
        subplot(224)
        plot(AA), grid on
        pause(eps)
    end
end

BB=AA;
threshold=SNR_threshold;
BB(AA<threshold)=threshold;
mm=1;
pos=[];
for kk=2:length(BB)-1
    if BB(kk)>BB(kk-1) && BB(kk)>BB(kk+1)
        pos(mm)=kk;
        mm=mm+1;
    end
end
DD=df(pos);
DD_mean=mean(DD);

Total_num_samples_to_drift_one_symbol_period=DD_mean*pQAM.tx_num_sym*pQAM.tx_ovs;
Total_num_samples_to_drift_one_sample_period=Total_num_samples_to_drift_one_symbol_period/pQAM.tx_ovs;
SFO_est=1/Total_num_samples_to_drift_one_sample_period;

%SFO_est/SFO

