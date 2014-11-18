function pass=test_rfmod_qam_tx_AWGN_small_step(graphic)
s1=randn('state');
s2=rand('state');
randn('state', 0);
rand('state', 0);
if ~exist('graphic','var')
   graphic=1; 
end
SNR_map= 39 : 0.2 : 41;
SNR_est=nan(size(SNR_map));
for nn=1:length(SNR_map)
    pQAM.tx_ovs=8;
    pQAM.tx_filter_length=40;
    pQAM.tx_num_sym=1000;
    pRF.awgn.snr=SNR_map(nn);
    pRF.fs=1e6;
    [pQAM, pRF]=test_qam_tx(pQAM, pRF, graphic);
    SNR_est(nn)=-10*log10(mean(10.^(pQAM.evm_db/10)));
end
pass=sum(abs(SNR_est-SNR_map))<1.4;
if graphic==1
    figure(1), clf
    plot(SNR_map, SNR_map), hold on
    plot(SNR_map, SNR_est, 'r.-')
end
randn('state', s1);
rand('state', s2);
