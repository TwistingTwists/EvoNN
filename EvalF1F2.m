%-------------------------------------------------
% Evaluate F1 and F2
%-------------------------------------------------
function[F1 F2 UW IC] = EvalF1F2(Prey)
global nonodes noinnodes F_bad

for i = 1:length(Prey(:,1,1))
    w = squeeze(Prey(i,:,:));

    %{
    for j = 1:nonodes
        for k = 1:noinnodes+1
            w(j,k) = Prey(i,j,k);
        end
    end
    %}
    [fval,W,InfoC] = NNevalnet(w);
    F1(i) = fval;
    if isnan(F1(i)) || isinf(F1(i))
        F1(i) = F_bad+eps; F2(i) = F_bad+eps;
    end
    F2(i) = length(find(w(:,2:noinnodes+1))); %Does not include bias parameters!
    UW(i).W = W;
    IC(i) = InfoC;
    %Should somehow be able to retrieve the different networks...
end
F1 = F1'; F2 = F2'; IC = IC'; UW = UW';
end