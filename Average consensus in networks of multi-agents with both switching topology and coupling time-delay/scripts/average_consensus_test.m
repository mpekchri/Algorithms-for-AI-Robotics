function x = average_consensus_test(N,x0,A,iters,Ts,times,titl)
%% function average_consensus_test(...) can be used to simulate protocol P1 (look the technical report)
%% inputs : 
% N : total number of agents.
% x0 : a vector with the initial states of all agents.
% A : matrix A has an amount of sub-matrices , one for each time iteration . Each sub-matrix of A refers to the adjacency matrix of the agents, at a specific moment (iteration) .
% iters : total number of iterations required for our simulation
% Ts : sampling time in seconds 
% times : matrix times has an amount of sub-matrices , one for each time iteration . The expression times(i,j,k) returns the delay time required for communication between agent i and agent j , at simulation's iteration k.
% titl : is a string that will be displayed in the figure that the function creates 

%% outputs : 
% x = position of all vectors, among all different iterations through time

x = zeros(N,iters);
x(:,1) = x0;

start = max(max(max(times)));
start = floor(start);
for k=1:start
    x(:,k+1) = x(:,1);
end
pos = zeros(N,1);

for k=start+1:iters
    for i=1:N
        pos(i) = x(i,k);
        for j=1:N
            pos(i) = pos(i) - Ts*(A(i,j,k)*( x(i,k-floor(times(i,i,k)))' - x(j,k-floor(times(i,j,k))))' );
        end
    end
    x(:,k+1) = pos;
end

pos = zeros(iters+1,N);
figure
hold on
for i=1:N
   pos(:,i) = x(i,:); 
   plot(pos(:,i));

end
title(titl)
xlabel(['time iterations (in ',num2str(Ts) , ' seconds)' ])
ylabel('agents positions')
% legend(['max delay is ' , num2str(max(max(max(times)))*Ts) , ' seconds'])

dim = [.7 .5 .5 .4];
str = ['max delay is ' , num2str(max(max(max(times)))*Ts) , ' seconds'];
annotation('textbox',dim,'String',str,'FitBoxToText','on');
end

