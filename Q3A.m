clear; 
close all;

%% Doppler processing
file='--';
path='--';

[BScans,SweepTime,CentreFreq,Bandwidth,T] = ReadSiversBIN(path,file);

DopplerSpectrum = (fftshift(fft(detrend(BScans), 1024, 1), 1));
[a, ~] = size(DopplerSpectrum);
f_s = a/SweepTime;
Maxfs = f_s/2;
c = 3e8;
lam = c/CentreFreq;
Vmax = (Maxfs*lam/2);

%% Plotting Doppler spectrum
%Slow time
t = linspace(0,T,size(BScans,2));

%Velocity vector
vAxis = linspace(-Vmax,Vmax,size(t, 2));

%Plotting the Doppler processed data
imagesc(t,vAxis,db(abs(DopplerSpectrum)));

%Beautification
colorbar
caxis([70 100])
set(gca,'ydir','norm');
xlabel('Slow time (s)');
ylabel('Velocity (m/s)');
title('Velocity Vs. Slow Time for pendulum');
ylim([0,10]);

%Linear Plot
maxDoppler =  db(abs(max(DopplerSpectrum)))./10;
%Obtaining the linear plot
figure(2);
plot(t, maxDoppler, 'LineWidth', 1.5);
xlabel('Slow time (s)');
ylabel('Velocity (m/s)');
title('Maximum Doppler Spectrum');

%% Period of the pendulum

period = fftshift(fft(DopplerSpectrum), 1);
freq = linspace(-Maxfs,Maxfs,size(period, 2));
figure(3);
plot(freq,max(abs(period)), 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Period of Pendulum Movement');