function pQAM=qam_rx(pQAM)
xx=pQAM.tx_qam_waveform;
ZZ=pQAM.rx_filter_internal_state;
[yy, ZZ]=filter(pQAM.rx_filter_coeff, 1, xx, ZZ);
pQAM.rx_qam_waveform=yy;
pQAM.rx_filter_internal_state=ZZ;
pos=pQAM.rx_sampling_instance;
ovs=pQAM.tx_ovs;
ddd=pQAM.rx_qam_waveform(pos:ovs:end)*sqrt(ovs);
pQAM.rx_qam_sym=ddd+j*eps;
pQAM=qam_rx_calc_evm(pQAM);
end

function pQAM=qam_rx_calc_evm(pQAM)
LL=length(pQAM.rx_qam_sym);
ev=pQAM.tx_qam_sym(1:LL) - pQAM.rx_qam_sym(1:LL);
evm_db=20*log10(abs(ev));
pQAM.error_vector=ev;
pQAM.evm_db=evm_db;
end