%% Extensões na Flexão

angle = [0 90 45 -45];
T_epsilon_inv = zeros (3,3,4);
for i=1:4
    m = cosd(angle(i));
    n = sind(angle(i));
    T_epsilon_inv(:,:,i) = [m^2 n^2 -m*n; n^2 m^2 m*n; 2*m*n -2*m*n m^2-n^2];
end

M = readmatrix('Results_tensao.xlsx', 'Sheet', 'Folha1', 'Range', 'I5:K52')

extensoes_FEM_local = zeros(48,3)
for i=1:48
    extensoes_FEM_local(i,:) = M(i,:)
end
extensoes_FEM_local = transpose(extensoes_FEM_local)

for i=1:8
    extensoes_FEM(:,i) = T_epsilon_inv(:,:,4)*extensoes_FEM_local(:,i);
end
for i=9:16
    extensoes_FEM(:,i) = T_epsilon_inv(:,:,3)*extensoes_FEM_local(:,i);
end
for i=17:22
    extensoes_FEM(:,i) = T_epsilon_inv(:,:,2)*extensoes_FEM_local(:,i);
end
for i=23:26
    extensoes_FEM(:,i) = T_epsilon_inv(:,:,1)*extensoes_FEM_local(:,i);
end
for i=27:32
    extensoes_FEM(:,i) = T_epsilon_inv(:,:,2)*extensoes_FEM_local(:,i);
end
for i=33:40
    extensoes_FEM(:,i) = T_epsilon_inv(:,:,3)*extensoes_FEM_local(:,i);
end
for i=41:48
    extensoes_FEM(:,i) = T_epsilon_inv(:,:,4)*extensoes_FEM_local(:,i)
end

z_FEM_aux = [0.19 0.19 0.38 0.38 0.57 0.57 0.76 0.76 0.95 0.95 1.14 1.14 1.33 1.33 1.52 1.52 1.71 1.71 1.9 1.9 2.09 2.09 2.28];
z_FEM_aux = [-flip(z_FEM_aux) 0 0 z_FEM_aux]

figure
plot(-extensoes_FEM(1,:),z_FEM_aux)
hold
plot(extensoes_lam_1(1,:),z)
legend('FEM','Analitico')
title('Extensão no eixo x em função da espessura')
xlabel('\epsilon_x (MPa)')
ylabel('z (mm)')
