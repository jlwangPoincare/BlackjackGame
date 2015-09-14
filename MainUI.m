function MainUI( handles )
% Start again with a blank figure
% Should write the main part of game here
    % Create four control buttons for player to use
    handles.hHitButton = uicontrol(handles.hFig, ...
        'Style', 'pushbutton', ...
        'Visible', 'off', ...
        'Units', 'pixels', ...
        'Position', [20, 40, 80, 80], ...
        'String', 'Hit', ...
        'FontSize', 14, ...
        'Callback', {@HitButton, handles});
    handles.hStandButton = uicontrol(handles.hFig, ...
        'Style', 'pushbutton', ...
        'Visible', 'off', ...
        'Units', 'pixels', ...
        'Position', [140, 40, 80, 80], ...
        'String', 'Stand', ...
        'FontSize', 14, ...
        'Callback', {@StandButton, handles});
    handles.hSurrenderButton = uicontrol(handles.hFig, ...
        'Style', 'pushbutton', ...
        'Visible', 'off', ...
        'Units', 'pixels', ...
        'Position', [260, 40, 80, 80], ...
        'String', 'Surrender', ...
        'FontSize', 12, ...
        'Callback', {@SurrenderButton, handles});
    %handles.hDoubleButton = uicontrol(handles.hFig, ...
        %'Style', 'pushbutton', ...
        %'Units', 'pixels', ...
        %'Position', [260, 40, 80, 80], ...
        %'String', 'Double', ...
        %'FontSize', 14);%, ...
        %'Callback', {@StartButton, handles.hFig, hStartChips});
    %handles.hSplitButton = uicontrol(handles.hFig, ...
        %'Style', 'pushbutton', ...
        %'Units', 'pixels', ...
        %'Position', [380, 40, 80, 80], ...
        %'String', 'Split', ...
        %'FontSize', 14);%, ...
        %'Callback', {@StartButton, handles.hFig, hStartChips});
    handles.hQuitButton = uicontrol(handles.hFig, ...
        'Style', 'pushbutton', ...
        'Visible', 'on', ...
        'Units', 'pixels', ...
        'Position', [500, 40, 80, 80], ...
        'String', 'Quit', ...
        'FontSize', 14, ...
        'Callback', {@QuitButton, handles});

    % An area for displaying game log
    handles.hLog = uicontrol(handles.hFig, ...
        'Style', 'text', ...
        'Units', 'pixels', ...
        'Position', [600, 400, 150, 150], ...
        'String', '', ...
        'BackgroundColor', [1.0, 1.0, 1.0], ...
        'FontSize', 14, ...
        'FontName', 'Helvetica');

    % Display player's chips in hand and how much wants to bet in this game
    handles.hPlayerChip = uicontrol(handles.hFig, ...
        'Style', 'text', ...
        'Units', 'pixels', ...
        'Position', [625, 40, 150, 33], ...
        'String', num2str(handles.player.Chips), ...
        'BackgroundColor', [1.0, 1.0, 1.0], ...
        'FontSize', 20, ...
        'FontName', 'Helvetica');
    handles.hChipText1 = uicontrol(handles.hFig, ...
        'Style', 'text', ...
        'Units', 'pixels', ...
        'Position', [625, 75, 150, 30], ...
        'String', 'Chips in hand:', ...
        'FontSize', 14, ...
        'FontName', 'Helvetica');
    handles.hBetChips = uicontrol(handles.hFig, ...
        'Style', 'text', ...
        'Units', 'pixels', ...
        'Position', [625, 220, 100, 33], ...
        'String', '0', ...
        'BackgroundColor', [1.0, 1.0, 1.0], ...
        'FontSize', 20, ...
        'FontName', 'Helvetica');
    handles.hBetText = uicontrol(handles.hFig, ...
        'Style', 'text', ...
        'Units', 'pixels', ...
        'Position', [625, 255, 150, 30], ...
        'String', 'Bet:', ...
        'FontSize', 14, ...
        'FontName', 'Helvetica');
    % Four buttons to modify chips to bet
    handles.hBetSmallPlus = uicontrol(handles.hFig, ...
        'Style', 'pushbutton', ...
        'Visible', 'on', ...
        'Units', 'pixels', ...
        'Position', [725, 238, 20, 15], ...
        'String', '+1', ...
        'FontSize', 5, ...
        'Callback', {@BetSmallPlus, handles});
    handles.hBetSmallMinus = uicontrol(handles.hFig, ...
        'Style', 'pushbutton', ...
        'Visible', 'on', ...
        'Units', 'pixels', ...
        'Position', [725, 220, 20, 15], ...
        'String', '-1', ...
        'FontSize', 5, ...
        'Callback', {@BetSmallMinus, handles});
    handles.hBetBigPlus = uicontrol(handles.hFig, ...
        'Style', 'pushbutton', ...
        'Visible', 'on', ...
        'Units', 'pixels', ...
        'Position', [750, 238, 20, 15], ...
        'String', '+10', ...
        'FontSize', 5, ...
        'Callback', {@BetBigPlus, handles});
    handles.hBetBigMinus = uicontrol(handles.hFig, ...
        'Style', 'pushbutton', ...
        'Visible', 'on', ...
        'Units', 'pixels', ...
        'Position', [750, 220, 20, 15], ...
        'String', '-10', ...
        'FontSize', 5, ...
        'Callback', {@BetBigMinus, handles});

    % A button for RoundStart, will start a new round with the betted chips
    handles.hRoundStart = uicontrol(handles.hFig, ...
        'Style', 'pushbutton', ...
        'Visible', 'on', ...
        'Units', 'pixels', ...
        'Position', [660, 120, 80, 80], ...
        'String', 'Start!', ...
        'FontSize', 14, ...
        'Callback', {@RoundStart, handles});

    % Display chips on table
    handles.hTableChip = uicontrol(handles.hFig, ...
        'Style', 'text', ...
        'Units', 'pixels', ...
        'Position', [175, 338, 100, 33], ...
        'String', num2str(handles.table.TableChip), ...
        'BackgroundColor', [1.0, 1.0, 1.0], ...
        'FontSize', 20, ...
        'FontName', 'Helvetica');
    handles.hChipText2 = uicontrol(handles.hFig, ...
        'Style', 'text', ...
        'Units', 'pixels', ...
        'Position', [25, 336, 150, 30], ...
        'String', 'Chips on table:', ...
        'FontSize', 14, ...
        'FontName', 'Helvetica');

    % Display current points in hand
    handles.hCurrentPoints = uicontrol(handles.hFig, ...
        'Style', 'text', ...
        'Units', 'pixels', ...
        'Position', [435, 338, 50, 33], ...
        'String', num2str(handles.player.CurrentPointA), ...
        'BackgroundColor', [1.0, 1.0, 1.0], ...
        'FontSize', 20, ...
        'FontName', 'Helvetica');
    handles.hPointsText = uicontrol(handles.hFig, ...
        'Style', 'text', ...
        'Units', 'pixels', ...
        'Position', [285, 336, 150, 30], ...
        'String', 'Current points:', ...
        'FontSize', 14, ...
        'FontName', 'Helvetica');
    handles.hPointsMode = uicontrol(handles.hFig, ...
        'Style', 'pushbutton', ...
        'Visible', 'off', ...
        'Units', 'pixels', ...
        'Position', [485, 336, 60, 20], ...
        'String', 'A=1/11', ...
        'FontSize', 10, ...
        'Callback', {@PointsMode, handles});

    % Create 10 axis for displaying cards
    for iter = 1:10
    % 1~5 player's cards, 6~10 dealer's cards
        xpixel = mod((iter-1),5) * 120 + 5;
        ypixel = idivide((iter-1),int32(5)) * 250 + 150;
        handles.hA(iter) = axes('Units', 'pixels', ...
            'Position', [xpixel, ypixel, 105, 150]);
        axis off;
    end
    clear iter
    clear xpixel
    clear ypixel
    % At this time, all the elements are drawn on the figure
    handles.table.GameStatus = 'Wait';
    % Wait for RoundStart
    uiwait(handles.hFig);
    while true
        switch handles.table.GameStatus
        % GameStatus are 'RoundStart', 'Hit', 'Stand', 'Surrender', 'Bust', 'RoundEnd', 'DealerBust', 'DealerWin', 'Tie', 'Win', 'Quit'
        case 'RoundStart'
            % 'RoundStart' is only available when a round is over
            % After resumed from 'RoundStart' button, first clear log area
            set(handles.hLog, 'String', 'RoundStart');
            % Get the current bet
            currentbet = str2double(get(handles.hBetChips, 'String'));
            % Since bet start from 0, must check to avoid player inputting 0 bet
            if BetIllegal(currentbet)
                set(handles.hLog, 'String', 'Your bet must be at least 1');
                handles.table.GameStatus = 'RoundEnd';
            else
                % Update chips
                handles.table.ChangeChip(currentbet);
                handles.player.ChangeChip(-currentbet);
                % Update chips display
                set(handles.hTableChip, 'String', num2str(handles.table.TableChip));
                set(handles.hPlayerChip, 'String', num2str(handles.player.Chips));
                set(handles.hBetChips, 'String', '0');

                % Deal two cards, points in hand is updated automatically
                % This block should be used whenever dealing a card
                if ~handles.table.EmptyDeck
                    position = handles.player.GetCard(handles.table.DrawOne);
                else
                    handles.table.Shuffle(1);
                    position = handles.player.GetCard(handles.table.DrawOne);
                end
                if ~handles.table.EmptyDeck
                    position = handles.player.GetCard(handles.table.DrawOne);
                else
                    handles.table.Shuffle(1);
                    position = handles.player.GetCard(handles.table.DrawOne);
                end
                % And dealer gets two cards also
                if ~handles.table.EmptyDeck
                    position = handles.dealer.GetCard(handles.table.DrawOne);
                else
                    handles.table.Shuffle(1);
                    position = handles.dealer.GetCard(handles.table.DrawOne);
                end
                if ~handles.table.EmptyDeck
                    position = handles.dealer.GetCard(handles.table.DrawOne);
                else
                    handles.table.Shuffle(1);
                    position = handles.dealer.GetCard(handles.table.DrawOne);
                end
                % Display these cards
                DispPlayer(handles, [1, 2]);
                DispDealer(handles, [1, 2]);
                % Update points display
                set(handles.hCurrentPoints, 'String', num2str(handles.player.CurrentPointA));
                % Make 'Hit', 'Stand', 'Surrender' visible, and 'Start' invisible
                set(handles.hHitButton, 'Visible', 'on');
                set(handles.hStandButton, 'Visible', 'on');
                set(handles.hSurrenderButton, 'Visible', 'on');
                set(handles.hQuitButton, 'Visible', 'off');
                set(handles.hRoundStart, 'Visible', 'off');
                set(handles.hBetSmallPlus, 'Visible', 'off');
                set(handles.hBetSmallMinus, 'Visible', 'off');
                set(handles.hBetBigPlus, 'Visible', 'off');
                set(handles.hBetBigMinus, 'Visible', 'off');
                set(handles.hPointsMode, 'Visible', 'on');
                uiwait(handles.hFig);
            end% of if else
        case 'Hit'
            % Hit is visible when player does not bust, stand or surrender
            % Deal one card
            if ~handles.table.EmptyDeck
                position = handles.player.GetCard(handles.table.DrawOne);
            else
                handles.table.Shuffle(1);
                position = handles.player.GetCard(handles.table.DrawOne);
            end
            % Update display of this card
            DispPlayer(handles, position);
            % Update points display
            set(handles.hCurrentPoints, 'String', num2str(handles.player.CurrentPointA));
            % Test if the player bust, or get the fifth card but not bust
            if handles.player.CurrentPointA > 21
                handles.table.GameStatus = 'Bust';
            elseif position == 5
                handles.table.GameStatus = 'Stand';
            else
                % Not bust, not five cards stand, just keep waiting
                uiwait(handles.hFig);
            end
        case 'Stand'
            % Stand just means it's dealer's turn
            % Make player choices invisible
            set(handles.hHitButton, 'Visible', 'off');
            set(handles.hStandButton, 'Visible', 'off');
            set(handles.hSurrenderButton, 'Visible', 'off');
            set(handles.hQuitButton, 'Visible', 'off');
            % Dealer hit until he has 17 or higher
            position = 2;
            while position < 5 && handles.dealer.CurrentPointA < 17
                % While dealer not bust or stand, draw one card
                pause(1);
                if ~handles.table.EmptyDeck
                    position = handles.dealer.GetCard(handles.table.DrawOne);
                else
                    handles.table.Shuffle(1);
                    position = handles.dealer.GetCard(handles.table.DrawOne);
                end
                % Update display of this card
                DispDealer(handles, position);
                % Don't update points display because player doesn't kow
            end
            if handles.dealer.CurrentPointA > 21
                handles.table.GameStatus = 'DealerBust';
            elseif handles.dealer.CurrentPointA > handles.player.CurrentPointA
                handles.table.GameStatus = 'DealerWin';
            elseif handles.dealer.CurrentPointA == handles.player.CurrentPointA
                set(handles.hLog, 'String', 'Tie');
                handles.table.GameStatus = 'Tie';
            elseif handles.dealer.CurrentPointA < handles.player.CurrentPointA
                set(handles.hLog, 'String', 'Player Wins');
                handles.table.GameStatus = 'Win';
            else
                set(handles.hLog, 'String', 'Odd case, bug');
            end
        case 'Surrender'
            % Surrender actually ends a round
            % Display in log area
            set(handles.hLog, 'String', 'Surrender');
            pause(1);
            % Return half(floor) of the chips on table to player, another half to dealer
            currentbet = handles.table.TableChip;
            half = floor(currentbet/2);
            handles.player.ChangeChip(half);
            handles.dealer.ChangeChip(currentbet - half);
            handles.table.ClearChips;
            % Display in log area how many chips player gets back
            if half == 1
                set(handles.hLog, 'String', ['You get 1 chip back']);
            else
                set(handles.hLog, 'String', ['You get ', num2str(half), ' chips back']);
            end
            % Update chips display
            set(handles.hTableChip, 'String', num2str(handles.table.TableChip));
            set(handles.hPlayerChip, 'String', num2str(handles.player.Chips));
            % Modify GameStatus
            handles.table.GameStatus = 'RoundEnd';
        case 'Bust'
            % When player bust, this round ends
            % Display in log area
            set(handles.hLog, 'String', 'Bust');
            % Make player choices invisible
            set(handles.hHitButton, 'Visible', 'off');
            set(handles.hStandButton, 'Visible', 'off');
            set(handles.hSurrenderButton, 'Visible', 'off');
            set(handles.hQuitButton, 'Visible', 'off');
            pause(1);
            % Return all the chips to dealer
            currentbet = handles.table.TableChip;
            handles.dealer.ChangeChip(currentbet);
            %handles.player.ChangeChip(-currentbet);
            handles.table.ClearChips;
            % Display in log area how many chips dealer gets
            if currentbet == 1
                set(handles.hLog, 'String', ['Dealer gets 1 chip']);
            else
                set(handles.hLog, 'String', ['Dealer gets ', num2str(currentbet), ' chips']);
            end
            % Update chips display
            set(handles.hTableChip, 'String', num2str(handles.table.TableChip));
            %set(handles.hPlayerChip, 'String', num2str(handles.player.Chips));
            % Modify GameStatus
            handles.table.GameStatus = 'RoundEnd';
        case 'RoundEnd'
            % Return both player's and dealer's cards to DiscardDeck
            while ~handles.player.EmptyHand
                handles.table.ReturnOne(handles.player.ReturnCard);
            end
            while ~handles.dealer.EmptyHand
                handles.table.ReturnOne(handles.dealer.ReturnCard);
            end
            % Update cards display, clear all the axes
            for iter = 1:10
                cla(handles.hA(iter));
            end
            % Reset BetChips
            set(handles.hBetChips, 'String', '0');
            % Reset CurrentPoints
            set(handles.hCurrentPoints, 'String', '0');
            % Reset all the buttons
            set(handles.hHitButton, 'Visible', 'off');
            set(handles.hStandButton, 'Visible', 'off');
            set(handles.hSurrenderButton, 'Visible', 'off');
            set(handles.hQuitButton, 'Visible', 'on');
            set(handles.hRoundStart, 'Visible', 'on');
            set(handles.hBetSmallPlus, 'Visible', 'on');
            set(handles.hBetSmallMinus, 'Visible', 'on');
            set(handles.hBetBigPlus, 'Visible', 'on');
            set(handles.hBetBigMinus, 'Visible', 'on');
            set(handles.hPointsMode, 'Visible', 'off');
            % If the player has no chips left, quit game
            if handles.player.Chips == 0
                handles.table.GameStatus = 'Quit';
            else
                % Wait for RoundStart
                uiwait(handles.hFig);
            end
        case 'DealerBust'
            % When dealer bust, this round ends
            % Display in log area
            set(handles.hLog, 'String', 'Dealer Bust');
            pause(1);
            % Return double the chips to player
            currentbet = handles.table.TableChip;
            handles.dealer.ChangeChip(-currentbet);
            handles.player.ChangeChip(2*currentbet);
            handles.table.ClearChips;
            % Display in log area how many chips player gets
            set(handles.hLog, 'String', ['You get ', num2str(2*currentbet), ' chips']);
            % Update chips display
            set(handles.hTableChip, 'String', num2str(handles.table.TableChip));
            set(handles.hPlayerChip, 'String', num2str(handles.player.Chips));
            % Modify GameStatus
            handles.table.GameStatus = 'RoundEnd';
        case 'DealerWin'
            % Dealer wins when dealer has higher score than player
            % Display in log area
            set(handles.hLog, 'String', ['Dealer Wins with ', num2str(handles.dealer.CurrentPointA), ' points']);
            pause(1);
            % Return double the chips to player
            currentbet = handles.table.TableChip;
            % Win with a Black Jack?
            %modifybet = currentbet * (1 + 0.5 * dealer.BlackJack);
            handles.dealer.ChangeChip(currentbet);
            %handles.player.ChangeChip(-currentbet);
            handles.table.ClearChips;
            % Display in log area how many chips dealer gets
            if currentbet == 1
                set(handles.hLog, 'String', ['Dealer gets 1 chip']);
            else
                set(handles.hLog, 'String', ['Dealer gets ', num2str(currentbet), ' chips']);
            end
            % Update chips display
            set(handles.hTableChip, 'String', num2str(handles.table.TableChip));
            %set(handles.hPlayerChip, 'String', num2str(handles.player.Chips));
            % Modify GameStatus
            handles.table.GameStatus = 'RoundEnd';
        case 'Tie'
            if handles.player.BlackJack && ~handles.dealer.BlackJack
                handles.table.GameStatus = 'Win';
            elseif handles.dealer.BlackJack && ~handles.player.BlackJack
                handles.table.GameStatus = 'DealerWin';
            else
                % Genuine 'Tie'
                % Display in log area
                handles.table.GameStatus = 'Tie';
                pause(1);
                % Return the chips to player
                currentbet = handles.table.TableChip;
                %handles.dealer.ChangeChip(currentbet);
                handles.player.ChangeChip(currentbet);
                handles.table.ClearChips;
                % Display in log area how many chips player gets back
                if currentbet == 1
                    set(handles.hLog, 'String', ['You get 1 chip back']);
                else
                    set(handles.hLog, 'String', ['You get ', num2str(currentbet), ' chips back']);
                end
                % Update chips display
                set(handles.hTableChip, 'String', num2str(handles.table.TableChip));
                set(handles.hPlayerChip, 'String', num2str(handles.player.Chips));
                % Modify GameStatus
                handles.table.GameStatus = 'RoundEnd';
            end
        case 'Win'
            % Player wins when player has higher score than dealer
            % Display in log area
            set(handles.hLog, 'String', 'You Win!');
            pause(1);
            % Return double the chips to player
            currentbet = handles.table.TableChip;
            % Win with a Black Jack?
            modifybet = floor(currentbet * (1 + 0.5 * handles.player.BlackJack));
            handles.dealer.ChangeChip(-modifybet);
            handles.player.ChangeChip(currentbet + modifybet);
            handles.table.ClearChips;
            % Display in log area how many chips player gets
            set(handles.hLog, 'String', ['You get ', num2str(currentbet + modifybet), ' chips']);
            % Update chips display
            set(handles.hTableChip, 'String', num2str(handles.table.TableChip));
            set(handles.hPlayerChip, 'String', num2str(handles.player.Chips));
            % Modify GameStatus
            handles.table.GameStatus = 'RoundEnd';
        case 'Quit'
            % Clear the figure
            % Because 'handles' is copied, not referenced here, all the fields will be automatically deleted except player, table and dealer
            tmparray = get(handles.hFig, 'Children');
            delete(tmparray(end:-1:1));
            clear tmparray;
            break;
        otherwise
            % Unexpected input, keep waiting
            uiwait(handles.hFig);
        end% of switch
    end% of while

end% of function

function BetSmallPlus( ~, ~, handles )
    tempnum = str2double(get(handles.hBetChips, 'String'));
    % Upper limit is player chips
    % All in is allowed
    if tempnum <= (handles.player.Chips - 1)
        tempnum = tempnum + 1;
        set(handles.hBetChips, 'String', num2str(tempnum));
    end
end

function BetSmallMinus( ~, ~, handles )
    tempnum = str2double(get(handles.hBetChips, 'String'));
    % Lower limit 1
    if tempnum >= 1
        tempnum = tempnum - 1;
        set(handles.hBetChips, 'String', num2str(tempnum));
    end
end

function BetBigPlus( ~, ~, handles )
    tempnum = str2double(get(handles.hBetChips, 'String'));
    % Upper limit is player chips
    % All in is allowed
    if tempnum <= (handles.player.Chips - 10)
        tempnum = tempnum + 10;
        set(handles.hBetChips, 'String', num2str(tempnum));
    end
end

function BetBigMinus( ~, ~, handles )
    tempnum = str2double(get(handles.hBetChips, 'String'));
    % Lower limit 10
    if tempnum >= 10
        tempnum = tempnum - 10;
        set(handles.hBetChips, 'String', num2str(tempnum));
    end
end

function RoundStart( ~, ~, handles )
% Resume, and go on to get the bet chips, then start a new round
    handles.table.GameStatus = 'RoundStart';
    uiresume(handles.hFig);
end% of function

function HitButton( ~, ~, handles )
% Resume, change the status to 'Hit'
    handles.table.GameStatus = 'Hit';
    uiresume(handles.hFig);
end% of function

function StandButton( ~, ~, handles )
% Resume, change the status to 'Stand'
    handles.table.GameStatus = 'Stand';
    uiresume(handles.hFig);
end% of function

function SurrenderButton( ~, ~, handles )
% Resume, change the status to 'Surrender'
    handles.table.GameStatus = 'Surrender';
    uiresume(handles.hFig);
end% of function

function QuitButton( ~, ~, handles )
% Resume, change the status to 'Quit'
    handles.table.GameStatus = 'Quit';
    uiresume(handles.hFig);
end% of function

function DispPlayer(handles, numbers)
% Update the cards display according to the current cards in player's hands
    for iter = numbers
        if (iter >= 1 && iter <= 5)
            tempcard = handles.player.CardsInHand(iter);
            if ~(EmptyCard(tempcard))
                tempstr = ['Library\', tempcard.suit(1), tempcard.number, '.jpg'];
                axes(handles.hA(iter));
                tempC = imread(tempstr);
                image(tempC);
                axis off;
            end
        end
    end
end% of function

function DispDealer(handles, numbers)
% Update the cards display according to the current cards in dealer's hands
    for iter = numbers
        if (iter >= 1 && iter <= 5)
            tempcard = handles.dealer.CardsInHand(iter);
            if (iter == 1 && ~EmptyCard(tempcard))
                tempstr = ['Library\', tempcard.suit(1), tempcard.number, '.jpg'];
                % For dealer, axes number is iter + 5
                axes(handles.hA(iter+5));
                tempC = imread(tempstr);
                image(tempC);
                axis off;
            elseif (iter > 1 && ~EmptyCard(tempcard))
                % Dealer's cards 2~5 are not visible
                tempstr = 'Library\back.jpg';
                % For dealer, axes number is iter + 5
                axes(handles.hA(iter+5));
                tempC = imread(tempstr);
                image(tempC);
                axis off;
            end
        end
    end
end% of function

function PointsMode( ~, ~, handles )
% Change the mode of displaying points
    % Change AcesAs10 first
    handles.player.UpdatePoint(2);
    % Change display
    set(handles.hCurrentPoints, 'String', num2str(handles.player.CurrentPointB + handles.player.AcesAs10 * 10));
end% of function

function logi = BetIllegal(bet)
% Check if bet is 0
    logi = ~boolean(bet);
end% of function
