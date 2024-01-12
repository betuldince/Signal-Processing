%% AM MODULATION
% Part 1
%--------------------------------------------------------------------------
x=audioread('speech_dft_8kHz.wav');
%--------------------------------------------------------------------------
%(a)Upsample
%--------------------------------------------------------------------------
m=interp(x,150);
%--------------------------------------------------------------------------
%(b)Finding Sampling Frequency
%--------------------------------------------------------------------------
Fs=150*8000;
%--------------------------------------------------------------------------
%Variables
%--------------------------------------------------------------------------
ts=(0:length(m)-1)/Fs; %x-axes time interval
deltaM=max(abs(m));%Max value of speech signal
A=deltaM/0.7;%for m=0.7, the A value
kc=240000; %frequency of carrier signal
c=cos(2*pi.*kc.*ts); %carrier signal
%--------------------------------------------------------------------------
%(c)AM modulation
%--------------------------------------------------------------------------
y=((A)+m).*c(:);
%--------------------------------------------------------------------------
%(d)Fourier magnitude spectrum of m(t) and y(t)
%--------------------------------------------------------------------------
%Fourier Transform of Message Signal
ftM=fft(m); %Fourier Transform of message signal
f2=Fs*(0:length(ftM)-1)/length(ftM); %x-axes frequency interval for spectrum
magM=abs(ftM); %Magnitude of message signal in Frequency Domain
figure
plot(f2,mag2db(magM)); %Plotting Fourier Transform of message signal in dB
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of Message Signal');
%--------------------------------------------------------------------------
%Fourier Transform of modulated Signal
ftY=fft(y); %Fourier Transform of modulated signal
freqY=Fs*(0:length(ftY)-1)/length(ftY); %x-axes
magY=abs(ftY); %Magnitude of modulated signal in Frequency Domain
YDB=mag2db(magY); % y signal magnitude in dB 
figure
plot(freqY,YDB);
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of Modulated Signal');
%% Part 2- Demodulation
%--------------------------------------------------------------------------
%(a)Rectify
%--------------------------------------------------------------------------
%Multiplication by carrier signal
c=cos(2*pi.*kc.*ts);
YdeM=y.*c(:); %Demodulated Signal
%Rectify demodulated signal by diode
YtoRect2=zeros([5988300,1]);
for b=1:length(YdeM)
    if YdeM(b)>0
        YtoRect2(b)=YdeM(b);
    end 
end
ftYRect2=fft(YtoRect2); % Fourier Transform of Rectified Signal
freqYRect2=Fs*(0:length(ftYRect2)-1)/length(ftYRect2); % x-axes frequency values
magYRect2=abs(ftYRect2);
YRectDB2=mag2db(magYRect2);% Fourier Transform of Rectified Signal in dB
figure
subplot(2,1,1)
plot(YtoRect2)
xlabel('Time(t)')
ylabel('Magnitude')
title('Rectify Signal in Time Domain');
subplot(2,1,2)
plot(freqYRect2,YRectDB2)
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Spectrum of Rectify Signal');
%--------------------------------------------------------------------------
%(b)Low Pass Filter
%--------------------------------------------------------------------------
%İmpulse Response
 u=heaviside(ts); %unit step signal
 tcons=0.00005; %time constant
 %tcons1=0.0005; %time constant1
 h=exp(-ts/tcons).*u; %impulse response
 %--------------------------------------------------------------------------
 %Fouirer Transform of filter Signal
 ftH=fft(h); %Fourier Transform of impulse Response
 freqH=Fs*(0:length(ftH)-1)/length(ftH);
 magH=abs(ftH);
 HDB=mag2db(magH);
 figure
 subplot(2,1,1)
 plot(freqH,HDB)
 xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of filter Signal');
%--------------------------------------------------------------------------
%Fouirer Transform of filtered Signal
filt=ftH'.*ftYRect2; %Multipication of filter and Rectified Signal in Frequency Domain
freqFilt=Fs*(0:length(filt)-1)/length(filt);
magFilt=abs(filt);
YFiltDB=mag2db(magFilt);
subplot(2,1,2)
plot(freqFilt,YFiltDB)
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of filtered Signal');
%--------------------------------------------------------------------------
%Demodulated Signal and original message Signal
demodulated=ifft(filt); %Demodulation of filtered signal
figure
subplot(2,1,1)
plot(m); %Message Signal in time domain
xlabel('Time(t)')
ylabel('Magnitude')
title('Message Signal in Time Domain');
subplot(2,1,2)
plot(demodulated); %Demodulated Signal in time domain
xlabel('Time(t)')
ylabel('Magnitude')
title('Demodulated Signal in Time Domain');
%--------------------------------------------------------------------------
%(c)Downsample
%--------------------------------------------------------------------------
t1= decimate(demodulated,150); %Downsample by 150
soundsc(t1,8000) 
figure 
subplot(2,1,1)
plot(m); %Message Signal in time domain
xlabel('Time(t)')
ylabel('Magnitude')
title('Message Signal in Time Domain');
subplot(2,1,2)
plot(t1)
xlabel('Time(t)')
ylabel('Magnitude')
title('Downsampled Demodulated Signal in Time Domain');

%Fourier Transform of Message Signal
ftM=fft(m); %Fourier Transform of message signal
f2=Fs*(0:length(ftM)-1)/length(ftM); %x-axes frequency interval for spectrum
magM=abs(ftM); %Magnitude of message signal in Frequency Domain
figure
subplot(2,1,1)
plot(f2,mag2db(magM)); %Plotting Fourier Transform of message signal in dB
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of Message Signal');
%Fourier Transform of Downsampled Signal
ft_t1=fft(t1);
ff2=Fs*(0:length(ft_t1)-1)/length(ft_t1);
magt1=abs(ft_t1); %Magnitude of downsampled signal in Frequency Domain
subplot(2,1,2)
plot(ff2,mag2db(magt1)); %Plotting Fourier Transform of message signal in dB
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of Downsampled Signal');

%% Part 3 Gaussian noise
%Add 20 dB white Gaussian noise to y(t)
y1=awgn(y,20);
ftY=fft(y1);
freqY=Fs*(0:length(ftY)-1)/length(ftY);
magY=abs(ftY);
YDB=mag2db(magY);

%--------------------------------------------------------------------------
%(a)Rectify
%--------------------------------------------------------------------------
%Multiplication by carrier signal
YdeM=y1.*c(:); %Demodulated Signal
%Rectify demodulated signal by diode
YtoRect2=zeros([5988300,1]);
for b=1:length(YdeM)
    if YdeM(b)>0
        YtoRect2(b)=YdeM(b);
    end 
end
ftYRect2=fft(YtoRect2); % Fourier Transform of Rectified Signal
freqYRect2=Fs*(0:length(ftYRect2)-1)/length(ftYRect2); % x-axes frequency values
magYRect2=abs(ftYRect2);
YRectDB2=mag2db(magYRect2);% Fourier Transform of Rectified Signal in dB

figure
subplot(2,1,1)
plot(YtoRect2)
xlabel('Time(t)')
ylabel('Magnitude')
title('Rectify Signal in Time Domain');
subplot(2,1,2)
plot(freqYRect2,YRectDB2)
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Spectrum of Rectify Signal');

%--------------------------------------------------------------------------
%(b)Low Pass Filter
%--------------------------------------------------------------------------
%İmpulse Response
 u=heaviside(ts); %unit step signal
 tcons=0.00005; %time constant
 tcons1=0.0005; %time constant1
 h=exp(-ts/tcons).*u; %impulse response
 %--------------------------------------------------------------------------
 %Fouirer Transform of filter Signal
 ftH=fft(h); %Fourier Transform of impulse Response
 freqH=Fs*(0:length(ftH)-1)/length(ftH);
 magH=abs(ftH);
 HDB=mag2db(magH);
 figure
 subplot(2,1,1)
 plot(freqH,HDB)
 xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of filter Signal');
%--------------------------------------------------------------------------
%Fouirer Transform of filtered Signal
filt=ftH'.*ftYRect2; %Multipication of filter and Rectified Signal in Frequency Domain
freqFilt=Fs*(0:length(filt)-1)/length(filt);
magFilt=abs(filt);
YFiltDB=mag2db(magFilt);
subplot(2,1,2)
plot(freqFilt,YFiltDB)
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of filtered Signal');
%--------------------------------------------------------------------------
%Demodulated Signal and original message Signal
demodulated=ifft(filt); %Demodulation of filtered signal
figure
subplot(2,1,1)
plot(m); %Message Signal in time domain
xlabel('Time(t)')
ylabel('Magnitude')
title('Message Signal in Time Domain');
subplot(2,1,2)
plot(demodulated); %Demodulated Signal in time domain
xlabel('Time(t)')
ylabel('Magnitude')
title('Demodulated Signal in Time Domain');
%--------------------------------------------------------------------------
%(c)Downsample
%--------------------------------------------------------------------------
t1= decimate(demodulated,150); %Downsample by 150
soundsc(t1,8000) 
figure 
subplot(2,1,1)
plot(m); %Message Signal in time domain
xlabel('Time(t)')
ylabel('Magnitude')
title('Message Signal in Time Domain');
subplot(2,1,2)
plot(t1)
xlabel('Time(t)')
ylabel('Magnitude')
title('Downsampled Demodulated Noisy Signal in Time Domain');

%Fourier Transform of Message Signal
ftM=fft(m); %Fourier Transform of message signal
f2=Fs*(0:length(ftM)-1)/length(ftM); %x-axes frequency interval for spectrum
magM=abs(ftM); %Magnitude of message signal in Frequency Domain
figure
subplot(2,1,1)
plot(f2,mag2db(magM)); %Plotting Fourier Transform of message signal in dB
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of Message Signal');
%Fourier Transform of Downsampled Signal
ft_t1=fft(t1);
ff2=Fs*(0:length(ft_t1)-1)/length(ft_t1);
magt1=abs(ft_t1); %Magnitude of downsampled signal in Frequency Domain
subplot(2,1,2)
plot(ff2,mag2db(magt1)); %Plotting Fourier Transform of message signal in dB
xlabel('Frequency(Hz)')
ylabel('Magnitude(dB)')
title('Fouirer Transform of Downsampled Signal');



