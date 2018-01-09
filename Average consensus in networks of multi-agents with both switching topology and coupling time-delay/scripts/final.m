close all
clear all

N = 4;
iters = 600;
Ts = 0.01;

A = zeros(N,N,iters);
A(:,:,1:200) = repmat([0 1 0 0; 1 0 1 0; 0 1 0 1 ; 0 0 1 0 ],1,1,200);
A(:,:,201:300) = repmat([0 1 0 1; 1 0 1 0; 0 1 0 1 ; 1 0 1 0 ],1,1,100);
A(:,:,301:400) = repmat([0 1 0 1; 1 0 1 0; 0 1 0 0 ; 1 0 0 0],1,1,100);
A(:,:,401:end) = repmat([0 1 0 0; 1 0 1 0; 0 1 0 1 ; 0 0 1 0 ],1,1,200);

tau = 0.4;
times = zeros(N,N,iters);
for i=1:iters
    times(:,:,i) = (abs(cos(1:N))'*rand(N,1)').*(100*tau);
end

x0 = rand(N,1).*10;
final_pos = average_consensus_test(N,x0,A,iters,Ts,times,'average consenus with time delay and swithcing topologies');

% a1 = [0 1 0 0; 1 0 1 0; 0 1 0 1 ; 0 0 1 0 ];
% a2 = [0 1 0 1; 1 0 1 0; 0 1 0 1 ; 1 0 1 0 ];
% a3 = [0 1 0 1; 1 0 1 0; 0 1 0 0 ; 1 0 0 0];
% a4 = [0 1 0 0; 1 0 1 0; 0 1 0 1 ; 0 0 1 0 ];
% 
% figure
% subplot(2,2,1);
% plot(graph(a1))
% subplot(2,2,2);
% plot(graph(a2))
% subplot(2,2,3);
% plot(graph(a3))
% subplot(2,2,4);
% plot(graph(a4))