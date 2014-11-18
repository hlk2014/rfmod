function pass=test_rfmod_qam_tx_SFO_validation_SFO_RANGE(dummy)
% This test tests the linear range of the simulation SFO using the QAM
% transmission chain.
% Li-Ke Huang 2011/01/10.
dummy=1;

[fs, SFO, ovs, tx_num_sym, N_loop, SNR_th]=deal(10e6, 10e-6, 2, 0.5e3, 1e3, 35);
SFO_est=[];
SFO_map=[20 18 16 14 12 10]*1e-6;
for kk=1:length(SFO_map)
    SFO_est(kk)=test_rfmod_qam_tx_SFO_validation_CORE(0, fs, SFO_map(kk), ovs, tx_num_sym, N_loop, SNR_th);
end
pp(1)=sum(abs(SFO_est-SFO_map)) < 1e-6;

[fs, SFO, ovs, tx_num_sym, N_loop, SNR_th]=deal(10e6, 10e-6, 2, 4e3, 1e3, 35);
SFO_est=[];
SFO_map=[2 1.5 1]*1e-6;
for kk=1:length(SFO_map)
    SFO_est(kk)=test_rfmod_qam_tx_SFO_validation_CORE(0, fs, SFO_map(kk), ovs, tx_num_sym, N_loop, SNR_th);
end
pp(2)=sum(abs(SFO_est-SFO_map)) < 1e-6;


[fs, SFO, ovs, tx_num_sym, N_loop, SNR_th]=deal(10e6, 10e-6, 2, 20e3, 2e3, 35);
SFO_est=[];
SFO_map=[0.15 0.1 0.05]*1e-6;
for kk=1:length(SFO_map)
    SFO_est(kk)=test_rfmod_qam_tx_SFO_validation_CORE(0, fs, SFO_map(kk), ovs, tx_num_sym, N_loop, SNR_th);
end
pp(3)=sum(abs(SFO_est-SFO_map)) < 1e-9;

pass=all(pp==1);
