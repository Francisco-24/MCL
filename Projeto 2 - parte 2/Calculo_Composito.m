clear 
close all
clc

%% INPUTS
% Preencher
laminas = 24;

% Preencher o seguinte vetor:
% 1 -> camada de carbono 45 graus
% 2 -> camada de carbono -45 graus
% 3 -> camada de carbono 90 graus
% 4 -> camada de carbono 0 graus

%Empilhamento C
n = [2 2 2 2 1 1 1 1 3 3 3 4 4 3 3 3 1 1 1 1 2 2 2 2];

%% LAMINADO CARBONO T800 COM RESINA EPOXÍDICA

%Carbono T800
ro_carbono = 1754; 
E_carbono = 290000; 
v_carbono = 0.35;
sigma_r = 2.8; 
gramagem = 200;
hi = 0.19;
Vf = 0.6;
Gf = E_carbono/(2*(1+v_carbono));

%Resina 
ro_resina = 1200;
E_resina = 4500;
v_resina = 0.4;
Vm = 0.4;
Gm = E_resina/(2*(1+v_resina));

%Lei das misturas
% E_L = Vm*E_resina + Vf*E_carbono;
% v_LT = Vf*v_carbono + Vm*v_resina;
% E_T = 1/(Vf/E_carbono + Vm/E_resina);
% G_LT = 1/(Vf/Gf + Vm/Gm);
% v_TL = E_T*v_LT/E_L;

% Set 1 props - tensão aplicada 
% E_L = 73.8892*10^3;
% v_LT = 0.3101;
% E_T = 20.5717*10^3;
% G_LT = 6.2404*10^3;
% v_TL = 0.0863;

% Set 2 props - deslocamento aplicado
E_L = 176.1647*10^3;
v_LT = 0.3631;
E_T = 38.3081*10^3;
G_LT = 17.9012*10^3;
v_TL = 0.0790;

espessura_lamina = hi;
espessura = laminas*espessura_lamina; 
Props_fibra = [E_L E_T v_LT v_TL G_LT];

%% matriz Q

Q_inv = [1/E_L -v_TL/E_T 0; -v_LT/E_L 1/E_T 0; 0 0 1/G_LT];
Q = inv(Q_inv)/10^3;

Q_lamina = zeros(3,3,laminas);
Q_laminaGPA = zeros(3,3,laminas);

for i=1:laminas
    Q_lamina(:,:,i) = matriz_Q(n(i), Props_fibra);
    Q_laminaGPA(:,:,i) = Q_lamina(:,:,i)*10^-3;
end

%% Calcular posições das laminas em altura

z = zeros(1,laminas/2);

for i=1:((laminas/2))
    z(i)=(i)*espessura_lamina; 
end

z=[-flip(z),0,z];

%% matriz ABD

 A=zeros(3,3);
 B=zeros(3,3);
 D=zeros(3,3);

 for i=1:3
     for j=1:3
         for k=1:laminas
                 A(i,j)=A(i,j) + Q_lamina(i,j,k)*(z(k+1)-z(k));
                 B(i,j)=B(i,j) + (Q_lamina(i,j,k)/2)*(z(k+1)^2-z(k)^2);
                 D(i,j)=D(i,j) + (Q_lamina(i,j,k)/3)*(z(k+1)^3-z(k)^3);
         end
     end
 end

ABD_matrix = [A,B;B,D];

ABD_inverse = inv(ABD_matrix);
A_inverse = inv(A);
D_inverse = inv(D);
A_GPa = A*10^-3;
D_GPa = D*10^-3;

%% Constantes de Elasticidade do laminado [MPa]

Ex = 1/(espessura*A_inverse(1,1));
Ey = 1/(espessura*A_inverse(2,2));
vxy = -A_inverse(2,1)/A_inverse(1,1);
vyx = vxy*Ey/Ex;
Gxy = 1/(espessura*A_inverse(3,3));

Props_laminado = [Ex Ey vxy vyx Gxy]

%% Constantes de Elasticidade de Flexão do laminado [MPa]

Efx = 12/(D_inverse(1,1)*espessura^3);
Efy = 12/(D_inverse(2,2)*espessura^3);
vfxy = -D_inverse(2,1)/D_inverse(1,1);
vfyx = -D_inverse(1,2)/D_inverse(2,2);
Gfxy = 12/(D_inverse(3,3)*espessura^3);


%% Tensões ao longo da espessura do laminado - ensaio de tração

b = 57.20;
Nx = 8000/b;
Ny = 0;
Nxy = 0;
F = [Nx Ny Nxy]';

% extensoes = A_inverse * F;
extensoes = A\F;

tensoes = zeros(3,laminas);

for i=1:laminas
    tensoes(:,i) = Q_lamina (:,:,i) * extensoes;
end

aux = [linspace(-2.28,-2.29+0.19*4,4) linspace(-2.29+0.19*4,-0.19*4,4) linspace(-0.19*4,-0.19,3) -0.19];
aux_ = flip(aux);
pos_lamina = [aux -aux_];

figure
plot(tensoes(1,:),pos_lamina,'LineWidth',2)
title('Tensão no eixo x em função da espessura')
xlabel('\sigma_x (MPa)')
ylabel('z (mm)')


figure
plot(tensoes(2,:),pos_lamina,'LineWidth',2)
title('Tensão no eixo y em função da espessura')
xlabel('\sigma_y (MPa)')
ylabel('z (mm)')


figure
plot(tensoes(3,:),pos_lamina,'LineWidth',2)
title('Tensão no eixo xy em função da espessura')
xlabel('\tau_{xy} (MPa)')
ylabel('z (mm)')


%% Tensões ao longo da espessura do laminado - ensaio de flexão
P = 9;
L = 200;
b= 57.20;
Mx = P*L/b;
My = 0;
Mxy = 0;

M = [Mx My Mxy]';

ks = D\M;

extensoes_lam = zeros(3,length(z));
for i=1:length(z)
    extensoes_lam(:,i) = z(i)*ks;
end

tensoes_lam = zeros(3,16);

% lamina de 0 graus (está entre o z(13) e o z(14))
tensoes_lam(:,1) = Q_lamina(:,:,13)*extensoes_lam(:,13);
tensoes_lam(:,2) = Q_lamina(:,:,13)*extensoes_lam(:,14);

% laminas de 90 graus (estao entre z(14) e z(17))
for i=3:6
    tensoes_lam(:,i) = Q_lamina(:,:,14)*extensoes_lam(:,11+i);
end

% laminas de 45 graus (estao entre z(17) e z(21))
for i=7:11
    tensoes_lam(:,i) = Q_lamina(:,:,20)*extensoes_lam(:,10+i);
end

%laminas de -45 graus (estao entre z(21) e z(25)
for i=12:16
    tensoes_lam(:,i) = Q_lamina(:,:,21)*extensoes_lam(:,9+i);
end

tensoes_lamx = tensoes_lam(1,:);
aux = tensoes_lamx(2:16);
tensoes_lamx = [-flip(aux), tensoes_lamx];

tensoes_lamy = tensoes_lam(2,:);
aux = tensoes_lamy(2:16);
tensoes_lamy = [-flip(aux), tensoes_lamy];

tensoes_lamxy = tensoes_lam(3,:);
aux = tensoes_lamxy(2:16);
tensoes_lamxy = [-flip(aux), tensoes_lamxy];

z_aux = [0.19 0.19 0.38 0.57 0.76 0.76 0.95 1.14 1.33 1.52 1.52 1.71 1.9 2.09 2.28];
z_aux = [-flip(z_aux) 0 z_aux];

figure
plot(tensoes_lamx,z_aux,'LineWidth',2)
title('Tensão no eixo x em função da espessura')
xlabel('\sigma_x (MPa)')
ylabel('z (mm)')

figure
plot(tensoes_lamy,z_aux,'LineWidth',2)
title('Tensão no eixo y em função da espessura')
xlabel('\sigma_y (MPa)')
ylabel('z (mm)')


figure
plot(tensoes_lamxy,z_aux,'LineWidth',2)
title('Tensão no eixo xy em função da espessura','LineWidth',2)
xlabel('\tau_{xy} (MPa)')
ylabel('z (mm)')

%% Defleção - Teoria clássica

% Iyy = 435.83;
% b = 57.20;
% Exx_b = Efx;
% F_0 = 20;
% a = 200;
% x = 200;
% 
% c1 = (F_0 * b * a^3)/(Exx_b * Iyy);
% w0 = c1/48 * 8 (3*(x/a)^2-(x/a)^3);

%% Defleção - Primeira ordem

% h = 4.51;
% Gxz_b = 0;
% 
% c1 = (F_0 * b * a^3)/(Exx_b * Iyy);
% s1 = (F_0 * b * a)/(k * Gxz_b * b * h);
% w0 = c1/48 * 8 (3*(x/a)^2-(x/a)^3) + s1*(x/a);

%% Análise Modal

M = readmatrix('Lab_2.xlsx', 'Sheet', 'Folha1', 'Range', 'A1:D1601');

f = M(:,2);
Magnitude = M(:,4);

figure
plot(f,Magnitude)
xlabel('Frequência (Hz)');
ylabel('Magnitude (dB)');
title('Ensaio laboratorial');

%% Rayleigh-Ritz

syms x1 x2
L = 200;
b = 57.20;
P = 20;

B = [2 6*x1 x2;
    0 0 0;
    0 0 4*x1];

B_t_D_B = transpose(B) * D * B;

K = int(int(B_t_D_B,x1,0,L),x2,-b/2,b/2);

F = [P*L^2 P*L^3 0];

Delta = K\F'

Delta = double(Delta)

F = transpose (F);
Delta_E = linsolve(K,F)
Delta_E = double(Delta_E)

w0 = L^2 * Delta(1) + L^3 * Delta(2)
w0_E = L^2 * Delta_E(1) + L^3 * Delta_E(2)






