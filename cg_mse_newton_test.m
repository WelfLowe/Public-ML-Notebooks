close all;
clear all;

%% Creating the data
rng(1);
N=100;
XX=fliplr(fullfact([N N]));
a10 = 20;
a20 = -3;
X1 = XX(:,1);
X2 = XX(:,2);

f0 = @(x1,x2)(a10*x1 + a20*x2);
f = @(x1,x2,r)(a10*x1 + a20*x2 + r);
R = normrnd(0,10,1,N*N).';
Y = arrayfun(f,X1,X2,R);
[A,B] = meshgrid(1:10:N,1:10:N);
plot3d(f0,A,B, true);

%% Creating the model
m1 = @(ws,x)(ws(1)*x(1) + ws(2)*x(2));
mse1 = @(ws)(mse(ws,m1,XX,Y));

%% setting initial weights
in = 2;
out = 1;
limit = sqrt(6 / (in + out));
ws0 = [rand*2*limit-limit;rand*2*limit-limit]

%% plot search space
 
f = @(a, b)(mse1([a,b]));
[A,B] = meshgrid(min(a10,ws0(1))-10:1:max(a10,ws0(1))+10,min(a20,ws0(2))-10:1:max(a20,ws0(2))+10);

figure
plot3d(f, A, B, false) %3D contour
hold on
plot(a10,a20,'*r')
plot(ws0(1),ws0(2),'+r')

%% defining the gradient of mse
gradients1{1} = @(ws,x)(x(1));
gradients1{2} = @(ws,x)(x(2));
grad_loss2 = @(ws, randices)(grad_mse(ws, m1, gradients1, XX(randices,:),Y(randices)));

mse2 = @(ws, randices)(mse(ws,m1,XX(randices,:), Y(randices)));
stochastic_grad_eps = @(eps, ws, rho, randices)(grad_eps(eps, ws, rho, m1, XX(randices,:), Y(randices)));
stochastic_grad2_eps = @(rho, randices)(grad2_eps(rho, XX(randices,:)));

%%CG; 
K=20;
tic;
[ws, history] = cg_mse(K, ws0, mse1, mse2, grad_loss2, N*N, true);
toc

%%CG with Newton's method
K=20;
tic;
[ws, history] = cg_mse_newton(K, ws0, mse1, grad_loss2, stochastic_grad_eps, stochastic_grad2_eps, N*N, true);
toc