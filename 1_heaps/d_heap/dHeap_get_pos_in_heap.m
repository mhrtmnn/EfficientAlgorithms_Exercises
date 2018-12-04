function pos = dHeap_get_pos_in_heap(item, heap)
%get position in heap of a given item
	assert(isfield(heap,'arr'))
	assert(isfield(heap,'d'))
	assert(isfield(item,'key'))
	assert(isfield(item,'data'))
	
	for i=1:length(heap.arr)
		if heap.arr(i).key == item.key && all(heap.arr(i).data == item.data)
			pos = i;
			return
		end
	end
	
	err("Could not find array in heap!")
end
