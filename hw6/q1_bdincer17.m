%MATLAB 6
%a
n=0:1:100; %0<=n<=100 
x=sin(2*pi*n*0.05)+sin(2*pi*n*0.4); %x[c-n]
figure
stem((0:100),x) %plot of x
xlabel("n")
ylabel("Amplitude")
title("x[n]")
x1=fft(x,128);%128 point DFT of x[n]
figure
stem((0:127),abs(x1))
xlabel("freq")
ylabel("Magnitude")
title("DFT of x[n]")
%b
%%
y=downsample(x,2);%downsample by factor of 2
y1=fft(y,128); %DFT of y
figure
stem(y)
xlabel("n")
ylabel("Amplitude")
title("y[n]")
figure
stem((0:127),abs(y1))
xlabel("freq")
ylabel("Magnitude")
title("DFT of y[n]")
%%
%c
h=[0.2 0.2 0.2 0.2 0.2];%antialiasing filter
z=conv(x,h);%convolution of x and h
z_d=downsample(z,2);%downsample z by a factor of 2
zd1=fft(z_d,128);%128 point DFT
figure
stem((0:length(z_d)-1),z_d)
xlabel("n")
ylabel("Amplitude")
title("z[n]-downsampled ")
figure
stem((0:length(zd1)-1),abs(zd1))
xlabel("freq")
ylabel("Magnitude")
title("DFT of z[n]-downsampled")
%%
%d
up_y=upsample(y,2);%interopolate y by a factor of 2
up_y1=fft(up_y,128);%DFT of interpolated y
figure
stem(up_y)
xlabel("n")
ylabel("Amplitude")
title("upsampled y by a factor of 2")
figure
stem((0:127),abs(up_y1))
xlabel("freq")
ylabel("Magnitude")
title("DFT upsampled y ")

up_z=upsample(z_d,2);%upsample downsampled z by a factor of 2
up_z1=fft(up_z,128);%DFT of upsampled z
figure
stem(up_z)
xlabel("n")
ylabel("Amplitude")
title("Interpolation of downsampled z by a factor of 2")
figure
stem((0:127),abs(up_z1))
xlabel("freq")
ylabel("Magnitude")
title("DFT upsampled z ")
%%
%e
xn=0:length(up_y)-1; %sample points for zero order hold
xqn=0:0.2:length(up_y)-1;%query points for finer sampling over the range of xn
vq1 = interp1(xn,up_y,xqn,'nearest'); %interpolate with zero order hold
figure
plot(xn,up_y,'o',xqn,vq1,':.');
xlabel("n")
ylabel("Amplitude")
title("Zero older hold for interpolated y")
vq1_f=fft(vq1,128);
figure
stem((0:127),abs(vq1_f))
xlabel("freq")
ylabel("Magnitude")
title("DFT zero order hold for upsampled y")

xn1=0:length(up_z)-1; %sample points for zero order hold
xqn1=0:0.25:length(up_z)-1;%query points for finer sampling over the range of xn1
vq11 = interp1(xn1,up_z,xqn1,'nearest'); %interpolate with zero order hold
figure
plot(xn1,up_z,'o',xqn1,vq11,':.');
xlabel("n")
ylabel("Amplitude")
title("Zero older hold for interpolated z")
vq11_f=fft(vq11,128);
figure
stem((0:127),abs(vq11_f))
xlabel("freq")
ylabel("Magnitude")
title("DFT zero order hold for upsampled z")
%%
%f
xn_n=0:length(up_y)-1; %sample points for linear interpolation
xqn_n=0:0.25:length(up_y)-1;%query points for finer sampling over the range of xn_n
vq1_n = interp1(xn_n,up_y,xqn_n);%interpolate with linear interpolation
figure
plot(xn_n,up_y,'o',xqn_n,vq1_n,':.');
xlabel("n")
ylabel("Amplitude")
title("Linear interpolation for interpolated y")
vq1_fn=fft(vq1_n,128);
figure
stem((0:127),abs(vq1_fn))
xlabel("freq")
ylabel("Magnitude")
title("DFT linear interpolation for upsampled y")

xn1_n=0:length(up_z)-1;
xqn1_n=0:0.25:length(up_z)-1;
vq11_n = interp1(xn1_n,up_z,xqn1_n);
figure
plot(xn1_n,up_z,'o',xqn1_n,vq11_n,':.');
xlabel("n")
ylabel("Amplitude")
title("Linear interpolation for interpolated z")
vq11_fn=fft(vq11_n,128);
figure
stem((0:127),abs(vq11_fn))
xlabel("freq")
ylabel("Magnitude")
title("DFT linear interpolation for upsampled z")
