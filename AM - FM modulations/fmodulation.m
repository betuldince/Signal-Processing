%% FM MODULATION
%Part 1
%--------------------------------------------------------------------------
%(a)Upsample
%--------------------------------------------------------------------------
x=audioread('speech_dft_8kHz.wav');
%Upsample speech signal by factor of 400
m1=interp(x,400); 
%--------------------------------------------------------------------------
%(b)Sampling Rate
%--------------------------------------------------------------------------
Fs=400*8000; %Sampling Rate
%--------------------------------------------------------------------------
%Variables
fc=480000; %carrier frequency
ts=(0:length(m1)-1)/Fs; %Sampling time
wc=2.*pi.*fc.*ts; %Angular sampling frequency
kf=150000; %given constant
integral=cumsum(m1)/Fs; %Integration by cumsum normalised by Fs
i=(kf.*integral); 
%--------------------------------------------------------------------------
%(c)Modulation 
%--------------------------------------------------------------------------
% Trigonometry: cos(a+b)=cosa*cosb-sin(a)*sin(b)
cosa=cos(wc);
cosb=cos(i);
sina=sin(wc);
sinb=sin(i);
%Modulated Signal
y=cosa(:).*cosb(:)-sina(:).*sinb(:);
%--------------------------------------------------------------------------
%(d)Fourier Transform of modulated Signal
%--------------------------------------------------------------------------
ftY=fft(y); %Fourier Transform of modulated signal
freqY=Fs*(0:length(ftY)-1)/length(ftY); %x-axes
magY=abs(ftY); %Magnitude of modulated signal in Frequency Domain
YDB=mag2db(magY); %y signal magnitude in dB
figure
plot(freqY,YDB)
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of Modulated Signal with Fs');
%--------------------------------------------------------------------------
%(e)Carson's Rule
%--------------------------------------------------------------------------
peakD=kf.*max(m1); %peak deviation
%% Part 2- Demodulation
%--------------------------------------------------------------------------
%(a)Differentiate
%--------------------------------------------------------------------------
dY=diff(y)*Fs;
%--------------------------------------------------------------------------
%(b)Rectify
%--------------------------------------------------------------------------
%Rectify demodulated signal by diode
YtoRect2=zeros([15968800,1]);
for b=1:length(dY)
    if dY(b)>0
        YtoRect2(b)=dY(b);
    end 
end
fYtoRect2=fft(YtoRect2); %Fourier Transform of Rectified Signal
%Fouirer Transform of filter Signal
 u=heaviside(ts); %unit step signal
 tcons=0.001; %time constant
 h=exp(-ts/tcons).*u; %impulse response
 ftH=fft(h); % Fourier Transform of impulse response
%--------------------------------------------------------------------------
%(c)Comparison
%--------------------------------------------------------------------------
%Comparison in time domain
%--------------------------------------------------------------------------
filt=ftH'.*fYtoRect2; %Multipication of filter and Rectified Signal in Frequency Domain
demodulated=ifft(filt); %Turn back to Time Domain
ts1=(0:length(demodulated)-1);
freqFilt=Fs*5*(0:length(demodulated)-1)/length(demodulated);
figure
subplot(2,1,1)
plot(ts1,demodulated);
xlabel('Time(t)')
ylabel('Amplitude')
title('Demodulated signal in time domain')
subplot(2,1,2)
plot(ts1,m1)
xlabel('Time(t)')
ylabel('Amplitude')
title('Speech signal in time domain')

%--------------------------------------------------------------------------
%Comparison in Frequency Domain
%--------------------------------------------------------------------------
fr_demod=fft(demodulated); %Again take the Forier Transfor of demodulated signal
fr_d=Fs*(0:length(fr_demod)-1)/length(fr_demod);
magD=abs(fr_demod);
figure
subplot(2,1,1)
plot(fr_d,mag2db(magD))
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of demodulated Signal');

ftM=fft(m1);
f2=Fs*(0:length(ftM)-1)/length(ftM);
magM=abs(ftM);

subplot(2,1,2)
plot(f2,mag2db(magM));
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of Message Signal');
%--------------------------------------------------------------------------
%(d)Comparison
%--------------------------------------------------------------------------
%Downsample to 8kHz by a factor of 400 .
t1= decimate(demodulated,400);
%soundsc(t1,8000)