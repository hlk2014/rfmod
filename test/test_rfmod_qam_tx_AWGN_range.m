function pass=test_rfmod_qam_tx_AWGN_range(graphic)
s1=randn('state');
s2=rand('state');
randn('state', 0);
rand('state', 0);
if ~exist('graphic','var')
    graphic=1;
end
SNR_map=0 : 10 : 120;
for nn=1:length(SNR_map)
    pQAM=[];
    pRF=[];
    pQAM.tx_ovs=8;
    pQAM.tx_filter_length=100;
    pQAM.tx_num_sym=400;
    pRF.awgn.snr=SNR_map(nn);
    pRF.fs=1e6;
    [pQAM, pRF]=test_qam_tx(pQAM, pRF, graphic);
    SNR_est(nn)=-10*log10(mean(10.^(pQAM.evm_db/10)));
end
pass=sum(abs(SNR_est(1:9)-SNR_map(1:9)))<2.0 && SNR_est(end) > 95;
if graphic==1
    figure(1), clf
    plot(SNR_map, SNR_map,  'b.-'), hold on
    plot(SNR_map, SNR_est, 'g.-')
end
randn('state', s1);
rand('state', s2);