function WindowKeyFcn( hFig, eventdata )
    switch eventdata.Key
        case 'escape'
            delete(hFig);
            clear all
        %case 'uparrow'
            %Popup;
    end
end

%function Popup
    %hPopup = figure('DockControls', 'off', ...
        %'MenuBar', 'none', ...
        %'Name', 'Popup', ...
        %'NumberTitle', 'off', ...
        %'Units', 'pixels', ...
        %'OuterPosition', [283, 84, 200, 100], ...
        %'Resize', 'off');
    %hEndButton = uicontrol(hPopup, ...
        %'Style', 'pushbutton', ...
        %'Units', 'normalized', ...
        %'Position', [0.1, 0.1, 0.8, 0.8], ...
        %'String', 'End!', ...
        %'FontSize', 15, ...
        %'Callback', {@EndButton, hPopup});
    %uiwait(hPopup);
%end% of function

%function EndButton(~, ~, hPopup)
    %delete(hPopup);
%end
