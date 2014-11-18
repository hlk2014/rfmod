function pass=test_rfmod_ofdm_tx_SFO_RANGE(dummy)
dummy=0;
SFO_map=[0.1e-6 0.2e-6 0.4e-6 0.8e-6 1e-6];
SFO_est=[];
for kk=1:length(SFO_map)
    SFO_est(kk)=test_rfmod_ofdm_tx_SFO_CORE(SFO_map(kk));
end
pp(1)=sum(abs(SFO_est-SFO_map)) < 1e-7;

SFO_map=-[ 2e-6 4e-6 8e-6 10e-6];
SFO_est=[];
for kk=1:length(SFO_map)
    SFO_est(kk)=test_rfmod_ofdm_tx_SFO_CORE(SFO_map(kk));
end
pp(2)=sum(abs(SFO_est-SFO_map)) < 0.5e-6;

SFO_map=[ 10e-6 14e-6 18e-6 20e-6];
SFO_est=[];
for kk=1:length(SFO_map)
    SFO_est(kk)=test_rfmod_ofdm_tx_SFO_CORE(SFO_map(kk));
end
pp(3)=sum(abs(SFO_est-SFO_map)) < 4e-6; 
pass=all(pp==1);