%Determine what signal we compare
clear;clc;close all;



    muscle={'LRF', 'LTA', 'LGL','RTA', 'RRF','RGL'};
statistic={'Mean', 'CV', }; %Mean, SD, CV,


GenericPathGait


    load([Path.JBAnalyse, 'GroupData1D.mat']);


for imuscle = 1 : length(muscle)
    
    for istat= 1 : length(statistic)
        
        
            
            disp([muscle{imuscle}, ', ', statistic{istat}]) 
            
                      
            [Stats1D.(muscle{imuscle}).(statistic{istat}).ANOVA,...
               Stats1D.(muscle{imuscle}).(statistic{istat}).Regression] = ...
                OneWayANOVA(Megadatabase, muscle{imuscle}, statistic{istat});
            
        end
        
    end
    


%% Generate Summary Tables
% 
% 
% clf
% subplot(2,1,1)
% plot([1, 2], [mean(Y(Sex==1 & Time==1));mean(Y(Sex==1 & Time==2))],'bo-')
% hold on
% plot([1, 2], [mean(Y(Sex==2 & Time==1));mean(Y(Sex==2 & Time==2))],'mo-')
% 
% % plot([1, 2], [Y(Sex==1 & Time==1);Y(Sex==1 & Time==2)],'bo-')
% %  hold on
% %  plot([1, 2], [Y(Sex==2 & Time==1);Y(Sex==2 & Time==2)],'mo-')
% 
% subplot(2,1,2)
% plot([FFni.SPMs{1,1}.z,FFni.SPMs{1,2}.z,FFni.SPMs{1,3}.z],'ko') 
% hold on
% plot([FFni.SPMs{1,1}.zstar,FFni.SPMs{1,2}.zstar,FFni.SPMs{1,3}.zstar],'r') 
% plot([FFpi.SPMs{1,1}.zstar,FFpi.SPMs{1,2}.zstar,FFpi.SPMs{1,3}.zstar],'g') 
%  
% 
