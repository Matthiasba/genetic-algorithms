function [ SelCh ] = tournament_selection( Chrom, ObjV, TSIZE, GGAP)
%tournament_selection This function selects a number of parents using the
%tournament method.
%Input Parameters:
%   Chrom - The pool from which mating candidates should be selected
%   ObjV - The fitness values for the Chrom pool
%   TSIZE (optional) - the tournament size. This parameter determines the
%   size for each tournament round, default = 4
%   GGAP (optional) - the genreational gap, default = 1

    DEFAULT_TSIZE = 4
    if (nargin < 2), error('Not enough input parameter'); end
    
    % Identify the population size (Nind)
   [NindCh,Nvar] = size(Chrom);
   [NindF,VarF] = size(ObjV);
   if NindCh ~= NindF, error('Chrom and FitnV disagree'); end
   if VarF ~= 1, error('FitnV must be a column vector'); end
   
   if nargin < 3, TSIZE = DEFAULT_TSIZE; end
   if nargin > 2,
       if isempty(TSIZE), TSIZE = DEFAULT_TSIZE;
       elseif isnan(TSIZE), TSIZE = DEFAULT_TSIZE;
       elseif length(TSIZE) ~= 1, error('TSIZE must be a scalar');
       elseif (TSIZE <= 1), error('GGAP must be a scalar bigger than 1');end
    end
       
   if nargin < 4, GGAP = 1; end
   if nargin > 3,
      if isempty(GGAP), GGAP = 1;
      elseif isnan(GGAP), GGAP = 1;
      elseif length(GGAP) ~= 1, error('GGAP must be a scalar');
      elseif (GGAP < 0), error('GGAP must be a scalar bigger than 0'); end
   end
   
   % Compute number of new individuals (to select)
   NSel=max(floor(NindCh*GGAP+.5),2);

    % Select individuals from population
   SelCh = zeros(NSel, Nvar);
   for irun = 1:NSel,
      [sample, idx] = datasample(ObjV, TSIZE, 'Replace', false);
      [M, I] = min(sample);
      SelCh(irun, :) = Chrom(idx(I(1)), :);
      
      
   end

end

