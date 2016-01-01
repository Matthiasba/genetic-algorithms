%
% adj2path(Adj)
% function to convert between adjacency and path representation for TSP
% Adj is a row vector 
% Path is a row vector
%

function Path = adj2path(Adj);

	walking_index=1;
	Path=zeros(size(Adj));
	Path(1)=1;
	for t=2:size(Adj,2)
		Path(t)=Adj(walking_index);
		walking_index=Path(t);
	end


% End of function

% vectors x and y represent the x- and y-coordinates of the cities.
% (x(j),y(j)) == coordinates of the j-th city

% Adj is a vector that represent a tour in adjancency representation
% Adj(i) == j if city i is connected to city j (directional tour view)

% Path is a vector that represent a tour in path representation
% Path(1) == 1 always (city 1)
% Path(i) == city number that is connected to city Path(i-1).

