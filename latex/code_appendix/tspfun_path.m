
function ObjVal = tspfun_path(Phen, Dist)
%   Implementation of the TSP fitness function
%   Phen contains the phenocode of the matrix coded in 
%   path representation.
%   Phen is a matrix of size NIND x NVAR with at every row
%   the path representation of a tour.
%   Dist is the matrix with precalculated distances 
%   between each pair of cities.
%   ObjVal is a vector with the fitness values for 
%   each candidate tour (=each row of Phen)

size_Dist = size(Dist);
ObjVal = Dist( sub2ind(size_Dist, Phen(:,end), Phen(:,1)) );
for t = 1:size(Phen,2)-1
    ObjVal=ObjVal + Dist( sub2ind(size_Dist, Phen(:,t), Phen(:,t+1)) );
end

end
