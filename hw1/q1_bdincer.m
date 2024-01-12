%Question 1
%Constants
f_initial = 0; %The beginning frequency
f_final = pi;  %The ending frequency
sampling = 301;%Sample number
t = linspace(0,pi,sampling); %Time vector
l=length(t); %Length of the time vector
n=0:300; 
a=(f_final-f_initial)/l; %Slope of the frequency
fNew=f_initial+a*t; %New frequency value from initial frequency and slope
y=cos(fNew.*n);
figure
stem(y)

xlabel("Frequency");
ylabel("Amplitude");
title("Swept-frequency signal");
