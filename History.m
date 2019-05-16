% Couple of things:
% Since we are sampling a continuous (assumed) signal and thus
% transforming it into a discrete signal, we are in the need of
% discrete historic or prediction data.
% The historic and prediction signals will be discrete.
% TODO:
% prediction and actual need to be initialized to a one-dimensional
% array of data. Maybe we should create another class for discrete
% signals.
% prediction and actual will only be an approximation of the continuous
% signal we are dealing with. They are linear functions between each
% time we call record or predict.
% We do also need a function to adjust the prediction signal, when
% we are done with a time window. However it is not yet clear, when
% a time-window is about to end. How do we tell this class, that the
% time window is ending?
% Proposal:
% We define a time-window for each discrete signal. When this time-window
% is exceeded in the record function (e.g. t > time_window), we simply do:
% prediction(1:end) = prediction(1:end)+ (prediction(1:end) - actual(1:end))/2;
% NOTE:
% We are currently assuming equidistant sampling intervals. If t is
% not increased by 1 every call to history (t=t+1) but actually is
% increased by an arbitrary variable (t=t+c), then we need to
% store an additional x value in our prediction and actual arrays.
% Thus they will be 2-dimensional. The derivative calculation needs to
% be adapted for this case aswell.

classdef History
    %History The history class is responsible for dealing out predictions
    %   The history class records actual sampling values and
    %   gives a prediction of probable continuations of a signal
    
    properties
        prediction % 1-dimensional array of discrete sampling data
        actual % 1-dimensional array of actual sampling data
    end
    
    methods
        function outputArg = predict(obj,t)
            %predict Returns the next assumed signal slope
            %   Call like this: history.predict(t+1);
            if(isempty(obj.prediction))
                outputArg = 0;
            else
                outputArg = (obj.prediction(t+1)-obj.prediction(t));
            end
        end
        
        function record(obj, t, sig)
            %record Record a sampled value for the actual signal
            %   Call like this: history.record(t, amplitude);
            obj.actual(t) = sig;
        end
    end
end

