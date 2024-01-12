%Question 1

fs=8000; %Sampling Rate
F_edge=[2000 2500]; %Passband-Stoppband Edge
mag=[1 0];%1->Magnitude of passband 0->Magnitude of stopband
delta=[0.05 0.05]; %Tolerances of passband-stopband

[n_kaiser,Wn,beta,ftype] = kaiserord(F_edge,mag,delta,fs);
%n_kaiser-order of filter
%Wn-normalized freq.
%beta-affects the sidelobe attenuation of the 
%ftype-filter type
%n_kaiser; %show order

win=kaiser(n_kaiser+1,beta);
kaiser_win = fir1(n_kaiser,Wn,ftype,win );
figure
freqz(kaiser_win)
title("Normalized frequency and phase response of Kaiser window");


[n_parksMc,fo,ao,w] = firpmord(F_edge,mag,delta,fs);
%n_parksMc-order of filter
%fo-normalized freq. points
%ao-Amplitude response
%w-Weights

 n_parksMc; %show order

pm_win=firpm(n_parksMc,fo,ao,w);
figure
freqz(pm_win)
title("Frequency and phase response of Parks-McClellan window ");




