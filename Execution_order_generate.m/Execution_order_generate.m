%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name          : Execution_order_generate.m                              %
%   Author        : Pruthvi Raj G                                           %
%   Version       : Version 1.0                                             %
%   Input         : Simulink Model                                          %
%   Date          : 11-Febraury-2019 11:03:00                               %
%   Output        : Text file Contating Execution order                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[modelName modelpath] = uigetfile('*.slx','Please select the Simulink Model,which can be simulated');
if modelName ==0
warndlg('User Aborted the process');
return
end
modelName = modelName(1:end-4);

load_system(modelName);
OutputText  =  [modelName '_SortedOrder.txt'];
debugCommands = {'slist','quit'}; 
% debugCommands = {'slist'};%,'quit'}; 
warning off;
diary(OutputText);

try
    diary on
    sim(modelName, 'debug', debugCommands);
    diary off
catch
    Error_dialog = ['The Model "',modelName,'" cannot be simulated, Manually simulate once and run the script, Add Workspace data if required' ];
    errordlg(Error_dialog,'Error');
    return;
end
warning on;
winopen(OutputText)
