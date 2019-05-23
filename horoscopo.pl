%Adverbios parametrizados de acordo com classe (tempo, modo, nega��o)
%e assunto (
adv(time,pred) --> [hoje]|[amanh�].
adv(mode, concl) --> [s�].
adv(neg, concl) --> [n�o].

%Preposi��es parametrizadas de acordo com g�nero
%(fem, masc), n�mero (sing), assunto (concl, pred, planet, sug)
%e classe (posse, lugar)
p(fem, sing, concl) --> [na].
p(masc, sing, concl) --> [no].
p(poss,pred) --> [de].
p(place,pred)--> [em].
p(planet)-->[com].
p(sug)-->[com].

%Substantivos parametrizados de acordo com g�nero, n�mero e assunto
%Sao divididos em t1 e t2 com o intuito de prevenir repeti��es
%ex:os planetas s�o divididos em n_t1 e n_t2,
%de maneira a n�o aparecer frases como "J�piter est� alinhado
%com J�piter"  
n_t1(masc, sing, pred) --> [tema]|[assunto]|[foco]|[lema].
n_t1(fem, sing, pred) --> [preocupa��o]|[previs�o].
n_t1(masc, sing, planet)-->[j�piter]|[marte]|[v�nus]|[urano].
n_t1(masc, sing, sug)--> [esfor�o]|[gasto]|[medo]|[sofrimento].
n_t1(masc, pl, sug)--> [cuidados]|[desperd�cios]|[esfor�os].
n_t1(fem, sing, sug)--> [dedica��o]|[reclama��o]|[ansiedade].
n_t1(fem, pl,  sug)--> [ang�stias]|[alegrias]|[obsess�es].
n_t1(masc, sing, concl) --> [otimismo]|[pessimismo]|[cigarro]|[stress]|[�lcool].
n_t1(fem, sing, concl) --> [bebida]|[comida]|[dieta].
n_t2(masc, sing, pred) --> [trabalho]|[lazer]|[amor].
n_t2(masc, sing, planet)-->[merc�rio]|[saturno]|[netuno].
n_t2(masc, sing, sug)-->[trabalho]|[fam�lia]|[amor]|[amizades].

%Artigos parametrizados com g�nero e n�mero
art(masc, sing) --> [o].
art(fem, sing) --> [a].
art(masc, pl) --> [os].
art(fem, pl) --> [as].

%Verbos parametrizados por assunto
v(pred) --> [�].
v(planet)-->[est�].
v(sug)-->[redobre]|[aumente]|[diminua]|[reduza]|[pare].
v(concl) --> [exagere]|[economize].

%Pontuacao (sem parametro)
pnt --> [.].

%Adjetivos (foram usadas as classes geradas pelo lx-center)
a(planet)-->[alinhado]|[sintonizado]|[orbitando].

%Conjun��es
conj-->[ent�o].

%Sintagmas preposicionais, parametrizados 
pp(pred) --> p(poss,pred), adv(time,pred).
pp(planet)-->p(planet),n_t2(_,sing, planet).
pp(sug)-->p(sug),n_t2(_,_,sug).
pp(Gen, Num, concl)--> p(Gen, Num, concl),n_t1(Gen,Num,concl).

%Substantivos parametrizados com genero, numero e assunto
n(Gen,Num, pred) --> n_t1(Gen, Num, pred), pp(pred).
np(Gen,Num, pred) --> art(Gen, Num), n(Gen,Num, pred).
np(Gen, Num, sug)-->art(Gen, Num),n_t1(Gen, Num, sug).

%sintagmas verbais, separados em vp_1 e vp_2 por aparecerem
%em diferentes profundidades da �rvore sint�tica
vp_2(Gen,Num, pred) --> v(pred), np(Gen,Num, pred).
vp_2(planet)-->v(planet), a(planet).
vp_2(sug)-->v(sug),np(_,_, sug).

vp_1(pred) --> n_t2(_,sing, pred), vp_2(_,sing, pred).
vp_1(planet)-->vp_2(planet), pp(planet).
vp_1(sug)-->vp_2(sug),pp(sug).
vp_1(Gen, Num, concl)-->v(concl), pp(Gen, Num, concl).

%Sintagma adverbial
ap(concl)-->adv(mode, concl),adv(neg, concl).

%Sentencas, utilizadas pelos componentes principais do horoscopo
s(planet)-->n_t1(_,sing, planet), vp_1(planet).
s(pred)-->vp_1(pred), pnt.
s(sug)-->vp_1(sug), pnt.

%Clausulas de alto nivel, combinando as sentencas que formam
%cada parte do horoscopo
horoscope(concl)-->ap(concl), vp_1(_,_,concl).
horoscope(sug) --> s(sug), horoscope(concl).
horoscope(pred)-->conj,s(pred).
horoscope(planet) -->s(planet),horoscope(pred).
horoscope-->horoscope(planet), horoscope(sug).