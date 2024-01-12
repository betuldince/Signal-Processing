%% Question 1

fr_P=4000; %frequency of passband corner
fr_S=8000; %frequency of stopband corner
Fs=44000; %Sampling frequency

R=0.5; %passband ripple
SA=40; %stopband attentuation
%Normalized frequecies
N_fp=2*fr_P/Fs; %passband
N_fs=2*fr_S/Fs; %stopband

[Or_B,C_B] = buttord(N_fp,N_fs,R,SA); %Order and cutoff frequency for Butterworth 
[Or_C1,C_C1] = cheb1ord(N_fp,N_fs,R,SA); %Order and cutoff frequency for Chebyshev - 1 
[Or_C2,C_C2] = cheb2ord(N_fp,N_fs,R,SA); %Order and cutoff frequency for Chebyshev - 2
[Or_E,C_E] = ellipord(N_fp,N_fs,R,SA); %Order and cutoff frequency for Ellipord

%% Question 2
%filter design
%butteror
[b1,a1]=butter(Or_B,C_B); %returns the transfer function coefficients 
[H1,w1]=freqz(b1,a1); %returns the n-point complex frequency response for the digital filter 


figure
plot(w1/pi,20*log(abs(H1)))
xlabel('w/pi');
ylabel('|H(w)|')
title('Magnitude response-butterworth')
figure
plot(w1/pi,angle(H1))
xlabel('w/pi');
ylabel('angle H(w)')
title('Phase response-butterworth')

H_z1=tf(b1,a1,1);%convert dynamic system models to transfer function form to find analytical form

%%
%chebyshev 1
[b2,a2]=cheby1(Or_C1,R,N_fp);
[H2,w2]=freqz(b2,a2);

figure;
plot(w2/pi,20*log10(abs(H2)))
xlabel('w/pi');
ylabel('|H(w)|')
title('Magnitude response-chebyshev 1')
figure
plot(w2/pi,angle(H2))
xlabel('w/pi');
ylabel('<H(w)')
title('Phase response chebyshev 1 ')
H_z2=tf(b2,a2);

%%

%chebyshev Filter 2
[b3,a3] = cheby2(Or_C2,SA,N_fs);
[H3,w3]=freqz(b3,a3);
figure;
plot(w3/pi ,20*log10(abs(H3)))
xlabel('w/pi '); 
ylabel('|H(w)|  ')
title('Magnitude response-chebyshev2')
figure;
plot(w3/pi,angle(H3))
xlabel('w/pi');
ylabel('<H(w)')
title('Phase response chebyshev2')
H_z3=tf(b3,a3);
%%
%Elliptic
[b4,a4] = ellip(Or_E,R,SA,C_E);
[H4,w4]=freqz(b4,a4);
figure;
plot(w4/pi,20*log10(abs(H4)))
xlabel('w/pi '); 
ylabel('|H(w)|')
title('Magnitude response-Elliptic')
figure
plot(w4/pi,angle(H4))
xlabel('w/pi'); 
ylabel('<H(w)')
title('Phase response-Elliptic')
H_z4=tf(b4,a4);


