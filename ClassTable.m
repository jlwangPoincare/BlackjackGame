classdef ClassTable < handle
% Class of table, a handle class (in order to manipulate the decks and chips)
    properties
        % Undealt cards in NewDeck
        NewDeck = repmat(ClassCard.CreateCardSlot, 1, 52);
        % Discarded cards in DiscardDeck
        DiscardDeck = repmat(ClassCard.CreateCardSlot, 1, 52);
        % Already bet chips in TableChip
        TableChip = 0;
        % A special variable who records the current status of game
        GameStatus = '';
    end% of properties

    methods
        function table = ClassTable
        % Constructor, no input, no output, just create the NewDeck
            colors = {'heart', 'spade', 'diamond', 'club'};
            ranks = {'A'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; 'J'; 'Q'; 'K'};
            suitValues = repmat(colors, 13, 1);
            numberValues = repmat(ranks, 1, 4);
            suitValues = suitValues(:);
            numberValues = numberValues(:);
            for iter = 1:52
                table.NewDeck(iter) = ClassCard(suitValues{iter}, numberValues{iter});
            end
            % Create only the NewDeck. At this time, DiscardDeck and TableChip should be the same as the default initializer
        end% of function

        function card = DrawOne(table, varargin)
        % Draw one card from NewDeck. if any other input is specified, draw one card from DiscardDeck
            if nargin < 2
                iter = 1;
                while (iter <= 52) && (table.NewDeck(iter).EmptyCard)
                    iter = iter + 1;
                end
                % After while loop, NewDeck(iter) is the first non-empty card in NewDeck, unless iter is 53
                if iter <= 52
                    % Return the card
                    card = table.NewDeck(iter);
                    % And delete the drawn card from deck
                    table.NewDeck(iter) = ClassCard.CreateCardSlot;
                else
                    % iter == 53, means all the deck is empty
                    % Return an empty card as a status
                    card = ClassCard.CreateCardSlot;
                end
            else
                % Draw card from DiscardDeck
                iter = 1;
                while (iter <= 52) && (table.DiscardDeck(iter).EmptyCard)
                    iter = iter + 1;
                end
                % After while loop, DiscardDeck(iter) is the first non-empty card in DiscardDeck, unless iter is 53
                if iter <= 52
                    % Return the card
                    card = table.DiscardDeck(iter);
                    % And delete the drawn card from deck
                    table.DiscardDeck(iter) = ClassCard.CreateCardSlot;
                else
                    % iter == 53, means all the deck is empty
                    % Return an empty card as a status
                    card = ClassCard.CreateCardSlot;
                end
            end
        end% of function

        function Status = ReturnOne(table, card, varargin)
        % Return one card to DiscardDeck. if any other input is specified, return one card to NewDeck
            if nargin < 3
                iter = 1;
                while ~(table.DiscardDeck(iter).EmptyCard);
                    iter = iter + 1;
                end
                % After while loop, DiscardDeck(iter) is the first empty card in DiscardDeck, unless iter is 53
                if iter <= 52
                    % Return the card
                    table.DiscardDeck(iter) = card;
                    Status = 1;
                else
                    % iter == 53, means the deck is full, which is unexpected
                    display('Unexpected full deck, cannot return');
                    Status = 0;
                end
            else
                % Return card to NewDeck
                iter = 1;
                while ~(table.NewDeck(iter).EmptyCard);
                    iter = iter + 1;
                end
                % After while loop, NewDeck(iter) is the first empty card in NewDeck, unless iter is 53
                if iter <= 52
                    % Return the card
                    table.NewDeck(iter) = card;
                    Status = 1;
                else
                    % iter == 53, means the deck is full, which is unexpected
                    display('Unexpected full deck, cannot return');
                    Status = 0;
                end
            end
        end% of function

        function Status = Shuffle(table, mode)
        % 3 modes of shuffle: 1, NewDeck is empty, shuffle all cards in DiscardDeck and put back to NewDeck; 2, NewDeck is not empty, shuffle all cards in DiscardDeck and NewDeck and put back to NewDeck; 3, DiscardDeck is empty, shuffle all cards in NewDeck only
            switch mode
                case 1
                    % Preallocation of tempdeck
                    tempdeck = repmat(ClassCard.CreateCardSlot, 1, 52);
                    iter = 1;
                    % Draw all the cards out from DiscardDeck
                    tempcard = table.DrawOne(2);
                    while ~(tempcard.EmptyCard);
                        tempdeck(iter) = tempcard;
                        iter = iter + 1;
                        tempcard = table.DrawOne(2);
                    end
                    % Number of cards to be shuffled, iter should be # of cards + 1 after the while loop
                    nCard = iter - 1;
                    if nCard > 0;
                        % Shuffle
                        shuffledtemp = tempdeck(randperm(nCard));
                        iter = nCard;
                        % Return all cards to NewDeck
                        while (iter > 0) && table.ReturnOne(shuffledtemp(iter), 1);
                            iter = iter - 1;
                        end
                        Status = 1;
                    else
                        % DiscardDeck is empty
                        Status = 0;
                    end
                case 2
                    % Preallocation of tempdeck
                    tempdeck = repmat(ClassCard.CreateCardSlot, 1, 52);
                    iter = 1;
                    % Draw all the cards out from DiscardDeck
                    tempcard = table.DrawOne(2);
                    while ~(tempcard.EmptyCard);
                        tempdeck(iter) = tempcard;
                        iter = iter + 1;
                        tempcard = table.DrawOne(2);
                    end
                    % Then draw all the cards out from NewDeck
                    tempcard = table.DrawOne;
                    while ~(tempcard.EmptyCard);
                        tempdeck(iter) = tempcard;
                        iter = iter + 1;
                        tempcard = table.DrawOne;
                    end
                    % Number of cards to be shuffled, iter should be # of cards + 1 after the while loop
                    nCard = iter - 1;
                    if nCard > 0;
                        % Shuffle
                        shuffledtemp = tempdeck(randperm(nCard));
                        iter = nCard;
                        % Return all cards to NewDeck
                        while (iter > 0) && table.ReturnOne(shuffledtemp(iter), 1);
                            iter = iter - 1;
                        end
                        Status = 1;
                    else
                        % Both NewDeck and DiscardDeck is empty
                        Status = 0;
                    end
                case 3
                    % Preallocation of tempdeck
                    tempdeck = repmat(ClassCard.CreateCardSlot, 1, 52);
                    iter = 1;
                    % Draw all the cards out from NewDeck
                    tempcard = table.DrawOne;
                    while ~(tempcard.EmptyCard);
                        tempdeck(iter) = tempcard;
                        iter = iter + 1;
                        tempcard = table.DrawOne;
                    end
                    % Number of cards to be shuffled, iter should be # of cards + 1 after the while loop
                    nCard = iter - 1;
                    if nCard > 0;
                        % Shuffle
                        shuffledtemp = tempdeck(randperm(nCard));
                        iter = nCard;
                        % Return all cards to NewDeck
                        while (iter > 0) && table.ReturnOne(shuffledtemp(iter), 1);
                            iter = iter - 1;
                        end
                        Status = 1;
                    else
                        % NewDeck is empty
                        Status = 0;
                    end
                otherwise
                    display('Shuffle mode error');
                    Status = 0;
            end% of switch
        end% of function

        function Status = ChangeChip(table, amount)
            % Round the amount to integer for robustness
            amount = round(amount);
            % Check if amount <= 0
            if amount <= 0;
                Status = 0;
                display('Negative bet');
            else
                table.TableChip = amount;
                Status = 1;
            end
        end% of function

        function ClearChips(table)
            table.TableChip = 0;
        end% of function

        function logi = EmptyDeck(table, varargin)
        % Test if NewDeck is empty. If any other input is specified, test DiscardDeck
            if nargin < 2
                iter = 1;
                while (iter <= 52) && (table.NewDeck(iter).EmptyCard)
                    iter = iter + 1;
                end
                % After while loop, NewDeck(iter) is the first non-empty card in NewDeck, unless iter is 53
                if iter <= 52
                    % Not empty
                    logi = false;
                else
                    % iter == 53, means all the deck is empty
                    % Empty NewDeck
                    logi = true;
                end
            else
                % Test DiscardDeck
                iter = 1;
                while (iter <= 52) && (table.DiscardDeck(iter).EmptyCard)
                    iter = iter + 1;
                end
                % After while loop, DiscardDeck(iter) is the first non-empty card in DiscardDeck, unless iter is 53
                if iter <= 52
                    % Not empty
                    logi = false;
                else
                    % iter == 53, means all the deck is empty
                    % Empty DiscardDeck
                    logi = true;
                end
            end
        end% of function

    end% of methods

end% of classdef

