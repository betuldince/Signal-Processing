%Question 4
%Constants
%a)
%------------------------------------------------------------------------------------------------------------------
t=0:0.0001:9 ; %Time
b=[0 0.5 1 1.5 2]; %Omega values
%Cos plots for given omega values
for i = 1:1:5
    y1 = cos(b(i)*pi*t);
    figure
    plot(y1)
xlabel("time");
ylabel("Amplitude");
title("Cosine signal with plot");
end
%b)
%-------------------------------------------------------------------------------------------------------------------
t1=0:0.1:9; %Another time function to get meaningfull results from stem funct,on
for i = 1:1:5
    y2 = cos(b(i)*pi*t1);
    figure
    stem(t1,y2)
    xlabel("time");
ylabel("Amplitude");
title("Cosine signal with stem");
end
