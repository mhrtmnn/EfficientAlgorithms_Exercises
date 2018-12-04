function heap = dHeap_makeheap(items, d)
%construct heap from given elements in 'items'
	assert(isfield(items(:),'key'))
	assert(isfield(items(:),'data'))
	
	heap.d = d;
	heap.arr = [];

	for item=items
		new = length(heap.arr) + 1;
		heap.arr(new).key = item.key;
		heap.arr(new).data = item.data;
	end
	
	for x=length(items):-1:1
		heap = dHeap_siftdown(heap.arr(x), x, heap);
	end
end
