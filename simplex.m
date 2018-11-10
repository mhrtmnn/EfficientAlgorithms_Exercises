function x = simplex(c, A, b)
	m = size(A, 1); % rows of A
	n = size(A, 2); % cols of A
	assert(m == rank(A))

	% prepare for Phase II
	A_start = [A, eye(m)];
	x_start = [zeros(n, 1) ; b];
	B_start = (n+1):(n+m);
	c_start = [zeros(n, 1); ones(m, 1)];

	% find start corner with known start values
	[x_start, B] = simplex_bare(c_start, A_start, b, x_start, B_start);

	% prepare for Phase II
	assert(all(B<=n), 'Start corner is invalid')
	x = zeros(n, 1);
	x(B) = x_start(B);

	% use calculated start corner to find the true solution
	[x, B] = simplex_bare(c, A, b, x, B);
end


function [x, B] = simplex_bare(c, A, b, x, B)
	assert(size(A,1) <= size(A,2))
	assert(size(A,1) == size(b,1))
	assert(size(A,2) == size(x,1))
	m = size(A, 1); % rows of A
	n = size(A, 2); % cols of A
	assert(m == rank(A))

	while 1
		% non base indices
		N = setdiff(1:n, B);

		% reduced costs
		dn = c(N)' - c(B)' * inv(A(:, B)) * A(:, N);

		dn_neg_idx = find(dn < 0);
		if isempty(dn_neg_idx)
			% CASE: dn componentwise >= 0
			% we should not change x(N), since this can only increase c'*x
			disp('Optimal solution found!')
			return
		end

		% CASE: at least one element of dn < 0
		% we may be able to increase the mathing x(N) for a better solution (and decrease x(B) accordingly)
		gamma = dn_neg_idx(1);
		gamma = N(gamma); % index mapping

		ug = inv(A(:, B)) * A(:, gamma);
		if all(ug <= 0)
			% CASE: all components of ug are <= 0
			% we can increase some x(N) without restriction, and x>=0 constraint will never be violated
			error('Problem is unbounded')
		end

		% CASE: at least one component of ug > 0
		% find lambda with: x_hat + lambda*vg = x_B - lambda*ug .= 0
		% (i.e. lambda s.t. one component is 0, all others >= 0)
		ratios = (inv(A(:, B)) * b) ./ ug;

		% disregard all non positive components in the following
		ug_nonpos_idx = find(ug <= 0);
		ratios(ug_nonpos_idx) = Inf;

		[lambda, r] = min(ratios);
		r = B(r); % index mapping

		% construct a vector that fulfills: x + alpha*vg is a solution of A*x=b for all alpha
		vg = zeros(n, 1);
		vg(B) = -ug;
		vg(gamma) = 1;

		% new base solution: lambda is max value of alpha (above) so that x>=0 is still fulfilled
		x = x + lambda * vg;

		% sanity check
		assert(abs(x(gamma) - lambda) <= 10e-8)
		assert(abs(x(r)) <= 10e-8)

		% swap elements r and gamma
		assert(any(ismember(B,r)));
		assert(~any(ismember(B,gamma)));
		B(B==r) = gamma;
		fprintf('Change of corner %d --> %d\n', r, gamma);
	end
end
