%{Shared birthday problem}%
%Description: Using Monte Carlo simulation to figure out how many people
%needed in one group that any two of their birthdays in the year 2018 occur in the same
%week. Performing this procedure in 10^6 trials and making a histogram and
%finding the median.


clc;
clear all;
close all;

rng ('shuffle');
nTrials = 10^6;
arr = zeros(1,nTrials); % the array holding number of people needed

for k = 1:nTrials
    unmatch = true; % flag
    n = 1;
    group = zeros(1, n); % the array holding the birthday
    
    % 1-365: Monday, Jan 1, 2018 - December 31, 2018
    day = randi([1 365]); %first element in the group array
    group(1)= day;
    
    
    while (unmatch)
        new = randi([1 365]); % new birthday
        a = mod (new,7);
        
        for i = 1: n
            b = mod(group(i),7);
            s = a + b;
            
            % mod(day/7): 1(Mon) 2(Tue) 3(Wed) 4(Thurs) 5(Fri) 6(Sat)
            % any 2 days in this range have same quotient.
            if ((floor (new/7) == floor(group(i)/7))&& 2 < s && s < 12 && new ~= day)
                unmatch = false;
            end   
        end 
        
            % if one day is Sun, the other one is in Mon- Sat
            % Sun has remainder 0, but the quotient is 1 greater than the
            % other case. 
            
            % if new is Sunday, group(i): Mon- Sat
            if ((floor (new/7) == floor(group(i)/7) + 1) && a == 0 && 1<= b && b <=6)
                 unmatch = false;
            end    
            
            % if group(i) is sunday, new: Mon-Sat
            if ((floor (group(i)/7) == floor(new/7) + 1) && b == 0 && 1<= a && a <=6)
                 unmatch = false;
            end    
        
        group(n+1) = new; % add the new bd to "group"
        n = n+1;   
       
    end 
    
    d = length (group); 
    arr(k) = d; % store number of birthdays in one group to the array

end    

% Calculate the median of the histogram
med = median(arr);
fprintf ("Median number of people: %d\n",med);


% Histogram
figure(1);
h = histogram(arr);
xlabel ('Value');
ylabel ('Occurenceness');
title ('nTrials =10^6');
set(gcf, 'Position', [200 20 800 600]);
set(gca, 'LineWidth', 2, 'FontSize', 15);
ax = gca;
ax.XGrid = 'off';
ax.YGrid = 'on'; 
