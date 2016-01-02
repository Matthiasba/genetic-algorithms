function Offspring = order_crossover(Parents)

n = size(Parents,2);

rn1 = randi(n);
delta = randi(n-1); % aantal getallen gekopied
Offspring = zeros(2,n);

j = rn1;
Offspring_copy = zeros(2,delta);
idx = 1;

while delta >= 1
    Offspring(:, j) = Parents(:,j);
    Offspring_copy(:,idx) = Offspring(:, j);
    if j == n
        j = 1;
    else
        j = j+1;
    end
    delta = delta - 1;
    idx = idx+1;
end


offspring1_index = 1;
offspring2_index = 1;
while j ~= rn1
    % check for position j
    cand1 = Parents(2, offspring1_index);
    cand2 = Parents(1, offspring2_index);
    while (ismember(cand1,Offspring_copy(1,:)))
        offspring1_index=offspring1_index+1;
        cand1 = Parents(2, offspring1_index);
    end
    while (ismember(cand2,Offspring_copy(2,:)))
        offspring2_index=offspring2_index+1;
        cand2 = Parents(1, offspring2_index);
    end
    Offspring(1, j) = cand1;
    Offspring(2, j) = cand2;
    if j == n
        j = 1;
    else
        j = j+1;
    end
end






end