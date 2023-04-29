% load the data
trainLen = 2000;
testLen = 2000;
initLen = 25;

%Uncomment either dataset to use
%data = load('MackeyGlass_t17.txt');

%data = load('lorenz_text.txt');

%data = load('chua_text.txt');
%data = data/10;

% plot some of it
figure(1);
plot(data(1:1000));
title('A sample of data');

%Choose parameters of Reservoir
N =20  ;%Number of Nodes in Reservoir
r = 0.25;%configuration parameter r
v = 0.85;% configuration parameter v

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

       
        %collect a matrix of node outputs for training
        for j = 1:trainLen
    
            node_out(j,1) = Activation_function(v*data(j+initLen,1)+r*node_out(j,N));
    
            for k = 2:N
                if rem(k,2)==0
                    node_out(j,k) = Activation_function(-v*data(j+initLen,1)+r*node_out(j,k-1));
                end
                if rem(k,2)~=0
                    node_out(j,k) = Activation_function(v*data(j+initLen,1)+r*node_out(j,k-1));
                end
            end
        end


        %If we are recreating the input then y_target is equal to system input
        y_target = data(initLen:trainLen+initLen-1);

        %call the least squares regression
        W_out = least_squares_regression(node_out, y_target);


        %we test the system
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

        
        MSE = mean((y_out-y_target_final).^2);

figure(2);
plot(y_out(:), 'r--o');
hold on;
plot(data(trainLen+initLen+1:testLen+trainLen+initLen), 'b');
title('Predicted vs Actual');
legend('Systems prediction', 'Actual value');
xlabel('Time');
xlim([1 testLen]);
hold off;









function W_out = least_squares_regression(X, Y_target)
    K = (X.'*X)^-1;
    W_out = K * X.'*Y_target;
    
end

function node_out = Activation_function(x)
    node_out = tanh(x);
end

