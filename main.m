clear all; clc;
[z,x_true, w_true, param] = Model(param);
disp('Simulation completed.')
%% Inherent delay test and matrix calculations  
param = inh_delay(param);
if param.detectability
    disp(['The system is invertible with inherent delay L_0=', num2str(param.L0),' and it is detectable.'])
else 
    disp(['The system is invertible with inherent delay L_0=', num2str(param.L0),' and it is not detectable.'])
end
%% Estimation
x0 =[5; 0; 5; 0]; 
P0 = diag([10 1 10 1].^2); 
[x_u,P_u,x_p,P_p,w_u,Pw, param] = filtering(z,x0,P0,param); 
disp('Filtering completed.')
[x_s,P_s,w_s,Pw_s] = smoothing(x_u,P_u,x_p,P_p,w_u,Pw,param);
disp('Smoothing completed.')
%% Plot
plt=5;
myplot(x_true,w_true,x_u,w_u,P_u,Pw,x_s,P_s,w_s,Pw_s,plt, param)
disp('Plotting completed.')
