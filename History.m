classdef History < handle
    %History The history class is responsible for dealing out predictions
    %   This class predicts and records signal values.
    %   It does also adjust the prediction.
    
    properties (SetAccess = private)
        s_predicted = Record.empty % Prediction
        s_actual = Record.empty % Actual signal
        weight % The weight of the actual signal in adjustments
        size % The size of both s_predicted and s_actual
        tmax % The maximum time; if exceeded, we reset
        flag % Indicates wether s_predicted is holding data
    end
    
    methods
        function obj = History(tmax,step_size)
            %History Construct an instance of this class
            %   Creates suitable Records
            obj.tmax = tmax;
            obj.size = tmax/step_size;
            obj.s_predicted = Record(obj.size,step_size);
            obj.s_actual = Record(obj.size,step_size);
            obj.weight = 1;
            obj.flag = 0;
        end
        
        function slope = predict(obj,t)
            %predict Predicts the estimated slope for the next time window
            %   Detailed explanation goes here
            slope = obj.s_predicted.at(t+1) - obj.s_predicted.at(t);
        end
        
        function record(obj,t,amplitude)
            %record Records an actual signal value
            %   Detailed explanation goes here
            obj.s_actual.set(t,amplitude);
        end
        
        function adjust(obj)
           %adjust Adjusts the predicted signal given a full actual signal
           %    Adjustment is done according to the following formula:
           %    p = p + (p-a)/(c+1)
           %    p: predicted signal
           %    a: actual signal
           %    c: weight
           
           for i=1:obj.size
               diff = (obj.s_predicted.at(i) - obj.s_actual.at(i)) * obj.flag;
               amplitude = obj.s_predicted.at(i) + diff / obj.weight;
               obj.s_predicted.set(i,amplitude);
           end
           
           obj.flag = 1; % Once we set s_predicted, we can set the flag to 1
           obj.weight = obj.weight + 1;
        
        end
    end
end

