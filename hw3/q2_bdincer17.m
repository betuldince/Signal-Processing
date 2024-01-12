%Question 2
n=0:1:16000; 
x=cos(pi*n/4+1000*sin(pi*n/8000)); %x signal
rect=rectwin(256); %256 point rectangle
spectrogram(x,rect,50,256) %spectrogram of 256 point rectangular windowed x signal