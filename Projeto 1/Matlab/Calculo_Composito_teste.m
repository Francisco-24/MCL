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

%Empilhamento 
n = [2 3 1 4 2 2 3 3 1 1 4 4 4 4 1 1 3 3 2 2 4 1 3 2];

%Empilhamento E 22/23
% n = [2 2 2 1 1 1 3 3 3 3 3 4 4 3 3 3 3 3 1 1 1 2 2 2];

%Para testar
% laminas = 8;
% n = [4 3 2 1 1 2 3 4];

%% LAMINADO CARBONO T800 COM RESINA EPOXÍDICA

%Carbono T800
ro_carbono = 1790; %Kg/m3$
E_carbono = 300000; %MPa%
v_carbono = 0.35;
sigma_r = 3.1; %L0 = 200mm$
gramagem = 145;
hi = 0.135;
Vf = 0.6;
Gf = E_carbono/(2*(1+v_carbono));

%Resina 
ro_resina = 1200;
E_resina = 4500;
v_resina = 0.4;
Vm = 0.4;
Gm = E_resina/(2*(1+v_resina));

%Lamina
E_L = Vm*E_resina + Vf*E_carbono
v_LT = Vf*v_carbono + Vm*v_resina
E_T = 1/(Vf/E_carbono + Vm/E_resina)
G_LT = 1/(Vf/Gf + Vm/Gm)
v_TL = E_T*v_LT/E_L

espessura_lamina = hi;
espessura = laminas*espessura_lamina; %mm
Props_fibra = [E_L E_T v_LT v_TL G_LT];


%% matriz Q

Q_inv = [1/E_L -v_TL/E_T 0; -v_LT/E_L 1/E_T 0; 0 0 1/G_LT];
Q = inv(Q_inv)/10^3;

Q_lamina = zeros(3,3,laminas);
Q_laminaGPA = zeros(3,3,laminas);

for i=1:laminas
    Q_lamina(:,:,i) = matriz_Q_novo(n(i), Props_fibra);
    Q_laminaGPA(:,:,i) = Q_lamina(:,:,i)*10^-3;
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

Efx = 12/(D_inverse(1,1)*espessura^3)
Efy = 12/(D_inverse(2,2)*espessura^3)
vfxy = -D_inverse(2,1)/D_inverse(1,1)
vfyx = -D_inverse(1,2)/D_inverse(2,2)
Gfxy = 12/(D_inverse(3,3)*espessura^3)

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

% b = 57.20;
% 
% Nx = 8000/b;
% Ny = 0;
% Nxy = 0;
% 
% 
% F = [Nx Ny Nxy]';
% 
% % extensoes = A_inverse * F;
% extensoes = A\F;
% 
% tensoes = zeros(3,laminas);
% 
% for i=1:laminas
%     tensoes(:,i) = Q_lamina (:,:,i) * extensoes;
% end
% 
% aux = [linspace(-2.28,-2.29+0.19*4,4) linspace(-2.29+0.19*4,-0.19*4,4) linspace(-0.19*4,-0.19,3) -0.19];
% aux_ = flip(aux);
% pos_lamina = [aux -aux_];
% 
% figure
% plot(tensoes(1,:),pos_lamina)
% 
% figure
% plot(tensoes(2,:),pos_lamina)
% 
% figure
% plot(tensoes(3,:),pos_lamina)


%% Ponto 6 (Aproximação de Halpin Tsai)
%Propriedades
% qsi_E = 2;
% niu_E = ((E_carbono/E_resina)-1)/((E_carbono/E_resina)+qsi_E);
% 
% E_T_HT = E_resina*(1+qsi_E*niu_E*Vf)/(1-niu_E*Vf);
% v_TL_HT = v_LT*E_T_HT/E_L;
% 
% 
% qsi_G = 1+40*Vf^10;
% niu_G = ((Gf/Gm)-1)/((Gf/Gm)+qsi_G);
% 
% G_LT_HT = Gm*(1+qsi_G*niu_G*Vf)/(1-niu_G*Vf);
% Props_fibra_HT = [E_L E_T_HT v_LT v_TL_HT G_LT_HT];
% 
% %Q inversa
% Q_inv_HT = [1/E_L -v_TL_HT/E_T_HT 0; -v_LT/E_L 1/E_T_HT 0; 0 0 1/G_LT_HT];
% Q_HT = inv(Q_inv_HT)/10^3;
% 
% Q_lamina_HT = zeros(3,3,laminas);
% 
% for i=1:laminas
%     Q_lamina_HT(:,:,i) = matriz_Q_novo(n(i), Props_fibra_HT);
% end
% 
% %Matriz ABD
%  A_HT=zeros(3,3);
%  B_HT=zeros(3,3);
%  D_HT=zeros(3,3);
% 
%  for i=1:3
%      for j=1:3
%          for k=1:laminas
%                  A_HT(i,j)=A_HT(i,j) + Q_lamina_HT(i,j,k)*(z(k+1)-z(k));
%                  B_HT(i,j)=B_HT(i,j) + (Q_lamina_HT(i,j,k)/2)*(z(k+1)^2-z(k)^2);
%                  D_HT(i,j)=D_HT(i,j) + (Q_lamina_HT(i,j,k)/3)*(z(k+1)^3-z(k)^3);
%          end
%      end
%  end
% 
% ABD_matrix_HT = [A,B;B,D];
% 
% ABD_inverse_HT = inv(ABD_matrix_HT);
% A_inverse_HT = inv(A_HT);
% D_inverse_HT = inv(D_HT);
% A_GPa_HT = A_HT*10^-3;
% D_GPa_HT = D_HT*10^-3;
% 
% %Cálculo Young
% Ex_HT = 1/(espessura*A_inverse_HT(1,1));
% 
% %Cálculo Young flexão
% Efx_HT = 12/(D_inverse_HT(1,1)*espessura^3);


%% Ponto 7 
% P = 9;
% L = 200;
% b = 50;
% 
% Mx = P*L/b;
% My = 0;
% Mxy = 0;
% 
% M = [Mx My Mxy]';
% 
% ks = D\M;
% 
% extensoes_lam = zeros(3,length(z));
% for i=1:length(z)
%     extensoes_lam(:,i) = z(i)*ks;
% end
% 
% tensoes_lam = zeros(3,16);
% 
% % lamina de 0 graus (está entre o z(13) e o z(14))
% tensoes_lam(:,1) = Q_lamina(:,:,13)*extensoes_lam(:,13);
% tensoes_lam(:,2) = Q_lamina(:,:,13)*extensoes_lam(:,14);
% 
% % laminas de 90 graus (estao entre z(14) e z(17))
% for i=3:6
%     tensoes_lam(:,i) = Q_lamina(:,:,14)*extensoes_lam(:,11+i);
% end
% 
% % laminas de 45 graus (estao entre z(17) e z(21))
% for i=7:11
%     tensoes_lam(:,i) = Q_lamina(:,:,20)*extensoes_lam(:,10+i);
% end
% 
% %laminas de -45 graus (estao entre z(21) e z(25)
% for i=12:16
%     tensoes_lam(:,i) = Q_lamina(:,:,21)*extensoes_lam(:,9+i);
% end
% 
% tensoes_lamx = tensoes_lam(1,:);
% aux = tensoes_lamx(2:16);
% tensoes_lamx = [-flip(aux), tensoes_lamx];
% 
% tensoes_lamy = tensoes_lam(2,:);
% aux = tensoes_lamy(2:16);
% tensoes_lamy = [-flip(aux), tensoes_lamy];
% 
% tensoes_lamxy = tensoes_lam(3,:);
% aux = tensoes_lamxy(2:16);
% tensoes_lamxy = [-flip(aux), tensoes_lamxy];
% 
% z_aux = [0.19 0.19 0.38 0.57 0.76 0.76 0.95 1.14 1.33 1.52 1.52 1.71 1.9 2.09 2.28];
% z_aux = [-flip(z_aux) 0 z_aux];
% 
% figure
% plot(tensoes_lamx,z_aux)
% 
% figure
% plot(tensoes_lamy,z_aux)
% 
% figure
% plot(tensoes_lamxy,z_aux)

%% Matrizes T

angle = [0 90 45 -45 30 -30];
T_epsilon = zeros (3,3,6);
for i=1:6
    m = cosd(angle(i));
    n = sind(angle(i));

    T_sigma = [m^2 n^2 2*m*n; n^2 m^2 -2*m*n; -m*n m*n m^2-n^2];
    T_epsilon_inv = [m^2 n^2 -m*n; n^2 m^2 m*n; 2*m*n -2*m*n m^2-n^2];
    T_epsilon(:,:,i) = inv(T_epsilon_inv);
end

