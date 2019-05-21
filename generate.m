close all
clear all
clc

SCALING = 20;
VALUES_PER_HOUR=4;
STEP = 1/VALUES_PER_HOUR;
baseline=0;
NOISE = randn (VALUES_PER_HOUR*24,1);
time1=STEP:STEP:12;
time2=(12+STEP):STEP:24;
time= [time1 time2];
s1=cos((time1 / 12 * 2 * pi / 3)-pi/2)*SCALING + baseline;
s2=sin(((time2-12) / 12 * 2 * pi / 3) + pi/3)*SCALING*1.2 + baseline;
BASESIGNAL= [s1 s2];
BASESIGNAL=BASESIGNAL';
FINALSIGNAL= BASESIGNAL+NOISE;
figure (1)
plot (time,FINALSIGNAL)
title ('Daily Data Traffic');
xlabel ('Hours')
ylabel ('Data Traffic')
grid on;