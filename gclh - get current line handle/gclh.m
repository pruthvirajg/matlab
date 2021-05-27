%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name          : gclh.m
%   Author        : Pruthvi Raj G
%   Version       : Version 1.0
%   Input         : Any Simulink Model.
%   Date          : 20-January-2019 07:41:00
%   Updates       : 1. Gives Line handles for the selected line.
%                   2. If multiple lines are tapped to the single line the
%                      handles are stored in array.
%
%   Examples      : 1. Line = gclh
%                        Output : Line =  3.0780e+03
%                   2. Lines = gclh
%                        Output: Lines =
% 
%                                    1.0e+03 *
% 
%                                     3.1050
%                                     3.1040
%                                     3.1030
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%GCLH Get the handle to the current Simulink Line.
function [Selected_handles] = gclh()
Liness = find_system(bdroot,'FindAll','on','Type','Line');
On_variable = cell(size(Liness,1),1);
On_variable(:) = {'on'};
selected = cellfun(@strcmp,get_param(Liness,'Selected'),On_variable);
Selected_handles = Liness(selected);
end