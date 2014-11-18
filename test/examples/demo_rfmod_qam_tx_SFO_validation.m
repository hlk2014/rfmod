%function [CFO_est, pQAM, pRF]=test_rfmod_qam_tx_CFO_validation(fs, CFO, ovs)

clear all
close all
clc

fs=10.0e6;
SFO=-10e-6;
CFO=0;
ovs=2;
pQAM.tx_ovs=ovs;
pQAM.tx_filter_length=10;
pQAM.tx_num_sym=400;
pQAM.tx_qam_type='qpsk';
pRF.dummy=nan;
pRF.fs=fs;
pRF.SFO=SFO;
pRF.CFO=CFO;
N_loop=1000;
T_period=pQAM.tx_num_sym*pQAM.tx_ovs/pRF.fs;
for nn=1:N_loop
    nn
    pQAM=qam_tx(pQAM);
    [pQAM.tx_qam_waveform, pRF]=rfmod(pQAM.tx_qam_waveform, pRF);
    pQAM=qam_rx(pQAM);
    AA(nn)=snrmes(pQAM.rx_qam_sym);
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

BB=AA;
threshold=40;
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
SFO_est=1/Total_num_samples_to_drift_one_sample_period

SFO_est/SFO

