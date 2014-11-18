function pass=test_rfmod_ofdm_tx_CFO_validation_fs_range(dummy)
% Validate the same CFO is simulated for different
% fs, Nfft and Ncp.
% Li-Ke Huang 2011/01/05.
[CFO, Nfft, Ncp, CFO_est]=deal(0.001, 1024, 16, []);
fs_map=[1e1, 1e2, 1e3, 1e4, 1e5, 1e6, 23.12e6];
for nn=1:length(fs_map)
    CFO_est(nn) =test_rfmod_ofdm_tx_CFO_validation(fs_map(nn), CFO, Nfft, Ncp);
end
pp(1)=sum(abs(CFO_est-CFO))< 1e-14;

[CFO, Nfft, Ncp, CFO_est]=deal(-0.01, 1024, 16, []);
fs_map=[1e2, 1e3, 1e4, 1e5, 1.135467e6, 23.12e6];
for nn=1:length(fs_map)
    CFO_est(nn) =test_rfmod_ofdm_tx_CFO_validation(fs_map(nn), CFO, Nfft, Ncp);
end
pp(2)=sum(abs(CFO_est-CFO)) < 1e-14;

[CFO, Nfft, Ncp, CFO_est]=deal(1, 1024*2, 16, []);
fs_map=[1e5, 1.135467e6, 23.12876e6];
for nn=1:length(fs_map)
    CFO_est(nn) =test_rfmod_ofdm_tx_CFO_validation(fs_map(nn), CFO, Nfft, Ncp);
end
pp(3)=sum(abs(CFO_est-CFO)) < 1e-14;

[CFO, Nfft, Ncp, CFO_est]=deal(-10, 1024*2*2, 16*5, []);
fs_map=[1e5, 1.135467e6, 23.12876e6];
for nn=1:length(fs_map)
    CFO_est(nn) =test_rfmod_ofdm_tx_CFO_validation(fs_map(nn), CFO, Nfft, Ncp); 
end
pp(4)=sum(abs(CFO_est-CFO)) < 1e-13;

[CFO, Nfft, Ncp, CFO_est]=deal(100, 1024*2*2, 16*5, []);
fs_map=[1.135467e6, 23.12876e6, 100e6];
for nn=1:length(fs_map)
    CFO_est(nn) =test_rfmod_ofdm_tx_CFO_validation(fs_map(nn), CFO, Nfft, Ncp); 
end
pp(5)=sum(abs(CFO_est-CFO)) < 1e-12;

pass=all(pp);
