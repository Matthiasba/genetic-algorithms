function ObjVal = tspfun_path(Phen, Dist);
% 	ObjVal=Dist(Phen(:,1),1);
% 	for t=2:size(Phen,2)
% 
%     	ObjVal=ObjVal+Dist(Phen(:,t),t);
%     end
    
    ObjVal = Dist(Phen(:,size(Phen, 2)), Phen(:,1) );