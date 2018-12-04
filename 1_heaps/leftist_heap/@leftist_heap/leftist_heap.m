classdef leftist_heap < handle
properties
	% Mamber variables
	rank
	key
	left
	right
end

methods
	% Constructor
	function obj = leftist_heap()
		obj.rank = 0;
	end

	r = leftist_get_rank(obj)
end

end
