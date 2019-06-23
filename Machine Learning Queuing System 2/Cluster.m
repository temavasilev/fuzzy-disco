classdef Cluster < handle
    %CLUSTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        app
        cpu
        num_cpus
        queue
        packets % Queue size
        mode % == behaviour
        dropped
        table
    end

    methods (Access = private)
        function age(obj)
           if(isempty(obj.queue.first))
               return
           end
           
           n = obj.queue.first;
           while(~isempty(n))
               n.container = n.container - 1;
               next = n.next;
               if(n.container <= 0)
                   n.removeNode();
                   obj.dropped = obj.dropped + 1;
                   obj.packets = obj.packets - 1;
               end
               n = next;
           end 
        end
    end
    
    methods
        function obj = Cluster(app)
            %CLUSTER Construct an instance of this class
            %   Detailed explanation goes here
            obj.app = app;
            obj.queue = List();
            obj.dropped = 0;
            obj.packets = 0;
            obj.num_cpus = 0;
            obj.cpu = Cpu.empty;
            
            obj.addCpu();
            obj.addCpu();
        end

        function addCpu(obj)
            if(isempty(obj.cpu))
                obj.cpu = Cpu();
            else
                obj.cpu = [obj.cpu Cpu()];
            end
            obj.num_cpus = obj.num_cpus + 1;
        end
        
        function setMode(obj,mode)
           obj.mode = mode; 
        end
        
        function addPacket(obj,packet)
            for i=1:1:length(packet)
               obj.queue.insort(packet(i));
               obj.packets = obj.packets + 1;
            end
        end
        
        function setCpuSpeed(obj,index,speed)
            obj.cpu(index).setSpeed(speed);
        end
        
        function update(obj)
            % Update the age of the queue
            obj.age();
            
            % Remove urgent packet from queue
            packet = obj.queue.deleteLast();
            packet = obj.queue.deleteLast();
            packet = obj.queue.deleteLast();
            packet = obj.queue.deleteLast();
            packet = obj.queue.deleteLast();
            packet = obj.queue.deleteLast();
            obj.packets = obj.packets - 6;
            
            % Assign packets to CPUs
            active_cpus = 0;
            for i=1:1:obj.num_cpus
               if(obj.cpu(i).available)
                  obj.cpu(i).assign();
                  obj.cpu(i).assign();
                  break;
               else
                   active_cpus = active_cpus + 1;
               end
            end
            obj.app.LoadGauge.Value = 100 * (active_cpus / obj.num_cpus);
            
            % Perform processing
            for i=1:1:obj.num_cpus
               obj.cpu(i).process(); 
            end
        end
        
        function draw(obj)
            cycle = obj.app.simulation.clock;
            
            obj.table = cell(obj.num_cpus,4);
            for i = 1:1:obj.num_cpus
               obj.table(i,1) = {i};
               obj.table(i,2) = {obj.cpu(i).status};
               obj.table(i,3) = {obj.cpu(i).ppc};
               obj.table(i,4) = {obj.cpu(i).packets};
            end
            obj.app.UITable.Data = obj.table;
            line(obj.app.UIAxes4,[cycle cycle],[0 obj.packets]);
            obj.app.DroppedpacketsEditField.Value = obj.dropped;
            obj.app.QueuesizeEditField.Value = obj.packets;
        end
    end
end

