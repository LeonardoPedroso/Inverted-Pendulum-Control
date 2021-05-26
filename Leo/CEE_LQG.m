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
ABK_values = eig(A - B*K);
[~,idx] = max(real(ABK_values));
slowestPoleLQR = ABK_values(idx);
        

% LQG
Q = 10.^[-1 0 1 2];
figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);

% LQE
G = eye(size(A));
%Qe = 100*diag([(0.018)^2,(10*0.018)^2,0.018^2,(10*0.018)^2,0.025^2]);
Qe = 100*diag([(0.018)^2,(10*0.018)^2,(30*0.018)^2,(30*10*0.018)^2,0.025^2]);
Re = (0.018^2)*eye(2); %Variance of measurement errors
L = lqe(A, G, C, Qe, Re);  
sim('Model_LQG',T); 
plot(t,x(:,:)-x_hat(:,:),'LineWidth',3);
legend({"$\alpha$",...
        "$\dot{\alpha}$",...
        "$\beta$",...
        "$\dot{\beta}$",...
        "$i$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
ylabel("Estimation error",'Interpreter','latex');
saveas(gcf,'./figures/LQG.png');
hold off;

damp(A-L*C)

obs_values = eig(A - L*C);
[~,idx] = max(real(obs_values));
slowestPoleLQE = obs_values(idx);
real(slowestPoleLQE)/real(slowestPoleLQR)
