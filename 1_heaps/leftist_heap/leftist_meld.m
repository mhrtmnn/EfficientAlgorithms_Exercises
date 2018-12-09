function heap = leftist_meld(heap1, heap2)
%inserts item into heap
	assert(isempty(heap1) || (isprop(heap1, 'rank') && isprop(heap1, 'left') && isprop(heap1, 'right')))
	assert(isempty(heap2) || (isprop(heap2, 'rank') && isprop(heap2, 'left') && isprop(heap2, 'right')))

	if isempty(heap1) || heap1.rank == 0
		heap = heap2;
	elseif isempty(heap2) || heap2.rank == 0
		heap = heap1;
	else
		heap = leftist_mesh(heap1, heap2);
	end
end
