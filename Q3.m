%% task 2 practicum 3
clear 
close all

%% A.2 Pendulum Period
file='--';
path='--';

[BScans,SweepTime,CentreFreq,Bandwidth,T] = ReadSiversBIN(path,file);
t = linspace(0,T,size(BScans,2));
limit = size(BScans,1)/SweepTime;
f = linspace(-limit/2,limit/2,size(BScans,1));
BScans = detrend(BScans);
f_rec = fftshift(fft(BScans));
figure(1);
f_rec(1:floor(size(f_rec,1)/2)+10,:)=0;
f_d = NaN(size(BScans,2),1);
for i=1:size(BScans,2)
    plot(f,abs(f_rec(:,i))); hold on;
    [~,pos] = max(abs(f_rec(:,i)));
    f_d(i) = f(pos);
end
hold off;

figure(2);
plot(t,f_d)
limit2 = length(f_d)/T;
period = fftshift(fft(f_d));
f2 = linspace(-limit2/2,limit2/2,length(f_d));
figure(3); 

plot(f2, abs(period),'LineWidth',2)
grid on
ylim([0 12e4])
xlim([0 3])
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('Period of Pendulum Movement')
%% display image of the frequency spectrum
% f_rec = fftshift(fft(BScans), 1);
% c=3e8;
% lambda=c/CentreFreq;
% velocity=f_rec.*lambda/2;
% y = [f(1) f(end)];
% %r=3e8./(2.*Bandwidth);
% %y=[r(1) r(end)];
% x = [0 T];
% figure(4); imagesc(t,velocity(1),abs(f_rec))
% xlabel('time (s)')
% ylabel('frequency (kHz)')
% ylim([-5 5])
% title('Slow time ? frequency plot')