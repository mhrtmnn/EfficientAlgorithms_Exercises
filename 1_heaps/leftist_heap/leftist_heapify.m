function heap = leftist_heapify(q)
%make heap form a given list of roots 'q'
	assert(all(isprop(q(:), 'rank')))
	assert(all(isprop(q(:), 'left')))
	assert(all(isprop(q(:), 'right')))

	while length(q) >= 2
		q1 = q(1);
		q2 = q(2);
		q = q(3:end);

		q(end+1) = leftist_meld(q1, q2);
	end

	if isempty(q)
		heap = leftist_heap;
	else
		heap = q(1);
	end
end
