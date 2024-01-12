%%
%Part1
s=tf('s'); %to transform letter s to the 's' symbol
%Constants
R1=8;
R2=3.75;
L=50*10^-3;
C1=8*10^-3;
a=0.125;
b=-1;
K=1;
%RLC circuit transfer function
Z1=(s*L+R2)/(1+s^2*L*C1+s*R2*C1);
sy=Z1/(R1+Z1);
%Plant
P=1/(a*s+b);
%Feedback system
sys1=feedback(P*sy,K);
figure
step(sys1);
%%
%Part2
K1=6; %gain value for stable system
sys2=feedback(P*sy,K1);
figure
step(sys2);
figure
rlocus(sys2);


%%
%Part 3
Ts=2*10^-3; %sampling period
sysd=c2d(sy,Ts);
figure 
rlocusplot(sysd);
figure
rlocusplot(sy);
%%
%Part4
sysc=d2c(sysd);
figure 
rlocusplot(sysc); %Root locus for converted C(s)
figure 
rlocusplot(sy); %Root locus for original C(s)
figure 
step(sysc); %Step response converted C(s)
figure 
step(sy); %Step response for original C(s)


sysfin=feedback(P*sysc,6);%Feeding converted C(s) to the system
figure
step(sysfin);
