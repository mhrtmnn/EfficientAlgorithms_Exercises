function vertprop_blue = dheap_MST(graph, s_idx)
% calc the MST of given vertices 'vertices', starting with vertex 's'

	% properties
	num_nodes = size(graph.Nodes, 1);
	vertprop_key = inf * ones(1, num_nodes);
	
	% makeheap cannot be called with emtpy item list
	h.d = 2;
	h.arr = [];
	
	v = s_idx;
	
	while true
		vertprop_key(v) = -Inf;
		
		edgeTable = graph.Edges(graph.outedges(v),:);
		for i=1:height(edgeTable)
			edge = edgeTable(i,:);

			w_str = string(setdiff(edge.EndNodes, num2str(v)));
			w = str2num(w_str);

			if edge.Weight < vertprop_key(w)
				vertprop_key(w) = edge.Weight;
				vertprop_blue(w,:) = edge;
				
				% check membership of w
				itemPos = simpleFindInHeap(h, w_str);
				if isempty(itemPos)
					item.data = w_str;
					item.key = vertprop_key(w);
					h = dHeap_insert(item, h);
				else
					h = dHeap_siftup(item, itemPos, h);
				end
			end
		end
		
		[h, v] = dHeap_deletemin(h);
		if isempty(v)
			break
		else
			v = str2num(v.data);
		end
	end
end


function pos = simpleFindInHeap(heap, data)
% check if there is an item in 'heap' with a given key, and return its position
% in contrast to dHeap_get_pos_in_heap, this function only compares the 'data' member
	assert(isfield(heap,'arr'))
	assert(isfield(heap,'d'))

	pos = [];
	for i=1:length(heap.arr)
		item=heap.arr(i);
		if strcmp(item.data, data)
			pos = i;
			return;
		end
	end
end
