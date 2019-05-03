classdef List < handle
    %List Doubly-linked list
    %   Detailed explanation goes here
    
    properties
        first = Node.empty  % first node
        last = Node.empty   % last node
    end
    
    methods

        function obj = List()
            % List Constructs an instance of this class
        end

        function append(obj,node)
            %append Adds a node to the end of the list
            if(isempty(obj.first) || isempty(obj.last))
                obj.first = node;
                obj.last = node;
            else
                node.insertAfter(obj.last);
                obj.last = node;
            end
        end
        
        function prepend(list,node)
            %prepend Adds a node to the beginning of the list
           if(isempty(list.first) || isempty(list.last))
              list.first = node;
              list.last = node;
           else
               node.insertBefore(list.first);
               list.first = node;
           end
        end
        
        function deleteLast(list)
            %deleteLast deletes the last node in the list
            if(~(isempty(list.first) || isempty(list.last)))
                newLast = list.last.prev;
                list.last.removeNode();
                if(isempty(newLast))
                    list.first = Node.empty;
                    list.last = Node.empty;
                else
                    list.last = newLast;
                end
            end
        end
    end
end

