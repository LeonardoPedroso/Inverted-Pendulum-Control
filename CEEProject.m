%% CEE Project
clear;
%Load state model matrices A, B, C, D
load Material/fp_lin_matrices_fit3.mat

%% 1.Analyse matrix A eigenvalues 
A_values = eig(A);
n = size(A,1);
m = size(B,2);
o = size(C,1);
fprintf("1. Uncontrolled system poles:\n");
damp(A)

% Matrix A has three negative eigenvalues, a zero eigenvalue, and a
% positive eigenvalue. The existence of the positive eigenvalue is expected
% as the analysed system (inverted pendulum) is naturally unstable.
%
% Eigenvalues of A:
%
%   * -737.3184 -> Motor Dynamics
%   * -19.3673 -> f(torque,i)
%   * -5.7612 -> Pendulum dynamics (beta)
%   * 0-> Integrator alpha
%   * 6.9974 -> Pendulum dynamics (beta)
% Theta_dot_dot = g
% d/dx([theta theta_dot]) = [0 1;g/l 0]
% Dynamics from u to i is a first-order lowpass system
% Dynamics from i to torque is a first-order lowpass system
% Pendulum dynamics is an unstable second-order system

%% 2. Check controllability
fprintf("-------------------------\n");
fprintf("2. Check controllability:\n");
control_mat = ctrb(A,B);
fprintf("Rank of ctrb: %d | is controllable: %d \n",...
    rank(control_mat),rank(control_mat)==n);
% As A is a 5x5 matrix and B is a 1x5 vector, the controllability matrix
% will be a 5x5 matrix. Its rank is 5, equal to the number of columns.
% This implies that the system is completely controllable, i.e., from any
% initial state, it is possible to reach the origin in finite time.

%% 3. Check observability
fprintf("-------------------------\n");
fprintf("3. Check observability:\n");
% Just measuring x3 (angle beta)
C_aux = [0,0,1,0,0]; 
observ_mat = obsv(A,C_aux);
fprintf("Rank of obsv (measuring x3): %d | is observable: %d \n",...
    rank(observ_mat),rank(observ_mat)==n);

% Measuring x1 and x3 - original C matrix (angles alpha and beta)
observ_mat = obsv(A,C);
fprintf("Rank of obsv (measuring x1 and x3): %d | is observable: %d \n",...
    rank(observ_mat),rank(observ_mat)==n);

% When only x3 is measured, the C matrix is 1x5 and the correspondent
% observability will be 5x5. Its rank is 4, which is not equal to the
% number of columns. This means that, just my measuring x3, the system is
% not completely observable.
% On the other hand, when the original C matrix with size 2x5 is considered, 
% the resulting observability matrix will be 10x5 with rank 5, equal to the 
% number of columns. In this case, the system is completely observable: there
% exists a finite time such that the knowledge of the output is enough to 
% find the initial state x(0)

%% 4. Find transfer function and plot Bode Diagrams
fprintf("-------------------------\n");
fprintf("4. Find transfer function and plot Bode Diagrams:\n");
[b,a] = ss2tf(A,B,C,D);
fprintf("Transfer function alpha(s)/u(s):\n");
H_alpha = tf(b(1,:), a)
fprintf("Transfer function beta(s)/u(s):\n");
H_beta = tf(b(2,:),a)
fprintf("Transfer function beta(s)/alpha(s):\n");
H_beta_alpha = tf(b(2,:),b(1,:))

drawPlots = false;
if drawPlots
figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
set(gca,'FontSize',35);
bode(H_alpha, {10^(-2), 10^4});
grid on;
saveas(gcf,'./figures/4_bode_alpha.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
set(gca,'FontSize',35);
bode(H_alpha, {10^(-2), 10^4});
grid on;
saveas(gcf,'./figures/4_bode_beta.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
set(gca,'FontSize',35);
bode(H_alpha, {10^(-2), 10^4});
grid on;
saveas(gcf,'./figures/4_bode_beta_alpha.png');

% Os pz map que são gerados abaixo tem de se fazer zoom para por no
% relatório

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
set(gca,'FontSize',35);
pzmap(H_alpha);
grid on;
axis equal;
saveas(gcf,'./figures/4_pz_alpha.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
set(gca,'FontSize',35);
pzmap(H_beta);
grid on;
axis equal;
saveas(gcf,'./figures/4_pz_beta.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
set(gca,'FontSize',35);
pzmap(H_beta_alpha);
grid on;
axis equal;
saveas(gcf,'./figures/4_pz_beta_alpha.png');

close all;
end

% Comment the diagram shape 
% O diagrama de bode de alhpa tende para + infty para uma
% entrada constante, o que é consistente com o inteegrador da velocidade
% angukar do motor. É de notar que a mag começa a cair a -40 db/dec após
% passar o pólo -5.76 que como prvisto anteriormente é o pólo que rege a
% dinâmica entre o torque na barra horizontal. è de notar que como os pólos
% da dinâmica do pendulo estão muito próximos dos zeros da func de
% transferencia de u para beta, então estes têm um efeito despresável na
% mag de fase. 
% Já o diagram de beta, como seria de esperar dados os dois zeros na origem
% + polo da funcao de tranferencia sobe a 20 db/decada a baixas
% frequencias. Note-se, portanto, que a dinâmica do pendulo é pouco 
% excitada por sinais de baixa frequencia do motor. Pelo contrário a
% dinâmica de beta é exitada por altas frequencias de alpha 
% (i.e. a dinâmica de beta com input de alpha é de um filtro passa-alto)
% caracterizada por dois zeros na origem e pelos dois pólos do pêndulo 
% (que são os zeros da f.t. de u para alpha).
% Assim, o diagram de beta é uma combinação destes dois efeitos:
% A baixas frequencias u excita a barra horizontal, mas nesta gamma de
% frequencias a barra horizontal não excita o pêndulo. Já para altas
% frequencias, ainda que o movimento da barra horizontal exite o pêdulo, 
% não é possivel esitar a barra nesta gama de frequencias usando o motor.
% Assim, é possívek controlar o pêdulo com um sinal u de uma frequencia
% intermédia.

% Porque é que é controlável
% O sistema tem dois graus de liberdade alpha e beta que pretedemos
% controlar. O diagrama de bode de alhpa tende para + infty para uma
% entrada constante, o que é consistente com o inteegrador da velocidade
% angukar do motor. Por outro lado, beta é penas sensivel a uma gama de
% frequencias em torno de 5 rad/s = 0.8 Hz. Assim, ainda que tenhamos
% apenas um input conseguimos controlor dois graus de liberdade, visto que
% cada uma é controlada de forma diferente no dominio da frquencia. isto e,
% alpha é controlado por tensões aproximadamente constantes e beta por
% variacoes de tensaõ de frequencia de ordem de grandeza de 5 rad s.

% A funcção transferencia evidencia a existencia de dois zeros na origem,
% que causam a subida a baixas frequencias da magnitude do diagrama de
% bode. Assim, há um cancelamento do pólo do integrador que inibe que se
% possa observar esse modo.

%% 5. Compute vector of gains K
fprintf("-------------------------\n");
fprintf("5. Compute vector of gains K: (assuming full state feedback)\n");
R = 1; % Must be a positive scalar (single input system)
% Q is a scaled version of a matrix for 
% (Must be a semidefinite positive matrix)
Q = 500*diag([0.1*0.18^2,0,0.18^2,0,0]);  
[K,S,e] = lqr(A,B,Q,R,0); %Linear Quadratic Regulator

ABK_values = eig(A - B*K);
fprintf("Controlled system poles:\n");
damp(A - B*K)

% slowest poles
[~,idx] = min(abs(ABK_values));
slowestPoleLQR = ABK_values(idx);
fprintf("Slowest pole: %f%+fj\n", real(ABK_values(idx)), imag(ABK_values(idx)));

%% 6. State Feedback Simulation (Model 1)
fprintf("-------------------------\n");
fprintf("6. State Feedback Simulation (assuming full state feedback)\n");

T = 20;
x0 = [0.1,0,0,0,0]';
sim('Model1',T);

if false

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

%% 7. Calculate vector of gains of observer state
fprintf("-------------------------\n");
fprintf("7. Calculate vector of gains of observer state: \n");

G = eye(size(A)); %Gain of the process noise
%Variance of process errors
Qe = 0.1*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
Re = (0.018^2)*eye(2); %Variance of measurement errors
L = lqe(A, G, C, Qe, Re); %Synthesize estimator gains

% Observer eigenvalues
obs_values = eig(A - L*C);
fprintf("Controlled system poles:\n");
damp(A - L*C)

% slowest pole
[~,idx] = min(abs(obs_values));
slowestPoleLQE = obs_values(idx);
fprintf("Slowest pole: %f%+fj\n", real(obs_values(idx)), imag(obs_values(idx)));
fprintf("Speed estimator/controller: %f\n",real(slowestPoleLQR)/real(slowestPoleLQE));

% Closed loop dynamics
V = A - B*K - L*C;
D_ = [0 0];
Acl = [A -B*K; L*C V];
Acl_values = eig(Acl);

% Note that the vector of gains is designed such that the estimation error
% converges to zero.

%% 8. Simulate Controlled System (with state observer)
fprintf("-------------------------\n");
fprintf("8. Simulate Controlled System (with state observer) \n");

T = 20;
sim('Model2',T);

if false

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,x(:,[1 3]),'LineWidth',3);
legend({"$\alpha$","$\beta$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/8_angles.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,x(:,[2 4]),'LineWidth',3);
legend({"$\dot{\alpha}$","$\dot{\beta}$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/8_vel_angles.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,u,'LineWidth',3);
plot(t,x(:,5),'LineWidth',3);
legend({"$u$","$i$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/8_u_i.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,x_hat-x,'LineWidth',3);
ylabel("$\hat{x}-x$",'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
legend({"$\alpha$","$\dot{\alpha}$","$\beta$","$\dot{\beta}$","$i$"},'Interpreter','latex');
saveas(gcf,'./figures/8_estimation_error.png');
end

% With this control strategy, the values of alpha and beta converge to zero
% and the inverted pendulum is properly controlled. Note now that the
% values of K can be altered to try to improve this solution (for example,
% minimizing the time of convergence to zero).

%% 9. Simulate Controlled System (with state observer) 
% Process noise + sensor noise + saturation
fprintf("-------------------------\n");
fprintf("8.1 Simulate Controlled System with process noise, sensor noise, saturation.\n");

saturation_u = 5;

tc = (1/100)*2*pi/737;
covProcess = 10*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
covSensor = (0.018^2)*eye(2);

T = 20;
sim('ModelNL1',T);

if true

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,x(:,[1 3]),'LineWidth',3);
legend({"$\alpha$","$\beta$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/9_angles.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,x(:,[2 4]),'LineWidth',3);
legend({"$\dot{\alpha}$","$\dot{\beta}$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/9_vel_angles.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,u,'LineWidth',3);
plot(t,x(:,5),'LineWidth',3);
legend({"$u$","$i$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/9_u_i.png');

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(t,x_hat-x,'LineWidth',3);
ylabel("$\hat{x}-x$",'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
legend({"$\alpha$","$\dot{\alpha}$","$\beta$","$\dot{\beta}$","$i$"},'Interpreter','latex');
saveas(gcf,'./figures/9_estimation_error.png');
end

% With this control strategy, the values of alpha and beta converge to zero
% and the inverted pendulum is properly controlled. Note now that the
% values of K can be altered to try to improve this solution (for example,
% minimizing the time of convergence to zero).

%% A Fazer
% Ver funcao tranferencia -> observabilidade - check leo 16/04
% Comentar bode no codigo em relação a controlabilidade - check leo 16/04
% Ver não linearidades: 
% 1. Ruido aditivo; 
% 2. Saturação;  -> aparece lá 5, mas acho que não deve ser o que ali está 
% -> já se pode por heuristica de performance
% 3. Deadzone; 
% 4. Não linearidade
% 5. delay
% Referencia em alpha
