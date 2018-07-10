function r = baza(sursa,b1,b2)
	v =[];
	length = length(sursa);
	i=1;
	suma = 0;
	%Conversia in baza 10
	while i<=length
		d = sursa(i);
		%Daca valoarea codului ASCII este mai mare decat a lui 'a' atunci
		%ca sa aflu cat inseamna ca valoare scad 97 si mai adaug 10 
		if d >= 'a'
			d = d - 'a' + 10;
		else
			d = d - '0';
		endif
		suma = suma + d*(b1^(length-i));
		i = i + 1;

	endwhile
	%Conversia in baza b2

	while suma > 0
		rest = mod(suma, b2);
		if rest > 9
			rest = rest + 'a' - 10;
		else
			rest = rest + '0';
		endif
	
		v = [v;rest];
		%Am nevoie de partea intreaga.
		suma = floor(suma/b2);
	endwhile

	r = char(v(end:-1:1)');
endfunction

	

	
