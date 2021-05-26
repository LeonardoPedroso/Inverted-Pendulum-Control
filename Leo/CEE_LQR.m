%% CEE Project - LQR
clear;
%Load state model matrices A, B, C, D
load Material/fp_lin_matrices_fit3.mat

pulse = 4;
x0 = [50,0,10,0,0]'*pi/180;
T = 10;

% LQR
f = 10.^[-1 0 1 2];
figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
for i = 1:4
    R = 1;
    Q = 10*diag([1/(f(i)*0.18)^2,0,1/0.18^2,0,0]); 
    [K,~,~] = lqr(A,B,Q,R,0);
    sim('Model_LQR',T); 
    plot(t,x(:,1),'LineWidth',3);
    plot(t,x(:,3),'--','LineWidth',3);
end
legend({"$\alpha (k = 0.1)$","$\beta (k = 0.1)$",...
        "$\alpha (k = 1)$","$\beta (k = 1)$",...
        "$\alpha (k = 10)$","$\beta (k = 10)$",...
        "$\alpha (k = 100)$","$\beta (k = 100)$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
ylabel("$(\mathrm{rad})$",'Interpreter','latex');
saveas(gcf,'./figures/LQR_k.png');
hold off;

% LQR
f = 10.^[-1 0 1 2];
figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
for i = 1:4
    R = 1;
    Q = 10*diag([1/(f(i)*0.18)^2,0,1/0.18^2,0,0]); 
    [K,~,~] = lqr(A,B,Q,R,0);
    sim('Model_LQR',T); 
    plot(t,u(:,1),'LineWidth',3);
  
end
legend({"$u (k = 0.1)$",...
        "$u (k = 1)$",...
        "$u (k = 10)$",...
        "$u (k = 100)$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
ylabel("$(\mathrm{V})$",'Interpreter','latex');
ylim([-10 10]);
saveas(gcf,'./figures/LQR_k_u.png');
hold off;
%%
% LQR
Qctrl = 10.^[0 1 2 3];
figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
for i = 1:4
    R = 1;
    Q = Qctrl(i)*diag([1/(10*0.18)^2,0,1/0.18^2,0,0]); 
    [K,~,~] = lqr(A,B,Q,R,0);
    sim('Model_LQR',T); 
    plot(t,x(:,1),'LineWidth',3);
    plot(t,x(:,3),'--','LineWidth',3);
end
legend({"$\alpha (\gamma = 1)$","$\beta (\gamma = 1)$",...
        "$\alpha (\gamma = 10)$","$\beta (\gamma = 10)$",...
        "$\alpha (\gamma = 100)$","$\beta (\gamma = 100)$",...
        "$\alpha (\gamma = 1000)$","$\beta (\gamma = 1000)$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
ylabel("$(\mathrm{rad})$",'Interpreter','latex');
saveas(gcf,'./figures/LQR_gamma.png');
hold off;

% LQR
Qctrl = 10.^[0 1 2 3];
figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
grid on;
set(gca,'FontSize',35);
for i = 1:4
    R = 1;
    Q = Qctrl(i)*diag([1/(10*0.18)^2,0,1/0.18^2,0,0]); 
    [K,~,~] = lqr(A,B,Q,R,0);
    sim('Model_LQR',T); 
    if i == 4
        plot(t,u,'--','LineWidth',3);
    else
        plot(t,u,'LineWidth',3);
    end
    
end
legend({"$u (\gamma = 1)$",...
        "$u (\gamma = 10)$",...
        "$u (\gamma = 100)$",...
        "$u (\gamma = 1000)$"},'Interpreter','latex');
xlabel("$t (\mathrm{s})$",'Interpreter','latex');
ylabel("$(\mathrm{V})$",'Interpreter','latex');
ylim([-10 10]);
saveas(gcf,'./figures/LQR_gamma_u.png');
hold off;

%% 


R = 1;
Q = 10*diag([1/(10*0.18)^2,0,1/0.18^2,0,0]); 
[K,~,~] = lqr(A,B,Q,R,0);

damp(A-B*K)


