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
        
        qsize_last
        dropped_last
        cum_last
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
            obj.setMode(Clustermode.short);
            
            obj.addCpu();
            obj.addCpu();
            obj.addCpu();
            
            obj.setCpuSpeed(1,2);
            obj.setCpuSpeed(2,3);
            obj.setCpuSpeed(3,10);
            
            obj.qsize_last = 0;
            obj.dropped_last = 0;
            obj.cum_last = 0;
        end
        
        function reset(obj)
           obj.setMode(Clustermode.short);
           
           obj.qsize_last = 0;
           obj.dropped_last = 0;
           obj.cum_last = 0;
           
           obj.dropped = 0;
           obj.packets = 0;
           
           delete(obj.queue);
           obj.queue = List();
           
           obj.app.QueuesizeEditField.Value = obj.packets;
           obj.app.DroppedpacketsEditField.Value = obj.dropped;
           
           cla(obj.app.UIAxes3);
           cla(obj.app.UIAxes4);
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
           obj.app.ModeEditField.Value = Clustermode.text(obj.mode);
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
            active_cpus = 0;
            
            % Clustermode.short
            % In this mode all packets are assigned to the CPUs in a way,
            % so that all CPUs will be immediately available again after 
            % a call to process().
            % The ppc of a CPU is never exceeded in this mode.
            if(obj.mode == Clustermode.short)
               % Determine the number of packets we can process
               % in the current cycle
               capacity = 0;
               for i=1:1:obj.num_cpus
                  if(obj.cpu(i).available)
                      capacity = capacity + obj.cpu(i).ppc;
                  end
               end
               
               % If we can allocate more packets than we need, we reduce
               % the capacity to the packet amount.
               if(capacity > obj.packets)
                  capacity = obj.packets; 
               end
               
               % Remove the packets from the queue
               for k=1:1:capacity
                   obj.queue.deleteLast();
                   obj.packets = obj.packets - 1;
               end
               
               % Packet iterator
               packetIt = capacity;
               
               % Assign packets to CPUs
               for i=1:1:obj.num_cpus
                   if(packetIt <= 0)
                       break;
                   end
                   
                    if(obj.cpu(i).available)
                        num = obj.cpu(i).ppc;
                        if(obj.cpu(i).ppc > packetIt)
                            num = packetIt;
                            packetIt = 0;
                        else
                            packetIt = packetIt - obj.cpu(i).ppc;
                        end
                        obj.cpu(i).assign(num);
                    else
                        active_cpus = active_cpus + 1;
                    end
                end
               
            % Clustermode.medium
            % In this mode packets may be allocated to a CPU for a longer
            % period of time. Still pretty much all resources are used
            % though. It is not that much more efficient than short mode.
            %
            elseif(obj.mode == Clustermode.medium)
               % Determine the number of packets we can process
               % in the current cycle and in upcoming cycles
               capacity = 0;
               for i=1:1:obj.num_cpus
                  if(obj.cpu(i).available)
                      capacity = capacity + obj.cpu(i).ppc * 3;
                  elseif(obj.cpu(i).availableWhen() < 3)
                      capacity = capacity + obj.cpu(i).ppc;
                  end
               end
               
               % If we can allocate more packets than we need, we reduce
               % the capacity to the packet amount.
               if(capacity > obj.packets)
                  capacity = obj.packets; 
               end
               
               % Remove the packets from the queue
               for k=1:1:capacity
                   obj.queue.deleteLast();
                   obj.packets = obj.packets - 1;
               end
               
               % Packet iterator
               packetIt = capacity;
               
               % Assign packets to CPUs
               for i=1:1:obj.num_cpus
                   if(packetIt <= 0)
                       break;
                   end
                   
                    if(obj.cpu(i).available)
                        num = obj.cpu(i).ppc * 3;
                        if(obj.cpu(i).ppc > packetIt)
                            num = packetIt;
                            packetIt = 0;
                        else
                            packetIt = packetIt - obj.cpu(i).ppc*3;
                        end
                        obj.cpu(i).assign(num);
                    else
                        active_cpus = active_cpus + 1;
                    end
               end
               
            % Clustermode.long
            %
            %
            %
            %
            %
            elseif(obj.mode == Clustermode.long)
               % Determine the number of packets we can process
               % in the current cycle and in upcoming cycles
               capacity = 0;
               for i=1:1:obj.num_cpus
                  if(obj.cpu(i).available)
                      capacity = capacity + obj.cpu(i).ppc * 6;
                  elseif(obj.cpu(i).availableWhen() < 6)
                      capacity = capacity + obj.cpu(i).ppc;
                  end
               end
               
               % If we can allocate more packets than we need, we reduce
               % the capacity to the packet amount.
               if(capacity > obj.packets)
                  capacity = obj.packets; 
               end
               
               % Remove the packets from the queue
               for k=1:1:capacity
                   obj.queue.deleteLast();
                   obj.packets = obj.packets - 1;
               end
               
               % Packet iterator
               packetIt = capacity;
               
               % Assign packets to CPUs
               for i=1:1:obj.num_cpus
                   if(packetIt <= 0)
                       break;
                   end
                   
                    if(obj.cpu(i).available)
                        num = obj.cpu(i).ppc * 3;
                        if(obj.cpu(i).ppc > packetIt)
                            num = packetIt;
                            packetIt = 0;
                        else
                            packetIt = packetIt - obj.cpu(i).ppc*3;
                        end
                        obj.cpu(i).assign(num);
                    else
                        active_cpus = active_cpus + 1;
                    end
               end
            end

            obj.app.LoadGauge.Value = 100 * (active_cpus / obj.num_cpus);
            obj.draw();
            
            % Perform processing
            for i=1:1:obj.num_cpus
               obj.cpu(i).process(); 
            end
        end
        
        function draw(obj)
            % Get current cycle
            cycle = obj.app.simulation.clock;
            
            % Fill and draw cluster table
            obj.table = cell(obj.num_cpus,4);
            for i = 1:1:obj.num_cpus
               obj.table(i,1) = {i};
               obj.table(i,2) = {obj.cpu(i).status};
               obj.table(i,3) = {obj.cpu(i).ppc};
               obj.table(i,4) = {obj.cpu(i).packets};
            end
            obj.app.UITable.Data = obj.table;
            
            % Draw queue size and dropped packets in graph
            line(obj.app.UIAxes4,[cycle-1 cycle],[obj.qsize_last obj.packets],'Color','blue');
            obj.qsize_last = obj.packets;
            dropped = 0;
            if(obj.dropped ~= obj.dropped_last)
                dropped = obj.dropped - obj.dropped_last;
                obj.dropped_last = obj.dropped;
            end
            line(obj.app.UIAxes4,[cycle cycle],[0 dropped],'Color','red');
            legend(obj.app.UIAxes4,'Queue size','Dropped packets');

            % Draw CPU Usage in graph
            cum = 0;
            for i=1:1:obj.num_cpus
                cum = cum + obj.cpu(i).packets;
            end
            line(obj.app.UIAxes3,[cycle-1 cycle],[obj.cum_last cum]); %100*(cum/obj.num_cpus)
            obj.cum_last = cum;
            
            % Set dopped packet and queuesize counters
            obj.app.DroppedpacketsEditField.Value = obj.dropped;
            obj.app.QueuesizeEditField.Value = obj.packets;
        end
    end
end

