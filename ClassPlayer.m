classdef ClassPlayer < handle
% class of player, a handle class
    properties
        % Chips initialized when game starts
        Chips = 0;
        % 5 cards in total, use default initialization: blank str
        CardsInHand = repmat(ClassCard.CreateCardSlot, 1, 5);
        % Optimal points stored in A, minimum points stored in B
        % Player can use button to change AcesAs10
        CurrentPointA = 0;
        CurrentPointB = 0;
        AcesAs10 = 0;
        % Point updated after every card dealt
    end% of properties

    methods
        function player = ClassPlayer( Chips )
        % player initialization, only initialize chips
            player.Chips = Chips;
        end% of function

        function Status = ChangeChip(player, amount)
        % Get chips or bet (use) chips, prevent from negative chips
            % Round the amount to integer for robustness
            amount = round(amount);
            % Add or minus chips with amount
            player.Chips = player.Chips + amount;
            if player.Chips < 0
                % Use returned value to indicate status
                Status = -1;
                % And prevent negative values at the same time
                player.Chips = player.Chips - amount;
            elseif player.Chips == 0
                % Status 0 indicate "all in"
                Status = 0;
            else
                Status = 1;
            end
        end% of function

        function Status = GetCard(player, card)
        % Deal the player a card when hand is not full, card is a ClassCard object as an input
        % Status 0 means error, other integers means the position of the dealt card
            % Use a flag to indicate hand full, default not full
            flag = true;
            iter = 1;
            while ~(player.CardsInHand(iter).EmptyCard)
                iter = iter + 1;
            end
            if iter >= 6
            % iter reaches 6 and no empty slot found, means hand full
                disp('get card denied: full hand')
                flag = false;
                Status = 0;
            end
            % flag true means hand not full
            if flag
                player.CardsInHand(iter) = card;
                Status = iter;
            end
            % Update current point every time a card is dealt (even if denied)
            player.UpdatePoint;
        end% of function

        function card = ReturnCard(player)
        % Delete the last card from player, return the card (to deck)
            if player.EmptyHand
                % In the case of empty hand, returns an empty card, use the empty return as a status
                card = ClassCard.CreateCardSlot;
            else
                iter = 5;
                while player.CardsInHand(iter).EmptyCard;
                    iter = iter - 1;
                end
                % Because hand is not empty, CardsInHand(iter) must correspond to a card in hand
                % Give the card to returned value, clear the card in player's hand
                card = player.CardsInHand(iter);
                player.CardsInHand(iter) = ClassCard.CreateCardSlot;
            end
        end% of function

        function Logi = EmptyHand(player)
        % Returns a Logical value indicating if player has no cards
            Logi = true;
            % Use 'and' to make Logi false any time a card is found
            for iter = 1:5
                Logi = Logi && player.CardsInHand(iter).EmptyCard;
            end
        end% of function

        function Logi = FullHand(player)
        % Returns a Logical value indicating if player has five cards
            Logi = true;
            % Use 'and' to make Logi false any time an empty slot is found
            for iter = 1:5
                Logi = Logi && ~(player.CardsInHand(iter).EmptyCard);
            end
        end% of function

        function Logi = BlackJack(player)
        % Test if a player has Black Jack
            if player.EmptyHand
                Logi = false;
            else 
                count = 0;
                for iter = 1:5
                    if ~player.CardsInHand(iter).EmptyCard
                        count = count + 1;
                    end
                end
                if (count == 2) && player.CurrentPointA == 21;
                    Logi = true;
                else
                    Logi = false;
                end
            end
        end% of function

        function Status = UpdatePoint(player, varargin)
        % Use current information to calculate current point A
        % CurrentPointB saves the minimum possible points
        % If any other input is specified, change AcesAs10
            if nargin < 2
                % Update optimal points, minimum points and AcesAs10
                if player.EmptyHand;
                    % Directly, prevent numberInHand becomes []
                    player.CurrentPointA = 0;
                    player.CurrentPointB = 0;
                    player.AcesAs10 = 0;
                    Status = 0;
                else
                    % Get all the numbers of cards in hand to make a 'string'
                    numberInHand = [player.CardsInHand.number];
                    point = 0;
                    aces = 0;
                    for k = numberInHand
                        % numberInHand should be a string, and k goes through every character
                        switch k
                            case 'A'
                                aces = aces + 1;
                                point = point + 1;
                            case {'K', 'Q', 'J'}
                                point = point + 10;
                            case '1'% means 10
                                point = point + 10;
                            case {'2', '3', '4', '5', '6', '7', '8', '9', '0'}
                                point = point + str2double(k);
                            otherwise
                                disp('Unexpected number in hand')
                        end
                    end
                    % Now we have points without aces and number of aces
                    player.CurrentPointB = point;
                    for iter = 0:aces
                        temppoint = point + iter * 10;
                        if temppoint > 11
                            break;
                        end
                    end
                    % No matter how much aces we have, here we get the optimal points
                    player.CurrentPointA = point + iter * 10;
                    % And CurrentPointA should equal to CurrentPointB + AcesAs10 * 10
                    player.AcesAs10 = iter;
                    Status = 0;
                end
            else
                % Update AcesAs10 only with a new mode
                if player.EmptyHand;
                    % Directly, prevent numberInHand becomes []
                    player.CurrentPointA = 0;
                    player.CurrentPointB = 0;
                    player.AcesAs10 = 0;
                    Status = 1;
                else
                    % Get all the numbers of cards in hand to make a 'string'
                    numberInHand = [player.CardsInHand.number];
                    aces = 0;
                    for k = numberInHand
                        % numberInHand should be a string, and k goes through every character
                        if k == 'A'
                            aces = aces + 1;
                        end
                        % Just get number of A's
                    end
                    % Now we have number of aces
                    if player.AcesAs10 < aces
                        player.AcesAs10 = player.AcesAs10 + 1;
                    else
                        player.AcesAs10 = 0;
                    end
                end
            end
        end% of function

    end% of public methods

    %methods (Access = private)

    %end% of private methods

    %methods (Static)
        %function point = totalPoint(numberInHand, mode)
        % Totalling points with different modes of counting A
            %point = 0;
            %aces = 0;
            %for k = numberInHand
                % numberInHand should be a string, and k goes through every character
                %switch k
                    %case 'A'
                        %aces = aces + 1;
                        %point = point + 1;
                    %case {'K', 'Q', 'J', '10'}
                        %point = point + 10;
                    %case {'2', '3', '4', '5', '6', '7', '8', '9'}
                        %point = point + str2double(k);
                    %otherwise
                        %disp('Unexpected number in hand')
                %end
            %end
            % Now we have points without aces and number of aces
            %for iter = 0:aces
                %temppoint = point + iter * 10;
                %if temppoint > 21
                    %break;
                %end
            %end
        %end% of function
    %end% of static methods

end% of classdef

