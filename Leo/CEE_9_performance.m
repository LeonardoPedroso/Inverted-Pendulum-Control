%% 9. Performance evaluation including nonlinearities
%% Init
clear;
%Load state model matrices A, B, C, D
load Material/fp_lin_matrices_fit3.mat

RUN = 5;
Qctrl = 10.^(0:0.25:7);
Qobs = 10.^(0:0.25:9);
performance = inf(length(Qctrl),length(Qobs));
speedRatio = zeros(length(Qctrl),length(Qobs));


%% Nonlinear model
% Model parameters
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
deadzone_u = 1e-1;
tc = (1/100)*2*pi/10;
covProcess = 100*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
covSensor = ((2*0.018)^2)*eye(2);

% Simulation parameters
pulse = 4;
x0 = [50,0,10,0,0]'*pi/180;
T = 10;

%% Simulate synthesis
for ictrl = 1:length(Qctrl)
    for iobs = 1:length(Qobs)
        % LQR
        R = 1;
        Q = Qctrl(ictrl)*diag([0.01*0.18^2,0,0.18^2,0,0]);  
        [K,~,~] = lqr(A,B,Q,R,0);
        ABK_values = eig(A - B*K);
        [~,idx] = min(abs(ABK_values));
        slowestPoleLQR = ABK_values(idx);
        
        % LQE
        G = eye(size(A));
        Qe = Qobs(iobs)*diag([0.018^2,(0.018*10)^2,0.018^2,(0.018*10)^2,0.025^2]);
        Re = (0.018^2)*eye(2); %Variance of measurement errors
        L = lqe(A, G, C, Qe, Re);  
        obs_values = eig(A - L*C);
        [~,idx] = min(abs(obs_values));
        slowestPoleLQE = obs_values(idx);
        
        % Test speed ratio
        if real(slowestPoleLQE)/real(slowestPoleLQR) < 4
           speedRatio(ictrl,iobs) = 1;
        end
        
        sim('Model_9',T);
        performance(ictrl,iobs) = x(:,1)'*x(:,1)+ x(:,3)'*x(:,3);
    end
    ictrl
end

%% Save data
str = sprintf("perfromance%02d.mat",RUN);
save(str,'performance','speedRatio','Qctrl','Qobs','saturation_u','deadzone_u',...
    'covProcess','covSensor','pulse','T');

%% Plot
performanceSpeed = performance;
performanceSpeed(speedRatio == 0) = NaN;
performance(speedRatio ~= 0) = NaN;

[aux, imin] = min(performance);
[Jmin,jmin] = min(aux);
[X,Y] = meshgrid(log10(Qctrl),log10(Qobs));
figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
s = mesh(X,Y,log10(performance)');
s.FaceColor = 'flat';
s = mesh(X,Y,log10(performanceSpeed)');
s.FaceColor = [0.8500 0.3250 0.0980];
scatter3(log10(Qctrl(imin(jmin))),log10(Qobs(jmin)),log10(Jmin),500,'r','filled','d');
xlabel('$\log(\gamma)$','Interpreter','latex');
ylabel('$\log(\phi)$','Interpreter','latex');
zlabel('$\log(J)$','Interpreter','latex');
hold off;



