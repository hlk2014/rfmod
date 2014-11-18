function pOFDM=ofdm_rx(pOFDM)
Nsymbol=pOFDM.tx_num_sym;
bbMap=pOFDM.bbMap;
Nfft=pOFDM.Nfft;
Ncp=pOFDM.Ncp;
x=pOFDM.tx_ofdm_waveform;
x=reshape(x, Nfft+Ncp, Nsymbol);  
y=fft(x(Ncp+1 : end, :), Nfft)./sqrt(Nfft);      
z=y(bb2fft(bbMap, Nfft), :);    
if strcmpi(pOFDM.tx_dft_spread, 'on')
     z=ifft(z)*sqrt(length(z));
end
pOFDM.rx_qam_sym=z+j*eps;
pOFDM=ofdm_rx_calc_evm(pOFDM);
end

function pOFDM=ofdm_rx_calc_evm(pOFDM)
qam_tx=pOFDM.tx_qam_sym(:);
qam_rx=pOFDM.rx_qam_sym(:);
ev=qam_tx-qam_rx;
evm_db=20*log10(abs(ev));
pOFDM.error_vector=ev;
pOFDM.evm_db=evm_db;
end