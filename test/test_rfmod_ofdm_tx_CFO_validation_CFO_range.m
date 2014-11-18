function pass=test_rfmod_ofdm_tx_CFO_validation_CFO_range(dummy)
% Validate the range of the CFO setting for different fs and Nfft
% using the OFDM transmission chain.
% Li-Ke Huang 2011/01/05.
[fs, Nfft, Ncp, CFO_est]=deal(62.88e6, 1024*2, 16, []);
CFO_map=-10000 : 1000 : 10000;
for kk=1:length(CFO_map)
    CFO_est(kk) =test_rfmod_ofdm_tx_CFO_validation(fs, CFO_map(kk), Nfft, Ncp);
end
pp(1)=sum(abs(CFO_est-CFO_map))<1e-9;

[fs, Nfft, Ncp, CFO_est]=deal(22.88e6, 1024, 16, []);
CFO_map=-10000 : 1000 : 10000;
for kk=1:length(CFO_map)
    CFO_est(kk) =test_rfmod_ofdm_tx_CFO_validation(fs, CFO_map(kk), Nfft, Ncp);
end
pp(2)=sum(abs(CFO_est-CFO_map))<1e-9;
if 0
    figure(1), clf
    plot(CFO_map, CFO_map, 'b.-'), hold on
    plot(CFO_map, CFO_est, 'ro-')
end
pass=all(pp);