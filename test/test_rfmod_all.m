clear all
close all
clc
tic

nn=0;

show_progress=1;

nn=nn+1; try pass(nn)=test_rfmod_qam_tx_timing_error_OVS_fs(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end  
nn=nn+1; try pass(nn)=test_rfmod_ofdm_tx_SFO_RANGE(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end  
nn=nn+1; try pass(nn)=test_rfmod_qam_tx_SFO_validation_SFO_RANGE(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end
nn=nn+1; try pass(nn)=test_rfmod_qam_tx_CFO_validation_CFO_range_step_size(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end
nn=nn+1; try pass(nn)=test_rfmod_qam_tx_CFO_validation_CFO_range(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end
nn=nn+1; try pass(nn)=test_rfmod_ofdm_tx_CFO_validation_CFO_range_step_size(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end
nn=nn+1; try pass(nn)=test_rfmod_ofdm_tx_CFO_validation_CFO_range(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end
nn=nn+1; try pass(nn)=test_rfmod_ofdm_tx_CFO_validation_fs_range(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end
nn=nn+1; try pass(nn)=test_rfmod_timebase_vs_SFO_value(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end
nn=nn+1; try pass(nn)=test_rfmod_ofdm_tx_AWGN_small_step(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end
nn=nn+1; try pass(nn)=test_rfmod_ofdm_tx_AWGN_range(0); catch pass(nn)=-1; end;if show_progress==1, disp([nn, pass(nn)]); end
nn=nn+1; try pass(nn)=test_rfmod_qam_tx_AWGN_range(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end
nn=nn+1; try pass(nn)=test_rfmod_qam_tx_AWGN_small_step(0); catch pass(nn)=-1; end; if show_progress==1, disp([nn, pass(nn)]); end

all_test_pass=all(pass==1);

if all_test_pass==1
    disp('RF impariment modelling regression tests PASSED.')
else
    disp('RF impariment modelling regression tests FAILED.')
end

toc