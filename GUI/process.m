function [CPU_distribution] = process (Q, processing_profile, CPUs)
%UNTITLED Summary of this function goes here
%   processing_profile: 2= a lot of packages incoming/ 1= constant traffic/
%   0= few incoming packages

% don't always use the fastest CPU/ prioritize slow ones actually

CPU_distribution = zeros (3,1);

if size(Q) ~= 0
    if CPUs(1,1) ~= 0 && CPUs(2,1) ~= 0 && CPUs(3,1) ~= 0
        CPU_distribution = zeros (3,1);
    else
        i = 1;
        must_process = 0;
        while Q(i) == 1 || Q(i) == 2 || Q(i) == 3 || Q(i) == 4
            must_process = must_process + 1;
            i = i + 1;
            if i > size(Q)
                break;
            end
        end
        i = 1;
        while CPUs(i,1) ~= 0
            i = i + 1;
            if i == 4
                break;
            end
        end
        CPU_distribution(i) = must_process + (floor(ceil(must_process*CPUs(i,3))/CPUs(i,3)));
        if CPU_distribution(i) > size(Q,2)
            CPU_distribution(i) = size(Q,2);
        end
        if CPU_distribution(i) ~= 0
            CPUs(i,1) = 1;
        end
        
        if (processing_profile ~= 2)
            
            i = 1;
            should_process = 0;
            while Q(i) == 5 || Q(i) == 6 || Q(i) == 7 || Q(i) == 8
                should_process = should_process + 1;
                i = i + 1;
                if i > size(Q)
                    break;
                end
            end
            
            i = 1;
            while CPUs(i,1) ~= 0
                i = i + 1;
                if i == 4
                    break;
                end
            end
            if (i ~= 4)
                CPU_distribution(i) = should_process + (floor(ceil(should_process*CPUs(i,3))/CPUs(i,3)));
                if CPU_distribution(i) > size(Q,2)
                    CPU_distribution(i) = size(Q,2);
                end
                if CPU_distribution(i) ~= 0
                    CPUs(i,1) = 1;
                end
            end
            if (processing_profile == 0)
                i = 1;
                could_process = 0;
                while Q(i) > 8
                    could_process = could_process + 1;
                    i = i + 1;
                    if i > size(Q)
                        break;
                    end
                end
                
                i = 1;
                while CPUs(i,1) ~= 0
                    i = i + 1;
                    if i == 4
                        break;
                    end
                end
                if (i ~= 4)
                    CPU_distribution(i) = could_process + (floor(ceil(could_process*CPUs(i,3))/CPUs(i,3)));
                    if CPU_distribution(i) > size(Q,2)
                        CPU_distribution(i) = size(Q,2);
                    end
                    if CPU_distribution(i) ~= 0
                        CPUs(i,1) = 1;
                    end
                end
            end
        end
    end
else
    CPU_distribution = zeros (3,1);
end
end