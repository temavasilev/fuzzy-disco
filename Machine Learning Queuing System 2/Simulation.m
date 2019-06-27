classdef Simulation < handle
    %SIMULATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        status = SimulationStatus.reset
        cluster = Cluster.empty
        clock
        distribution = Distribution.empty
        prediction = Distribution.empty
        generator
        settings = Settings.empty
        app
    end
    
    methods
        function obj = Simulation(app)
            %SIMULATION Construct an instance of this class
            %   Detailed explanation goes here
            obj.app = app;
            obj.clock = 0;
            obj.settings = Settings();
            obj.status = SimulationStatus.reset;
            obj.generator = PacketGenerator();
            obj.distribution = Distribution();
            obj.prediction = Distribution();
            obj.cluster = Cluster(app);
        end
        
        function start(obj)
            obj.status = SimulationStatus.started;
            
            for i = 1:1:obj.settings.cycles
                % Update Clock
                obj.clock = i;
                obj.app.CycleEditField.Value = obj.clock;
                
                % Draw distribution
                cla(obj.app.UIAxes);
                obj.distribution.plot(obj.app.UIAxes);
                line(obj.app.UIAxes,[i i],[0 obj.distribution.at(i)],'Color','red');
                
                n = obj.distribution.at(i);
                p = obj.prediction.at(i+1);
                obj.cluster.addPacket(obj.generator.generate(n));
                
                if(p > n)
                    obj.cluster.setMode(Clustermode.short);
                else
                    obj.cluster.setMode(Clustermode.medium);
                end

                %obj.cluster.draw();
                obj.cluster.update();
                % It makes less sense to draw after processing, since
                % queue elements are added before update and removed in
                % update.
%                obj.cluster.draw();
                
                % Pause for specified interval
                pause(obj.settings.interval * 0.001);
            end
            
            obj.prediction.adjust(obj.distribution);
            obj.prediction.plot(obj.app.UIAxes2);
        end
        
        function pause(obj)
            obj.status = SimulationStatus.paused;
        end
        
        function reset(obj)
            obj.status = SimulationStatus.reset;
            obj.clock = 0;
            obj.app.CycleEditField.Value = obj.clock;
            obj.cluster.dropped = 0;
            delete(obj.cluster.queue);
            obj.cluster.queue = List();
            obj.cluster.packets = 0;
            cla(obj.app.UIAxes);
            cla(obj.app.UIAxes2);
            cla(obj.app.UIAxes3);
            cla(obj.app.UIAxes4);
        end
        
        function generateDistribution(obj)
           obj.distribution.generate(obj.settings.scaling);
           obj.distribution.plot(obj.app.UIAxes);
        end
        
        function generatePrediction(obj)
           obj.prediction.generate(obj.settings.scaling);
           obj.prediction.plot(obj.app.UIAxes2);
        end
    end
end