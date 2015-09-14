classdef ClassCard
% Class of Cards
    properties
        % Cards have only two properties, suit and number
        suit = '';
        number = '';
    end% of properties

    methods
        function card = ClassCard( suit, number )
            colors = {'', 'heart', 'spade', 'diamond', 'club'};
            ranks = {'', 'A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'};
            if (any(ismember(colors, suit)) && any(ismember(ranks, number)))
                card.suit = suit;
                card.number = number;
            else
                display('Wrong suit or number');
                % Return an empty card as status
                card.suit = '';
                card.number = '';
            end
        end% of function

        function Logi = EmptyCard(card)
            Logi = isempty(card) || (isempty(card.suit) && isempty(card.number));
        end% of function

        function Logi = eq(card1, card2)
            if (card1.suit == card2.suit) && (card1.number == card2.number)
                Logi = true;
            else
                Logi = false;
            end
        end% of function

    end% of methods

    methods (Static)
        function card = CreateCardSlot()
        % Named constructor, used to create an empty card
            card = ClassCard('', '');
        end
    end% of static methods
end% of classdef
