clear;
load Material/fp_lin_matrices_fit3.mat

A_values = eig(A);
fprintf("Uncontrolled system poles:\n");
damp(A)

%% 5

R = 1; % Must be a positive scalar (single input system)
% Q is a scaled version of a matrix for 
% (Must be a semidefinite positive matrix) % 500
Q =   500*diag([0.1*0.18^2,0,0.18^2,0,0]);
[K,S,e] = lqr(A,B,Q,R,0); %Linear Quadratic Regulator

ABK_values = eig(A - B*K);
fprintf("\n");
fprintf("Controlled system poles:\n");
[wn,zeta,p] = damp(A - B*K);

% slowest poles
[~,idx] = min(abs(ABK_values));
slowestPoleLQR = ABK_values(idx);
fprintf("\n");
fprintf("Slowest pole: %f%+fj\n", real(ABK_values(idx)), imag(ABK_values(idx)));

%% 6
fprintf("\n");
fprintf("State Feedback Simulation\n");

T = 20;
x0 = [pi,0,0.4,0,0]';
sim('Model1',T);

if true

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,x(:,[1 3]),'LineWidth',3);
legend({"$\alpha$","$\beta$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/6_angles.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,x(:,[2 4]),'LineWidth',3);
legend({"$\dot{\alpha}$","$\dot{\beta}$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/6_vel_angles.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,u,'LineWidth',3);
plot(t,x(:,5),'LineWidth',3);
legend({"$u$","$i$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/6_u_i.png');

end

%% 7

% Qe mais alto do q Re - confiar mais no modelo do que nos sensores
    
fprintf("\n");
fprintf("Calculate vector of gains of observer state: \n");

G = eye(size(A)); %Gain of the process noise
%Variance of process errors %100
% Qe = 1*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
% Re = (0.018^2)*eye(2); %Variance of measurement errors

% O último valor da diagonal de Qe é irrelevante. Eu meti todos os outros
% parâmetros fixos e mudei este não acontece nada.

% Se eu aumentar os valores de beta em relação aos valores de alfa, vamos
% dar mais importância ao beta ser estimado mais rapidamente.
%E é isso que acontece.

Qe = 50*diag([(0.018)^2,(0.018*10)^2,(0.018^2),(0.018*10)^2,0]);
Re = (0.018^2)*eye(2);
L = lqe(A, G, C, Qe, Re); %Synthesize estimator gains

% Observer eigenvalues
obs_values = eig(A - L*C);
fprintf("Controlled system poles:\n");
damp(A - L*C)

% slowest pole
[~,idx] = min(abs(obs_values));
slowestPoleLQE = obs_values(idx);
fprintf("Slowest pole: %f%+fj\n", real(obs_values(idx)), imag(obs_values(idx)));
fprintf("Speed estimator/controller: %f\n",real(slowestPoleLQE)/real(slowestPoleLQR));

% Closed loop dynamics
V = A - B*K - L*C;
D_ = [0 0];
Acl = [A -B*K; L*C V];
Acl_values = eig(Acl);

% Note that the vector of gains is designed such that the estimation error
% converges to zero.

%% 8
fprintf("\n");
fprintf("Simulate Controlled System (with state observer)\n");

T = 20;
sim('Model2',T);

a_error_thres = 0.05*(x(1,[1])-x_hat(1,[1]));
b_error_thres = 0.05*(x(1,[3])-x_hat(1,[3]));

index_a = 0;
index_b_1 = 0;
index_b_2 = 0;

for i=1:length(x(:,[1]))
    if (abs(x(i,[1])-x_hat(i,[1])) < a_error_thres)
        index_a = i
        break;
    end
end
for i=50:length(x(:,[1]))
    if (abs(x(i,[3])-x_hat(i,[3])) < b_error_thres)
        index_b = i
        break;
    end
end

if true
    
figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,x(:,[1])-x_hat(:,[1]),'LineWidth',3);
plot(t,x(:,[3])-x_hat(:,[3]),'LineWidth',3);
plot(t,x(:,[1]),'LineWidth',3);
plot(t,x(:,[3]),'LineWidth',3);
plot(t,x_hat(:,[1]),'LineWidth',3);
plot(t,x_hat(:,[3]),'LineWidth',3);
scatter(t(index_a), x(index_a,[1])-x_hat(index_a,[1]), 100, 'filled', 'MarkerFaceColor', [138/255 43/255 226/255]);
scatter(t(index_b), x(index_b,[3])-x_hat(index_b,[3]), 100, 'filled', 'MarkerFaceColor', [138/255 43/255 226/255]);
xlim([min(t), 5])
legend({"$\alpha-\hat{\alpha}$","$\beta-\hat{\beta}$", "$\alpha$", "$\beta$", "$\hat{\alpha}$", "$\hat{\beta}$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/8_angles.png');

% figure('units','normalized','outerposition',[0 0 1 1]);
% hold on;
% grid on;
% set(gca,'FontSize',35);
% plot(t,x(:,[2 4]),'LineWidth',3);
% legend({"$\dot{\alpha}$","$\dot{\beta}$"},'Interpreter','latex');
% xlabel("$t (\mathrm{s})$",'Interpreter','latex');
% saveas(gcf,'./figures/8_vel_angles.png');

% figure('units','normalized','outerposition',[0 0 1 1]);
% hold on;
% grid on;
% set(gca,'FontSize',35);
% plot(t,u,'LineWidth',3);
% plot(t,x(:,5),'LineWidth',3);
% legend({"$u$","$i$"},'Interpreter','latex');
% xlabel("$t (\mathrm{s})$",'Interpreter','latex');
% saveas(gcf,'./figures/8_u_i.png');

% figure('units','normalized','outerposition',[0 0 1 1]);
% hold on;
% grid on;
% set(gca,'FontSize',35);
% plot(t,x_hat-x,'LineWidth',3);
% ylabel("$\hat{x}-x$",'Interpreter','latex');
% xlabel("$t (\mathrm{s})$",'Interpreter','latex');
% legend({"$\alpha$","$\dot{\alpha}$","$\beta$","$\dot{\beta}$","$i$"},'Interpreter','latex');
% saveas(gcf,'./figures/8_estimation_error.png');
end

% With this control strategy, the values of alpha and beta converge to zero
% and the inverted pendulum is properly controlled. Note now that the
% values of K can be altered to try to improve this solution (for example,
% minimizing the time of convergence to zero).
