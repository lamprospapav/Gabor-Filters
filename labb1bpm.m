% 
% Fh = 'tansig';                  % ���������� ��� ������������ (string) ��� ������� �� ��������� ������������� ��� ������ ���������. ������������ �����: 'logsig', 'tansig', 'purelin' (default = 'tansig').
% Fo = 'tansig';                  % ���������� ��� ������������ (string) ��� ������� �� ��������� ������������� ��� ��������� ������. ������������ �����: 'logsig', 'tansig', 'purelin' (default = 'tansig').
% Tf = 'trainscg';                % ���������� ��� ������������ (string) ��� ������� �� ��������� ����������� ��������� ��������. ������������ �����: 'traingd' (gradient method), 'traingdm'(gradient descent with momentum backpropagation), 'traingda' (gradient descent with adaptive learning rate backpropagation), 'traingdx' (gradient descent with momentum and adaptive learning rate backpropagation) (default = 'trainlm' (Levenberg-Marquardt)).
% Lf = 'learngdm';                % ���������� ��� ������������ (string) ��� ������� �� ��������� ����������� ��� �����/��������. �������� ��� ���������� �����: 'learngd' (default = 'learngdm').
% Pf = 'mse';                     % ���������� ��� ������������ (string) ��� ������� �� ��������� ��������. ������������ �����: 'mae' (mean absolute error: 1/N*[Sum[abs(Xi-Yi)]]), 'mse'(mean squared error: 1/N*[Sum[(Xi-Yi)^2]]), 'sse' (sum of squared error: sum[(Xi-Yi)^2]) (default = 'mse').
% 
% 
% net=newff(minmax(input_train'),[200,10],{'tansig','logsig'},Tf,Lf,Pf);
% 
% % �'���� �� ������ ���������� ������� ������� ����������� ��� ������� ���� ���������� ��� ���������� �������.
% net.trainParam.show=10;         % �� ���������� ����������� ���� 10� ��������� (epoch).
% net.trainParam.lr=0.1;          % ����������� � ������ �������. ���� ������ back propagation ������ � ������ ������� ��������� ��������.
% net.trainParam.mc=0.2;          % ����������� � ������� ��� ����� (0<momentum<1).
% % �� �������� ��� ���������� ��������� �������� �����������.
% net.trainParam.epochs=1000;     % ����������� � �������� ������� ������ ����� �� �������� ��� ����� ��������� (target error).
% net.trainParam.goal=0.01;       % ����������� � ������ ���������, ������ � �������� ���� ���� ����� ������ �� ������ � ��������� ��������.
% 
% 
% net_tr=train(net,input_train',labels'); % �� ������������ ��������� ������ ������������ ��� ��������� net_tr.



Output=sim(net1,input_train');       % � ������ ��� ���������� ������� ������������ ��� ��������� Output.
[~,idx]=max(Output);
out2=zeros(length(idx),10);
for i=1:length(idx)
    out2(i,idx(i))=1;
end
out2=abs(out2-labels);
out2=sum(out2');
sum(out2==0)/length(out2)



