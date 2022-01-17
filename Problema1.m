clc
close all
clear all
format long

% amplitudine și frecvență aleatoare (la fiecare  rulare)
A2 = 2;
F2 = 20;

Fs = 5000;
Ts = 1/Fs;
A1 = 2;

a = -3;
b = 3;
t = a : Ts : b;

%generare semnal dreptunghiular
x1 = A1 * rectpuls(t, 2);

%generare semnal sinusoidal
x2 = A2 * sin(2 * pi * F2 * t);

%Suma celor doua semnale:
x3 = x1 + x2;

%Afisare semnale separat:

figure
hold on

subplot(3,1,1)
plot(t, x1, 'r')
xlabel('Timp')
ylabel('Amplitudine')
title('Semnal dreptunghiular')

subplot(3,1,2)
plot(t, x2, 'b')
xlabel('Timp')
ylabel('Amplitudine')
title('Semnal sinusoidal')


subplot(3,1,3)
plot(t, x3, 'g')
xlabel('Timp')
ylabel('Amplitudine')
title('Suma semnalelelor')

grid


%Semnal modulat in frecventa:
Nfft = length(x3) * 13;
pas = Fs/Nfft;
F = -Fs/2 : pas : Fs/2 - pas;
X3 = fft(x3, Nfft);

%Semnal modulat timp
kA = 2;
Ap = 10;
Fp = 1000;
 
xMA = (Ap + kA * x3) .* cos(2*pi*Fp*t);

%Semnal modulat in frecventa
Nfft3 = length(xMA) * 15;
F3 = -Fs/2 :Fs/Nfft3 : Fs/2 - Fs/Nfft3;
XMA = fft(xMA, Nfft3);

figure
hold on

subplot(2,1,1)
plot(t, xMA)
xlabel('timp')
ylabel('xMA(t)')
title('Semnal modulat in timp')

subplot(2,1,2)
plot(F3, abs(fftshift(XMA)))
xlabel('frecventa')
ylabel('XMA')
title('Semnal modulat in frecventa')

grid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Comparatii cu un al doilea semnal 

A11 = A1;
A22 = A2;
F22 = 2;

%t2 = -1 : Ts : 5;

%generam un al doilea semnal dreptunghiular
%x11 = A11 * rectpuls(t2, 1);
x11 = A11 * rectpuls(t, 1);

%generare al doilea semnal sinusoidal
%x22 = A22 * sin( 2 * pi * F22 * t2 );
x22 = A22 * sin( 2 * pi * F22 * t );

%Suma celor doua semnale:
x33 = x11 + x22;

figure
hold on

subplot(3,1,1)
%plot(t2, x11, 'r')
plot(t, x11, 'r')
xlabel('Timp')
ylabel('Amplitudine')
title('Semnal dreptunghiular 2')

subplot(3,1,2)
%plot(t2, x22, 'b')
plot(t, x22, 'b')
xlabel('Timp')
ylabel('Amplitudine')
title('Semnal sinusoidal 2')


subplot(3,1,3)
%plot(t2, x33, 'g')
plot(t, x33, 'g')
xlabel('Timp')
ylabel('Amplitudine')
title('Suma semnalelelor (2)')

grid

%Semnal modulat in frecventa:
Nfft2 = length(x33) * 13;
pas2 = Fs/Nfft2;
F2 = -Fs/2 : pas2 : Fs/2 - pas2;
X33 = fft(x33, Nfft2);

%Semnal modulat timp
kA = 2;
Ap = 10;
Fp = 1000;
 
%xMA2 = (Ap + kA * x33) .* cos(2*pi*Fp*t2);
xMA2 = (Ap + kA * x33) .* cos(2*pi*Fp*t);

%Semnal modulat in frecventa
Nfft33 = length(xMA2) * 15;
F3 = -Fs/2 : Fs/Nfft33 : Fs/2 - Fs/Nfft33;
XMA2 = fft(xMA2, Nfft33);

figure
hold on

plot(F, abs(fftshift(X3)), 'r')
plot(F, abs(fftshift(X33)), 'b')
xlabel('Frecventa')
ylabel('Amplitudine')
title('Suma semnalelor  modulata in frecventa (1) si (2)')

grid

figure
hold on

%plot(t2, xMA)
%plot(t2, xMA2)
plot(t, xMA)
plot(t, xMA2)
xlabel('timp')
ylabel('xMA(t)')
title('Semnal modulat in timp (1) si (2)')

grid

figure
hold on

plot(F3, abs(fftshift(XMA)))
plot(F3, abs(fftshift(XMA2)))
xlabel('frecventa')
ylabel('XMA')
title('Semnal modulat in frecventa (1) si (2)')

grid
