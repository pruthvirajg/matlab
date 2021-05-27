%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name          : excel_write_num2cell.m
%   Author        : Pruthvi Raj G
%   Input         : excel_write (Cell array containing matrix of double data.)
%   Date          : 12-March-2019 06:12:00
%   Output        : Cell array which can be used to write in excel file.
%   Constarint    : All the dimensions of the matix inside the cell should be same
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [excel_Writable_Data] = excel_write_num2cell(excel_write)

excel_Writable_Data = {};

if size(excel_write,2)>1

for i = 1:size(excel_write,2)
    excel_Writable_Data = [excel_Writable_Data num2cell(excel_write{1,i})];
end

elseif size(excel_write,1)>1

    for i = 1:size(excel_write,1)
    excel_Writable_Data = [excel_Writable_Data num2cell(excel_write{i,1})];
    end
    
end
end