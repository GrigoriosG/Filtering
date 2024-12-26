function param = inh_delay(param)

%This function computes the system inherent delay (if invertible) ...
%and defines matrices used in the filter/smoother. 

T = param.D;
OL = param.C;
r = rank(T);
rho = r;
T_old = [];
d = 0;

while rho(1)<param.m && d<param.n+1
    T_old = T;
    T = [T, zeros(size(T,1),param.m); param.C*param.A^d*param.B, T(end-(param.p-1):end,:)];
    OL = [OL; param.C*param.A^(d+1)];
    r = [rank(T), r];
    rho = [r(1)-r(2), rho];
    d = d+1;
end 

if rho(1) == param.m
    % SVD rank decompositions
    [U,S,V] = svd(T_old);
    M = T*blkdiag(V,eye(param.m));
    M2 = M(d*param.p+1:end, r(2)+1:end);
    [U2,S2,V2] = svd(M2);
    Xe = M*blkdiag(eye(r(2)),V2);
    X = Xe(:,1:r(1));
    % filter matrices 
    X0 = T(:,1:param.m);
    X1 = X(1:d*param.p, 1:r(2));
    X2 = X(d*param.p+1:end, 1:r(2));
    X3 = X(d*param.p+1:end, r(2)+1:end);
    Z = [X0, [zeros(param.p, r(2)); X1] ];
    Ri = inv(param.R);
    RiCellred = repmat({Ri}, 1, d);
    RiL0red = blkdiag(RiCellred{:});
    RiCell = repmat({Ri}, 1, d+1);
    RiL0 = blkdiag(RiCell{:});
    X1d = (X1'*RiL0red*X1)\(X1'*RiL0red);
    X3d = (X3'*Ri*X3)\(X3'*Ri);
    piX3 = eye(param.p)-X3*X3d;
    Zd = (Z'*RiL0*Z)\Z'*RiL0;
    param.L0 = d;
    param.rho = rho;
    param.OL = OL;
    param.RL = inv(RiL0);
    param.Td = Zd(1:param.m,:);
    param.Pix = [-piX3*X2*X1d piX3];
    param.Rx = [piX3*X2*X1d eye(param.p)]*param.RL*[piX3*X2*X1d eye(param.p)]';
    param.Cx = param.Pix*param.OL;
    param.Bx = param.B*param.Td;
    param.Ax = param.A - param.Bx*param.OL; 
    
    %test for detectability equivalence condition 
%     [Vcol,Deig] = eig(param.Ax);
%     num=4;
%     z=Deig(num,num);
%     x=Vcol(:,num);
%     what = [T_old*repmat(eye(param.m),d,1)*z, -X1]*Zd*OL*x;
    
    
else
    error('The system is not invertible.')
end

invzeros = tzero(param.A, param.B, param.C, param.D);
if any(abs(invzeros)>=1-10^(-8))
    param.detectability = false;
else 
    param.detectability = true;
end

% %     zero(tf(ss(param.A,param.B,param.C,param.D)))






