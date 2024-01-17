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
E_L_1 = 73.8892*10^3;
v_LT_1 = 0.3101;
E_T_1 = 20.5717*10^3;
G_LT_1 = 6.2404*10^3;
v_TL_1 = 0.0863;

% Set 2 props - deslocamento aplicado
E_L_2 = 176.1647*10^3;
v_LT_2 = 0.3631;
E_T_2 = 38.3081*10^3;
G_LT_2 = 17.9012*10^3;
v_TL_2 = 0.0790;

espessura_lamina = hi;
espessura = laminas*espessura_lamina; 
Props_fibra_1 = [E_L_1 E_T_1 v_LT_1 v_TL_1 G_LT_1];
Props_fibra_2 = [E_L_2 E_T_2 v_LT_2 v_TL_2 G_LT_2];

%% Calcular posições das laminas em altura

z = zeros(1,laminas/2);

for i=1:((laminas/2))
    z(i)=(i)*espessura_lamina; 
end

z=[-flip(z),0,z];

%%%%%%%%%%%%%%%%%%%%%%% SET 1 Propriedades %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% matriz Q - Set 1

Q_inv_1 = [1/E_L_1 -v_TL_1/E_T_1 0; -v_LT_1/E_L_1 1/E_T_1 0; 0 0 1/G_LT_1];
Q_1 = inv(Q_inv_1)/10^3;

Q_lamina_1 = zeros(3,3,laminas);
Q_laminaGPA_1 = zeros(3,3,laminas);

for i=1:laminas
    Q_lamina_1(:,:,i) = matriz_Q(n(i), Props_fibra_1);
    Q_laminaGPA_1(:,:,i) = Q_lamina_1(:,:,i)*10^-3;
end

%% matriz ABD - Set 1

 A_1=zeros(3,3);
 B_1=zeros(3,3);
 D_1=zeros(3,3);

 for i=1:3
     for j=1:3
         for k=1:laminas
                 A_1(i,j)=A_1(i,j) + Q_lamina_1(i,j,k)*(z(k+1)-z(k));
                 B_1(i,j)=B_1(i,j) + (Q_lamina_1(i,j,k)/2)*(z(k+1)^2-z(k)^2);
                 D_1(i,j)=D_1(i,j) + (Q_lamina_1(i,j,k)/3)*(z(k+1)^3-z(k)^3);
         end
     end
 end

ABD_matrix_1 = [A_1,B_1;B_1,D_1];

ABD_inverse_1 = inv(ABD_matrix_1);
A_inverse_1 = inv(A_1);
D_inverse_1 = inv(D_1);
A_GPa_1 = A_1*10^-3;
D_GPa_1 = D_1*10^-3;

%% Constantes de Elasticidade do laminado [MPa] - Set 1

Ex_1 = 1/(espessura*A_inverse_1(1,1));
Ey_1 = 1/(espessura*A_inverse_1(2,2));
vxy_1 = -A_inverse_1(2,1)/A_inverse_1(1,1);
vyx_1  = vxy_1*Ey_1/Ex_1;
Gxy_1 = 1/(espessura*A_inverse_1(3,3));

Props_laminado_1 = [Ex_1 Ey_1 vxy_1 vyx_1 Gxy_1]

%% Constantes de Elasticidade de Flexão do laminado [MPa] - Set 1

Efx_1 = 12/(D_inverse_1(1,1)*espessura^3);
Efy_1 = 12/(D_inverse_1(2,2)*espessura^3);
vfxy_1 = -D_inverse_1(2,1)/D_inverse_1(1,1);
vfyx_1 = -D_inverse_1(1,2)/D_inverse_1(2,2);
Gfxy_1 = 12/(D_inverse_1(3,3)*espessura^3);

%%%%%%%%%%%%%%%%%%%%%%% SET 2 Propriedades %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% matriz Q - Set 2

Q_inv_2 = [1/E_L_2 -v_TL_2/E_T_2 0; -v_LT_2/E_L_2 1/E_T_2 0; 0 0 1/G_LT_2];
Q_2 = inv(Q_inv_2)/10^3;

Q_lamina_2 = zeros(3,3,laminas);
Q_laminaGPA_2 = zeros(3,3,laminas);

for i=1:laminas
    Q_lamina_2(:,:,i) = matriz_Q(n(i), Props_fibra_2);
    Q_laminaGPA_2(:,:,i) = Q_lamina_2(:,:,i)*10^-3;
end

%% matriz ABD - Set 2

 A_2=zeros(3,3);
 B_2=zeros(3,3);
 D_2=zeros(3,3);

 for i=1:3
     for j=1:3
         for k=1:laminas
                 A_2(i,j)=A_2(i,j) + Q_lamina_2(i,j,k)*(z(k+1)-z(k));
                 B_2(i,j)=B_2(i,j) + (Q_lamina_2(i,j,k)/2)*(z(k+1)^2-z(k)^2);
                 D_2(i,j)=D_2(i,j) + (Q_lamina_2(i,j,k)/3)*(z(k+1)^3-z(k)^3);
         end
     end
 end

ABD_matrix_2 = [A_2,B_2;B_2,D_2];

ABD_inverse_2 = inv(ABD_matrix_2);
A_inverse_2 = inv(A_2);
D_inverse_2 = inv(D_2);
A_GPa_2 = A_2*10^-3;
D_GPa_2 = D_2*10^-3;

%% Constantes de Elasticidade do laminado [MPa] - Set 2

Ex_2 = 1/(espessura*A_inverse_2(1,1));
Ey_2 = 1/(espessura*A_inverse_2(2,2));
vxy_2 = -A_inverse_2(2,1)/A_inverse_2(1,1);
vyx_2  = vxy_2*Ey_2/Ex_2;
Gxy_2 = 1/(espessura*A_inverse_2(3,3));

Props_laminado_2 = [Ex_2 Ey_2 vxy_2 vyx_2 Gxy_2]

%% Constantes de Elasticidade de Flexão do laminado [MPa] - Set 2

Efx_2 = 12/(D_inverse_2(1,1)*espessura^3);
Efy_2 = 12/(D_inverse_2(2,2)*espessura^3);
vfxy_2 = -D_inverse_2(2,1)/D_inverse_2(1,1);
vfyx_2 = -D_inverse_2(1,2)/D_inverse_2(2,2);
Gfxy_2 = 12/(D_inverse_2(3,3)*espessura^3);

%%%%%%%%%%%%%%%%%%%%%%%%%% Ensaios %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Tensões ao longo da espessura do laminado - ensaio de tração

b = 57.20;
Nx = 9000/b;
Ny = 0;
Nxy = 0;
F = [Nx Ny Nxy]';

% extensoes = A_inverse * F;
extensoes_1 = A_1\F

tensoes_1 = zeros(3,laminas);

for i=1:laminas
    tensoes_1(:,i) = Q_lamina_1(:,:,i) * extensoes_1;
end

extensoes_2 = A_2\F

tensoes_2 = zeros(3,laminas);

for i=1:laminas
    tensoes_2(:,i) = Q_lamina_2(:,:,i) * extensoes_2;
end


aux = [linspace(-2.28,-2.28+0.19*4,4) linspace(-2.28+0.19*4,-0.19*4,4) linspace(-0.19*4,-0.19,3) -0.19];
aux_ = flip(aux);
pos_lamina = [aux -aux_];

figure
plot(tensoes_1(1,:),pos_lamina,'LineWidth',2)
hold on
plot(tensoes_2(1,:),pos_lamina,'LineWidth',2)
legend('CF tensão', 'CF extensão')
title('Tensão no eixo x em função da espessura')
xlabel('\sigma_x (MPa)')
ylabel('z (mm)')


figure
plot(tensoes_1(2,:),pos_lamina,'LineWidth',2)
hold on
plot(tensoes_2(2,:),pos_lamina,'LineWidth',2)
legend('CF tensão', 'CF extensão')
title('Tensão no eixo y em função da espessura')
xlabel('\sigma_y (MPa)')
ylabel('z (mm)')


figure
plot(tensoes_1(3,:),pos_lamina,'LineWidth',2)
hold on
plot(tensoes_2(3,:),pos_lamina,'LineWidth',2)
legend('CF tensão', 'CF extensão')
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

ks_1 = D_1\M;

extensoes_lam_1 = zeros(3,length(z));
for i=1:length(z)
    extensoes_lam_1(:,i) = z(i)*ks_1;
end

tensoes_lam_1 = zeros(3,16);

% lamina de 0 graus (está entre o z(13) e o z(14))
tensoes_lam_1(:,1) = Q_lamina_1(:,:,13)*extensoes_lam_1(:,13);
tensoes_lam_1(:,2) = Q_lamina_1(:,:,13)*extensoes_lam_1(:,14);

% laminas de 90 graus (estao entre z(14) e z(17))
for i=3:6
    tensoes_lam_1(:,i) = Q_lamina_1(:,:,14)*extensoes_lam_1(:,11+i);
end

% laminas de 45 graus (estao entre z(17) e z(21))
for i=7:11
    tensoes_lam_1(:,i) = Q_lamina_1(:,:,20)*extensoes_lam_1(:,10+i);
end

%laminas de -45 graus (estao entre z(21) e z(25)
for i=12:16
    tensoes_lam_1(:,i) = Q_lamina_1(:,:,21)*extensoes_lam_1(:,9+i);
end

tensoes_lamx_1 = tensoes_lam_1(1,:);
aux = tensoes_lamx_1(2:16);
tensoes_lamx_1 = [-flip(aux), tensoes_lamx_1];

tensoes_lamy_1 = tensoes_lam_1(2,:);
aux = tensoes_lamy_1(2:16);
tensoes_lamy_1 = [-flip(aux), tensoes_lamy_1];

tensoes_lamxy_1 = tensoes_lam_1(3,:);
aux = tensoes_lamxy_1(2:16);
tensoes_lamxy_1 = [-flip(aux), tensoes_lamxy_1];


ks_2 = D_2\M;

extensoes_lam_2 = zeros(3,length(z));
for i=1:length(z)
    extensoes_lam_2(:,i) = z(i)*ks_2;
end

tensoes_lam_2 = zeros(3,16);

% lamina de 0 graus (está entre o z(13) e o z(14))
tensoes_lam_2(:,1) = Q_lamina_2(:,:,13)*extensoes_lam_2(:,13);
tensoes_lam_2(:,2) = Q_lamina_2(:,:,13)*extensoes_lam_2(:,14);

% laminas de 90 graus (estao entre z(14) e z(17))
for i=3:6
    tensoes_lam_2(:,i) = Q_lamina_2(:,:,14)*extensoes_lam_2(:,11+i);
end

% laminas de 45 graus (estao entre z(17) e z(21))
for i=7:11
    tensoes_lam_2(:,i) = Q_lamina_2(:,:,20)*extensoes_lam_2(:,10+i);
end

%laminas de -45 graus (estao entre z(21) e z(25)
for i=12:16
    tensoes_lam_2(:,i) = Q_lamina_2(:,:,21)*extensoes_lam_2(:,9+i);
end

tensoes_lamx_2 = tensoes_lam_2(1,:);
aux = tensoes_lamx_2(2:16);
tensoes_lamx_2 = [-flip(aux), tensoes_lamx_2];

tensoes_lamy_2 = tensoes_lam_2(2,:);
aux = tensoes_lamy_2(2:16);
tensoes_lamy_2 = [-flip(aux), tensoes_lamy_2];

tensoes_lamxy_2 = tensoes_lam_2(3,:);
aux = tensoes_lamxy_2(2:16);
tensoes_lamxy_2 = [-flip(aux), tensoes_lamxy_2];

z_aux = [0.19 0.19 0.38 0.57 0.76 0.76 0.95 1.14 1.33 1.52 1.52 1.71 1.9 2.09 2.28];
z_aux = [-flip(z_aux) 0 z_aux];

figure
plot(tensoes_lamx_1,z_aux,'LineWidth',2)
hold on
plot(tensoes_lamx_2,z_aux,'LineWidth',2)
legend('CF tensão', 'CF extensão')
title('Tensão no eixo x em função da espessura')
xlabel('\sigma_x (MPa)')
ylabel('z (mm)')

figure
plot(tensoes_lamy_1,z_aux,'LineWidth',2)
hold on
plot(tensoes_lamy_2,z_aux,'LineWidth',2)
legend('CF tensão', 'CF extensão')
title('Tensão no eixo y em função da espessura')
xlabel('\sigma_y (MPa)')
ylabel('z (mm)')


figure
plot(tensoes_lamxy_1,z_aux,'LineWidth',2)
hold on
plot(tensoes_lamxy_2,z_aux,'LineWidth',2)
legend('CF tensão', 'CF extensão')
title('Tensão no eixo xy em função da espessura','LineWidth',2)
xlabel('\tau_{xy} (MPa)')
ylabel('z (mm)')

%% Defleção - Teoria clássica

Iyy = 435.83;
b = 57.20;
Exx_b_1 = Efx_1;
Exx_b_2 = Efx_2;
F_0 = 20;
a = 200;
x = linspace(0,200,21);

c1_1 = (F_0 * a^3)/(Exx_b_1 * Iyy);
w0_TC_1 = - c1_1/6 * (3*(x./a).^2-(x./a).^3);

c1_2 = (F_0 * a^3)/(Exx_b_2 * Iyy);
w0_TC_2 = - c1_2/6 * (3*(x./a).^2-(x./a).^3);

figure
plot(x,w0_TC_1,'LineWidth',2)
hold on
plot(x,w0_TC_2,'LineWidth',2)
legend('CF Tensão','CF Extensão')
title('Defleção','LineWidth',2)
ylabel('w_{0} (mm)')
xlabel('x (mm)')

%% Defleção - Primeira ordem

h = 4.51;
Gxz_b_1 = Gfxy_1;
Gxz_b_2 = Gfxy_2;

c1_1 = (F_0  * a^3)/(Exx_b_1 * Iyy);
s1_1 = (F_0  * a)/(k * Gxz_b_1 * b * h);
w0_PO_1 = -c1_1/6* (3*(x./a).^2-(x./a).^3) + s1_1*(x./a);

c1_2 = (F_0  * a^3)/(Exx_b_2 * Iyy);
s1_2 = (F_0  * a)/(k * Gxz_b_2 * b * h);
w0_PO_2 = -c1_2/6* (3*(x./a).^2-(x./a).^3) + s1_2*(x./a);

figure
plot(x,w0_TC_1,'LineWidth',2)
hold on
plot(x,w0_TC_2,'LineWidth',2)
hold on
plot(x,w0_PO_1,'--','LineWidth',2)
hold on
plot(x,w0_PO_2,'--','LineWidth',2)
legend('CF Tensão Teoria Clássica','CF Extensão Teoria Clássica', 'CF Tensão 1ª Ordem','CF Extensão 1ª Ordem')
title('Defleção','LineWidth',2)
ylabel('w_{0} (mm)')
xlabel('x (mm)')


%% Análise Modal

M = readmatrix('Lab_2.xlsx', 'Sheet', 'Folha1', 'Range', 'A1:E1601');

f = M(:,2);
Magnitude = M(:,5);
[max_mag, index] = max(Magnitude);

figure
plot(f,Magnitude, f(index), Magnitude(index),'r*')
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

% F = transpose (F);
% Delta_E = linsolve(K,F)
% Delta_E = double(Delta_E)

w0 = L^2 * Delta(1) + L^3 * Delta(2)
% w0_E = L^2 * Delta_E(1) + L^3 * Delta_E(2)

%% Estimação do Módulo de Young em Bending com a frequencia natural

ro  = (ro_resina*Vm + ro_carbono*Vf)*10^-12;
b = 57.20;
h = 4.51;
Iyy = 435.83;
I_0 = ro*b*h;
L=300;

f(index)

Exx_b = I_0*(2*pi*f(index))^2/(Iyy*(4.730/L)^4)*10^-3

fn = sqrt(Exx_b_2*Iyy/(I_0))*(4.730/L)^2/(2*pi)






