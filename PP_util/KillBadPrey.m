function [Prey F] = KillBadPrey(Prey, F)
%-------------------------------------------------
% Kill bad Prey [more than two objectives]
%-------------------------------------------------

global lattice F_bad no_x no_y

PreyIndex = (1:length(Prey(:,1,1)))';
n_obj = length(F(1,:));

%indx = zeros(0,n_obj);
indx=[];
for i=1:n_obj
	indx = [indx ; find(F(:,i) >= F_bad)]; %implementation in below line is faster
    %indx(:,i) = find(F(:,i) >= F_bad);
end
rem = unique(indx); % Union of bad solutions corr. to each F(:,i)

for i = 1:length(rem)
    [xpos,ypos] = find(lattice(2:no_x+1,2:no_y+1) == rem(i));
    lattice(xpos+1,ypos+1) = 0;
end

Prey(rem,:,:)=[];
PreyIndex(rem)=[];
% F1(rem)=[];
% F2(rem)=[];
F(rem,:) = [];
if isempty(PreyIndex)
    disp('Eliminated all Prey as useless')
    pause
end
for i = 1:length(PreyIndex)
    [xpos,ypos] = find(lattice(2:no_x+1,2:no_y+1) == PreyIndex(i));
    lattice(xpos+1,ypos+1) = i;
end

MovePrey(0, 0, 0);

end
