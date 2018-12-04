function heap = dHeap_siftdown(item, pos, heap)
%start at pos in heap and sift item down
	assert(isfield(heap,'arr'))
	assert(isfield(heap,'d'))
	assert(isfield(item,'key'))
	assert(isfield(item,'data'))

	child = dHeap_minchild(pos, heap);

	while child ~= 0 && dHeap_key(heap.arr(child)) < dHeap_key(item)
		heap.arr(pos) = heap.arr(child);
		pos = child;
		child = dHeap_minchild(child, heap);
	end

	% insert item into determined position in heap
	heap.arr(pos) = item;
end
