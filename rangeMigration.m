clear; 
close all;

%% Doppler processing Range Vs. Slow-Time
file='--';
path='--';

[BScans,SweepTime,CentreFreq,Bandwidth,T] = ReadSiversBIN(path,file);

DopplerSpectrum = (fftshift(fft(detrend(BScans), 1024, 1), 1));
[a, b] = size(DopplerSpectrum);
f_s = a/SweepTime;
Maxfs = f_s/2;
c = 3e8;
lam = c/CentreFreq;

%% Plotting Doppler spectrum
%Slow time
t = linspace(0,T,size(BScans,2));

%Velocity vector
range = linspace(0, 5, size(BScans,2));
imagesc(t,range,db(abs(DopplerSpectrum)./max(max(DopplerSpectrum))));
colorbar
caxis([-50 0])
set(gca,'ydir','norm');
xlabel('Slow time (s)');
ylabel('Range (m)');
title('Velocity Vs. Slow Time for pendulum');
%ylim([0,3.5]);

%Linear Plot
maxDoppler =  db(abs(max(DopplerSpectrum)))./10;
%Obtaining the linear plot
figure(2);
plot(t, maxDoppler, 'LineWidth', 1.5);
xlabel('Slow time (s)');
ylabel('Range (m)');
title('Maximum Doppler Spectrum');

%% Period of the pendulum

period = fftshift(fft(DopplerSpectrum), 1);
freq = linspace(-Maxfs,Maxfs,size(period, 2));
figure(3);
plot(freq,max(abs(period)), 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Period of Pendulum Movement');