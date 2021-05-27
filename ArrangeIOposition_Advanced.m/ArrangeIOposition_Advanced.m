function [] = ArrangeIOposition_Advanced(gcbName,offset,BlkType)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name          : ArrangeIOposition_Advanced.m                                                                                                        %
%   Author        : Pruthvi Raj G                                                                                                                       %
%   Version       : Version 1.0                                                                                                                         %
%   Input         : gcbName = Subsystem path Name for                                                                                                   %
% 					offset =  Distance from subsystem to ports.                                                                                         %
% 					BlkType =  Add if any other type of BlockType required.                                                                             %
%                                                                                                                                                       %
%	Output		  : Arranging the following blocktype (inports, outports ,from-goto blocks , terminator) connected to Subsystem.                        %
%   Date          : 17-December-2018 07:41:00                                                                                                           %
%   Updates       : 1. Gives Line handles for the selected line.                                                                                        %
%                   2. If multiple lines are tapped to the single line the                                                                              %
%                      handles are stored in array.                                                                                                     %
%                                                                                                                                                       %
%   Examples      : 1.  ArrangeIOposition_Advanced('Subsystem/Sub_subsystem1',200,'Ground')                                                             %
%					2.  ArrangeIOposition_Advanced('Subsystem/Sub_subsystem1')                                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 1
	gcbName = gcb;
    offset = 200;
    BlkType = 'Constant';
end

if nargin < 2
    offset = 200;
    BlkType = 'Constant';
end

if nargin < 3
    BlkType = 'Constant';
end

MainSubsystem = get_param(gcbName,'PortConnectivity'); % get the subsystem port handle positions
get_main_sub = get(get_param(gcbName,'Handle'));

for i = 1:numel(MainSubsystem)

    y = MainSubsystem(i).Position(2);
    x = MainSubsystem(i).Position(1);

    if isempty(MainSubsystem(i).SrcBlock)
        ConnectedBlock = MainSubsystem(i).DstBlock;
        off = -(offset-50);
    else
        ConnectedBlock = MainSubsystem(i).SrcBlock;
        off = offset;
    end

    try
        PosConnectedBlock = get_param(ConnectedBlock,'Position');
        w = PosConnectedBlock(3)-PosConnectedBlock(1);
        h = PosConnectedBlock(4)-PosConnectedBlock(2);

        if (strcmp(get_param(ConnectedBlock,'BlockType'),'Inport') || strcmp(get_param(ConnectedBlock,'BlockType'),'Outport') ||  strcmp(get_param(ConnectedBlock,'BlockType'),'From')  ||  strcmp(get_param(ConnectedBlock,'BlockType'),'Goto') || strcmp(get_param(ConnectedBlock,'BlockType'),'Terminator') || strcmp(get_param(ConnectedBlock,'BlockType'),BlkType))
            set_param(ConnectedBlock,'Position',[x-off,y-h/2,x-off+w,y+h-h/2]);
        end
        
        
        
    catch
    end
end

if ~isempty(get_main_sub.LineHandles.Trigger) || ~isempty(get_main_sub.LineHandles.Enable)
    if ~isempty(get_main_sub.LineHandles.Enable)
    Line_handle = get_main_sub.LineHandles.Enable; 
     get_Line_handle = get(Line_handle);  
     % for x & y width
     pos_old_input = get_param(get_Line_handle.SrcBlockHandle,'position');
     x_width = pos_old_input(3)-pos_old_input(1);
     y_width = pos_old_input(4)-pos_old_input(2);
     pos = get_param(get_Line_handle.DstPortHandle,'position');
     New_position = [pos(1)-150 pos(2)-40-(y_width/2) pos(1)-150+x_width pos(2)-40+(y_width/2)];
     set_param(get_Line_handle.SrcBlockHandle,'position',New_position);
     
    
    else
     Line_handle = get_main_sub.LineHandles.Trigger;   
     get_Line_handle = get(Line_handle);  
     % for x & y width
     pos_old_input = get_param(get_Line_handle.SrcBlockHandle,'position');
     x_width = pos_old_input(3)-pos_old_input(1);
     y_width = pos_old_input(4)-pos_old_input(2);
     pos = get_param(get_Line_handle.DstPortHandle,'position');
     New_position = [pos(1)-150 pos(2)-40-(y_width/2) pos(1)-150+x_width pos(2)-40+(y_width/2)];
     set_param(get_Line_handle.SrcBlockHandle,'position',New_position);
     
     
    end
    
end
end