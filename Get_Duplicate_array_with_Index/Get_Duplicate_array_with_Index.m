%%***********************************************************************************************
%   Name          : Get_Duplicate_array_with_Index
%   Author        : Pruthvi Raj G - KPIT_RNTBCI   ::  (  :: www.prudhvy.com )
%   Version       : Version 1.0 - 2011b Compactible
%   Description   : To find the duplicate Values(String) in the Cell array List.
%   Input         : Cell Array List
%   Date          : 08-April-2019
%**********************************************************************************************%%
function [Duplicate_Names, Duplicate_Index] = Get_Duplicate_array_with_Index(Cell_Array_list)
[unique_List,~,unique_index] = unique(Cell_Array_list);
Hist_Output = histc(unique_index,1:numel(unique_List));
Duplicate_Names = unique_List(Hist_Output>1);
Duplicate_Index = arrayfun(@(x) find(unique_index==x), find(Hist_Output>1),'UniformOutput',false);
end