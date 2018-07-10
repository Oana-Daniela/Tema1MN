function [] = joc()

printf('\n');
flag = 0;

while flag == 0
	utilizator = input('Alegeti X sau 0 : ', 's');

	if utilizator ~= 'X' && utilizator ~= '0'
		printf('Nu ati ales X sau 0.\n');
	else
		flag = 1;
	endif
endwhile


if utilizator == 'X'
	utilizator = 1;
else
	utilizator = 0;
endif

M = zeros(3);



runde_terminate = 0;
joc_terminat = 0;

	while joc_terminat == 0

		joc_terminat = returneaza_castigator(M);	
		
		if joc_terminat ~= 0
			break;
		endif
		%Daca nu au mai ramas spatii libere,ies din joc
		if spatii_libere(M) == 0
			break;
		endif
	
		M = ocupa_pozitie(M,1,-1,-1);
	
		joc_terminat = returneaza_castigator(M);
		
		if joc_terminat ~= 0
			break;
		endif
		
		if spatii_libere(M) == 0
			break;
		endif
	
		[poz_i poz_j] = mutare_calculator(M, utilizator);
		M = ocupa_pozitie(M,4,poz_i,poz_j);




		afisare_matrice(M,utilizator);

		
	
	endwhile


u = 0;
c = 0;


	if joc_terminat == 0
		printf('Egalitate\n');
		runde_terminate = runde_terminate + 1; 
	else
		if joc_terminat == 1
			printf('A castigat utilizatorul.\n');
				u = u + 1;
			runde_terminate = runde_terminate + 1; 
		else
			if joc_terminat == 4
				printf('A castigat calculatorul.\n');
					c = c + 1;
				runde_terminate = runde_terminate + 1; 
			endif
		endif
		
	endif

	printf('\nUtilizator : %d\nCalculator : %d\n',u,c);
	q = input('Apasati q pentru a iesi : ','s');


	if q == 'q';
		runde_terminate = 1;
		break;
	else
		%incrementez numarul de jocuri
		printf('\nJoc %d\n',runde_terminate+1);
		joc();
	

	endif





endfunction

function [] = afisare_matrice(M,utilizator)

	for i=1:3
		for j=1:3
			if M(i,j) == 0
				printf('|_ _');
			else
				if M(i,j) == 1 
					%Afisez ce s-a dat ca input.
					if utilizator == 0
						printf('|_0_');
					else
						printf('|_X_');
					endif
				else
					if M(i,j) == 4
						if utilizator == 0
							printf('|_X_');
						else
							printf('|_0_');
						endif
					endif
				endif
			endif
		endfor
		printf('|');
		printf('\n');
	endfor

endfunction


function r = returneaza_castigator(M)
	flag = 0;
%verific cazurile in care elementele de pe linii ,coloane sau diagonale au aceeasi valoare
	for i= 1 : 3
		if M(i,1) == M(i,2) && M(i,2) == M(i,3) && M(i,1) ~= 0
			r = M(i,1);
			flag = 1;
		endif
		
		if M(1,i) == M(2,i) && M(2,i) == M(3,i) && M(1,i) ~= 0
			r = M(1,i);
			flag = 1;
		endif
	endfor

	if M(1,1) == M(2,2) && M(2,2) == M(3,3) && M(1,1) ~= 0
		r = M(1,1);
		flag = 1;
	endif
	
	
	if M(1,3) == M(2,2) && M(2,2) == M(3,1) && M(1,3) ~= 0
		r = M(1,3);
		flag = 1;
	endif

	if flag == 0
		r = 0;
	endif
	
	
	
endfunction




function M = ocupa_pozitie(M,x,poz_i,poz_j)

poz_invalida = 0;

while poz_invalida == 0
	%Citesc ce indice de linie si coloana primesc.
	if poz_i == -1 && poz_j == -1
		poz_i = input('Alegeti linia : ');
		poz_j = input('Alegeti coloana : ');
		printf('\n');
	endif

	if poz_i < 1 || poz_i >3 || poz_j < 1 || poz_j >3
		printf('Pozitie invalida!\n');
		poz_i = -1;
		poz_j = -1;
		continue;
	endif

	if M(poz_i,poz_j) ~= 0
		printf('Pozitie ocupata!\n');
		poz_i = -1;
		poz_j = -1;
		continue;
	endif

	M(poz_i,poz_j) = x;
	poz_invalida = 1;

	

endwhile

endfunction

function n = spatii_libere(M)

	
	count = 0;
	for i = 1:3
		for j= 1:3
		
			if M(i,j) == 0
				%Cate spatii libere au mai ramas.
				count = count + 1;
			endif 
		endfor
	endfor

	n = count;
endfunction


function [poz_i poz_j] =  mutare_calculator(M, utilizator)
[poz_i poz_j] = poate_castiga(M,4);

%poz_i = -1 (sau j) - Marchez faptul ca respectivele pozitii sunt libere.
if poz_i == -1 || poz_j == -1
	[poz_i poz_j] = poate_castiga(M,1);
	if poz_i == -1 || poz_j == -1
		%daca casuta din mijloc este libera calculatorul face mutarea in ea.
		if M(2,2) == 0
			poz_i = 2;
			poz_j = 2;
		else
		i = 1;
		flag = 0;
		%Daca casuta din mijloc nu este libera gasesc prima
		%casuta libera si acolo pune calculatorul mutarea.
		while flag == 0 && i < 4
			j = 1;
			while flag == 0 && j < 4
				if M(i,j) == 0
					poz_i = i;
					poz_j = j;
					flag = 1;
				endif
				j = j + 1;
			endwhile
			i = i + 1;
		endwhile
		endif
	endif
endif


endfunction


function [poz_i poz_j] = poate_castiga(M,x)
i = 1;
suma = 0;
flag =0;
%Daca 2 casute vecine poseda aceeasi valoare,atunci blochez 
%linia punand valoarea adversarului in a casuta ramasa pe 
%linii,coloane sau diagonale.
	while flag ==0 && i<4
		suma = M(i,1) + M(i,2) + M(i,3);
		if suma == 2*x
			if M(i,1) == 0
				poz_i = i;
				poz_j = 1;
				flag = 1;
				break;
			else if M(i,2) == 0
				poz_i = i;
				poz_j = 2;
				flag = 1;
				break;
			else
				poz_i = i;
				poz_j = 3;
				flag = 1;
				break;
			endif
			endif
		
		endif
		
		suma = M(1,i) + M(2,i) + M(3,i);
		if suma == 2*x
			if M(1,i) == 0
				poz_i = 1;
				poz_j = i;
				flag = 1;
				break;
			else if M(2,i) == 0
				poz_i = 2;
				poz_j = i;
				flag = 1;
				break;
			else
				poz_i = 3;
				poz_j = i;
				flag = 1;
				break;
			endif
			endif
		
		endif

		i = i + 1;	

	endwhile

	suma = M(1,1) + M(2,2) + M(3,3)
	if suma == 2*x 
		if M(1,1) == 0
				poz_i = 1;
				poz_j = 1;
				flag = 1;
				break;
			else if M(2,2) == 0
				poz_i = 2;
				poz_j = 2;
				flag = 1;
				break;
			else
				poz_i = 3;
				poz_j = 3;
				flag = 1;
				break;
			endif
			endif
	endif

	suma = M(1,3) + M(2,2) + M(3,1)
	if suma == 2*x 
		if M(1,3) == 0
				poz_i = 1;
				poz_j = 3;
				flag = 1;
				break;
			else if M(2,2) == 0
				poz_i = 2;
				poz_j = 2;
				flag = 1;
				break;
			else
				poz_i = 3;
				poz_j = 1;
				flag = 1;
				break;
			endif
			endif
	endif

	if flag == 0
		poz_i = -1;
		poz_j = -1;
	endif

	

endfunction



