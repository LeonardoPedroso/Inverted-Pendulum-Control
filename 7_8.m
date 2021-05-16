clear;
load Material/fp_lin_matrices_fit3.mat

A_values = eig(A);
fprintf("Uncontrolled system poles:\n");
damp(A)

%% 5

R = 5; % Must be a positive scalar (single input system)
% Q is a scaled version of a matrix for 
% (Must be a semidefinite positive matrix) % 500
Q = 600*diag([0.1*0.18^2,0,0.18^2,0,0]);
[K,S,e] = lqr(A,B,Q,R,0); %Linear Quadratic Regulator

ABK_values = eig(A - B*K);
fprintf("\n");
fprintf("Controlled system poles:\n");
[wn,zeta,p] = damp(A - B*K)

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

% If Qe is higher than Re, we are giving more importance to the model than
% to the sensors

% Effects of the parameter G: increasing the gain of the process noise
% shifts the slowest pole to the left (so the observer becomes faster) and
% the system also converges faster to the origin. However, increasing the
% gain too much results in the opposite effect, where the slowest pole
% begins shifting to the right again and the observer becomes slower,
% resulting in a slower convergence to the origin. As the gain increases,
% there is a faster shift in the motor's actuation, followed by a slower
% actuation.

% Effects of the parameter Qe:

    %If all the parameters in the diagonal are raised equally, the same
    %effect of the parameter G occurs;
    
    %Increasing only the parameter in beta results in a slower observer;
    
    %Increasing only the parameter in alpha results in a faster observer
    %(1000 times bigger than the parameter in alpha should be enough to move
    %the pole significantly to the left)

% Effects of the parameter Re: increasing Re results in a slower observer,
% as the slowest pole migrates to the right. It is possible to increase Re
% so much that the resulting system becomes unstable (although, in
% practice, this probably does not happen)

% Note that the observer also uses the vector of gains K that was obtained
% in the state feedback controller. Thus, changing K will also alter the
% behaviour of the observer. In particular, it is possible, for example,
% to find a combination of K, Qe, Re, and G that leads the errors of alpha
% and beta to thresholds at the same time.

G = 0.9*eye(size(A));
Qe = 50*diag([10.5*(0.018)^2,(0.018*10)^2,(0.018^2),(0.018*10)^2,0]);
Re = 5*(0.018^2)*eye(2);
L = lqe(A, G, C, Qe, Re); %Synthesize estimator gains
obs_values = eig(A - L*C)
[~,idx] = min(abs(obs_values));
slowestPoleLQE = obs_values(idx);
fprintf("Slowest pole: %f%+fj\n", real(obs_values(idx)), imag(obs_values(idx)));
fprintf("Speed estimator/controller: %f\n",real(slowestPoleLQE)/real(slowestPoleLQR));

V = A - B*K - L*C;
D_ = [0 0];
Acl = [A -B*K; L*C V];
Acl_values = eig(Acl);

%% 8

T = 10;
x0 = [pi,0,0.1,0,0]';
sim('Model2_sat',T);

a_error_thres = 0.05*(x(1,[1])-x_hat(1,[1]));
b_error_thres = 0.05*(x(1,[3])-x_hat(1,[3]));

index_a = 0;
index_b_1 = 0;
index_b_2 = 0;

for i=1:length(x(:,[1]))
    if (abs(x(i,[1]) - x_hat(i,[1])) < a_error_thres)
        index_a = i;
        break;
    end
end

for i=50:length(x(:,[3]))
    if (abs(x(i,[3]) - x_hat(i,[3])) < b_error_thres)
        index_b = i;
        break;
    end
end

fprintf("Indices: %d %d\n", index_a, index_b);

if true
 figure('units','normalized','outerposition',[0 0 1 1]);
 hold on;
 grid on;
 set(gca,'FontSize',35);
 plot(t,x(:,[1 3])-x_hat(:,[1 3]),'LineWidth',3);
 scatter(t(index_a), x(index_a,[1])-x_hat(index_a,[1]), 100, 'filled', 'MarkerFaceColor', [138/255 43/255 226/255]);
 scatter(t(index_b), x(index_b,[3])-x_hat(index_b,[3]), 100, 'filled', 'MarkerFaceColor', [138/255 43/255 226/255]);
 legend({"$\alpha-\hat{\alpha}$","$\beta-\hat{\beta}$"},'Interpreter','latex');
 xlabel("$t (\mathrm{s})$",'Interpreter','latex');
 saveas(gcf,'./figures/8_hat.png');

 figure('units','normalized','outerposition',[0 0 1 1]);
 hold on;
 grid on;
 set(gca,'FontSize',35);
 plot(t,u,'LineWidth',3);
 plot(t,x(:,5),'LineWidth',3);
 legend({"$u$","$i$"},'Interpreter','latex');
 xlabel("$t (\mathrm{s})$",'Interpreter','latex');
 saveas(gcf,'./figures/8_u_i.png');
end

% With this control strategy, the values of alpha and beta converge to zero
% and the inverted pendulum is properly controlled. Note now that the
% values of K can be altered to try to improve this solution (for example,
% minimizing the time of convergence to zero).clear;
load Material/fp_lin_matrices_fit3.mat

A_values = eig(A);
fprintf("Uncontrolled system poles:\n");
damp(A)

%% 5

R = 5; % Must be a positive scalar (single input system)
% Q is a scaled version of a matrix for 
% (Must be a semidefinite positive matrix) % 500
Q = 600*diag([0.1*0.18^2,0,0.18^2,0,0]);
[K,S,e] = lqr(A,B,Q,R,0); %Linear Quadratic Regulator

ABK_values = eig(A - B*K);
fprintf("\n");
fprintf("Controlled system poles:\n");
[wn,zeta,p] = damp(A - B*K)

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

% If Qe is higher than Re, we are giving more importance to the model than
% to the sensors

% Effects of the parameter G: increasing the gain of the process noise
% shifts the slowest pole to the left (so the observer becomes faster) and
% the system also converges faster to the origin. However, increasing the
% gain too much results in the opposite effect, where the slowest pole
% begins shifting to the right again and the observer becomes slower,
% resulting in a slower convergence to the origin. As the gain increases,
% there is a faster shift in the motor's actuation, followed by a slower
% actuation.

% Effects of the parameter Qe:

    %If all the parameters in the diagonal are raised equally, the same
    %effect of the parameter G occurs;
    
    %Increasing only the parameter in beta results in a slower observer;
    
    %Increasing only the parameter in alpha results in a faster observer
    %(1000 times bigger than the parameter in alpha should be enough to move
    %the pole significantly to the left)

% Effects of the parameter Re: increasing Re results in a slower observer,
% as the slowest pole migrates to the right. It is possible to increase Re
% so much that the resulting system becomes unstable (although, in
% practice, this probably does not happen)

% Note that the observer also uses the vector of gains K that was obtained
% in the state feedback controller. Thus, changing K will also alter the
% behaviour of the observer. In particular, it is possible, for example,
% to find a combination of K, Qe, Re, and G that leads the errors of alpha
% and beta to thresholds at the same time.

G = 0.9*eye(size(A));
Qe = 50*diag([10.5*(0.018)^2,(0.018*10)^2,(0.018^2),(0.018*10)^2,0]);
Re = 5*(0.018^2)*eye(2);
L = lqe(A, G, C, Qe, Re); %Synthesize estimator gains
obs_values = eig(A - L*C)
[~,idx] = min(abs(obs_values));
slowestPoleLQE = obs_values(idx);
fprintf("Slowest pole: %f%+fj\n", real(obs_values(idx)), imag(obs_values(idx)));
fprintf("Speed estimator/controller: %f\n",real(slowestPoleLQE)/real(slowestPoleLQR));

V = A - B*K - L*C;
D_ = [0 0];
Acl = [A -B*K; L*C V];
Acl_values = eig(Acl);

%% 8

T = 10;
x0 = [pi,0,0.1,0,0]';
sim('Model2_sat',T);

a_error_thres = 0.05*(x(1,[1])-x_hat(1,[1]));
b_error_thres = 0.05*(x(1,[3])-x_hat(1,[3]));

index_a = 0;
index_b_1 = 0;
index_b_2 = 0;

for i=1:length(x(:,[1]))
    if (abs(x(i,[1]) - x_hat(i,[1])) < a_error_thres)
        index_a = i;
        break;
    end
end

for i=50:length(x(:,[3]))
    if (abs(x(i,[3]) - x_hat(i,[3])) < b_error_thres)
        index_b = i;
        break;
    end
end

fprintf("Indices: %d %d\n", index_a, index_b);

if true
 figure('units','normalized','outerposition',[0 0 1 1]);
 hold on;
 grid on;
 set(gca,'FontSize',35);
 plot(t,x(:,[1 3])-x_hat(:,[1 3]),'LineWidth',3);
 scatter(t(index_a), x(index_a,[1])-x_hat(index_a,[1]), 100, 'filled', 'MarkerFaceColor', [138/255 43/255 226/255]);
 scatter(t(index_b), x(index_b,[3])-x_hat(index_b,[3]), 100, 'filled', 'MarkerFaceColor', [138/255 43/255 226/255]);
 legend({"$\alpha-\hat{\alpha}$","$\beta-\hat{\beta}$"},'Interpreter','latex');
 xlabel("$t (\mathrm{s})$",'Interpreter','latex');
 saveas(gcf,'./figures/8_hat.png');

 figure('units','normalized','outerposition',[0 0 1 1]);
 hold on;
 grid on;
 set(gca,'FontSize',35);
 plot(t,u,'LineWidth',3);
 plot(t,x(:,5),'LineWidth',3);
 legend({"$u$","$i$"},'Interpreter','latex');
 xlabel("$t (\mathrm{s})$",'Interpreter','latex');
 saveas(gcf,'./figures/8_u_i.png');
end

% With this control strategy, the values of alpha and beta converge to zero
% and the inverted pendulum is properly controlled. Note now that the
% values of K can be altered to try to improve this solution (for example,
% minimizing the time of convergence to zero).