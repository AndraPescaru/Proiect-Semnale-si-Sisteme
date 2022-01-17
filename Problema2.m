clc
close all
clear all
format long

Fp1 =500;
Ap1 = 0;
Fp2 = 2000;
Ap2 = 10;
f = 10;
Fs = 10000;
A1 = 2;

Ts = 1 / Fs;
t1 = -0.1 : Ts : 0.1;

% Generarea semnalului dreptunghiular periodic:
x1 = A1 * square( 2 * pi * f * t1);
%x1 = A1 * rectpuls(t1);
%x2 = [x1, x1, x1, x1, x1, x1, x1];
x2 = x1

%Modulam MA-PS semnalul in domeniul timp:
kA = 2;
xMAPS = kA * x2 .* cos( 2 * pi * Fp1 * t1);

% Semnalul modulat MA-PS moduleaza MA semnalul cu purtatoare Fp2 in domeniul timp:
xMA = (Ap2 + kA * xMAPS) .* cos(2 * pi * Fp2 * t1);

%Afisarea semnalelor:
figure
hold on

subplot(3,1,1)
plot(x2,'g')
xlabel('Timp')
ylabel('Amplitudine')
title('Semnal dreptunghiular periodic')

subplot(3,1,2)
plot(t1, xMAPS)
xlabel('Timp')
ylabel('xMAPS')
title('Semnal modulat MA-PS')

subplot(3,1,3)
plot(t1, xMA)
xlabel('Timp')
ylabel('xMA')
title('Semnal modulat MA')

grid

%Analiza in frecventa:

% Semnalul dreptunghiular periodic in domeniul frecventa:
Nfft1 = length(x2) * 13;
pas1 = Fs/Nfft1;
F1 = -Fs/2 : pas1 : Fs/2 - pas1;
X2 = fft(x2, Nfft1);

%Modulam MA-PS semnalul in domeniul frecventa:
Nfft2 = length(xMAPS) * 13;
pas2 = Fs / Nfft2;
F2 = -Fs/2 : pas2 : Fs/2 - pas2;
XMAPS = fft(xMAPS, Nfft2);

% Semnalul modulat MA-PS moduleaza MA semnalul cu purtatoare Fp2 in
% domeniul frecventa: 
Nfft3 = length(xMA) * 13;
pas3 = Fs / Nfft3;
F3 = -Fs/2 : pas3 : Fs/2 - pas3;
XMA = fft(xMA, Nfft3);

% Afisarea semnalelor:
figure
hold on

subplot(3,1,1)
plot(F1, abs(fftshift(X2)))
xlabel('Frecventa')
ylabel('Amplitudine')
title('Semnalul dreptunghiular modulat in frecventa')

subplot(3,1,2)
plot(F2, abs(fftshift(XMAPS)))
xlabel('Frecventa')
ylabel('xMAPS')
title('Semnal  MA-PS in frecventa')

subplot(3,1,3)
plot(F3, abs(fftshift(XMA)))
xlabel('Frecventa')
ylabel('xMA')
title('Semnal  MA  in frecventa')

grid
