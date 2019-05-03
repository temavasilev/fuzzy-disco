% TODO: Merge with queue by Ovidiu

classdef Queue < handle
    %Queue A queue for storing packages
    
    properties
        nelem      % Number of packages currently in queue
        packages   % Linked list of packages
    end
    
    methods
        function obj = Queue()
            %Queue Construct an instance of this class
            %   Initializes the queue with default values
            obj.nelem = 0;
            obj.packages = List();
        end
        
        function add(obj,package)
            %add Add a package to the front of the queue
            %   TODO: Insert the package based on priority
           newNode = Node(package);
           obj.packages.prepend(newNode);
           obj.nelem = obj.nelem + 1;
        end
        
        function package = pop(obj)
            %pop Remove a package from the queue
            %    Removes the last package from the queue and
            %    returns it
            if(obj.nelem > 0)
                package = obj.packages.last;
                obj.packages.deleteLast();
                obj.nelem = obj.nelem - 1;
            end
        end
    end
end

