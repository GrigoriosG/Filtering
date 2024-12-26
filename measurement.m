function [x,P,w,Pw] = measurement(z,x,P,param)

K = (P*param.Cx')/(param.Cx*P*param.Cx' + param.Rx);

x = x + K*(param.Pix*z - param.Cx*x);
P = P - K*param.Cx*P;
P = (P+P')/2;

w = param.Td*(z - param.OL*x);
Pw = param.Td*(param.OL*P*param.OL' + param.RL)*param.Td';

end