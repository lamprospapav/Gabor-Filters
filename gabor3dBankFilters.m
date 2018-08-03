function gabor3dbank = gabor3dBankFilters()

gabor3dbank = cell(10,7);
tmp = cell(10,7);

for i=1:10
    % yaw must be in range [0,180]
    yaw = ((i-1)*20)*pi/180;
    for j=1:7
    % pitch must be in range [0,90]
        pitch = ((j-1)*15)*pi/180;
        tmp{i,j}(:,:,:) = gabor3_fwb([0.3 0.3],[yaw pitch 0],4,0,2,[2 2 4]);
        gabor3dbank{i,j} = tmp{i,j}(:,:,1:8);
    end
end

clear tmp;

end