classdef ClassDealer < ClassPlayer
% class of dealer, inherited from ClassPlayer, because dealer is a special player
    properties
        %Chips = Inf;
        % Chips initialized as infinite
    end% of properties
    % No special properties

    methods
        function dealer = ClassDealer
        % Constructor of dealer, just construct a player with infinite chips
            dealer = dealer@ClassPlayer(2^20-1);
        end
    end% of methods

end% of classdef
