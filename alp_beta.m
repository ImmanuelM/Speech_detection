
function [Alpha,Beta,day_mean] = alp_beta(Data)
B = Data;

%% Calculating alpha and beta
[nDays,nStocks]=size(B);
day_mean =zeros(nDays,1);
    Alpha=zeros(nDays,1);
    Beta=zeros(nDays,1);
    fitting_error=zeros(nDays,1);
    miny=zeros(nDays,1);
    N = zeros(1,30);
    f = zeros(1,30);
    X = zeros(1,30);
parfor k=1:nDays
     Data=B(k,:);%(1:no(k)-1));
     C = Data;
 m = mean(C);
 x = C - mean(C);
x = abs(x);
    
L = length(C);
bet = [0.01:0.001:4];
y = zeros(1,length(bet));
for i = 1 : length(bet)
    
b = bet(i);
y(i) = 1 + (psi(0,1/b)/b) - (sum(abs(x).^b .* log(abs(x)))/sum(x.^b)) +...
    (log((b/L)*sum(x.^b))/b);
    
end
    
[mini,n] = min(abs(y));
b = bet(n);
a  = ((b/L)*sum(abs(x).^b))^(1/b);
[N,X] = hist(C,30);
N = N/sum(N);
f = (b/(2*a*gamma(1/b))).*exp(-((abs(X-m).^b)./(a^b)));
f = f/sum(f);
%**********************************************************************
    day_mean(k) = m;
    Alpha(k)=a;
    Beta(k)=b;
    fitting_error(k)=sum(abs(N-f));
    miny(k)=mini;
%  clc;
%  k
%  pause(0.0001);
    
end
Alpha= Alpha(:);
Beta=Beta(:);
day_mean=day_mean(:);

