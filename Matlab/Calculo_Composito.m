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

%Para testar
% laminas = 8;
% n = [4 3 2 1 1 2 3 4];

%% LAMINADO CARBONO T800 COM RESINA EPOXÍDICA

%Carbono T800
ro_carbono = 1754; %Kg/m3$
E_carbono = 290000; %MPa%
v_carbono = 0.35;
sigma_r = 2.8; %L0 = 200mm$
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

%Lamina
E_L = Vm*E_resina + Vf*E_carbono;
v_LT = Vf*v_carbono + Vm*v_resina;
E_T = 1/(Vf/E_carbono + Vm/E_resina);
G_LT = 1/(Vf/Gf + Vm/Gm);
v_TL = E_T*v_LT/E_L;

%Lamina para testar 
% E_L = 177800
% v_LT = 0.27
% E_T = 11050
% G_LT = 7600
% v_TL = E_T*v_LT/E_L
% hi = 0.14

espessura_lamina = hi;
espessura = laminas*espessura_lamina; %mm
Props_fibra = [E_L E_T v_LT v_TL G_LT];

%% LAMINADO PARA TESTAR
% espessura_lamina = 0.14;
% 
% %Preencher Xt,Xc, Yt, Yc, S da ultima lamina
% strength_val = [1500 1200 50 250 70];
% 
% %Preencher caracteristicas 
% E_L = 177800;
% E_T = 11050;
% v_LT = 0.27;
% v_TL = v_LT*E_T/E_L
% G_LT = 7600;
% %G_LN = 2000;
% %G_TN = 2000;
% espessura = laminas*espessura_lamina; %mm
% Props_fibra = [E_L E_T v_LT v_TL G_LT];

%% matriz Q

Q_inv = [1/E_L -v_TL/E_T 0; -v_LT/E_L 1/E_T 0; 0 0 1/G_LT];
Q = inv(Q_inv)/10^3;

Q_lamina = zeros(3,3,laminas);

for i=1:laminas
    Q_lamina(:,:,i) = matriz_Q_novo(n(i), Props_fibra);
end

%%     Calcular posições das laminas em altura

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

Props_laminado = [Ex Ey vxy vyx Gxy];

%% Constantes de Elasticidade de Flexão do laminado [MPa]

Efx = 12/(D_inverse(1,1)*espessura^3);
Efy = 12/(D_inverse(2,2)*espessura^3);
vfxy = -D_inverse(2,1)/D_inverse(1,1);
vfyx = -D_inverse(1,2)/D_inverse(2,2);
Gfxy = 12/(D_inverse(3,3)*espessura^3);

%% Tensão de rotura para L0=2 m 

m = 5;

sigma_r_2000 = sigma_r * (200/2000)^(1/m);

%% Fabrico de um painel (1mx1m)

espessura;
ro  = ro_resina*Vm + ro_carbono*Vf;

Volume = 1*1*espessura*10^-3;
massa_painel = Volume*ro;

massa_fibra = Vf*ro_carbono*Volume;
massa_fibra_ = Vf*ro_carbono*massa_painel/ro;
massa_resina = Vm*ro_resina*Volume;


%% Ponto 5 experimental

b = 57.20;

Nx = 9000/b;
Ny = 0;
Nxy = 0;
Mx = 0;
My = 0;
Mxy = 0;

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
plot(tensoes(1,:),pos_lamina)

figure
plot(tensoes(2,:),pos_lamina)

figure
plot(tensoes(3,:),pos_lamina)

