
function copy_sheet_ExcelX(Input_file,Output_file,Input_SheetName,Output_SheetName)
%%*********************************************************************************************************************
%   Name          : copy_sheet_ExcelX                                                                                  
%   Author        : Pruthvi Raj G :: www.prudhvy.com                                                                        
%                                                                                                                      
%   Version       : Version 1.0                                                                                        
%   Description   : A script intended to copy sheet from one excel file to another and renaming the sheet required.
%
%   Input         : 1. Input_file & Input_SheetName
%                   2. Output_file & Output_SheetName                                                                  
%					                                                                                                   
%   Date          : 30-Sep-2019.     
%
%
%   Examples      : copy_sheet_ExcelX('D:\Pruthvi\Test_file.xls','D:\Pruthvi\Test_file_output.xls','Input','Output')
%
%					% Output sheet name will be same as Input sheet name.
% 					copy_sheet_ExcelX('D:\Pruthvi\Test_file.xls','D:\Pruthvi\Test_file_output.xls','Input') 
%					
%					% Takes 'Sheet1' as  Default Input Sheet
% 					copy_sheet_ExcelX('D:\Pruthvi\Test_file.xls','D:\Pruthvi\Test_file_output.xls')                                                                               
%**********************************************************************************************************************

if nargin == 0
    warndlg('Please give input arguments to the function','No Input Arguments');
    return;
elseif nargin < 2
    warndlg(sprintf('Please give below input arguments to the function,\n1.Output_file_name,\n2.Input_SheetName,\n3.Output_SheetName'),'Input Arguments Missing !!');
    return;
elseif nargin < 3
    Input_SheetName = 'Sheet1'; % Default sheet as Sheet1
    Output_SheetName = Input_SheetName; % Add the Default input sheet as the output sheet.
elseif nargin < 4
    Output_SheetName = Input_SheetName; % Add the Default input sheet as the output sheet.
end




% Open the Excel file (*.xls or *.xlsx).
Excel = actxserver('Excel.Application');
set(Excel,'DisplayAlerts',1);


% If there is no file existing already , Please Create a new dummy file
% and rename it
try
    xl_write = Excel.Workbooks.Open(Output_file,1,false);
catch
    xl_write = Excel.Workbooks.Add;
    SaveAs(xl_write,Output_file);
end



% Output file
% xl_write = Excel.Workbooks.Open(Output_file,1,false);
output_sheet1 = Excel.ActiveWorkBook.Sheets;
OutputSheetsCount=output_sheet1.get('Count');
sheet1_opt=output_sheet1.get('Item',OutputSheetsCount);
sheet1_opt.Activate

Excel_BookOpen = Excel.Workbooks.Open(Input_file);
xl_write_sheets = Excel.ActiveWorkBook.Sheets;
xl_count=xl_write_sheets.get('Count');
flag=1;
for sht_cnt=1:xl_count
    select_book=xl_write_sheets.get('Item',sht_cnt);
    if strcmp(select_book.name,Input_SheetName)
        select_book.Activate;
        range=select_book.get('Range', 'A:XFD');
        range.Copy;
        sheet1_opt=output_sheet1.Add([],sheet1_opt);
        sheet1_opt.Activate;
        cell=sheet1_opt.Range('A1');
        sheet1_opt.Paste;
        try
            sheet1_opt.Name=Output_SheetName;
        catch ME
            if ~isempty(regexp(ME.message,'That name is already taken. Try a different one','once'))
                
            end
        end
        flag=0;
    end
end

if flag
    msgbox(sprintf('The Input sheet is not found in the input file,\nNo sheets are being Copied to the output file.'),'Sheet Missing !!!','warn');
    xl_write.Save;
    xl_write.Close;
    Excel_BookOpen.Close;
    Excel.Quit;
    Excel.delete;
    return;
end


% Saving the Input file
set(Excel,'DisplayAlerts',0);
% Save Output Excel Sheet 
xl_write.Save;
% Close output Excel Sheet
xl_write.Close;
% Close input Excel Sheet
Excel_BookOpen.Close;
% quit Excel Object
Excel.Quit;
Excel.delete;
end
