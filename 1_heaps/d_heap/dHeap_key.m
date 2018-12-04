function k = dHeap_key(item)
%retrieve key from item
	assert(isfield(item,'key'))

	k = [];
	for i=item
		k = [k, i.key];
	end
end

