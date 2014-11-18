function pOFDM=ofdm_tx(pOFDM)
pOFDM=ofdm_tx_init(pOFDM);
pOFDM=ofdm_tx_mod(pOFDM);
end

function pOFDM=ofdm_tx_mod(pOFDM)
Nsymbol=pOFDM.tx_num_sym;
bbMap=pOFDM.bbMap;
Nfft=pOFDM.Nfft;
Ncp=pOFDM.Ncp;
if strcmpi(pOFDM.tx_qam_type,'all_ones')
    q=ones(length(bbMap), Nsymbol);
else
    q=getqam(pOFDM.tx_qam_type, length(bbMap), Nsymbol);
end
if strcmpi(pOFDM.tx_dft_spread, 'on')
    qq=fft(q)/sqrt(length(q));
else
    qq=q;
end
z=zeros(Nfft, Nsymbol);
z(bb2fft(bbMap, Nfft), :)=qq;
xo=ifft(z, Nfft)*sqrt(Nfft);
xo=[xo((Nfft-Ncp+1):Nfft, :);  xo];
pOFDM.tx_ofdm_waveform=xo(:);
pOFDM.tx_qam_sym=q;
end

function pOFDM=ofdm_tx_init(pOFDM)
if ~isfield(pOFDM, 'tx_init_flag'),
    pOFDM.tx_init_flag=1;
else
    return;
end
if ~isfield(pOFDM, 'Nfft'),
    pOFDM.Nfft=2048;
end
if ~isfield(pOFDM, 'Ncp'),
    pOFDM.Ncp=512;
end
if ~isfield(pOFDM, 'tx_qam_type'),
    pOFDM.tx_qam_type='qpsk';
end
if ~isfield(pOFDM, 'tx_num_sym'),
    pOFDM.tx_num_sym=10;
end
if ~isfield(pOFDM, 'bbMap'),
    pOFDM.bbMap=-300:300;
end
if ~isfield(pOFDM, 'tx_dft_spread'),
    pOFDM.tx_dft_spread='off';
end
end