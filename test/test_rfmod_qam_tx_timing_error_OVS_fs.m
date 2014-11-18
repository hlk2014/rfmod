function pass=test_rfmod_qam_tx_timing_error_OVS_fs(dummy)
%
ovs=4;
fs=1;
timing_error_map=[0.0 0.01 0.02 0.1 0.2];
SNR_est=[];
for kk=1:length(timing_error_map)
    SNR_est_pos(kk)=test_rfmod_qam_tx_timing_error_CORE(1, 4, timing_error_map(kk));
end
timing_error_map=-[0.0 0.01 0.02 0.1 0.2];
SNR_est=[];
for kk=1:length(timing_error_map)
    SNR_est_neg(kk)=test_rfmod_qam_tx_timing_error_CORE(1, 4, timing_error_map(kk));
end
pp(1)=sum(abs(SNR_est_pos-SNR_est_neg))<1;


ovs=2;
fs=1;
timing_error_map=[0.0 0.01 0.02 0.1 0.2];
SNR_est=[];
for kk=1:length(timing_error_map)
    SNR_est_pos(kk)=test_rfmod_qam_tx_timing_error_CORE(1, 4, timing_error_map(kk));
end
timing_error_map=-[0.0 0.01 0.02 0.1 0.2];
SNR_est=[];
for kk=1:length(timing_error_map)
    SNR_est_neg(kk)=test_rfmod_qam_tx_timing_error_CORE(1, 4, timing_error_map(kk));
end
pp(2)=sum(abs(SNR_est_pos-SNR_est_neg))<1;

ovs=8;
fs=1e6;
timing_error_map=[0.0 0.01 0.02 0.1 0.2];
SNR_est=[];
for kk=1:length(timing_error_map)
    SNR_est_pos(kk)=test_rfmod_qam_tx_timing_error_CORE(1, 4, timing_error_map(kk));
end
timing_error_map=-[0.0 0.01 0.02 0.1 0.2];
SNR_est=[];
for kk=1:length(timing_error_map)
    SNR_est_neg(kk)=test_rfmod_qam_tx_timing_error_CORE(1, 4, timing_error_map(kk));
end
pp(3)=sum(abs(SNR_est_pos-SNR_est_neg));

pass=all(pp==1);