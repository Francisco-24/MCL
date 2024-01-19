clc
clear all
close all

angle = [0 90 45 -45];
T_epsilon_inv = zeros (3,3,4);
for i=1:4
    m = cosd(angle(i));
    n = sind(angle(i));
    T_epsilon_inv(:,:,i) = [m^2 n^2 -m*n; n^2 m^2 m*n; 2*m*n -2*m*n m^2-n^2];
end

%% Ensaio de Flexão

extensoes_local_1 = [1.435*10^-4; 2.3765*10^-4; 9.3425*10^-4];
extensoes_1 = T_epsilon_inv(:,:,4)*extensoes_local_1;

extensoes_local_2 = [5.805*10^-5; 1.053*10^-4; 3.4705*10^-4];
extensoes_2 = T_epsilon_inv(:,:,4)*extensoes_local_2;

Exx_1 = 15.039/extensoes_1(1)*10^-3
Exx_2 = 14.724/extensoes_2(1)*10^-3

P = 20;
L = 200;
delta_1 = 5.02;
delta_2 = 1.96;
Iy = 435.831;
Exx_1_ = P*L^3/(3*delta_1*Iy)*10^-3
Exx_2_ = P*L^3/(3*delta_2*Iy)*10^-3

Exx_1_TC = 14.511/(726.8*10^-6)*10^-3
Exx_2_TC = 14.439/(274.5*10^-6)*10^-3

delta_1_TC = 5.877;
delta_2_TC = 2.220;
Exx_1_TC_ = P*L^3/(3*delta_1_TC*Iy)*10^-3
Exx_2_TC_ = P*L^3/(3*delta_2_TC*Iy)*10^-3

%% Deflexão

w0_1 = readmatrix('Livro1.xlsx', 'Sheet', 'Folha1', 'Range', 'H3:H203');
w0_2 = readmatrix('Livro1.xlsx', 'Sheet', 'Folha1', 'Range', 'G3:G203');
