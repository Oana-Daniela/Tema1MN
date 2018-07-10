function Z = zigzag(n)

	Z = zeros(n);
	i = j = 0;
	count = 0;
	suma = 1;

	for k = 1:n
		suma = suma + 1;
		%Daca indicele k este par.
		if mod(k,2) == 0		
			for i =1:k
				j = suma - i;
				Z(i,j) = count;
				%valoarea pe care o pun la Z(i,j)=
				%valoare incermentata la 					   
				%fiecare parcurgere de element din matrice.
				count = count + 1;	
			endfor 

		else
		%Daca indicele k este impar pornesc invers.
			for i = k:-1:1
				j = suma - i;
				Z(i,j) = count;
				count = count + 1;
			endfor
		endif
	
	endfor

	for k = n-1:-1:1
		suma = suma + 1;
		if mod(k,2) == 0
			for i = n-k+1:n
				j = suma - i;
				Z(i,j) = count;
				count = count + 1;
			endfor 

		else
			for i = n:-1:n-k+1
				j = suma - i;
				Z(i,j) = count;
				count = count + 1;
			endfor
		endif
	
	endfor

endfunction
