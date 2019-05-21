close all
clear all
clc

SCALING = 1000;
VALUES_PER_HOUR=12;
STEP = 1/VALUES_PER_HOUR;
baseline=250;
NOISE = SCALING*(randn (VALUES_PER_HOUR*24,1))/20;
time1=STEP:STEP:6;
time2=(6+STEP):STEP:12;
time3=(12+STEP):STEP:18;
time4=(18+STEP):STEP:24;
time= [time1 time2 time3 time4];
s1=(time1.*time1)*(baseline/36);
s2=cos(((time2-6) / 6 * 2 * pi / 3)-pi/2)*SCALING + baseline;
s3=sin(((time3-12) / 6 * 2 * pi / 3) + pi/3)*SCALING*1.2 + baseline;
s4=fliplr(s1);
BASESIGNAL= [s1 s2 s3 s4];
BASESIGNAL=BASESIGNAL';
FINALSIGNAL= BASESIGNAL+NOISE;
figure (1)
plot (time,FINALSIGNAL)
title ('Daily Data Traffic');
xlabel ('Hours')
ylabel ('Data Traffic')
grid on;