%% 9. Inclusion of nonlinearities
%% Init
clear;
%Load state model matrices A, B, C, D
load Material/fp_lin_matrices_fit3.mat


%% Synthesize controller and observer - w bias
rng(1);
NLM.Le1 = 227*1e-3;
NLM.J0 = 86.98*1e-3;
NLM.Ka1 = 1e-3;
NLM.m2 = 309*1e-3;
NLM.Lcm2 = 404*1e-3;
NLM.J2 = 28.37*1e-3;
NLM.Ka2 = 0.136*1e-3;
NLM.Lb = 3e-3;
NLM.R = 2.266;
NLM.Kt = 0.696;
NLM.Kf = 3.377;
NLM.g = 9.81;
saturation_u = 5;
deadzone_u = 2e-1;
bias_u = 0.2;
tc = (1/100)*2*pi/10;
covProcess = 100*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
covSensor = ((0.018)^2)*eye(2); % std dev 1 deg
pulse = 4;
bias_u = 0.2;


RUN = 11;
str = sprintf("perfromanceMin%02d.mat",RUN);
load(str);

R = 1;
Q = Qctrl(imin)*diag([1/(10*0.18)^2,0,1/0.18^2,0,0]);  
[K,~,~] = lqr(A,B,Q,R,0);

damp(A-B*K)

% LQE
G = eye(size(A));
Qe = Qobs(jmin)*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
Re = (0.018^2)*eye(2); %Variance of measurement errors
L = lqe(A, G, C, Qe, Re);

T = 30;
x0 = [50,0,10,0,0]'*pi/180;
sim('Model_9',T);
xopt_ = x;
uopt_ = u;
topt_ = t;


rng(1);
NLM.Le1 = 227*1e-3+normrnd(0,(1e-3)^2);
NLM.J0 = 86.98*1e-3+normrnd(0,(0.03*1e-3)^2);
NLM.Ka1 = 1e-3+normrnd(0,(0.3e-3)^2);
NLM.m2 = 309*1e-3+normrnd(0,(1e-3)^2);
NLM.Lcm2 = 404*1e-3+normrnd(0,(1e-3)^2);
NLM.J2 = 28.37*1e-3+normrnd(0,(0.01e-3)^2);
NLM.Ka2 = 0.136*1e-3+normrnd(0,(0.001e-3)^2);
NLM.Lb = 3e-3+normrnd(0,(0.1e-3)^2);
NLM.R = 2.266+normrnd(0,(0.002)^2);
NLM.Kt = 0.696+normrnd(0,(0.001)^2);
NLM.Kf = 3.377+normrnd(0,(0.002)^2);
NLM.g = 9.81;

T = 30;
x0 = [50,0,10,0,0]'*pi/180;
sim('Model_9',T);
xopt = x;
uopt = u;
topt = t;

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(topt_,xopt_(:,[1 3]),'LineWidth',3);
plot(topt,xopt(:,[1 3]),'--','LineWidth',3);
legend({"$\alpha$ (uncertain id.)","$\beta$ (uncertain id.)","$\alpha_{opt}$","$\beta_{opt}$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
ylabel("$(\mathrm{rad})$",'Interpreter','latex');
saveas(gcf,'./figures/10_0_angles.png');
hold off;


%%
T = 30;
x0 = [50,0,10,0,0]'*pi/180;
sim('Model_9',T);
xopt = x;
uopt = u;
topt = t;

sim('Model_10',T);
xoptbias = x;
uoptbias = u;
toptbias = t;


figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(toptbias,xoptbias(:,[1 3]),'LineWidth',3);
plot(topt,xopt(:,[1 3]),'--','LineWidth',3);
legend({"$\alpha_{w/ bias}$","$\beta_{w/ bias}$","$\alpha_{opt}$","$\beta_{opt}$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
ylabel("$(\mathrm{rad})$",'Interpreter','latex');
saveas(gcf,'./figures/10_1_angles.png');
hold off;

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(toptbias,uoptbias,'LineWidth',3);
plot(topt,uopt,'--','LineWidth',3);
legend({"$u_{w/ bias}$","$u_{opt}$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
ylabel("$(V)$",'Interpreter','latex');
saveas(gcf,'./figures/10_1_u.png');



%% Synthesize controller and observer - Integrator 

C_I = [1 0 0 0 0];
A_ = [A zeros(5,1); C_I 0];
B_ = [B;0];
 
R = 1;
Q = Qctrl(imin)*diag([1/(10*0.18)^2,0,1/0.18^2,0,0]);  
Q_ = [Q zeros(5,1); zeros(1,5) 0.001*Qctrl(imin)*1/(0.18)^2];
[K,~,~] = lqr(A_,B_,Q_,R,0);

damp(A_-B_*K)

% LQE
G = eye(size(A));
Qe = Qobs(jmin)*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
Re = (0.018^2)*eye(2); %Variance of measurement errors
L = lqe(A, G, C, Qe, Re);

T = 30;
sim('Model_10_2',T);
xoptint = x;
uoptint = u;
toptint = t;
xoptint_int = xint;


figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(toptint,xoptint(:,[1 3]),'LineWidth',3);
plot(topt,xopt(:,[1 3]),'--','LineWidth',3);
legend({"$\alpha_{w/ int}$","$\beta_{w/ int}$","$\alpha_{opt}$","$\beta_{opt}$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
ylabel("$(\mathrm{rad})$",'Interpreter','latex');
saveas(gcf,'./figures/10_2_angles.png');
hold off;

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(toptint,xoptint_int(:,[1]),'LineWidth',3);
legend({"$x_{I}$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
ylabel("(rad s)",'Interpreter','latex');
saveas(gcf,'./figures/10_2_xI.png');


