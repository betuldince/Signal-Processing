%% Question 4
%------------------------a--------------------------
%Padded signals
x = [6 5 4 3 2 1];
y = [1 0 0 0 1 0];
xNew = [x zeros(1,11-length(x))]; %to have valid length
yNew = [y zeros(1,11-length(y))];  %to have valid length
circular = ifft(fft(xNew).*fft(yNew));
figure
stem(circular)
title('Circularly Convoled xNew and yNew for 6 point')
% To find 10 point DFT
x1 = [6 5 4 3 2 1 0 0 0 0]; %padding with zeros
y1 = [1 0 0 0 1 0 0 0 0 0];

x1New = [x1 zeros(1,19-length(x1))];
y1New = [y1 zeros(1,19-length(y1))];
circular1 = ifft(fft(x1New).*fft(y1New));
figure
stem(circular1)
title('Circularly Convoled x1New and y1New for 10 point')

%------------------------a-------------------------
%%
%Aliased versions
x1=[6 5 4 3 2 1 ]; %x1[n]
x2=[1 0 0 0 1 ]; %x2[n]
x1N= fft(x1,6); %6 point DFT of X1[k]
x2N= fft(x2,6); %6 point DFT X2[k]
xN=x1N.*x2N; %6 point X[k]=X1[k]*X2[k]
figure
i_fft=ifft(xN); %Inverse 6 point DFT of X[k]
stem(i_fft)
xlabel("n")
ylabel("X[n]")
title('6 point circular convolution-aliased version')

x1N= fft(x1,10); %10 point DFT of X1[k]
x2N= fft(x2,10); %10 point DFT of X2[k]
xNN=x1N.*x2N; %10 point X[k]=X1[k]*X2[k]
figure
i_fftN=ifft(xNN); %Inverse 6 point DFT of X[k]
stem(i_fftN)
xlabel("n")
ylabel("X[n]")
title('10 point circular convolution')
%------------------------b--------------------------
%%
newL=conv(x,y);
stem(newL)