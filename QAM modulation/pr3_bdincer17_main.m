%%
%Part 1
x = randi([0 1],120,1); %create random sequence
stem(x(1:40),'filled'); %plot random sequence
title('Random Bits');
xlabel('Bit Index');
ylabel('Binary Value');
%%
%convert binary random values to the integer valeus
k=4;
xInMatrix = reshape(x,length(x)/k,k); %reshaping rhe x sequence for conversion
xSymbolsIn = bi2de(xInMatrix); %decimal to binary conversion
dataMod = qammod(xSymbolsIn,16,'bin');
scatterplot(dataMod,1,0,'k*') %I(t) Q(t) constellation
%%
%Part C
%Constants
fb=50;%Baud rate
fc=1000;%Carrier frequency
fs=5000;%Sampling rate

 tb=1/fb;%Baud sampling tim
 t=0:tb:100;% Duration of Signal
 s=[];
    
    for i=1:1:4       % Modulation (multiplication with carrier signals cos and sin)
        Ac=real(dataMod(i));
        As=imag(dataMod(i));
        s1=Ac.*cos(2*pi*(fc/fs).*t); %For I(t)
        s2=As.*sin(2*pi*(fc/fs).*t);  %For Q(t)
        s=[s (s1+s2)];
    end
    figure(1)
    plot(s)     % 's' demotes the transmitted signal
    title('16-QAM Modulated Signal')
    xlabel("Frequency");
    %%
    %Part d
   
  
 rs1=2*cos(2*pi*(fc/fs)*t);  % Sin and Cos generation by Local Oscillator
 rs2=2*sin(2*pi*(fc/fs)*t);
    
 
 int1=[];
 int2=[];
 xNew1;
  k=rs1.*s1; 
  l=rs2.*s2;
  for n=0:1:120
  int1= integral(k,n*tb,(n+1)*tb); %Demodulation with local carriers
  int2= integral(l,n*tb,(n+1)*tb);
  intN=[intN(int+int2)];
  xNew1=floor(intN);%rounding
 xConverted=de2bi(xNew1); %decimal to binary
  end
%%
%Part 2
%(a)With 10 dB SNR
snr=10; %SNR value
receivedSignal = awgn(s,snr,'measured'); 
figure
plot(receivedSignal);
  title('16-QAM Modulated Signal with SNR')
    xlabel("Frequency");
%(d)
int11=[];
 int22=[];
 xNew11;
  k1=rs1.*receivedSignal; 
  l1=rs2.*receivedSignal;
  for n=0:1:120
  int11= integral(k1,n*tb,(n+1)*tb); %Demodulation with local carriers
  int22= integral(l1,n*tb,(n+1)*tb);
  intN1=[intN1(int+int2)];
  xNew11=floor(intN1);%rounding
 xConverted1=de2bi(xNew11); %decimal to binary
  end
