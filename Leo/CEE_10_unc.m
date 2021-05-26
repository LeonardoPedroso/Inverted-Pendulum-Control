%% 10. Inclusion of uncertainty
%% Init
clear;
%Load state model matrices A, B, C, D
load Material/fp_lin_matrices_fit3.mat

%% %% Synthesize controller and observer - w bias
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
tc = (1/100)*2*pi/10;
covProcess = 100*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
covSensor = ((2*0.018)^2)*eye(2); % std dev 1 deg
pulse = 4;
bias_u = 0.2;


RUN = 9;
str = sprintf("perfromanceMin%02d.mat",RUN);
load(str);

R = 1;
Q = Qctrl(imin)*diag([1/(10*0.18)^2,0,1/0.18^2,0,0]);  
[K,~,~] = lqr(A,B,Q,R,0);

% LQE
G = eye(size(A));
Qe = Qobs(jmin)*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
Re = (0.018^2)*eye(2); %Variance of measurement errors
L = lqe(A, G, C, Qe, Re);

%% 

C_a = [1 0 0 0 0];
A_ = A; % Matrix A com incerteza
A_(2:5,2:5) = A_(2:5,2:5)+ 0.4*(rand(4,4)-0.5);
B_ = B; % Matrix B com incerteza
B_(end) = B_(end)+0.4*(rand()-0.5)*B_(end);
G = (C_a*inv(A_-B_*K)*B_)/(C_a*inv(A-B*K)*B)














