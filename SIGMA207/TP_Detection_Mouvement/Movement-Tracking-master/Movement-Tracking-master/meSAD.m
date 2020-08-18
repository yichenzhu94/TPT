function [mvf MSE] = meSAD(cur, ref, brow, bcol, search)
%ME Motion estimation
%    MVF = ME(cur, ref, brow, bcol, search);
%    Computes a motion vector field between the current and reference
%    image, using a given block size and search area
%    [MVF MSE] = ME(...)
%    Returns the MSE associated to the output MVF
%

[rows cols]=size(cur);
total = 0;

% Balayage des macroblocs
for r=1:brow:rows
    for c=1:bcol:cols        
        % Macrobloc a coder
        if r+brow-1<=rows && c+bcol-1<=cols
        B=cur(r:r+brow-1,c:c+bcol-1);
        %else
        %B=cur(r:end,c:end);
        end
        % Initializations

        dcolmin=0; drowmin=0;
        SADmin=brow*bcol*256*256;
        % Motion Estimation
        for dcol=-search:search
            for drow=-search:search
                % Check: inside image
                if ((r+drow>0)&&(r+drow+brow-1<=rows)&& ...
                        (c+dcol>0)&&(c+dcol+bcol-1<=cols))
                    % Macrobloc de reference
                    R=ref(r+drow:r+drow+brow-1, c+dcol:c+dcol+bcol-1);
                    SAD=sum(sum(abs(B-R)));
                    if (SAD<SADmin)
                        SADmin=SAD;
                        dcolmin=dcol;
                        drowmin=drow;
                    end;
                end; % 
            end; % boucle sur drow
        end; % boucle sur dcol
        % sauvegarde du MV
        mvf(r:r+brow-1,c:c+bcol-1,1)=drowmin;
        mvf(r:r+brow-1,c:c+bcol-1,2)=dcolmin;
        total = total + SADmin;
    end; % boucle sur c
end; % boucle sur r
MSE = total /rows /cols;