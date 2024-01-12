%Question 2
%Constants
F=1000; %Sampling Frequency
T=1/F;  %Sampling period
l=1000; %Length of initial signal
tV=(0:l-1)*T; %Time Vector
f1=60; %1st frequency
f2=150; %2nd frequency

%Cos signals derived by given constants
y1=0.7*cos(2*pi*f1.*tV); 
y2=1.1*cos(2*pi*f2.*tV);
%Noise
n = 0 + 2 .* randn([1,1000]);
%Adding noise to the given signals
y1Noisy=y2+y1+n;
 
figure
plot(y1Noisy);
xlabel("time");
ylabel("Amplitude");
title("Noisy signal in time domain");

figure
ftG=fft(y1Noisy); %Fourier transform of noisy signal
plot(mag2db(abs(ftG)));
xlabel("Frequency");
ylabel("Magnitude");
title("Noisy signal in frequency domain");