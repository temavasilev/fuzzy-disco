%Main Function
% Implementation of history:
% The problem of empty prediction values for the first run persists.
% And since we are only doing one (first) run, we do never get any prediction.
% Alternative would be, to load a prediction from file (needs to be implemented)
% or to let the program run for multiple days.
% Both should be implemented imho.

VALUES_PER_HOUR = 1;

[Distribution, Frequency] = generate (25,VALUES_PER_HOUR);

% Create a history of signal values
history = History(24*VALUES_PER_HOUR);

Q = int16.empty;

traffic_sensitivity = 2;

%aggressivity = 2;

CPUs = zeros(3,3);
CPUs(1,3) = 0.07;
CPUs(2,3) = 0.11;
CPUs(3,3) = 0.15;

%processing_delay = 0.07; % of a cycle needed to process one package



%CYCLER STARTS HERE

i=1;

for Cycle_Counter = 1:1:(VALUES_PER_HOUR*24)
    
    package_amount = Distribution(Cycle_Counter);
    
    % Record the current actual package amount at the given time frame
    history.record(Cycle_Counter, package_amount);
    
    %package_amount = 2;
    
    Q = age(Q);
    
    if CPUs(1,2) ~= 0
        CPUs(1,2) = CPUs(1,2) - 1;
        if CPUs(1,2) <= 0
            CPUs(1,2) = 0;
            CPUs(1,1) = 0;
        end
    end
    if CPUs(2,2) ~= 0
        CPUs(2,2) = CPUs(2,2) - 1;
        if CPUs(2,2) <= 0
            CPUs(2,2) = 0;
            CPUs(2,1) = 0;
        end
    end
    if CPUs(3,2) ~= 0
        CPUs(3,2) = CPUs(3,2) - 1;
        if CPUs(3,2) <= 0
            CPUs(3,2) = 0;
            CPUs(3,1) = 0;
        end
    end
    
    for i = 1:(floor(package_amount/3))
        Q = [Q 3];
    end
    
    for i = 1:(ceil(package_amount/3))
        Q = [Q 7];
    end
    
    for i = 1:(package_amount-(floor(package_amount/3))-(ceil(package_amount/3)))
        Q = [Q 15];
    end
    
    
    Q = sort(Q);
    i = 1;
    while true
        
        if Q(i) < 1
            Q(i) = [];
        else
            break
        end
        i = i + 1;
    end
    %i Packages have been dropped
    i = 1;
    
    % Get the expected distribution of next cycle
    expected_traffic = history.predict (Cycle_Counter);
    
    %expected_traffic = package_amount;
    
    traffic_change = expected_traffic-package_amount;
    
    if traffic_change > traffic_sensitivity
        processing_profile = 0;
    elseif traffic_change < -traffic_sensitivity
        processing_profile = 2;
    else
        processing_profile = 1;
    end
    
    [CPU_distribution] = process (Q, processing_profile, CPUs);
    
    CPUs(1,1) = 1;
    CPUs(2,1) = 1;
    CPUs(3,1) = 1;
    CPUs(1,2) = CPUs(1,2) + CPU_distribution(1)*CPUs(1,3);
    CPUs(2,2) = CPUs(2,2) + CPU_distribution(2)*CPUs(2,3);
    CPUs(3,2) = CPUs(3,2) + CPU_distribution(3)*CPUs(3,3);
    
    p_processed = CPU_distribution(1) + CPU_distribution(2) + CPU_distribution(3);
    
    disp (Q);
    disp (CPU_distribution(1));
    disp (CPUs(1,2));
    disp (CPU_distribution(2));
    disp (CPU_distribution(3));
    disp end_of_cycle;
    disp (Cycle_Counter);
    
    %if p_processed ~= 0
        Q = Q(1+p_processed:1:end);
    %end
    %Distribution(Cycle_Counter)
end


%CYCLER ENDS HERE
