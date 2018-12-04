function heap = dHeap_insert(item, heap)
%inserts item into heap
	assert(isfield(heap,'arr'))
	assert(isfield(heap,'d'))

	heap = dHeap_siftup(item, length(heap.arr)+1, heap);
end
