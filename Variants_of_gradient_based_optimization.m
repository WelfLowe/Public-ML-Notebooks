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

%% testcall with initial weights
mse1(ws0)

%% defining the gradient of mse
gradients1{1} = @(ws,x)(x(1));
gradients1{2} = @(ws,x)(x(2));

%% plot loss
figure
f = @(a, b)(mse1([a,b]));
[A,B] = meshgrid(min(a10,ws0(1))-10:1:max(a10,ws0(1))+10,min(a20,ws0(2))-10:1:max(a20,ws0(2))+10);
plot3d(f, A, B, false) %3D contour
hold on
plot(a10,a20,'*')
plot(ws0(1),ws0(2),'+')

K = 20;
learning_eps = 0.00015;

%% gradient descent
grad_loss = @(ws)(grad_mse(ws, m1, gradients1, XX, Y));
[ws, history] = grad_desc_mse(K, ws0, learning_eps, mse1, grad_loss, true);
hold off;

%% plot the history
figure
plot(1:length(history),history)

%% stochastic gradient descent
figure
plot3d(f, A, B, false) %3D contour
hold on
plot(a10,a20,'*r')
plot(ws0(1),ws0(2),'+r')

grad_loss2 = @(ws, randices)(grad_mse(ws, m1, gradients1, XX(randices,:),Y(randices)));
tic;
[ws, history] = stochastic_grad_desc_mse(K, ws0, learning_eps, mse1, grad_loss2, N*N, true);
toc
hold off;


%% stochastic momentum gradient descent
figure
plot3d(f, A, B, false) %3D contour
hold on
plot(a10,a20,'*r')
plot(ws0(1),ws0(2),'+r')

alpha = 0.0001;
tic;
[ws, history] = stochastic_momentum_grad_desc_mse(K, ws0, learning_eps, mse1, grad_loss2, N*N, alpha, true);
toc
hold off;

%% RMSProp
optimize_hyperparameters_rms_prob = false;
if optimize_hyperparameters_rms_prob
    learning_epss = 0.1:0.1:5;
    rhos = 0:0.01:1;
    hyper_param_loss = zeros(length(learning_epss),length(rhos));
    i=1;
    for learning_eps=learning_epss
        j=1;
        for rho=rhos
            loss = 0;
            iter = 10;
            for k=1:10            
                [ws, history] = rms_prob_mse(K, ws0, learning_eps, mse1, grad_loss2, N*N, rho, false);
                this_loss = mse1(ws);
                if isnan(this_loss)
                    continue;
                end
                loss = loss + this_loss;
            end
            hyper_param_loss(i,j) = loss/iter;
            j=j+1;
        end
        i=i+1;
    end

    [v,is]=min(hyper_param_loss);
    [min_v,min_j]=min(v);
    min_i=min(is);
    learning_eps = learning_epss(min_i)
    rho= rhos(min_j)
    [A,B] = meshgrid(learning_epss,rhos);
    figure;
    surface(A,B,hyper_param_loss')
    colorbar
else
    learning_eps = 1;
    rho= 0.98;
end
% plot search space
figure;
plot3d(f, A, B, false) %3D contour
hold on
plot(a10,a20,'*r')
plot(ws0(1),ws0(2),'+r')

[ws, history] = rms_prob(K, ws0, learning_eps, mse1, grad_loss2, N*N, rho, true);
hold off


%% ADAM
optimize_hyperparameters_adam = true;
if optimize_hyperparameters_adam
    learning_epss = 0.01:0.01:1;
    rho1s = 0.9:0.001:1;
    rho2s = 0.9:0.001:1;
    hyper_param_loss = zeros(length(learning_epss),length(rho1s),length(rho2s));
    i=1;
    for learning_eps=learning_epss
        j=1;
        for rho1=rho1s
            k=1;
            for rho2=rho2s
                loss = 0;
                iter = 10;
                for l=1:10            
                    [ws, history] = adam_mse(K, ws0, learning_eps, mse1, grad_loss2, N*N, rho1, rho2, false);
                    this_loss = mse1(ws);
                    if isnan(this_loss)
                        continue;
                    end
                    loss = loss + this_loss;
                end
                hyper_param_loss(i,j,k) = loss/iter;
                k=k+1;
            end
            j=j+1;
        end
        i=i+1;
    end
end