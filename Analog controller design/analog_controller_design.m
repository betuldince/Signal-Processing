%% Anolog controller Design
%---------------------------------------------------------------------------
%1) Plant
%---------------------------------------------------------------------------
%Constants
C=[0.02]; %numerator
k1=0.01*0.5;
k2=0.01+0.1*0.5;
k3=0.1+0.02*0.02;
den=[k1 k2 k3]; %denominator
T=0:0.001:5; %Sampling time
Ps=tf(C,den); % Function to create Plant
figure
step(Ps,T); %Plot Plant function
S=stepinfo(Ps);
[Y0]=step(Ps,T);
erroPlant=1-Y0(5001);
%---------------------------------------------------------------------------
%2
%---------------------------------------------------------------------------
Ku=90;
%Ku=20; %Ku value whre the plot starts to oscillation
%Ku=160;
%---------------------------------------------------------------------------
%3
%---------------------------------------------------------------------------
kp=Ku*0.5; %kp value for Proportional
ki=0;%ki=0 for proportional 
kd=0;%kd=0 for proportional
P=pid(kp,ki,kd); %we can use default PID function to create PID controller
F=[1]; % feeding 1 to the system 
sys=feedback(Ps*P,F); % Taking the feedback of the system
figure
step(Ps,T);
hold on
step(sys,T); % sampling feedback system with 0.001 seconds and ploting
xlim([0 5]);
S1=stepinfo(sys);
hold on
Tu=0.333; % From the above plot, we find the period of the oscillation
kp1=Ku*0.45; %placing kp,Ti,ki,kd values for PI
Ti=Tu/1.2;
ki1=kp/Ti;
kd1=0;
PI=pid(kp1,ki1,kd1);
sys1=feedback(Ps*PI,F);
step(sys1,T);
xlim([0 5]);
S2=stepinfo(sys1);

kp3=0.6*Ku; %placing kp,Ti,ki,kd values for PID
ki3=1.2*Ku/Tu;
kd3=0.6*Ku*Tu/8;
PID=pid(kp3,ki3,kd3);
sys3=feedback(Ps*PID,F);

step(sys3,T);
xlim([0 5]);
S3=stepinfo(sys3);
legend('Plant', 'P','PI','PID');
%Steady state error
[Y]=step(sys,T);
errorP=1-Y(5001);
[Y1]=step(sys1,T);
errorPI=abs(1-Y1(5001));
[Y2]=step(sys,T);
errorPID=1-Y2(5001);
%---------------------------------------------------------------------------
%4)
%---------------------------------------------------------------------------
T=0:0.001:5; %sampling time 
Tu=0.636-0.157; %period of the oscillation 
Ku=90; 
kp3N=0.9*Ku;
ki3N=1.2*Ku/Tu;
kd3N=1.8*Ku*Tu/8;
PIDN=pid(kp3N,ki3N,kd3N);
sys3N=feedback(Ps*PIDN,F);
[YN]=step(sys3N,T);
xlim([0 5]);
S355=stepinfo(sys3N);
errorPIDNew=1-YN(5001);
%---------------------------------------------------------------------------
%5)
%---------------------------------------------------------------------------
%Disturbing P,PI,PID by the unit step PS function
distP=feedback(Ps,P);
distPI=feedback(Ps,PI);
distPID=feedback(Ps,PID);
figure 
hold on
step(distP);
step(distPI);
step(distPID);
legend('P','PI','PID');