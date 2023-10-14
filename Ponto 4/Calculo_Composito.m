clear all
close all
clc

%% INPUTS
% Preencher
laminas = 6;

% Preencher o seguinte vetor:
% 1 -> camada de carbono 45 graus
% 2 -> camada de carbono -45 graus
% 3 -> camada de carbono 90 graus
% 4 -> camada de carbono 0 graus
% 5 -> camada de core AIREX C70.75
n = [4 3 3 5 3 3 3];

%% CASCA
espessura_lamina = 0.21;
espessura_core = 4;

%Preencher Xt,Xc, Yt, Yc, S da ultima lamina
strength_val = [1500 1200 50 250 70];

%Preencher caracteristicas 
E_L = 135000;
E_T = 10000;
v_LT = 0.3;
v_TL = 0.3;
G_LT = 5000;
G_LN = 2000;
G_TN = 2000;

%% Longarina
% espessura_lamina = 0.15;
% espessura_core = 30;
% 
% %Preencher Xt,Xc, Yt, Yc, S da ultima lamina
% strength_val = [600 570 600 570 90];
% 
% %Preencher caracteristicas 
% E_L = 70000;
% E_T = 70000;
% v_LT = 0.1;
% v_TL = 0.1;
% G_LT = 5000;
% G_LN = 2000;
% G_TN = 2000;

%% Carregamento

%Preencher Nx Ny Nxy Mx My Mxy
Nx = -5.0059;
Ny = 0;
Nxy = 0.1240;
Mx = 0;
My = 0;
Mxy = 0;

% filename = 'Cruise_a=1.50_v=19.66ms.txt';

%% Leitura do ficheiro XFLR5

% [L,M] = ficheiro (filename);

%% Coisas

espessura = laminas*espessura_lamina + espessura_core; %mm
Props_fibra = [E_L E_T v_LT v_TL G_LT];
F_M = [Nx Ny Nxy Mx My Mxy];

%% matrizes Q com os valores já nas direções principais
for i=1:laminas+1
    if n(i) ~= 5
    Q_lamina(:,:,i) = matriz_Q(n(i), Props_fibra)  ; 
    end
end

%%     Calcular posições das laminas em altura
for i=1:((laminas/2)+1)
    z(i)=espessura_core/2+(i-1)*espessura_lamina; 
  end
z=[-flip(z),z];

% z(1) = -espessura/2;
% for i=1:laminas
%     if n(i)==1 || n(i)==2 || n(i)==3 || n(i)==4
%         h = espessura_lamina;
%     elseif n(i) == 5 
%         h = espessura_core;
%     end
%     z(i+1) = z(i) + h
% end

%% matriz ABD

 A=zeros(3,3);
 B=zeros(3,3);
 D=zeros(3,3);

 for i=1:3
     for j=1:3
         for k=1:laminas+1
             if n(k)~= 5 %no programa de otimização também excluem o core para este cálculo
                 A(i,j)=A(i,j)+ Q_lamina(i,j,k)*(z(k+1)-z(k));
                 B(i,j)=B(i,j)+ (Q_lamina(i,j,k)/2)*(z(k+1)^2-z(k)^2);
                 D(i,j)=D(i,j)+ (Q_lamina(i,j,k)/3)*(z(k+1)^3-z(k)^3);
             end
         end
     end
 end

ABD_matrix = [A,B;B,D];


ABD_inverse = inv(ABD_matrix);
A_inverse = inv(A);

%% Propriedades do material

Ex = 1/(espessura*A_inverse(1,1))
Ey = 1/(espessura*A_inverse(2,2));
vxy = -A_inverse(2,1)/A_inverse(1,1);
vyx = vxy*Ey/Ex;
Gxy = 1/(espessura*A_inverse(3,3))

Props_laminado = [Ex Ey vxy vyx Gxy];

%% Cálculo Gyz e Gxz (Sem 100% de certeza)

S44_0 = 1/G_TN;
S55_0 = 1/G_LN;

laminas+1

for i=1:laminas+1
        if n(i) == 1
            m = cosd(45);
            d = sind(45);
        elseif n(i) == 2
            m = cosd(-45);
            d = sind(-45);
        elseif n(i) == 3
            m = cosd(90);
            d = sind(90);
        elseif n(i) == 4
            m = cosd(0);
            d = sind(0);
        elseif n(i) == 5
            m = 0;
            d = 0;
        end

        S44 = S55_0*d^2 + S44_0*m^2;
        S45 = (S55_0 - S44_0)*m*d;
        S55 = S55_0*m^2 + S44_0*d^2;
        
        S_fsdt (:,:,i) = [S44 S45; S45 S55];
        Q_fsdt (:,:,i) = S_fsdt(:,:,i)';
end


E=zeros(2,2);

 for i=1:2
     for j=1:2
         for k=1:laminas+1
             if n(k)~= 5 %no programa de otimização também excluem o core para este cálculo
                 E(i,j)=E(i,j)+ Q_fsdt(i,j,k)*(z(k+1)-z(k));
             end
         end
     end
 end

 E_inverse = E';

 Gyz = 1/(espessura*E_inverse(1,1));
 Gxz = 1/(espessura*E_inverse(2,2));


%% Extensão e curvatura da lamina superior da placa

F_M = F_M';
strains_curvature = individual_strain(ABD_inverse, F_M, espessura);

if n(laminas+1) == 1
    m = cosd(45);
    n = sind(45);
elseif n(laminas+1) == 2
    m = cosd(-45);
    n = sind(-45);
elseif n(laminas+1) == 3
    m = cosd(90);
    n = sind(90);
elseif n(laminas+1) == 4
    m = cosd(0);
    n = sind(0);
end

Matriz_rotacao = [m^2 n^2 2*m*n; n^2 m^2 -2*m*n; -m*n m*n m^2-n^2];

Matriz_rotacao = Matriz_rotacao';

strains_curvature_corrigida = Matriz_rotacao*strains_curvature';

%% Passagem de extensões para tensões

%laminas+1 para ser a ultima camada (e não acontecer a situação de
%considerar core
tensions = Q_lamina(:,:,laminas+1)*strains_curvature_corrigida;

%% Tsai-Wu Failure

falha = Tsai_Wu(tensions, strength_val);
fator_caganco_TW = 1/falha

%% Buckling of Sandwich under Compression

a = 115;
b = 65.2;
t_f=espessura_lamina*laminas;
h=espessura_core+t_f;

D=(Ex*t_f*(h^2)*b)/2;
G_c=15;


P_b_crit=(pi^2*D)/(a^2+(pi^2*D)/(G_c*h*b));
P_b=-Nx*b;

if P_b_crit> P_b
    Buckling = 0;
else 
%     Buckling = 1;
end
fator_caganco_B=P_b_crit/P_b

% 
% Gyz=15;
% AR = a/b;
% 
% m = linspace(0,10,11);
% NCrit = 0;
% 
% for i=1:length(m)
%     NCrit(i) = (pi/a)^2 * (D(1,1) * m(i)^2 + 2 * (D(1,2) + D(3,3)) * AR^2 + D(2,2) * AR^4/m(i)^2);
% end
% 
% [NCrit_min,ind] = min(NCrit);
% 
% NXCrit = NCrit_min / (1 + NCrit_min/(espessura * Gyz))
% 
% if NXCrit> Nx
%     Buckling = 0
% else 
%     Buckling = 1
% end
% 
% fator_caganco_B=NXCrit/-Nx

