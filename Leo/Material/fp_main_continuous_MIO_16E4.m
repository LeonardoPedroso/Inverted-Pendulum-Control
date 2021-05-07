load('fp_lin_matrices_fit3.mat'); %%Load Matrices A, B, C, D

ENCODER_RES = 1024;
MOTOR_SAT = 5;
TH1_BOUND = pi;
TH2_BOUND = 30*pi/180;
TIME_DELAY = 6;

Qr = diag([10,0,1,0,0]); %Weight Matrix for x in the integral
Rr = 1e1; %Weight for the input variable

K = lqr(A, B, Qr, Rr); %Calculate feedback gain

G = eye(size(A)); %
Qe = eye(size(A))*10; %Variance of process errors
Re = eye(2); %Variance of measurement errors

L = lqe(A, G, C, Qe, Re); %Calculate estimator gains
