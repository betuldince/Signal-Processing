%% Question 3
x1=[1 1 1 1 0 0 0 0]; % x sequence
%------------------------a--------------------------
figure
K1= fft(x1,8); % 8 point DFT
stem(abs(K1))
xlabel("k")
ylabel("X[K]")
title('8 point DFT')
%------------------------b--------------------------
n=16; % 16 point DFT
y=zeros(n);
for c=1:16
    if mod(c,2)==0 %even terms
     y(c)=x1(c/2);
    else
        y(c)=0; %odd terms
     end
end

figure
K1N= fft(y,16); %16 point DFT
stem(abs(K1N))
xlabel("k")
ylabel("X[K]")
title('16 point DFT')

