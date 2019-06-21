classdef History < handle
    %History The history class is responsible for dealing out and adjusting
    %predictions regarding the packet distribution
    
    properties %(SetAccess = private)
        s_predicted = Distribution.empty % The predicted distribution
        s_actual = Distribution.empty    % The actual distribution
        size % The size of both s_predicted and s_actual
        adjustments % The number of adjustments made to the prediction
    end
    
    methods
        function obj = History(size)
            %History Construct an instance of this class
            %   Creates suitable Records

            obj.size = size;
            obj.s_predicted = Distribution(obj.size);
            obj.s_actual = Distribution(obj.size);
            obj.adjustments = 0;

        end
        
        % TODO
        function slope = predict(obj,t)
            %predict Predicts the next value for the next cycle according
            %to the following formula:
            % slope = obj.s_predicted.at(t+obj.dist) - obj.s_predicted.at(t);
            if(t+1 <= obj.size)
                slope = obj.s_predicted.at(t+1);
            else
                slope = 0;
            end
        end
        
        function record(obj,t,amplitude)
            %record Records an actual packet distribution value
            if(t <= obj.size)
                obj.s_actual.set(t,amplitude);
            end
        end
        
        function save(obj, filename)
            %save Saves the current predicted distribution to a file
            fileID = fopen(filename, 'w');
            fprintf(fileID, obj.s_predicted);
            fclose(fileID);
        end
        
        function load(obj, filename)
            %load Loads a distribution prediction from a file
            fileID = fopen(filename);
            obj.s_predicted = fread(fileID);
            fclose(fileID);
        end
        
        function adjust(obj)
           %adjust Adjusts the predicted signal given a full actual signal
           %    Adjustment is done according to the following formula:
           %    p = (p + a)/2
           %    p: predicted signal
           %    a: actual signal
           %    c: weight
           
           % If we do not have a prediction yet, we just copy the actual
           % distribution to the prediction
           if(obj.adjustments == 0)
               for i=1:obj.size
                  obj.s_predicted.set(i, obj.s_actual.at(i));
               end
               
               % Once we set s_predicted, we keep track of our adjustments
               obj.adjustments = 1;
               return
           end
           
           % Perform adjustment according to the formula in function
           % description
           for i=1:obj.size
               amplitude = (obj.s_predicted.at(i) + obj.s_actual.at(i))/2;
               obj.s_predicted.set(i,amplitude);
           end
        end
    end
end

