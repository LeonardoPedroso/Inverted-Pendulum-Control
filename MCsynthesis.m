%% MOnte Carlo Sims
clear;
%Load state model matrices A, B, C, D
load Material/fp_lin_matrices_fit3.mat

Nctrl = 100;

%% Sims

Qctrl = 10.^(2:0.5:7);
Qobs = 10.^(2:0.5:9);

performance = inf(length(Qctrl),length(Qobs));

for ictrl = 1:length(Qctrl)
    for iobs = 1:length(Qobs)
        % LQR
        R = 1; % Must be a positive scalar (single input system)
        % Q is a scaled version of a matrix for 
        % (Must be a semidefinite positive matrix)
        Q =  Qctrl(ictrl)*diag([0.1*0.18^2,0,0.18^2,0,0]);  
        [K,S,e] = lqr(A,B,Q,R,0); %Linear Quadratic Regulator

        ABK_values = eig(A - B*K);


        % slowest poles
        [~,idx] = min(abs(ABK_values));
        slowestPoleLQR = ABK_values(idx);

        % LQE
        G = eye(size(A)); %Gain of the process noise
        %Variance of process errors
        Qe = Qobs(iobs)*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
        Re = (0.018^2)*eye(2); %Variance of measurement errors
        L = lqe(A, G, C, Qe, Re); %Synthesize estimator gains

        % Observer eigenvalues
        obs_values = eig(A - L*C);
        [~,idx] = min(abs(obs_values));
        slowestPoleLQE = obs_values(idx);
        
        if real(slowestPoleLQE)/real(slowestPoleLQR) < 4
           continue; 
        end
        
         V = A - B*K - L*C;
         D_ = [0 0];
        
        % Simulação monte Carlo
        % Saturation constants
        saturation_u = 5;
        deadzone_u = 0; % no deadzone yet

        % Initial state
        x0 = [pi/2,0,0.18,0,0]';

        % Noise constants
        tc = (1/100)*2*pi/737;
        covProcess = 1*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
        covSensor = (0.018^2)*eye(2);

        % Nonlinear model constants
        NLM.Le1 = 227*1e-3; %normrnd(0,1e-3); %(m)
        NLM.J0 = 86.98*1e-3; %(Kg m^2) 
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
        
        T = 5;
        sim('ModelNL1',T);
        
        
        performance(ictrl,iobs) = x(:,1)'*x(:,1)+ x(:,3)'*2'*2*x(:,3);
                    
    end
    ictrl
end

save('performance.mat','performance','x0');


%% PLot 


mesh(log10(performance));
