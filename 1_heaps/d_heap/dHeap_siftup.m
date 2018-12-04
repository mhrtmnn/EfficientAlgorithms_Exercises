function heap = dHeap_siftup(item, pos, heap)
%inserts item at pos in heap and sift it up
	assert(isfield(heap,'arr'))
	assert(isfield(heap,'d'))
	assert(isfield(item,'key'))
	assert(isfield(item,'data'))

	parent = ceil((pos-1)/heap.d);

	while parent ~= 0 && dHeap_key(heap.arr(parent)) > dHeap_key(item)
		heap.arr(pos) = heap.arr(parent);
		pos = parent;
		parent = ceil((parent-1)/heap.d);
	end

	% insert item into determined position in heap
	heap.arr(pos).key = item.key;
	heap.arr(pos).data = item.data;
end
