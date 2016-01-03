function FitnV = FPS(ObjV)

% calculate the Fitness proportional selection (FPS) values based on the
% absolute lengts of the tours.

% ObjV is a column vector containing the lengths of the tours.

sum_lengths = sum(ObjV);

% First calculate the ObjV(i)/sum(ObjV)
% Secondly transform the values by f(x) = -x+1 (minimization problem)
FitnV = -ObjV/sum_lengths + 1;