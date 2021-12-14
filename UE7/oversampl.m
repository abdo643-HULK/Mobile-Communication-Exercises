function out = oversampl(vector,oversampling)
    length = size(vector());
    matrix = repmat(vector, 2^oversampling,1);
    out = reshape(matrix, 2^oversampling*length(2),1).';
end