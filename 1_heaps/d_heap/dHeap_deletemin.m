function [heap, item] = dHeap_deletemin(heap)
%delete item from heap
	assert(isfield(heap,'arr'))
	assert(isfield(heap,'d'))

	if isempty(heap.arr)
		item = [];
	else
		item = heap.arr(1);
		heap = dHeap_delete(item, heap);
	end
end
