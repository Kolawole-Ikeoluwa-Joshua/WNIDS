%prompt = 'Insert the MAC Address here ';
%str = input(prompt,'s');

%  xlswrite('RealworldMac.xlsx',f','convertedReal');
%  I = xlsread('RealworldMac.xlsx','convertedReal');l

%Access MAC Addresses from a file
[y1, y2] = xlsread('DATA3.xlsx');
 g = hex2dec(y2);
 f = dec2bin(g);
 for j=1:length(y2)
   for  i=1:48
d1(j,i)=str2double(f(j,i));
   end
end
 d=d1';


for k = 1:length(y2)
    d2 = d(:,k);

%pass to Neural network function
 p = myNeuralNetworkFunction(d2);

%produce result
display(p)
% Access control section

%extract the target section from the mAC address

tg=d2(25:48);

%find the coefficient of correllation
r = corr(tg,p);

if r>= 0.75
    
    % grant access
    disp(' Access granted')
    disp(['correlation = ', num2str(r)])
    
    g4(k)=1;
else
    % deny access
    disp(' Access Denied')
     disp(['correlation = ', num2str(r)])
         g4(k)=0;

end
end   
    
    
