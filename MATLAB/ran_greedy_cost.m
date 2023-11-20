function [ J_b,assignment] = ran_greedy_cost( placement,D,Wc,Wd,gamma )

N=length(placement);
% number of nodes


% assign nodes to minimize d + sum x * w_d
contact=placement*placement';
load_cost=Wd*placement*ones(1,N);
load_cost(:,N)=zeros(N,1);
D2=D+gamma*load_cost;
D2(all(placement==0,2),:)=ones(sum(all(placement==0,2)),N)*Inf;
[cost,assignment]=min(D2,[],1);


J=sum(cost); % J = J_a + load depedent part of J_s
J_s_c=sum(sum(contact.*Wc));
J_b=J+gamma*J_s_c;



end

