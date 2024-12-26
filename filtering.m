function [x_u,P_u,x_p,P_p,w_u,Pw, param] = filtering(z,x0,P0,param)
%% Initialisation
param.range = param.Steps-param.L0;
x_u=zeros(param.n,param.range); 
P_u=zeros(param.n,param.n,param.range); 
w_u=zeros(param.m,param.range);
Pw=zeros(param.m,param.m,param.range);
x_p = x_u; 
P_p = P_u;

x_p(:,1) = x0; 
P_p(:,:,1) = P0; 

%% Time loop
for t = 1:param.range
    z_L=reshape(z(:,t:t+param.L0), param.p*(param.L0+1),1);
    [x_u(:,t),P_u(:,:,t),w_u(:,t),Pw(:,:,t)] = measurement(z_L,x_p(:,t),P_p(:,:,t),param); 
    [x_p(:,t+1),P_p(:,:,t+1)] = propagation(z_L,x_u(:,t),P_u(:,:,t),param);       
end

end
