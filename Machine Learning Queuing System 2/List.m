classdef List < handle
    %LIST Doubly-linked list
    %   Doubly-linked list modified for specific purpose.
    %   Not a general doubly-linked list!
    
    properties
        first = Node.empty % Pointer to the beginning
        last = Node.empty % Pointer to the tail
    end
    
    methods
        function obj = List()
            %LIST Construct an instance of this class
            %   Empty constructor
        end
        
        function delete(obj)
           if(isempty(obj.first))
               return
           end
           
           n = obj.first;
           while(~isempty(n))
               next = n.next;
               delete(n);
               n = next;
           end
        end
        
        function print(obj)
            %print Print list elements
           if(isempty(obj.first))
               return
           end
           
           n = obj.first;
           while(~isempty(n))
               n.container
               n = n.next;
           end
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
        
        function insort(obj,num)
            %insort Insert a packet into the list
            %   The parameter 'num' is the urgency of the packet.
            %   Packets have been simplified to be represented only
            %   by their urgency.
           node = Node(num);
            
           if(isempty(obj.first) || isempty(obj.last))
               obj.first = node;
               obj.last = node;
           else
               n = obj.first;
               while(num < n.container)
                    if(isempty(n.next))
                       node.insertAfter(n);
                       return
                    end
                   n = n.next;
               end
               if(n == obj.first)
                  obj.first = node; 
               elseif(n == obj.last)
                   obj.last = node;
               end
               node.insertBefore(n);
           end
        end

        function data = deleteLast(list)
            %deleteLast deletes the last node in the list
            if(~(isempty(list.first) || isempty(list.last)))
                newLast = list.last.prev;
                data = list.last.container;
                list.last.removeNode();
                if(isempty(newLast))
                    list.first = Node.empty;
                    list.last = Node.empty;
                else
                    list.last = newLast;
                end
            else
                data = 0;
            end
        end
    end
end

