function myplot(x_true,w_true,x_u,w_u,P_u,Pw,x_s,P_s,w_s,Pw_s,plt, param)


t=(1:param.range)*param.dt;

if plt==1
    figure(1)
    subplot(3,1,1)
    plot(t, sqrt(squeeze(P_u(1,1,:))),'k--',t, sqrt(squeeze(P_s(1,1,:))),'r--')
    legend({'unc11 (m)','unc11s (m)'},'Location','northeast','FontSize',18)
    ylabel('m','FontSize',18)
    xlabel('Time (s)','FontSize',18)
    subplot(3,1,2)
    plot(t, sqrt(squeeze(P_u(2,2,:))),'k--',t, sqrt(squeeze(P_s(2,2,:))),'r--')
    legend({'unc22 (m)','unc22s (m)'},'Location','northeast','FontSize',18)
    ylabel('m/s','FontSize',18)
    xlabel('Time (s)','FontSize',18)
    subplot(3,1,3)
    plot(t, sqrt(squeeze(P_u(1,1,:))),'k--',t, sqrt(squeeze(P_u(2,2,:))),'r--',t, sqrt(squeeze(P_u(1,2,:))),'b--')
    legend({'unc11 (m)','unc22 (m)', 'unc12 (m)'},'Location','northeast','FontSize',18)
    ylabel('m, m/s, sqrt(m^2/s)','FontSize',18)
    xlabel('Time (s)','FontSize',18)
elseif plt==2
    figure(1)
    subplot(3,1,1)
    plot(t, x_true(1,:),'k--', t, x_u(1,:),'r', t, x_s(1,:),'b') %, t, x_s(1,:),'r--'
    legend({'True','Filtered','Smoothed'},'Location','northeast','FontSize',18)
    ylabel('x_s (m)','FontSize',18)
    xlabel('t (s)','FontSize',18)
    subplot(3,1,2)
    plot(t, x_true(3,:),'k--', t, x_u(3,:),'r', t, x_s(3,:),'b')
    legend({'True','Filtered','Smoothed'},'Location','northeast','FontSize',18)
    ylabel('x_u (m)','FontSize',18)
    xlabel('t (s)','FontSize',18)
    subplot(3,1,3)
    plot(t, w_true,'k--', t, w_u,'r', t, w_s,'b')
    legend({'True','Filtered','Smoothed'},'Location','northeast','FontSize',18)
    ylabel('x_r (m)','FontSize',18)
    xlabel('t (s)','FontSize',18)
elseif plt==3
    subplot(2,1,1)
    plot(t, x_true(1,:),'b', t, x_u(1,:),'b--', t, x_s(1,:),'b:',t, x_true(3,:),'r', t, x_u(3,:),'r--', t, x_s(3,:),'r:',t, w_true,'k', t, w_u,'k--', t, w_s,'k:')
    legend({'True Sprung Mass','Filtered Sprung Mass','Smoothed Sprung Mass',...
            'True Unsprung Mass','Filtered Unsprung Mass','Smoothed Unprung Mass',...
            'True Road Profile','Filtered Road Profile','Smoothed Road Profile'},'Location','northeast','FontSize',14)
    ylabel('Position(m)','FontSize',14)
    xlabel('Time(s)','FontSize',14)
    subplot(2,1,2)
    plot(t, x_true(2,:),'b', t, x_u(2,:),'b--', t, x_s(2,:),'b:',t, x_true(4,:),'r', t, x_u(4,:),'r--', t, x_s(4,:),'r:')
    legend({'True Sprung Mass','Filtered Sprung Mass','Smoothed Sprung Mass',...
            'True Unsprung Mass','Filtered Unsprung Mass','Smoothed Unprung Mass'},'Location','northeast','FontSize',14)
    ylabel('Velocity(m/s)','FontSize',14)
    xlabel('Time(s)','FontSize',14)
elseif plt==4
    figure(1)
    subplot(4,1,1)
    plot(t, x_true(1,1:param.range),'k', t, x_u(1,:),'r', t, x_s(1,:),'b') 
    patch([t,flip(t)],[x_u(1,:)+sqrt(squeeze(P_u(1,1,:)))',flip(x_u(1,:)-sqrt(squeeze(P_u(1,1,:)))')],'r','FaceAlpha',0.1,'EdgeAlpha',0); 
    patch([t,flip(t)],[x_s(1,:)+sqrt(squeeze(P_s(1,1,:)))',flip(x_s(1,:)-sqrt(squeeze(P_s(1,1,:)))')],'b','FaceAlpha',0.1,'EdgeAlpha',0);
    legend({'System State','Filtering Estimate','Smoothing Estimate'},'Location','northeast','FontSize',18)
    ylabel('x_1 (m)','FontSize',18)
    xlabel('t (s)','FontSize',18)
    subplot(4,1,2)
    plot(t, x_true(3,1:param.range),'k', t, x_u(3,:),'r', t, x_s(3,:),'b')
    patch([t,flip(t)],[x_u(3,:)+sqrt(squeeze(P_u(3,3,:)))',flip(x_u(3,:)-sqrt(squeeze(P_u(3,3,:)))')],'r','FaceAlpha',0.1,'EdgeAlpha',0); 
    patch([t,flip(t)],[x_s(3,:)+sqrt(squeeze(P_s(3,3,:)))',flip(x_s(3,:)-sqrt(squeeze(P_s(3,3,:)))')],'b','FaceAlpha',0.1,'EdgeAlpha',0);
    legend({'System State','Filtering Estimate','Smoothing Estimate'},'Location','northeast','FontSize',18)
    ylabel('x_2 (m)','FontSize',18)
    xlabel('t (s)','FontSize',18)
    subplot(4,1,3)
    plot(t, w_true(1,1:param.range),'k', t, w_u(1,:),'r', t, w_s(1,:),'b')
    patch([t,flip(t)],[w_u(1,:)+sqrt(squeeze(Pw(1,1,:)))',flip(w_u(1,:)-sqrt(squeeze(Pw(1,1,:)))')],'r','FaceAlpha',0.1,'EdgeAlpha',0); 
    patch([t,flip(t)],[w_s(1,:)+sqrt(squeeze(Pw_s(1,1,:)))',flip(w_s(1,:)-sqrt(squeeze(Pw_s(1,1,:)))')],'b','FaceAlpha',0.1,'EdgeAlpha',0);
    legend({'System Input','Filtering Estimate','Smoothing Estimate'},'Location','northeast','FontSize',18)
    ylabel('F_1 (N)','FontSize',18)
    xlabel('t (s)','FontSize',18)
    ylim([-300, 300])
    subplot(4,1,4)
    plot(t, w_true(2,1:param.range),'k', t, w_u(2,:),'r', t, w_s(2,:),'b')
    patch([t,flip(t)],[w_u(2,:)+sqrt(squeeze(Pw(2,2,:)))',flip(w_u(2,:)-sqrt(squeeze(Pw(2,2,:)))')],'r','FaceAlpha',0.1,'EdgeAlpha',0); 
    patch([t,flip(t)],[w_s(2,:)+sqrt(squeeze(Pw_s(2,2,:)))',flip(w_s(2,:)-sqrt(squeeze(Pw_s(2,2,:)))')],'b','FaceAlpha',0.1,'EdgeAlpha',0);
    legend({'System Input','Filtering Estimate','Smoothing Estimate'},'Location','northeast','FontSize',18)
    ylabel('F_2 (N)','FontSize',18)
    xlabel('t (s)','FontSize',18) 
elseif plt==5 % like plt==4  but only the filtering
    figure(1)
    subplot(4,1,1)
    plot(t, x_true(1,1:param.range),'k', t, x_u(1,:),'r') 
    patch([t,flip(t)],[x_u(1,:)+sqrt(squeeze(P_u(1,1,:)))',flip(x_u(1,:)-sqrt(squeeze(P_u(1,1,:)))')],'r','FaceAlpha',0.1,'EdgeAlpha',0); 
    %patch([t,flip(t)],[x_s(1,:)+sqrt(squeeze(P_s(1,1,:)))',flip(x_s(1,:)-sqrt(squeeze(P_s(1,1,:)))')],'b','FaceAlpha',0.1,'EdgeAlpha',0);
    %legend({'System State','Filtering Estimate'},'Location','northeast','FontSize',18)
    ylabel('x_1 (m)','FontSize',18)
    xlabel('t (s)','FontSize',18)
    subplot(4,1,2)
    plot(t, x_true(3,1:param.range),'k', t, x_u(3,:),'r')
    patch([t,flip(t)],[x_u(3,:)+sqrt(squeeze(P_u(3,3,:)))',flip(x_u(3,:)-sqrt(squeeze(P_u(3,3,:)))')],'r','FaceAlpha',0.1,'EdgeAlpha',0); 
    %patch([t,flip(t)],[x_s(3,:)+sqrt(squeeze(P_s(3,3,:)))',flip(x_s(3,:)-sqrt(squeeze(P_s(3,3,:)))')],'b','FaceAlpha',0.1,'EdgeAlpha',0);
    %legend({'System State','Filtering Estimate'},'Location','northeast','FontSize',18)
    ylabel('x_2 (m)','FontSize',18)
    xlabel('t (s)','FontSize',18)
    subplot(4,1,3)
    plot(t, w_true(1,1:param.range),'k', t, w_u(1,:),'r')
    patch([t,flip(t)],[w_u(1,:)+sqrt(squeeze(Pw(1,1,:)))',flip(w_u(1,:)-sqrt(squeeze(Pw(1,1,:)))')],'r','FaceAlpha',0.1,'EdgeAlpha',0); 
    %patch([t,flip(t)],[w_s(1,:)+sqrt(squeeze(Pw_s(1,1,:)))',flip(w_s(1,:)-sqrt(squeeze(Pw_s(1,1,:)))')],'b','FaceAlpha',0.1,'EdgeAlpha',0);
    %legend({'System Input','Filtering Estimate'},'Location','northeast','FontSize',18)
    ylabel('F_1 (N)','FontSize',18)
    xlabel('t (s)','FontSize',18)
    ylim([-300, 300])
    subplot(4,1,4)
    plot(t, w_true(2,1:param.range),'k', t, w_u(2,:),'r')
    patch([t,flip(t)],[w_u(2,:)+sqrt(squeeze(Pw(2,2,:)))',flip(w_u(2,:)-sqrt(squeeze(Pw(2,2,:)))')],'r','FaceAlpha',0.1,'EdgeAlpha',0); 
    %patch([t,flip(t)],[w_s(2,:)+sqrt(squeeze(Pw_s(2,2,:)))',flip(w_s(2,:)-sqrt(squeeze(Pw_s(2,2,:)))')],'b','FaceAlpha',0.1,'EdgeAlpha',0);
    %legend({'System Input','Filtering Estimate'},'Location','northeast','FontSize',18)
    ylabel('F_2 (N)','FontSize',18)
    xlabel('t (s)','FontSize',18)
end 
