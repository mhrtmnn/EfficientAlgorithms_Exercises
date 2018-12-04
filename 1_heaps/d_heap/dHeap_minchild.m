function mc = dHeap_minchild(pos, heap)
%find minimum child, starting at pos in heap
	assert(isfield(heap,'arr'))
	assert(isfield(heap,'d'))

	start = heap.d*(pos-1) + 2;

	if start > length(heap.arr)
		mc = 0;
		return
	end

	children = start:min(heap.d*pos + 1, length(heap.arr));
	keys = dHeap_key(heap.arr(children));
	[~, idx] = min(keys);
	mc = children(idx);
end