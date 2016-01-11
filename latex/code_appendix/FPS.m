function FitnV = FPS(ObjV)

% calculate the Fitness proportional selection (FPS) values based on the
% absolute lengts of the tours.

% ObjV is a column vector containing the lengths of the tours.
inverted = 1./ObjV;
sum_lengths = sum(inverted);

% First calculate the ObjV(i)/sum(ObjV)
% Secondly transform the values by f(x) = -x+1 (minimization problem)
FitnV = inverted/sum_lengths;