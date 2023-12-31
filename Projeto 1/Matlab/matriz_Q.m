function Q_lamina=matriz_Q(tipo_lamina, Props_fibra) 

E_L = Props_fibra(1);
E_T = Props_fibra(2);
v_LT = Props_fibra(3);
v_TL = Props_fibra(4);
G_LT = Props_fibra(5);

Q_inv = [1/E_L -v_TL/E_T 0; -v_LT/E_L 1/E_T 0; 0 0 1/G_LT];

if tipo_lamina == 1
    angle= 45;    
elseif tipo_lamina == 2
    angle= - 45;    
elseif tipo_lamina == 3
    angle= 90;
elseif tipo_lamina == 4
    angle= 0;
elseif tipo_lamina == 5
    angle= 30;
elseif tipo_lamina == 6
    angle= - 30;
end

m = cosd(angle); 
n = sind(angle);

T_sigma = [m^2 n^2 2*m*n; n^2 m^2 -2*m*n; -m*n m*n m^2-n^2];
T_epsilon_inv = [m^2 n^2 -m*n; n^2 m^2 m*n; 2*m*n -2*m*n m^2-n^2];

Q_lamina_inv = T_epsilon_inv*Q_inv*T_sigma;
Q_lamina = inv(Q_lamina_inv);
 end