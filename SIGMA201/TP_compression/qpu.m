function xq = qpu(x,delta)
% QPU_DZ Uniform predictive quantization
%

[R C] = size(x);
xq = zeros(R+1,C+2); % Image expansion to allow prediction
predImg = zeros(R,C);
ind=zeros(R,C);
%%

%select here the predictor type
predictorType = 1;
%  1 = Two neighbors, [1/2 1/2]
%  2 = Two neighbors, optimal filter
%  3 = Three neighbors, optimal filter
%  4 = Four neighbors, optimal filter

switch predictorType
    case 1
        filter = [1/2 1/2 0 0]';
    case 2
    case 3
    case 4
    otherwise
        filter = [1/2 1/2 0 0]';
end

fprintf('     Row   Col   X    Up        Left     UL       UR       Pred    PredErr\n');
for row = 2:R+1 
    for col = 2:C+1,
        
        pastSamples = [ xq(row-1,col) xq(row,col-1) xq(row-1,col-1) xq(row-1,col+1) ]' ;
        
        if row==2, flt = [ 0 1 0 0]';
        elseif col==2, flt = [1 0 0 0]';
        elseif col==C+1, flt = [1/2 1/2 0 0]';
        else flt=filter;
        end
        pred = flt'*pastSamples;
        predErr = x(row-1,col-1)-pred;
        %Encoder
        ind(row-1,col-1) = floor(predErr/delta);
        %Decoder
        xq(row,col) = delta*ind(row-1,col-1)  + ...
            (ind(row-1,col-1)~=0).*sign(predErr).*delta/2 + ...
            pred;
        predImg(row,col) = pred;
        
        
        fprintf('%6d%6d%6d%9.3f%9.3f%9.3f%9.3f%9.3f%9.3f\n',row-1,col-1,x(row-1,col-1),...
           xq(row-1,col), xq(row,col-1), xq(row-1,col-1), xq(row-1,col+1), ...
           pred, predErr);
        
        
    end
end






end

