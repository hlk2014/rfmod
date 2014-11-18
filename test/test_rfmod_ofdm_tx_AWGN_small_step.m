function pass=test_rfmod_ofdm_tx_AWGN_small_step(graphic)
if ~exist('graphic','var')
    graphic=1;
end
SNR_map=38 : 0.1 : 42;
for nn=1:length(SNR_map)
    pRF=[];
    pOFDM=[];
    pRF.awgn.snr=SNR_map(nn);
    pOFDM.tx_num_sym=100;
    pOFDM.Nfft=2^11;
    [pOFDM, pRF]=test_ofdm_tx(pOFDM, pRF);
    SNR_est(nn)=-10*log10(mean(10.^(pOFDM.evm_db/10)));
end
pass=sum(abs(SNR_est-SNR_map))<0.8;
if graphic==1
    figure(1), clf
    plot(SNR_map, SNR_map,  'b.-'), hold on
    plot(SNR_map, SNR_est, 'r.-')
end