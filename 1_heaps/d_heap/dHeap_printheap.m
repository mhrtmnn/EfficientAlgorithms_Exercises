function heap = dHeap_printheap(start, heap)
%print a given heap
	assert(isfield(heap,'arr'))
	assert(isfield(heap,'d'))

	queue = [];
	
	x = dHeap_get_pos_in_heap(start, heap);
	parent = ceil((x-1)/heap.d);

	children_idx = (heap.d*(x-1)+2):min(heap.d*x+1, length(heap.arr));
	
	fprintf("Node (Position=%d, parent=%d): key=%d, data=%s\n", x, parent, start.key, start.data)
	for c=children_idx
		child = heap.arr(c);
		dHeap_printheap(child, heap);
	end
end
