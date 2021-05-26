%% CEE Project - LQR
clear;
%Load state model matrices A, B, C, D
load Material/fp_lin_matrices_fit3.mat

pulse = 4;
x0 = [50,0,10,0,0]'*pi/180;
T = 10;

R = 1;
Q = 10*diag([1/(10*0.18)^2,0,1/0.18^2,0,0]);  
[K,~,~] = lqr(A,B,Q,R,0);
        
G = eye(size(A));
Qe = 100*diag([(0.018)^2,(10*0.018)^2,(10*0.018)^2,(10*10*0.018)^2,0.025^2]);
Re = (0.018^2)*eye(2); %Variance of measurement errors
L = lqe(A, G, C, Qe, Re);  


figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
sim('Model_LQG',T);
plot(t,x(:,1),'LineWidth',3);
plot(t,x(:,3),'LineWidth',3);
sim('Model_LQR',T); 
plot(t,x(:,1),'--','LineWidth',3);
plot(t,x(:,3),'--','LineWidth',3);
legend({"$\alpha (cascaded)$","$\beta (cascaded)$",...
        "$\alpha (wo/ observer)$","$\beta (wo/ observer)$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
ylabel("$(\mathrm{rad})$",'Interpreter','latex');
saveas(gcf,'./figures/LQG_all.png');
hold off;
