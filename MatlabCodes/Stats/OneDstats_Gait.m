function [ ANOVA, Regression ] = OneWayANOVA( Megadatabase, muscle, statistic)
%TwoWayAnova_1rm_1D Summary of this function goes here
%   Detailed explanation goes here

trials=find(strcmp(muscle,[Megadatabase.Muscle]) & ...
    strcmp(statistic,[Megadatabase.Stat]) & ...
    arrayfun(@(x)(sum(isnan(cell2mat(x.data)))),Megadatabase)==0 &...
    ~isnan(cell2mat([Megadatabase.Age])));

for itrial=length(trials):-1:1
Y(itrial,1:101)=cell2mat(Megadatabase(trials(itrial)).data);
end

Age=cell2mat([Megadatabase(trials).Age]);


%% Validate number of Men and Women
    
AgeGroup(Age<50)=1;
AgeGroup(Age>=50 & Age<65)=2;
AgeGroup(Age>=65)=3;



% %(1) Conduct non-parametric test:
% rng(0)     %set the random number generator seed
% alpha      = 0.05;
% iterations = 10000;
% FFn        = spm1d.stats.nonparam.anova2onerm(Y, Sex, Time, SUBJ);
% nonparam       = FFn.inference(alpha, 'iterations', iterations);
% disp_summ(nonparam)

%% Conduct parametric test
FFp        = spm1d.stats.anova1(Y, AgeGroup);
ANOVA       = FFp.inference(0.05);
disp(ANOVA)

%% Conduct parametric test
FFp        = spm1d.stats.regress(Y, Age);
Regression       = FFp.inference(0.05);
disp(Regression)
end

