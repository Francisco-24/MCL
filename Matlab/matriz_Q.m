function Q_lamina=matriz_Q(tipo_lamina, Props_fibra) 

E_L = Props_fibra(1);
E_T = Props_fibra(2);
v_LT = Props_fibra(3);
v_TL = Props_fibra(4);
G_LT = Props_fibra(5);
if tipo_lamina == 1
    angle= 45;
    
elseif tipo_lamina == 2
    angle= - 45;
    
elseif tipo_lamina == 3
    angle= 90;
elseif tipo_lamina == 4
    angle= 0;
end
%     E_L = 70000;
%     E_T = 70000;
%     v_LT = 0.1;
%     v_TL = 0.1;
%     G_LT = 5000;


Q_xx =(E_L)/(1-v_LT*v_TL);
Q_yy =(E_T)/(1-v_LT*v_TL);
Q_xy = (v_LT*E_T)/(1-v_LT*v_TL);
Q_ss = G_LT;

m = cosd(angle); 
n = sind(angle);

Q_11=(m^4)*Q_xx+(n^4)*Q_yy+2*(m^2)*(n^2)*Q_xy+4*(m^2)*(n^2)*Q_ss;
Q_22=(n^4)*Q_xx+(m^4)*Q_yy+2*(m^2)*(n^2)*Q_xy+4*(m^2)*(n^2)*Q_ss;
Q_12=(m^2)*(n^2)*Q_xx+(m^2)*(n^2)*Q_yy+(m^4+n^4)*Q_xy-4*(m^2)*(n^2)*Q_ss;
Q_66=(m^2)*(n^2)*Q_xx+(m^2)*(n^2)*Q_yy-2*(m^2)*(n^2)*Q_xy+((m^2-n^2)^2)*Q_ss;
Q_16 = (m^3)*n*Q_xx-m*(n^3)*Q_yy+(m*(n^3)-(m^3)*n)*Q_xy+2*(m*(n^3)-(m^3)*n)*Q_ss;
Q_26 = m*(n^3)*Q_xx-(m^3)*n*Q_yy+((m^3)*n-m*(n^3))*Q_xy+2*((m^3)*n-m*(n^3))*Q_ss;

Q_lamina = [Q_11 Q_12 Q_16 ; Q_12 Q_22 Q_26 ; Q_16 Q_26 Q_66];

end
