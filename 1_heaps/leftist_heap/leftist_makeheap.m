function heap = leftist_makeheap(s)
%make heap form a given set 's'
	assert(all(isfield(s(:), 'key')))

	q = [];
	for i=s
		root = leftist_heap;
		root.rank = 1;
		root.key = i.key;

		q = [q, root];
	end

	heap = leftist_heapify(q);
end
