%% 9. Inclusion of nonlinearities
%% Init
clear;
%Load state model matrices A, B, C, D
load Material/fp_lin_matrices_fit3.mat

%% Synthesize standard gain
% LQR
R = 1;
Q = 1e4*diag([0.01*0.18^2,0,0.18^2,0,0]);  
[K,~,~] = lqr(A,B,Q,R,0);
% LQE
G = eye(size(A));
Qe = 100*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
Re = (0.018^2)*eye(2); %Variance of measurement errors
L = lqe(A, G, C, Qe, Re);

%% 9.1 Nonlinear model
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
saturation_u = inf;
deadzone_u = 0;
tc = 1e6*(1/100)*2*pi/10;
covProcess = zeros(5);
covSensor = zeros(2);
pulse = 4;

x0 = [50,0,10,0,0]'*pi/180;
T = 10;
sim('Model_9',T);
xnon = x;
unon = u;
tnon = t;
sim('Model_9_linear',T);

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(tnon,xnon(:,[1 3]),'LineWidth',3);
plot(t_lin,x_lin(:,[1 3]),'--','LineWidth',3);
legend({"$\alpha$","$\beta$","$\alpha$ (linear)","$\beta$ (linear)"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/9_1_angles.png');
hold off;

%% 9.2 Saturation

saturation_u = 5;
sim('Model_9',T);
xsat = x;
usat = u;
tsat = t;

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(tsat,xsat(:,[1 3]),'LineWidth',3);
plot(tnon,xnon(:,[1 3]),'--','LineWidth',3);
legend({"$\alpha$","$\beta$","$\alpha$ (wo/ saturation)","$\beta$ (wo/ saturation)"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/9_2_angles.png');
hold off;

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(tsat,usat,'LineWidth',3);
plot(tnon,unon,'--','LineWidth',3);
legend({"$u$","$u$ (wo/ saturation)"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/9_2_u.png');


%% 9.3 Dead zone

deadzone_u = 1e-1;
sim('Model_9',T);
xdz = x;
udz = u;
tdz = t;

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(tdz,xdz(:,[1 3]),'LineWidth',3);
plot(tsat,xsat(:,[1 3]),'--','LineWidth',3);
legend({"$\alpha$","$\beta$","$\alpha$ (wo/ dead zone)","$\beta$ (wo/ dead zone)"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/9_3_angles.png');
hold off;

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(tdz,udz,'LineWidth',3);
plot(tsat,usat,'--','LineWidth',3);
legend({"$u$","$u$ (wo/ dead zone)"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/9_3_u.png');

T = 20;
sim('Model_9',T);
xdz = x;
udz = u;
tdz = t;


%% 9.4 Noise
tc = (1/100)*2*pi/10;
covProcess = 100*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
covSensor = ((2*0.018)^2)*eye(2); % std dev 1 deg
T = 20;
sim('Model_9',T);
xnoise = x;
unoise = u;
tnoise = t;

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(tnoise,xnoise(:,[1 3]),'LineWidth',3);
plot(tdz,xdz(:,[1 3]),'--','LineWidth',3);
legend({"$\alpha$","$\beta$","$\alpha$ (wo/ noise)","$\beta$ (wo/ noise)"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/9_3_angles.png');
hold off;

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
plot(tnoise,unoise,'LineWidth',3);
plot(tdz,udz,'--','LineWidth',3);
legend({"$u$","$u$ (wo/ noise)"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
saveas(gcf,'./figures/9_3_u.png');


