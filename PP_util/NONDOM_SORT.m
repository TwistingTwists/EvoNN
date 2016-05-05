function [fonrank, front]= NONDOM_SORT(pop)
%pop = [21,29,34,39,56;20,28,31,31,51;21,29,31,31,56;21,29,100,40,51;21,29,42,39,56];
shape = size(pop(:,1));
%fonrank = zeros(shape);
front = zeros(shape);

prey_no = length(pop(:,1));
dominates = zeros(prey_no,prey_no);


for i = 1:length(pop(:,1))
    broadcast = ones(length(pop(:,1)),1)*pop(i,:);
    dominates(:,i) = (all(pop >= broadcast,2));
    dominates(i,i)=0;
    
end

fonrank = sum(dominates,2);

copied_fonrank = fonrank;

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
        dominated_by_t = (dominates(:,tinu)==1);
        fonrank(dominated_by_t) = fonrank(dominated_by_t) - 1;
    end
    fonrank(tt) = -1;
    tt = find(fonrank==0); 
end

fonrank = copied_fonrank;
end 
