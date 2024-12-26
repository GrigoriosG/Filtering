function [z,x, w, param] = Model(param)
%% Parameters
m1=1; m2=1; k=1; c=1; 
param.dt = 0.03; param.T = 10;
Rgps = 0.01^2; Racc = 1^2; Rstrut = 10^2;
%% Plant matrices
param.Ac = [0          1          0              0;
            -k/m1     -c/m1     k/m1          c/m1;
            0          0          0              1;
            k/m2      c/m2      -k/m2         -c/m2];     
param.Bc = [0, 0; 1/m1, 0; 0, 0; 0, 1/m2]; 
param.n = size(param.Bc,1); 
param.m = size(param.Bc,2);
param.C = zeros(0,param.n);
param.D = zeros(0,param.m);   
param.R = zeros(0,0);
if param.gps 
    param.C = [param.C; [1, 0, 0, 0] ];
    param.D = [param.D; zeros(1,param.m) ];
    param.R = blkdiag(param.R, Rgps);
end
if param.strut 
    param.C = [param.C; [1, 0, -1, 0] ];
    param.D = [param.D; zeros(1,param.m) ];
    param.R = blkdiag(param.R, Rstrut);
end  
if param.acc_spr 
    param.C = [param.C; [-k/m1     -c/m1      k/m1         c/m1] ];
    param.D = [param.D; zeros(1,param.m) ];
    param.R = blkdiag(param.R, Racc);
end
if param.acc_unspr 
    param.C = [param.C; [k/m2      c/m2       -k/m2        -c/m2] ];
    param.D = [param.D; [0,   1/m2] ];
    param.R = blkdiag(param.R, Racc);
end
param.p = size(param.D,1);
if not(all(size(param.Ac)==[param.n param.n]) && all(size(param.Bc)==[param.n param.m]) ...
        && all(size(param.C)==[param.p param.n]) && all(size(param.R)==[param.p param.p]))
    error('Matrix dimensions are not consistent.')
end 

%% Discretize the system 
param.A = eye(param.n)+ (param.Ac*param.dt)  ; %expm(param.Ac*param.dt);%
param.B = ( eye(param.n)*param.dt  )*param.Bc; %param.Ac\(param.A-eye(param.n)) 
param.Steps = round(param.T/param.dt); 
param.t = (1:param.Steps)*param.dt;

%% Initialisation
x = zeros(param.n,param.Steps);
w = zeros(param.m,param.Steps);
z = zeros(param.p,param.Steps); 
v = chol(param.R)*randn(param.p,param.Steps);
% save(param.profile,'v_true') 
%% TIME LOOP
x(:,1) = [0; 0; 0; 0];
w(1,:) = 100*square(2*pi*param.t/2);
% w(1,:) = 100*sawtooth(2*pi*param.t/1,0.5);
w(2,1) = -20*x(3,1);
z(:,1) = param.C*x(:,1)+param.D*w(:,1)+v(:,1);
for t=2:param.Steps
    x(:,t) = param.A*x(:,t-1) + param.B*w(:,t-1);
    w(2,t) = -20*x(3,t);
    z(:,t) = param.C*x(:,t) + param.D*w(:,t) + v(:,t);
end
end

% mvib = (m1*m2)/(m1+m2);
% timescale = (2*pi)*sqrt(mvib/k);
% alpha = 0.01;
%alpha*timescale; 
%10*timescale;
% const = (m2/(k*(m1+m2)))*(2*pi*alpha)^2;

% param.F2='square'; 
% %Other profiles: 'square', 'sawtooth'
% if strcmp('square',param.F2)
%     w2_true = 100*square(2*pi*param.t/1)+0;
% elseif strcmp('sawtooth',param.F2)
%     w2_true = 100*sawtooth(2*pi*param.t/1,0.5);
% end 