function pass=test_rfmod_ofdm_tx_CFO_validation_CFO_range_step_size(dummy)
% Validate the step size of the CFO setting for different fs and Nfft
% using the OFDM transmission chain.
% Li-Ke Huang 2011/01/05.
[fs, Nfft, Ncp, CFO_est]=deal(62.88e6, 1024*2, 16, []);
CFO_map=-10 : 0.1 : 10;
for kk=1:length(CFO_map)
    CFO_est(kk) =test_rfmod_ofdm_tx_CFO_validation(fs, CFO_map(kk), Nfft, Ncp);
end
pp(1)=sum(abs(CFO_est-CFO_map))<1e-11;

[fs, Nfft, Ncp, CFO_est]=deal(62e3, 1024/2, 181, []);
CFO_map=-0.1 : 0.01 : 0.1;
for kk=1:length(CFO_map)
    CFO_est(kk) =test_rfmod_ofdm_tx_CFO_validation(fs, CFO_map(kk), Nfft, Ncp);
end
pp(2)=sum(abs(CFO_est-CFO_map))<1e-14;

[fs, Nfft, Ncp, CFO_est]=deal(40e3, 1024/2, 181, []);
CFO_map=[-0.1 : 0.01 : 0.1]+19;
for kk=1:length(CFO_map)
    CFO_est(kk) =test_rfmod_ofdm_tx_CFO_validation(fs, CFO_map(kk), Nfft, Ncp);
end
pp(3)=sum(abs(CFO_est-CFO_map))<1e-12;

pass=all(pp);

if 0
    figure(1), clf
    plot(CFO_map, CFO_map, 'b.-'), hold on
    plot(CFO_map, CFO_est, 'ro-')
end
