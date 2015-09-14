% This is the main process of the game.

% Create figure as our background
handles.hFig = figure('DockControls', 'off', ...
    'MenuBar', 'none', ...
    'Name', 'BlackJack', ...
    'NumberTitle', 'off', ...
    'Units', 'pixels', ...
    'OuterPosition', [283, 84, 800, 600], ...
    'Resize', 'off', ...
    'WindowKeyPressFcn', @WindowKeyFcn);

% The first step is creating a welcome screen, let player choose how
% many chips he/she wants to take, and click the 'Start' button.
startChips = StartUI(handles);
% Create the player, dealer and the table
handles.player = ClassPlayer(startChips);
handles.dealer = ClassDealer;
handles.table = ClassTable;
clear startChips
% Shuffle the deck before game starts
handles.table.Shuffle(3);
handles.table.Shuffle(3);
handles.table.GameStatus = 'StartGame';
% Create a new UI
% Do almost everything in it
MainUI(handles);
% End the game
fields = {'table', 'player', 'dealer'};
handles = rmfield(handles, fields);
EndUI(handles);
clear handles
