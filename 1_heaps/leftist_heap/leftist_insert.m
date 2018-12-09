function heap = leftist_insert(item, heap)
%inserts item into heap
	assert(isprop(heap, 'rank'))
	assert(isprop(heap, 'left'))
	assert(isprop(heap, 'right'))
	assert(isfield(item, 'key'))
	
	child = leftist_heap;

	child.left  = [];
	child.right = [];
	child.parent = [];
	child.rank  = 1;
	child.key = item.key;

	heap = leftist_meld(child, heap);
end
