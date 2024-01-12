%% Question 1
N=15; %Sequence of the length
n=linspace(0,N-1,N);
x1=triangularPulse(0,(N-1)/2,N-1,n);
%------------------------a--------------------------
x1_ft=fft(x1,16); %16 point DFT
figure
stem(abs(x1_ft));
xlabel("k")
ylabel("X[K]")
title('16 point DFT')
%------------------------b--------------------------
x2_ft=fft(x1,32); %32 point DFT
figure
stem(abs(x2_ft));
xlabel("k")
ylabel("X[K]")
title('32 point DFT')
%------------------------c--------------------------
x3_ft=fft(x1,64); %64 point DFT
figure
stem(abs(x3_ft));
xlabel("k")
ylabel("X[K]")
title('64 point DFT')
%------------------------d--------------------------
x4_ft=fft(x1,128); %128 point DFT
figure
stem(abs(x4_ft));
xlabel("k")
ylabel("X[K]")
title('128 point DFT')
%% IDFT
%------------------------a--------------------------
ix1_ft=ifft(x1_ft); %16 point IDFT
figure
stem(ix1_ft)
xlabel("n")
ylabel("x[n]")
title('16 point IDFT')
%------------------------b--------------------------
ix2_ft=ifft(x2_ft); %32 point IDFT
figure
stem(ix2_ft);
xlabel("n")
ylabel("x[n]")
title('32 point IDFT')
%------------------------c--------------------------
ix3_ft=ifft(x3_ft); %64 point IDFT
figure
stem(ix3_ft)
xlabel("n")
ylabel("x[n]")
title('64 point IDFT')
%------------------------d--------------------------
ix4_ft=ifft(x4_ft); %128 point IDFT
figure
stem(ix4_ft)
xlabel("n")
ylabel("x[n]")
title('128 point IDFT')