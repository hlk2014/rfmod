function [pOFDM, pRF]=test_ofdm_tx(pOFDM, pRF)
% Core test function for OFDM transmission chain
% including the RF imparinment modelling.
pOFDM=ofdm_tx(pOFDM);
xx=pOFDM.tx_ofdm_waveform;
[yy, pRF]=rfmod(xx, pRF);
pOFDM.tx_ofdm_waveform=yy;
pOFDM=ofdm_rx(pOFDM);