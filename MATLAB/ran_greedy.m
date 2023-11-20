function [ a,controllersGreedy,assignmentGreedy ] = ran_greedy( D,Wc,Wd,gamma )

% It follows exactly the same procedure as Algorithm 1 in the paper

N=length(D);
A=[zeros(N-1,1);1];
B=ones(N,1);
a=ran_greedy_cost(A,D,Wc,Wd,gamma);
b=ran_greedy_cost(B,D,Wc,Wd,gamma);

for i=1:1:(N-1)
    C1=A;
    C1(i)=1;
    a_new=ran_greedy_cost(C1,D,Wc,Wd,gamma);
    delta1=max(a-a_new,0);
    
    C2=B;
    C2(i)=0;
    b_new=ran_greedy_cost(C2,D,Wc,Wd,gamma);
    delta2=max(b-b_new,0);
    
    if delta1==0 && delta2==0
        p=1;
    else
        p=delta1/(delta1+delta2);
    end
    
    if rand()<p
        a=a_new;
        A=C1;
    else
        b=b_new;
        B=C2;
    end
end

%disp(ran_greedy_cost)
[temp,assignmentGreedy]=ran_greedy_cost(A,D,Wc,Wd,gamma);
controllersGreedy=A;
end

