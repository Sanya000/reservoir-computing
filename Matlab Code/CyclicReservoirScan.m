clear all;

% load the data
trainLen = 2000;
testLen = 2000;
initLen = 25;

%Uncomment either dataset to use
%data = load('MackeyGlass_t17.txt');

%data = load('chua_text.txt');
%data = data/10;

%data = load('lorenz_text.txt');


%Choose parameters of Reservoir
N =50  ;%Number of Nodes in Reservoir
config_res = 100;%configuration parameter resolution
MSE = zeros(config_res, config_res);%initialize the MSE array to 0

for y = 1:config_res
    for x = 1:config_res
        r = y/config_res;
        v = x/config_res;
        %construct cyclic reservoir and train
        %initialize the node output array for transient error
        node_out_init = zeros(initLen,N);
        %initialize the node outputs to 0
        node_out = zeros(trainLen,N);
        %initialize the final node states to 0
        node_x = zeros(testLen,N);
        %initialize the systems output
        y_out = zeros(testLen,1);
        %first run system and discard outputs to account for any transient errors


        for i = 1:initLen
    
            node_out_init(i,1) = Activation_function(v*data(i,1)+r*node_out_init(i,N));
    
            for k = 2:N
                if rem(k,2)==0
                    node_out_init(i,k) = Activation_function(-v*data(i,1)+r*node_out_init(i,k-1));
                end
                if rem(k,2)~=0
                    node_out_init(i,k) = Activation_function(v*data(i,1)+r*node_out_init(i,k-1));
                end
            end
        end


        %then collect a matrix of node outputs for training
        for j = 1:trainLen
    
            node_out(j,1) = Activation_function(v*data(j+initLen,1)+r*node_out(j,N));
    
            for h = 2:N
                if rem(h,2)==0
                    node_out(j,h) = Activation_function(-v*data(j+initLen,1)+r*node_out(j,h-1));
                end
                if rem(h,2)~=0
                    node_out(j,h) = Activation_function(v*data(j+initLen,1)+r*node_out(j,h-1));
                end
            end
        end


        %If we are recreating the input then y_target is equal to system input
        y_target = data(initLen:trainLen+initLen-1);

        %call the least squares regression
        W_out = least_squares_regression(node_out, y_target);


        %now we test the system
        for z = 1:testLen
    
            node_x(z,1) = Activation_function(v*data(z+initLen+trainLen,1)+r*node_x(z,N));
    
            for m = 2:N
                if rem(m,2)==0
                    node_x(z,m) = Activation_function(-v*data(z+initLen+trainLen,1)+r*node_x(z,m-1));
                end
                if rem(m,2)~=0
                    node_x(z,m) = Activation_function(v*data(z+initLen+trainLen,1)+r*node_x(z,m-1));
                end
            end
        end


        %we calculate the output of the system and the MSE


        for n = 1:testLen
            for c = 1:N
                y_out(n) =  y_out(n) + (node_x(n,c)*W_out(c,1));
            end
        end



        y_target_final = data(trainLen+initLen+1:testLen+trainLen+initLen);

        
        MSE(x,y) = mean((y_out-y_target_final).^2);

    end
end


for a = 1:config_res
    for b = 1:config_res
        if MSE(a,b)>0.1
            MSE(a,b)=0.1;
        end
       
    end
end

MSE(isnan(MSE))=0.1;

M_all = min(MSE,[],'all');

figure(1);
s=pcolor(MSE);
s.FaceColor = 'interp';
%xlim([1 10]);
%ylim([1 10]);
% %zlim([0 100]);
%set(gca, 'ZScale', 'log')
title('MSE over different combinations of r and v');
xlabel('r*40');
ylabel('v*40');
%zlabel('MSE');

figure(2);
mesh(MSE);
%xlim([1 10]);
%ylim([1 10]);
% %zlim([0 100]);
set(gca, 'ZScale', 'log')
title('MSE over different combinations of r and v');
xlabel('r*40');
ylabel('v*40');
zlabel('MSE');








function W_out = least_squares_regression(X, Y_target)
    K = inv(X.'*X);
    W_out = K * X.'*Y_target;
    
end

function node_out = Activation_function(x)
   node_out = tanh(x);
end

