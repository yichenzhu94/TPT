function reconstructed = reconstruct(ind,delta,filter)
% Recontruction of predictive quantization
%

[ROWS , COLS] = size(ind);

% initialization
predImg = zeros(ROWS,COLS);
xhat=zeros(ROWS+1,COLS+2);
predErrImg =zeros(ROWS,COLS);
qPredErrImg = delta*ind  + (ind~=0).*sign(ind).*delta/2; 

% The first sample is quantized without prediction
xhat(2,2) = qPredErrImg(1,1);

for row = 2:ROWS+1
    for col = 2:COLS+1,
        
        pastSamples = [ xhat(row-1,col) xhat(row,col-1) ...
            xhat(row-1,col-1) xhat(row-1,col+1) ]' ;
        
        if row==2, 
            if col==2, continue; else flt = [ 0 1 0 0]'; end
        elseif col==2, flt = [1 0 0 0]';
        elseif col==COLS+1, flt = [1/2 1/2 0 0]';
        else flt=filter;
        end
        pred = flt'*pastSamples;
        xhat(row,col) = qPredErrImg(row-1,col-1)+pred;
                              
    end
end

reconstructed = xhat(2:ROWS+1,2:COLS+1);

end

