function run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, SELECTION, TSIZE)
% usage: run_ga(x, y, 
%               NIND, MAXGEN, NVAR, 
%               ELITIST, STOP_PERCENTAGE, 
%               PR_CROSS, PR_MUT, CROSSOVER, 
%               ah1, ah2, ah3)
%
%
% x, y: coordinates of the cities
% NIND: number of individuals
% MAXGEN: maximal number of generations
% NVAR: number of cities
% ELITIST: percentage of elite population
% STOP_PERCENTAGE: percentage of equal fitness (stop criterium)
% PR_CROSS: probability for crossover
% PR_MUT: probability for mutation
% CROSSOVER: the crossover operator
% calculate distance matrix between each pair of cities
% ah1, ah2, ah3: axes handles to visualise tsp
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER LOCALLOOP}
        t_loop = zeros(5,2);
        for i_loop = 1:5
            tic;
            GGAP = 1 - ELITIST;
            mean_fits=zeros(1,MAXGEN+1);
            worst=zeros(1,MAXGEN+1);
            Dist=zeros(NVAR,NVAR);
            for i=1:size(x,1)
                for j=1:size(y,1)
                    Dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
                end
            end
            % initialize population
            Chrom=zeros(NIND,NVAR); % every row contains a representation of a tour
            for row=1:NIND
                % randperm(NVAR) is a random permutation of the vector 1:NVAR
                Chrom(row,:)=path2adj(randperm(NVAR)); 
                %Chrom(row,:)=randperm(NVAR);
            end
            gen=0; % index at generation while loop
            % number of individuals of equal fitness needed to stop
            stopN=ceil(STOP_PERCENTAGE*NIND);
            % evaluate initial population
            ObjV = tspfun(Chrom,Dist);
            % ObjV is a column vector containing the fitness values of the
            % initial candidates.
            best=zeros(1,MAXGEN);
            % generational loop
            while gen<MAXGEN
                sObjV=sort(ObjV);
                best(gen+1)=min(ObjV);
                minimum=best(gen+1);
                mean_fits(gen+1)=mean(ObjV);
                worst(gen+1)=max(ObjV);

                % find index t of minimum
                for t=1:size(ObjV,1)
                    if (ObjV(t)==minimum)
                        break;
                    end
                end

                visualizeTSP(x,y,adj2path(Chrom(t,:)), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);

                if (sObjV(stopN)-sObjV(1) <= 1e-15)
                      break;
                end          
                % assign fitness values and select individuals for breeding 
                switch SELECTION
                    case 'ranking'
                        FitnV = ranking(ObjV); % ranking selection
                        % select individuals for breeding 
                        SelCh = select('sus', Chrom, FitnV, GGAP);
                    case 'proportional'
                        FitnV = FPS(ObjV); % proportional fitness selection
                        % select individuals for breeding 
                        SelCh = select('sus', Chrom, FitnV, GGAP);
                    case 'tournament'
                         SelCh = tournament_selection(Chrom, ObjV, TSIZE, GGAP);
                    otherwise
                        error('SELECTION string is not an option')
                end
                % select individuals for breeding 
                % SelCh=select('sus', Chrom, FitnV, GGAP);
                %recombine individuals (crossover)
                SelCh = recombin(CROSSOVER,SelCh,PR_CROSS);
                SelCh=mutateTSP('inversion',SelCh,PR_MUT);
                %evaluate offspring, call objective function
                ObjVSel = tspfun(SelCh,Dist);
                %reinsert offspring into population
                [Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);

                Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom,LOCALLOOP,Dist);
                %increment generation counter
                gen=gen+1;            
            end
            t_loop(i_loop,1)=toc;
            t_loop(i_loop,2)=min(best(1, gen));
        end
        t_loop
        disp('Average time: ')
        time_avg = mean(t_loop(:,1))
        disp('Average best: ')
        best_avg = mean(t_loop(:,2))
        
        
        
        
end
