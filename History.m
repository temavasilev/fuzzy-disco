classdef History < handle
    %History The history class is responsible for dealing out predictions
    %   This class predicts and records signal values.
    %   It does also adjust the prediction.
    
    properties (SetAccess = private)
        s_predicted = Record.empty % Prediction
        s_actual = Record.empty % Actual signal
        weight % The weight of the actual signal in adjustments
        size % The size of both s_predicted and s_actual
        flag % Indicates wether s_predicted is holding data
    end
    
    methods
        function obj = History(size)
            %History Construct an instance of this class
            %   Creates suitable Records
            %   step_size: interval between recordings in time units TU
            obj.size = size;
            obj.s_predicted = Record(obj.size);
            obj.s_actual = Record(obj.size);
            obj.weight = 1;
            obj.flag = -1;
        end
        
        function slope = predict(obj,t)
            %predict Predicts the next value for the next cycle
            %   Detailed explanation goes here
            % slope = obj.s_predicted.at(t+obj.dist) - obj.s_predicted.at(t);
            if(t+1 <= obj.size)
                slope = obj.s_predicted.at(t+1);
            else
                slope = 0;
            end
        end
        
        function record(obj,t,amplitude)
            %record Records an actual signal value
            %   Detailed explanation goes here
            if(t <= obj.size)
                obj.s_actual.set(t,amplitude);
            end
        end
        
        function adjust(obj)
           %adjust Adjusts the predicted signal given a full actual signal
           %    Adjustment is done according to the following formula:
           %%%%% previously:    p = p + (p-a)/2
           %    p = (p + a)/2
           %    p: predicted signal
           %    a: actual signal
           %    c: weight
           
           % If we do not have a prediction yet, we just copy the actual
           % signal to the prediction
           if(obj.flag == -1)
               for i=1:obj.size
                  obj.s_predicted.set(i, obj.s_actual.at(i));
               end
               
              obj.flag = 1; % Once we set s_predicted, we can set the flag to 1
              return
           end
           
           for i=1:obj.size
               %diff = (obj.s_predicted.at(i) - obj.s_actual.at(i))/2;
               %amplitude = obj.s_predicted.at(i) + diff;
               amplitude = (obj.s_predicted.at(i) + obj.s_actual.at(i))/2;
               obj.s_predicted.set(i,amplitude);
           end
        end
    end
end

