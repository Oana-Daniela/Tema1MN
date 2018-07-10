function x = morse_decode(sir)

	A = morse();
	eroare = 0;
	lungime = length(sir);

	for i=1:lungime
		if sir(i) == '.'
			%Parcurg radacina stanga.
			A = A{2};
		else
			if sir(i) == '-'
				%Parcurg radacina dreapta.
				A = A{3};
			else
				x = '*';
				eroare = 1;
				break;
			endif		

		endif
		if ~iscell(A) || length(A) == 0
			x = '*';
			eroare = 1;
			break;
		endif		
	endfor

	if eroare == 0
		x = A{1};
	endif

endfunction 
