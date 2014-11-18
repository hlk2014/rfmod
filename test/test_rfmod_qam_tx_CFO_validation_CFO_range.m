function pass=test_rfmod_qam_tx_CFO_validation_CFO_range(dummy)
% Check the range of the CFO setting using QAM transmission chain.
% Li-Ke Huang 2011/01/06.
 
[fs, ovs, N_symbol]=deal(62.88e6, 4, 100);
CFO_map=-10000 : 1000 : 10000;
CFO_est=[];
for kk=1:length(CFO_map)
    CFO_est(kk)=test_rfmod_qam_tx_CFO_validation(fs, CFO_map(kk), ovs, N_symbol);
end
pp(1)=sum(abs(CFO_est-CFO_map)) < 1e-9; 

[fs, ovs, N_symbol]=deal(10.88e6, 4, 100);
CFO_map=-10000 : 1000 : 10000;
CFO_est=[];
for kk=1:length(CFO_map)
    CFO_est(kk)=test_rfmod_qam_tx_CFO_validation(fs, CFO_map(kk), ovs, N_symbol);
end
pp(2)=sum(abs(CFO_est-CFO_map)) < 1e-9;

[fs, ovs, N_symbol]=deal(10.88e6, 2, 100);
CFO_map=-10000 : 1000 : 10000;
CFO_est=[];
for kk=1:length(CFO_map)
    CFO_est(kk)=test_rfmod_qam_tx_CFO_validation(fs, CFO_map(kk), ovs, N_symbol);
end
pp(3)=sum(abs(CFO_est-CFO_map)) < 1e-9;

pass=all(pp);
%figure(1), clf, plot(CFO_map, CFO_map, 'bo-'), hold on, plot(CFO_map, CFO_est, 'r.-')