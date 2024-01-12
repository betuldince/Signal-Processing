%%Question 3
%a)
%-------------------------------------------------------------------------------------------------------------------
%for 25th order FIR filter
figure
%fir1 function creates FIR bandpass signal with given order and frequency 
b = fir1(25,[0.40 0.80]);
freqz(b,1,512)
title("25th order 0.40*pi-0.80*pi FIR bandpass filter");
%for 35th order FIR filter
figure
a = fir1(35,[0.40 0.80]);
freqz(a,1,512)
title("35th order 0.40*pi-0.80*pi FIR bandpass filter");
%b)
%-------------------------------------------------------------------------------------------------------------------
%25th order FIR signals with different passbands
figure
k=fir1(25,[0.10 0.30]);
freqz(k,1,512)
title("25th order 0.10*pi-0.30*pi FIR bandpass filter");
figure
k1=fir1(25,[0.40 0.60]);
freqz(k1,1,512)
title("25th order 0.40*pi-0.60*pi FIR bandpass filter");
figure
k2=fir1(25,[0.70 0.90]);
freqz(k2,1,512)
title("25th order 0.70*pi-0.90*pi FIR bandpass filter");

%c)
%-------------------------------------------------------------------------------------------------------------------
n=0:1:300; %Sampling the n axis
x=2*cos(52*pi*n/256)+3*cos(200*pi*n/256); %İnput signal
%d)
%-------------------------------------------------------------------------------------------------------------------
y=filter(k,1,x); %Passing x input signal to the first FIR bandpass filter
figure
subplot(2,1,1);
plot(mag2db(abs(fft(x))))
xlabel("time");
ylabel("Amplitude");
title("Input signal");
subplot(2,1,2);
plot(y)
xlabel("time");
ylabel("Amplitude");
title("Output signal filtered by 25th order 0.10*pi-0.30*pi FIR");
figure
y1=filter(k1,1,x); %Passing x input signal to the second FIR bandpass filter
subplot(2,1,1);
plot(mag2db(abs(fft(x))))
xlabel("time");
ylabel("Magnitude");
title("Input signal");
subplot(2,1,2);
plot(y1)
xlabel("time");
ylabel("Amplitude");
title("Output signal filtered by 0.40*pi-0.60*pi FIR ");
figure
subplot(2,1,1);
plot(mag2db(abs(fft(x))))
xlabel("time");
ylabel("Magnitude");
title("Input signal");
subplot(2,1,2);
y2=filter(k2,1,x); %Passing x input signal to the third FIR bandpass filter
plot(y2)
xlabel("time");
ylabel("Magnitude");
title("Output signal filtered by 0.70*pi-0.90*pi FIR ");