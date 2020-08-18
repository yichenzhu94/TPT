function [ind, filter, reconstr, predErrImg, qPredErrImg ] = qp_dz(x, delta)
% QPU_DZ Dead-zone predictive quantization
%[ind, filter, reconstr, predErrImg, qPredErrImg ] = qp_dz(x, delta)
% Input parameters:
%   x:  input image
%   delta: quantization interval
% Output parameters:
%   ind: quantized indexes, same size as x
%   filter: the filter used for spatial prediction
%   reconstr: the reconstructed quantized image
%   predErrImg: prediction error image
%   qPredErrImg: the quantized prediction error image
%
%(C) 2015-2016 M. Cagnazzo Telecom-ParisTech
%


global verbose

[ROWS, COLS] = size(x);

% Initialization
xq = zeros(ROWS+1,COLS+2); % Image expansion to allow prediction
predImg = zeros(ROWS,COLS);
ind=zeros(ROWS,COLS);
predErrImg =zeros(ROWS,COLS);
qPredErrImg = zeros(ROWS,COLS);

%% Prediction filter

%select here the predictor type
predictorType = 1;
%  1 = Two neighbors, [1/2 1/2]
%  2 = Two neighbors, optimal filter   ## NOT IMPLEMENTED YET
%  3 = Three neighbors, optimal filter ## NOT IMPLEMENTED YET
%  4 = Four neighbors, optimal filter  ## NOT IMPLEMENTED YET

switch predictorType
    case 1
        filter = [1/2 1/2 0 0]';
%     case {2,3,4}
%         filter = optimalPredictor(x,predictorType);
    otherwise
        filter = [1/2 1/2 0 0]'; % Default
end

if verbose, % For debug
fprintf('Row Col X Up Left UL UR Pred PredErr Q(PredErr) XQ\n');
end

for row = 2:ROWS+1     % image expansion to manage out-of-border filtering
    for col = 2:COLS+1,
        % row and col scan through the expanded image xq. The corresponding
        % indices on x are (row-1) and (col-1)
        
        
        % Samples for prediction are taken from the quantized decoded image
        % Note that xq has been initialzed as zero everywhere
        pastSamples = [ xq(row-1,col) xq(row,col-1) ...
            xq(row-1,col-1) xq(row-1,col+1) ]' ;
        % Pourquoi choisir tel vecteur ?????
        if row==2, flt = [ 0 1 0 0]';  % First row: special case
        elseif col==2, flt = [1 0 0 0]'; % First col: special case
        elseif col==COLS+1, flt = [1/2 1/2 0 0]'; % Last col: special case
        else flt=filter; % General case
        end
        % Compute prediction
        pred = flt'*pastSamples;
        % Compute preidction error 
        predErr = x(row-1,col-1)-pred; % current sample is in (row-1,col-1)
        % Quantization encoding, DZ-QU
        ind(row-1,col-1) = fix(predErr/delta);
        % Quantization decoding
        qPredErr = delta*ind(row-1,col-1)  + ...
            (ind(row-1,col-1)~=0).*sign(ind(row-1,col-1) ).*delta/2 ;
        % Decoded quantized image
        xq(row,col) = qPredErr + pred;
        % Store the prediction
        predImg(row-1,col-1) = pred;        
        % Store the quantization error
        predErrImg(row-1,col-1) = predErr;
        % Store the quantized prediction error
        qPredErrImg(row-1,col-1) = qPredErr;
        
        if verbose
        fprintf('%6d%6d%6d%9.3f%9.3f%9.3f%9.3f%9.3f%9.3f%9.3f%9.3f\n',row-1,col-1, ...
            x(row-1,col-1), ...
            xq(row-1,col),xq(row,col-1), xq(row-1,col-1), xq(row-1,col+1), ...
            pred, predErr, qPredErr, xq(row,col));
        end
        
    end
end


% Remove expanded data 
reconstr = xq(2:ROWS+1,2:COLS+1);



end

