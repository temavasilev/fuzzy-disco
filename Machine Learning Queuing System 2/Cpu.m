classdef Cpu < handle
    %CPU Packet Processor class
    %   A simple packet processor
    
    properties
        ppc = 1 %  number of packages the cpu can process per cycle
        packets = 0 % number of packets waiting to be processed
        status = false % cpu processing status (bool: true == busy)
        did_work = false
    end
    
    methods
        function obj = Cpu()
            %CPU Construct an instance of this class
            %   Empty constructor
            obj.packets = 0;
        end
        
        function assign(obj,n)
            %assign Assign a packet to a CPU
            %   The packet is added to the processing stack and
            %   processed on the next call to process.
            %   Since all packets are simplified to their numeric
            %   urgency value, we can simply increment the package
            %   counter.
            obj.packets = obj.packets + n;
        end
        
        function process(obj)
            %process Process packets
            %   An amount of 'ppc' packets is removed from the
            %   processing stack and processed.

            if(obj.packets > 0)
                obj.status = true;
                obj.packets = obj.packets - obj.ppc;
                obj.did_work = true;
            else
                obj.did_work = false;
            end
            
            % Are we done processing?
            if(obj.packets <= 0)
                obj.packets = 0;
                obj.status = false;
            end
        end
        
        function setSpeed(obj,ppc)
            %setSpeed Set processing speed
            %   The processing speed 'ppc' indicates the amount of
            %   packets, that can be processed in one cycle.
            obj.ppc = ppc;
        end
        
        function status = available(obj)
            %available Is the CPU busy?
            %   Returns 'true' is the CPU is available.
            %   Returns 'false' if the CPU is busy.
            status = (obj.status == false);
        end
        
        function n = availableWhen(obj)
            n = ceil(obj.packets / obj.ppc);
        end
    end
end

