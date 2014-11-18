function pQAM=qam_tx(pQAM)
pQAM=qam_tx_init(pQAM);
pQAM=qam_tx_mod(pQAM);
end

function pQAM=qam_tx_mod(pQAM)
ovs=pQAM.tx_ovs;
if strcmpi(pQAM.tx_qam_type, 'all_ones')
    qq=ones(pQAM.tx_num_sym, 1);
else
    qq=getqam(pQAM.tx_qam_type, pQAM.tx_num_sym, 1);
end
ZZ=pQAM.tx_filter_internal_state;
hh=pQAM.tx_filter_coeff;
[xx, ZZ]=filter(hh, 1, upsample(qq, ovs)*sqrt(ovs), ZZ);
pQAM.tx_filter_internal_state=ZZ;
pQAM.tx_qam_sym=qq;
pQAM.tx_qam_waveform=xx;
end

function pQAM=qam_tx_init(pQAM)
if ~isfield(pQAM, 'tx_init_flag'),
    pQAM.tx_init_flag=1;
else
    return;
end
if ~isfield(pQAM, 'tx_num_sym'),
    pQAM.tx_num_sym=10;
end
if ~isfield(pQAM, 'tx_ovs'),
    pQAM.tx_ovs=8;
end
if ~isfield(pQAM, 'tx_qam_type'),
    pQAM.tx_qam_type='qpsk';
end
if ~isfield(pQAM, 'tx_filter_length'),
    pQAM.tx_filter_length=10;
end
if ~isfield(pQAM, 'tx_filter_coeff'),
    pQAM.tx_filter_coeff=get_rrc(pQAM.tx_ovs, 0.22, pQAM.tx_filter_length);
end
if ~isfield(pQAM,'tx_filter_internal_state')
    pQAM.tx_filter_internal_state=zeros(length(pQAM.tx_filter_coeff)-1, 1);
end
if ~isfield(pQAM, 'rx_filter_coeff'),
    pQAM.rx_filter_coeff=pQAM.tx_filter_coeff;
end
if ~isfield(pQAM,'rx_filter_internal_state')
    pQAM.rx_filter_internal_state=zeros(length(pQAM.rx_filter_coeff)-1, 1);
end
pQAM=qam_rx_init_calc_sampling_instance(pQAM);
end

function pQAM=qam_rx_init_calc_sampling_instance(pQAM)
if isfield(pQAM,'rx_sampling_instance')
    return;
end
tx_h=pQAM.tx_filter_coeff;
rx_h=pQAM.rx_filter_coeff;
hh=conv(tx_h, rx_h);
[dummy, pos]=max(abs(hh));
pQAM.rx_sampling_instance=pos;
end
