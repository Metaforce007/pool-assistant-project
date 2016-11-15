% the values that are used to check if the rgb values represent a green
% color might need to be enhanced. they might not work with certain
% uncommon green shades


% grn(rgb) will return true if the rgb values of $rgb are green;

function [dos] = grn(rgb)

    % the values that used here were chosen wisely
    dos = rgb(1) <= 95 && rgb(2) >= 75 && rgb(3) <= 146;
    dos = dos && sum(rgb)/3 - min(rgb) > 10;
end
