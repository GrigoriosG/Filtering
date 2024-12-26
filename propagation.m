function [x,P] = propagation(z,x,P,param)

x = param.Ax*x + param.Bx*z; 
P = param.Ax*P*param.Ax' + param.Bx*param.RL*param.Bx';

end
