function falha=Tsai_Wu(Sigma_local, strength_val)

% Tsai-Wu components
TW(1)=(Sigma_local(1)^2)/(strength_val(1)*strength_val(2));
TW(2)=(Sigma_local(2)^2)/(strength_val(3)*strength_val(4));
TW(3)=-(Sigma_local(1))*(Sigma_local(2))*sqrt(1/((strength_val(1))*(strength_val(2))*(strength_val(3))*(strength_val(4))));
TW(4)=Sigma_local(1)*((1/strength_val(1))-(1/strength_val(2)));
TW(5)=Sigma_local(2)*((1/strength_val(3))-(1/strength_val(4)));
TW(6)=(Sigma_local(3)^2)/(strength_val(5)^2);

falha = TW(1)+TW(2)+TW(3)+TW(4)+TW(5)+TW(6);

end