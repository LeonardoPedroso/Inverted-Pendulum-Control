%% CEE Project

%Load state model matrices A, B, C, D
load fp_lin_matrices_fit3.mat

%% 1.Analyse matrix A eigenvalues 
A_values = eig(A);

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
%
% Dynamics from u to i is a first-order lowpass system
% Dynamics from i to torque is a first-order lowpass system
% Pendulum dynamics is an unstable second-order system

%% 2. Check controllability
control_mat = ctrb(A,B);
rank(control_mat);

% As A is a 5x5 matrix and B is a 1x5 vector, the controllability matrix
% will be a 5x5 matrix. Its rank is 5, equal to the number of columns.
% This implies that the system is completely controllable, i.e., from any
% initial state, it is possible to reach the origin in finite time.
%% 3. Check observability

% Just measuring x3 (angle beta)
C_aux = [0,0,1,0,0]; 
observ_mat = obsv(A,C_aux);
rank(observ_mat);

% Measuring x1 and x3 - original C matrix (angles alpha and beta)
observ_mat = obsv(A,C);
rank(observ_mat);

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
[b,a] = ss2tf(A,B,C,D);
H_alpha = tf(b(1,:), a);
H_beta = tf(b(2,:),a);
figure
bode(H_alpha, {10^(-2), 10^4});
figure
pzmap(H_alpha); %Pole-zero map
figure
bode(H_beta, {10^(-2), 10^4});
figure
pzmap(H_beta); %Pole-zero map
grid on;

%% 5. Compute vector of gains K
R = 1; %Must be a positive scalar
Q = diag([1,0,10,0,0]); %Must be a semidefinite positive matrix
[K,S,e] = lqr(A,B,Q,R,0); %Linear Quadratic Regulator

ABK_values = eig(A - B*K);

% -737.3184
%  -18.6615
%   -9.3649
%   -4.3740
%   -1.4659

%% 6. State Feedback Simulation (outputs = angles alpha and beta)
T = 40;
x0 = [0.1,0,0,0,0]';
K_ = [K(1) K(3)];
sim('Model1',T);

gg = plot(t,x);
set(gg,'LineWidth',1.5);
gg = xlabel('Time (s)');
set(gg,'Fontsize',12);
gg = ylabel('\alpha, \beta (rad)');
set(gg,'Fontsize',12);
legend('\alpha', '\beta');

%% 7. Calculate vector of gains of observer state
G = eye(size(A)); %Gain of the process noise
Qe = eye(size(A))*10; %Variance of process errors
Re = eye(2); %Variance of measurement errors

% Note that the vector of gains is designed such that the estimation error
% converges to zero.

%% 8. Simulate Controlled System (with state observer)
L = lqe(A, G, C, Qe, Re); %Calculate estimator gains
V = A - B*K - L*C;
D_ = [0 0];
obs_values = eig(A - L*C);
Acl = [A -B*K; L*C V];
Acl_values = eig(Acl);
%%

sim('Model2',T);

gg = plot(t,y);
set(gg,'LineWidth',1.5);
gg = xlabel('Time (s)');
set(gg,'Fontsize',12);
gg = ylabel('\alpha, \beta (rad)');
set(gg,'Fontsize',12);
legend('\alpha', '\beta');

% With this control strategy, the values of alpha and beta converge to zero
% and the inverted pendulum is properly controlled. Note now that the
% values of K can be altered to try to improve this solution (for example,
% minimizing the time of convergence to zero).