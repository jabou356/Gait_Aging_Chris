close all
clear
figure('Units', 'centimeters','Position', [1.5, 1, 16.5, 22]);

load('GroupData1D.mat')
muscle={'LRF', 'LTA', 'LGL','RTA', 'RRF','RGL'};
Statistic={'Mean'}; %Mean, SD, CV,Statistic={'SD'};

for i=length(Megadatabase):-1:1
    
    Mega1D.Age(i)=cell2mat(Megadatabase(i).Age);
    Mega1D.Stat(i)=Megadatabase(i).Stat;
    Mega1D.Muscle(i)=Megadatabase(i).Muscle;
    Mega1D.data(:,i)=cell2mat(Megadatabase(i).data)';
    
end
Age=Mega1D.Age;
Mega1D.Age=Mega1D.Age(~isnan(Mega1D.data(1,:))&~isnan(Age))';
Mega1D.AgeGroup(Mega1D.Age<50)=1;
Mega1D.AgeGroup(Mega1D.Age>=50&Mega1D.Age<65)=2;
Mega1D.AgeGroup(Mega1D.Age>=65)=3;

Mega1D.Stat=Mega1D.Stat(~isnan(Mega1D.data(1,:))&~isnan(Age))';
Mega1D.Muscle=Mega1D.Muscle(~isnan(Mega1D.data(1,:))&~isnan(Age))';
Mega1D.data=Mega1D.data(:,~isnan(Mega1D.data(1,:))&~isnan(Age))';
clear Megadatabase

% Generate figure for SRM with Confidence interval
% X value: DoF, Y value SRM +- IC, Women Red, Men Blue
g(1,1)=gramm('x',repmat([1:101]',1,length(Mega1D.Age))','y',Mega1D.data, 'color',Mega1D.AgeGroup,'subset', strcmp(Mega1D.Stat, Statistic));

g(1,1).facet_grid(Mega1D.Muscle,[],'scale', 'free_y', 'column_labels', true, ...
    'row_labels',true);

%g.geom_point('alpha',0.5)
%g(1,1).geom_line()
g(1,1).stat_summary('type','sem','geom','area','setylim','true')
g(1,1).set_title('Time histories','FontSize',11)
g(1,1).set_names('y','%Max', 'x', '% of movement duration', 'row','')
g(1,1).set_text_options('font','Arial')

g(1,1).set_limit_extra([0 0],[0.05 0.05])
g(1,1).no_legend



load('Stats1D.mat');


ANOVA.muscle={'LGL'; 'LRF'; 'LTA'; 'RGL'; 'RRF'; 'RTA'};
ANOVA.p=repmat(1,6,101);

for imuscle = 1:length(ANOVA.muscle)
    myANOVA=Stats1D.(ANOVA.muscle{imuscle}).(Statistic{1}).ANOVA;
    
    if myANOVA.h0reject
        
        for icluster = 1:myANOVA.nClusters
            myCLUSTER=myANOVA.clusters{1,icluster};
            ANOVA.p(imuscle,round(myCLUSTER.endpoints(1))+1:round(myCLUSTER.endpoints(2))+1)=myCLUSTER.P;
        end
    end
end

g(2,1)=gramm('x',repmat(1:101,6,1),'y',ANOVA.p);
 g(2,1).facet_grid(ANOVA.muscle,[],'scale', 'free_y', 'column_labels', true, ...
     'row_labels',true);

g(2,1).geom_line()
g(2,1).set_title('ANOVA one way: <50  vs >=50 & <65 vs >=65','FontSize',11)
g(2,1).set_names('y','pvalue', 'x', '% of movement duration', 'row','', 'column','')
g(2,1).set_limit_extra([0 0],[0.05 0.05])

g.draw
