classdef Assumption < handle
    % Basic idea: use struct to save all assumptions we have made
    
    properties
    end
    
    methods     
        function obj = Assumption()  %Constructor
            obj = struct;            %create empty struct
        end
        
        function save(obj,history,name)  %save assumption,name is a label 
                                         %for assumption(number can not be
                                         %involved.
            obj.name = history.s_predict;    %add a new nember to object by
                                             %using the parameter name
            str = sprintf('Assumption %c is saved.',name);  
            disp(str);  %print information about it
        end
        
        function assumption = load(obj,name)  %get assumption with given label
            assumption = obj.name;
            str = sprintf('Assumption %d is loaded.',name);
            disp(str);
        end
        
        function print(obj,time)  %print all assumptions we have saved
                                  %time is an array for plot
                                  %question: Is time for all assumptions
                                  %the same one?
            %disp(obj);
            names = fieldnames(obj);  %get all labels
            sz = size(names);
            for i = 1:sz
                plot(time,obj.names.i);
            end
        end
    end
    
end

