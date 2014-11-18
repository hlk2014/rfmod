clear all
close all
clc

SFO_map=[0.1e-6 1e-6 10e-6 20e-6];

for kk=1:length(SFO_map)
    [SFO_est(kk), pOFDM{kk}, pRF]=test_rfmod_ofdm_tx_SFO_CORE(SFO_map(kk));
    dd{kk}=df(angle(pOFDM{kk}.rx_qam_sym));
    dd{kk}=dd{kk}(4:end-4);
end

figure(1), hold on
for kk=1:length(dd)
    plot(dd{kk})
end