clear; clc;
GenericPathGait

[~,~,temp]=xlsread([Path.GroupDataPath, 'EMG_spatialcurves.xlsx'],2);


for iline=size(temp,1):-1:2
    
    Megadatabase(iline-1).Subject = temp(iline,1);
    Megadatabase(iline-1).SID = temp(iline,2);
    Megadatabase(iline-1).Sex = temp(iline,3);
    Megadatabase(iline-1).Age = temp(iline,4);
    Megadatabase(iline-1).Height = temp(iline,5);
    Megadatabase(iline-1).Weight = temp(iline,6);
    Megadatabase(iline-1).Stat = temp(iline,7);    
    Megadatabase(iline-1).Muscle = temp(iline,8);

    
    Megadatabase(iline-1).data = temp(iline,9:109);        
    
end



save([Path.JBAnalyse, 'GroupData1D.mat'], 'Megadatabase');