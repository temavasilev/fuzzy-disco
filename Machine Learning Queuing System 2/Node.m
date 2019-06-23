classdef Node < handle
    %NODE Doubly-linked node for the class 'List'
    %   Interconnected nodes storing data within a container
    
    properties (SetAccess = private)
        next = Node.empty % Pointer to the next Node
        prev = Node.empty % Pointer to the previous Node
    end
    
    properties
       container % Data storage container 
    end
    
    methods
        function obj = Node(data)
            %NODE Construct an instance of this class
            %   Initializes the data container with data
            obj.container = data;
        end
        
        function insertAfter(newNode,oldNode)
            %insertAfter Insert after a node
            %   Inserts the node 'newNode' after 'oldNode'
            removeNode(newNode);
            newNode.next = oldNode.next;
            newNode.prev = oldNode;
            
            if(~isempty(oldNode.next))
               oldNode.next.prev = newNode; 
            end
            
            oldNode.next = newNode;
        end
        
        function insertBefore(newNode,oldNode)
            %insertBefore Insert before a node
            %   Inserts the node 'newNode' before 'oldNode'
            removeNode(newNode);
            newNode.next = oldNode;
            newNode.prev = oldNode.prev;
            
            if(~isempty(oldNode.prev))
               oldNode.prev.next = newNode; 
            end
            
            oldNode.prev = newNode;
        end
        
        function removeNode(node)
            %removeNode Remove a node
            %   Removes the node 'node' from a list of nodes
            lprev = node.prev;
            lnext = node.next;
            
            if(~isempty(lprev))
               lprev.next = lnext;
            end
            
            if(~isempty(lnext))
               lnext.prev = lprev; 
            end
            
            node.next = Node.empty;
            node.prev = Node.empty;
        end
    end
end

