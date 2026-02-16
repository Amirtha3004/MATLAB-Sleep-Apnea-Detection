clc;
clear;
close all;
fs = 50;              
t = 0:1/fs:120;           
% Bandpass filter design (0.1–0.5 Hz)
[b,a] = butter(2,[0.1 0.5]/(fs/2),'bandpass');
resp_normal = 0.8*sin(2*pi*0.25*t);        
resp_normal = resp_normal + 0.1*randn(size(t));
filtered_normal = filtfilt(b,a,resp_normal);
[pks_n,locs_n] = findpeaks(filtered_normal,t,...
    'MinPeakDistance',2,...
    'MinPeakHeight',0.2);
num_breaths_n = length(locs_n);
duration = t(end) - t(1);
RR_normal = (num_breaths_n/duration)*60;
intervals_n = diff(locs_n);
max_interval_n = max(intervals_n);
if max_interval_n >= 10
    status_n = 'Sleep Apnea Detected!';
else
    status_n = 'Normal Breathing Pattern';
end
fprintf('\n===== NORMAL CASE =====\n');
fprintf('Respiratory Rate: %.2f breaths/min\n',RR_normal);
fprintf('Maximum Breathing Interval: %.2f seconds\n', max_interval_n);
disp(status_n);

figure;
subplot(4,1,1)
plot(t,resp_normal)
title('Normal Respiratory Signal')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,2)
plot(t,filtered_normal)
title('Filtered Signal')

subplot(4,1,3)
plot(t,filtered_normal)
hold on
plot(locs_n,pks_n,'ro')
title(['Detected Breaths - ', status_n])

subplot(4,1,4)
plot(intervals_n)
title('Respiratory Rate Variability')
sgtitle('Normal Case Analysis')
saveas(gcf,'Normal_Case.png');

resp_abnormal = 0.8*sin(2*pi*0.25*t);
resp_abnormal = resp_abnormal + 0.1*randn(size(t));
resp_abnormal(t>30 & t<45) = 0;

filtered_abnormal = filtfilt(b,a,resp_abnormal);

[pks_a,locs_a] = findpeaks(filtered_abnormal,t,...
    'MinPeakDistance',2,...
    'MinPeakHeight',0.2);

num_breaths_a = length(locs_a);
RR_abnormal = (num_breaths_a/duration)*60;

intervals_a = diff(locs_a);
max_interval_a = max(intervals_a);

if max_interval_a >= 10
    status_a = 'Sleep Apnea Detected!';
else
    status_a = 'Normal Breathing Pattern';
end

fprintf('\n===== ABNORMAL CASE =====\n');
fprintf('Respiratory Rate: %.2f breaths/min\n',RR_abnormal);
fprintf('Maximum Breathing Interval: %.2f seconds\n', max_interval_a);
disp(status_a);

figure;
subplot(4,1,1)
plot(t,resp_abnormal)
title('Abnormal Respiratory Signal (Apnea Present)')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,2)
plot(t,filtered_abnormal)
title('Filtered Signal')

subplot(4,1,3)
plot(t,filtered_abnormal)
hold on
plot(locs_a,pks_a,'ro')
title(['Detected Breaths - ', status_a])

subplot(4,1,4)
plot(intervals_a)
title('Respiratory Rate Variability')
sgtitle('Abnormal Case Analysis')
saveas(gcf,'Abnormal_Case.png');
figure;
plot(intervals_n,'b','LineWidth',1.5)
hold on
plot(intervals_a,'r','LineWidth',1.5)
legend('Normal','Abnormal')
title('Comparison of Respiratory Rate Variability')
xlabel('Breath Number')
ylabel('Interval (s)')
grid on
saveas(gcf,'Sleep_Apnea_Results.png');
