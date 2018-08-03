function output = maxPool(input,d1,d2)
    beta = zeros(size(input,1)/d1, size(input,2)/d2, d1*d2);
    jj=1;
    for x=1:d1
        for y=1:d2
            beta(:,:,jj) = input(x:d1:end, y:d2:end);
            jj=jj+1;
        end
    end
    output = max(beta,[],3);
end