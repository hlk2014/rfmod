function pass=test_rfmod_ofdm_tx_AWGN_range(graphic)
if ~exist('graphic','var')
    graphic=1;
end
SNR_map=0 : 10 : 100;
for nn=1:length(SNR_map)
    pRF=[];
    pOFDM=[];
    pRF.awgn.snr=SNR_map(nn);
    pOFDM.tx_num_sym=10;
    pOFDM.Nfft=2^12;
    [pOFDM, pRF]=test_ofdm_tx(pOFDM, pRF);
    SNR_est(nn)=-10*log10(mean(10.^(pOFDM.evm_db/10)));
end
pass=sum(abs(SNR_est-SNR_map))<1;
if graphic==1
    figure(1), clf
    plot(SNR_map, SNR_map,  'b.-'), hold on
    plot(SNR_map, SNR_est, 'g.-')
end