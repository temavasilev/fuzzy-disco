function [FINALSIGNAL, time] = generate(SCALING,VALUES_PER_HOUR)
%generate: Generates a Distribution that mimicks a sample data set with
%random variations

%SCALING = 150; %simple multiplier for height of curve
%VALUES_PER_HOUR=4; %affects Noise. Bigger number -> more Noise. Minimum is 1. Any higher than 15 is overkill
STEP = 1/VALUES_PER_HOUR;
baseline=SCALING/5; %constant value that is added to every point on the signal
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

for i = 1:1:(24*VALUES_PER_HOUR)
   FINALSIGNAL(i) = floor(FINALSIGNAL(i)); 
   if FINALSIGNAL(i) < 1
       FINALSIGNAL(i) = 1;
   end
   

end

%plot (  time, FINALSIGNAL);

end
