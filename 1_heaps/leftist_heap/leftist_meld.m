function heap = leftist_meld(heap1, heap2)
%inserts item into heap
	assert(isprop(heap1, 'rank'))
	assert(isprop(heap1, 'left'))
	assert(isprop(heap1, 'right'))
	assert(isprop(heap2, 'rank'))
	assert(isprop(heap2, 'left'))
	assert(isprop(heap2, 'right'))

	if heap1.rank == 0
		heap = heap2;
	elseif heap2.rank == 0
		heap = heap1;
	else
		heap = leftist_mesh(heap1, heap2);
	end
end
