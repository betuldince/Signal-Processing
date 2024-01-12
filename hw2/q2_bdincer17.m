%% Question 2
%------------------------b--------------------------
n=0:30; %n vector 0 to 30(include unit step)
x=(1/3).^n;
figure
K= fft(x,16); %16 point DFT
K(3)
stem(abs(K))
xlabel("k")
ylabel("X[K]")
title('16 point DFT')
%------------------------c--------------------------
figure
K1= fft(x,512); %512 point DFT
stem(abs(K1))
K1(65)
xlabel("k")
ylabel("X[K]")
title('512 point DFT')