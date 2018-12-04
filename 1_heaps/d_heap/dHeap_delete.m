function heap = dHeap_delete(item, heap)
%delete item from heap
	assert(isfield(heap,'arr'))
	assert(isfield(heap,'d'))
	assert(isfield(item,'key'))
	assert(isfield(item,'data'))

	j = heap.arr(end);
	heap.arr(end) = [];
	if item.key == j.key
		assert(item.data == j.data);
	elseif dHeap_key(j) <= dHeap_key(item)
		heap = dHeap_siftup(j, dHeap_get_pos_in_heap(item, heap), heap);
	elseif dHeap_key(j) >  dHeap_key(item)
		heap = dHeap_siftdown(j, dHeap_get_pos_in_heap(item, heap), heap);
	end
end
