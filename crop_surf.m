% find a way to ignore small little green pixels that might be found in the
% image but is not part of the surface (filtering, check if the n
% consecutive pixels are also green, cover a larger area with each check,
% ...)


% crop_surf(tab) is getting a pool table image $tab and returns an image of
% only the surface of the pool table

function [srfc] = crop_surf(tab)
    [tabr, tabc] = size(rgb2gray(tab));
    tabs = [tabr, tabc];

    % the table's quarter location -> one is by column and the other is by row
    tab_quar = round([ tabc/4 + (tabr+tabc)/10, tabr/4 + (tabr+tabc)/10 ]);

    % the surface's boundaries -> [startx, starty, endx, endy]
    surf_lim = [0,0,0,0];

    % iterate through the 4 surface's boundaries
    for i= 1:4

        % row or column -> 1 is row, 0 is column
        rc = mod(i,2);

        % iterate through the table's quarter location -> one time by row and
        % one time by column
        for j= 1:tab_quar(2-rc)

            % if we are finding the width or height of the surface's boundary
            if i > 2

                % $ tabs(i-2)-j+1 $ means we are iterating from the
                % end of the table to the boundary -> because we need to find the
                % width \ height of it

                if rc;  tab_pix = [tabs(i-2)-j+1, tab_quar(2-rc)];
                else	tab_pix = [tab_quar(2-rc), tabs(i-2)-j+1]; end

            % if we are finding the x or y of the surface's boundary
            else
                if rc;	tab_pix = [j, tab_quar(2-rc)];
                else 	tab_pix = [tab_quar(2-rc), j]; end
            end

            % if the pixel at $tab_pix is considered green by our definition
            % found in function $green(rgb) -> then we have encountered one the
            % surface's boundaries
            if green(tab(tab_pix(1), tab_pix(2), :))

                % submit the table's boundary we have found, which is at $tab_pix,
                % and continue to the next boundary
                surf_lim(i) = tab_pix(2-mod(i,2)); break;
            end
            
            % uncomment this if you want to see how the algorithms works
            % (dont forget the uncomment the $ imshow(tab); $ command
            % below); the mechanics will be marked with red lines
            %tab(tab_pix(1), tab_pix(2), :) = [255,0,0];
        end
    end
    
    % uncomment this to see how the algorithm works
    %imshow(tab);

    % arrange it by [x, y, width, height] model
    surf_lim = [surf_lim(2), surf_lim(1), surf_lim(4)-surf_lim(2), surf_lim(3)-surf_lim(1)];

    srfc = imcrop(tab, surf_lim);
end
