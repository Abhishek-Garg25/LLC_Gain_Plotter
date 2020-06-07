%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% title  = LLC_TransferFunction.m
% Author = Abhishek Garg
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all
close all
clc

%loop variables
i = 1;
j = 1;

% inductance ratio "h = Lr/Lm"
h = 0.09;

% transfer function
% c(f,h,q) = 1/sqrt((((1+h-(h/(f.^2))).^2)+((q.^2)*((f-(1/f)).^2))))
c = inline('1/sqrt((((1+h-(h/(f.^2))).^2)+((q.^2)*((f-(1/f)).^2))))','f','h','q');

% calculate
for qf = 0.2:0.05:0.4                       % quality factor
    for freq = 0.01:0.01:2                  % normalized frequency
        ax(j,i) = c(freq,h,qf);
        i = i+1;
    end
    i = 1;
    j = j + 1;
end

% plot 
qf = [0.2:0.05:0.4]'; 
freq = [0.01:0.01:2];
m = 0;

% desired gain
gain = 1.05; 
qf = cat(1,gain,qf);

% plot gain line
y = m.*freq + gain;  
p1 = plot(freq,y,'r--','LineWidth',1.5);
hold on  
grid on

% plot function values
p2 = plot(freq,ax,'-','LineWidth',2);      

% add graph properties
legendcell = cellstr(num2str(qf));
legend([strcat('Gain Margin = ',legendcell(1));strcat('Q = ',legendcell(2:end))]);
title('LLC Resonant Converter Gain Plots');
xlabel('Normalized Freq f')
ylabel('Normalized Gain')

