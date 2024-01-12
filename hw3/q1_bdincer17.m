%%Question 1
%a part
n=0:127; %128 points
rect=rectwin(128)'; %rectangular window
hamm=hamming(128)';%hamming window
%x
x_1=cos(pi*n/4)+cos(0.26*pi*n);
x_2=cos(pi*n/4)+(1/3)*cos(pi*n/8); 
x_3=cos(pi*n/8)+(1/3)*cos(pi*n/16); 
%v[n]=x[n]w[n] where w[n] is 128 point rectangular window
vr_1=x_1.*rect;
f_vr_1=fft(vr_1,128); %128 point fft for x1
vr_2=x_2.*rect;
f_vr_2=fft(vr_2,128);%128 point fft for x2
vr_3=x_3.*rect;
f_vr_3=fft(vr_3,128);%128 point fft for x3

%Sketch magnitude of discrete time V[k]<rectangular window>
figure
stem(n, abs(f_vr_1))
xlabel("n")
ylabel("Magnitude of V[k]")
title("V[k] for x1 and rectangular window")
figure
stem(n, abs(f_vr_2))
xlabel("n")
ylabel("Magnitude of V[k]")
title("V[k] for x2 and rectangular window")
figure
stem(n, abs(f_vr_3))
xlabel("n")
ylabel("Magnitude of V[k]")
title("V[k] for x3 and rectangular window")

%b part
%v[n]=x[n]w[n] where w[n] is 128 point hamming window
vh_1=x_1.*hamm;
f_vh_1=fft(vh_1,128);%128 point fft for x1
vh_2=x_2.*hamm;
f_vh_2=fft(vh_2,128);%128 point fft for x2
vh_3=x_3.*hamm;
f_vh_3=fft(vh_3,128);%128 point fft for x3

%Sketch magnitude of discrete time V[k]<hamming window>
figure
stem(n, abs(f_vh_1))
xlabel("n")
ylabel("Magnitude of V[k]")
title("V[k] for x1 and hamming window")
figure
stem(n, abs(f_vh_2))
xlabel("n")
ylabel("Magnitude of V[k]")
title("V[k] for x2 and hamming window")
figure
stem(n, abs(f_vh_3))
xlabel("n")
ylabel("Magnitude of V[k]")
title("V[k] for x3 and hamming window")