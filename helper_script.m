while 1
	% create a random problem
	m = randi(20);
	n = m + randi(20);
	A = randi(100,m,n);
	c = randi(30,n,1);
	b = randi(30,m,1);

	A_start = [A, eye(m)];
	c_start = [zeros(n, 1); ones(m, 1)];

	[x_mat,fval,exitflag,output] = linprog(c_start, -eye(n+m), zeros(n+m,1), A_start, b);
	if ~exitflag || norm(fval) > 0.1
		continue
	else
		disp('Found sensible start corner problem!')
	end

	[x_mat,fval,exitflag,output] = linprog(c, -eye(n), zeros(n,1), A, b);
	if ~exitflag
		continue
	else
		disp('Found sensible problem!')
	end

	x_own = simplex(c, A, b);

	x_own_enum = corner_enumeration_solver(c, A, b);

	if (norm(x_own - x_mat < 10e-8) && (norm(x_own_enum - x_mat) < 10e-8))
		disp('================== Seems about right ==================');

	else
		error('Seems like an error')
	end
end
