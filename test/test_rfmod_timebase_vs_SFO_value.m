function pass=test_rfmod_timebase_vs_SFO_value(dummy)
% Tests for the time base calculation in rfmos for 
% different fs, SFO and input vector length values.
% Li-Ke Huang 2011/01/05.
dummy=1;
nn=0;
nn=nn+1; P_map{nn}={1, 0, [1 100 1e3 1e4 1e5], 10};
nn=nn+1; P_map{nn}={1, 0.1, [100 1e3  1e4], 100};
nn=nn+1; P_map{nn}={1e6, 1e-6, 1e6, 1};
nn=nn+1; P_map{nn}={1e6, -1e-6, 1e6, 1};
nn=nn+1; P_map{nn}={1e6, 1e-6, 1e6/2, 2};
nn=nn+1; P_map{nn}={1e6, 0.1e-6, 1e6/2, 2};
nn=nn+1; P_map{nn}={1e6, -0.01e-6, 1e6/2, 2};
nn=nn+1; P_map{nn}={1e6, 0.001e-6, 1e6/2, 2};
nn=nn+1; P_map{nn}={1e6, 2e-6, 1e6/2, 2};
nn=nn+1; P_map{nn}={1e6, -10e-6, 1e6/2, 2};
nn=nn+1; P_map{nn}={10e6, -10e-6, 1e6/2, 2};
pp=nan(size(P_map));
for mm=1:length(P_map)
    [fs, SFO, L_map, M_loop]=deal(P_map{mm}{:});
    [t1, t2, d1, d2, ee]=test_rfmod_timebase(fs, SFO, L_map, M_loop);
    EE=ee(end)-length(t2)*SFO/fs;
    pp(mm)=EE<1e-16;
end
pass=all(pp);