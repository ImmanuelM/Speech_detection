t= 7;
fs = 8000;
x = wavrecord(t*fs, fs);

%% 
wavplay(x,fs);

%% 
Variance = sqrt(var(x));
x  = x./sqrt(var(x));
[alp,beta,mean] = alp_beta(x');
lags = 50;
acf(x,lags);
ZCD = Zero_crossing_counter(X);

if 5 < ZCD && ZCD < 12 && Variance > 0.02
display('Danger! Humans Detected');
else 
display('Monkey remains Silent');
end
