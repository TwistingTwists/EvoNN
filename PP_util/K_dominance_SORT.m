function [fonrank, front] = K_dominance_SORT(pop,K)

tol = 0.0001; %tolerance to match equality between two objectives

shape = size(pop(:,1)); S = cell(shape);
prey_no = length(pop(:,1));
non_dominating = zeros(prey_no,prey_no);
ith_dominating = non_dominating; %ith objective dominates others.
Second_dominating = non_dominating; % other objective (to which ith objective is
% being compared to dominates ith objective)
% only a testing feature. Not used direclty for calculating anything.

for i = 1:prey_no
    row = pop(i,:);
    % [deprecated] MATLAB can handle divide by zero (k=n_w/n_b) stuff. so following is not needed.
    %one = ones(shape(1,1)-1,shape(1,2));  %deleting the row to be compared from broadcasted matrix to match dimensions of pop

    broadcast_rows = repmat(row,prey_no,1);
    compare_pop = pop;

    % [deprecated] same as above: delete i th row from pop
    % compare_pop(i,:)=[];

    % since we are dealing with objectives (to be minimised,
    %  max objectives are sent here with negative values => always a min-min problem)
    n_b = sum(compare_pop > broadcast_rows,2);
    n_w = sum(compare_pop < broadcast_rows,2);
    n_e = sum(abs(compare_pop - broadcast_rows) < tol,2); % apply some tolerance: Python equivalent is == isClose()

    % HANDLE THE EXECPTION OF ith element itself --> (that would be 0/0 == NaN)
    % --> automatically handled by MATLAB. Yeay!
    k = n_w./n_b;

    % CONCEPT OF K-OPTIMALITY
    % [M. Farina and P. Amato.]
    % On the Optimal Solution Definition for Many criteria Optimization Problems.
    % In Proceedings of the NAFIPS-FLINT International Conference’2002, pages 233–238
    % n_e < M
    % n_b > (M-n_e)/(K+1) ; K = user given value of K

    % the above condition is translated to (n_w/n_b < K) using M = n_e + n_b + n_w

    ith_dominating(:,i) = k < K;
    % if ith(a,b)==1 => each column dominates row elements

    % the compare_pop dominates broadcast solution
    Second_dominating(:,i) = k > 1/K; % EACH row dominates column
    non_dominating(:,i) = ~(ith_dominating(:,i) + Second_dominating(:,i));
end

%******************************************
%following two can be used as assert statements
%front(find(non_zero_rows)) = 1 ;
%non_zero_rows = ~any(First_dominating,2);
%******************************************

% fonrank =  #solutions a solution is dominated by
fonrank = sum(ith_dominating,2);
front = zeros(shape(1,1),1);

copied_fonrank = fonrank;

%tt = find(fonrank>=0); %before
tt = find(fonrank==0);  % First K_dominated_front

front_count=0;

while (tt)
    front_count = front_count+1;
    front(tt)=front_count;

    % decrease the fonrank of the solutions each solution on
    % K_dominance_front dominates (Each solution, individually)
    % Take note that each solution on first front does not dominate ALL
    % OTHER SOLUTIONS. But certainly is not dominated by anyone.
    for tinu = tt' % because tt must be a row array (otherwise `for loop` doesn't work)
        dominated_by_t = (ith_dominating(:,tinu)==1);
        fonrank(dominated_by_t) = fonrank(dominated_by_t) - 1;
    end
    fonrank(tt) = -1;
    tt = find(fonrank==0);
end

fonrank = copied_fonrank;

%% check first comment - Correction in fonrank and front
%{
With this technique, front correction ( SEQUENTIAL ORDERING OF FRONTS) has to be applied.
you may get fronts 1,2, 13. So, next big front has to be corrected
for next number.
similarly, fonrank has to be ... edited.
%}

%{
index = [1:shape(1,1)]

    sort_matrix = [front,index'];
    sorted = sortrows(sort_matrix,-1);
    return_index = double.empty(0,1)
    for i = 1:shape(1,1)-1
        if count <= 2
            if (sorted(i,1)~=sorted(i+1,1))
                count = count + 1;
                return_index = [return_index; sorted(i,2)];
            end
        end
    end

    index_Kdominates = return_index;
   %}

%{
rank = fonrank;
frontc = 1;
P = find(fonrank == 0);
fonrank(P) = -1;
front(P) = frontc;
%}

end
