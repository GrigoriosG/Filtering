function [x_s,P_s,w_s,Pw_s] = smoothing(x_u,P_u,x_p,P_p,w_u,Pw,param)
%% Initialisation 
x_s=zeros(param.n,param.range); 
P_s=zeros(param.n,param.n,param.range); 
w_s=zeros(param.m,param.range); 
Pw_s=zeros(param.m,param.m,param.range);
x_s(:,end) = x_u(:,end); 
P_s(:,:,end) = P_u(:,:,end);
w_s(:,end) = w_u(:,end); 
Pw_s(:,:,end) = Pw(:,:,end);

%% Time loop
for t = param.range-1:-1:1   
    
    Pxu = - (param.Td*param.OL*P_u(:,:,t))'; 
    J1 = (  P_u(:,:,t)*param.A' + Pxu*param.B'  )/P_p(:,:,t+1);
    J3 = (   Pxu'*param.A' + Pw(:,:,t)*param.B'   )/P_p(:,:,t+1);
    
    e = x_s(:,t+1)-x_p(:,t+1);
    Pe = P_s(:,:,t+1)-P_p(:,:,t+1);
    
    x_s(:,t) = x_u(:,t)+J1*e;
    w_s(:,t) = w_u(:,t) + J3*e;
    P_s(:,:,t) = P_u(:,:,t) + J1*Pe*J1'; 
    Pw_s(:,:,t) = Pw(:,:,t) + J3*Pe*J3';  

end
end

%     eign = eig(P_s(:,:,t));
%     eign(1)/eign(end)
