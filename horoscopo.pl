%Adverbios, usados na primeira frase 
%(previsao->X é o Y de Z (trabalho é a preocupação de hoje)
adv(time,pred) --> [hoje]|[amanhã].
adv(mode, concl) --> [só].
adv(neg, concl) --> [não].

%Adverbios, parametrizados de acordo com assunto
p(fem, sing, concl) --> [na].
p(masc, sing, concl) --> [no].
p(poss,pred) --> [de].
p(place,pred)--> [em].
p(planet)-->[com].
p(sug)-->[com].

n_t1(masc, sing, pred) --> [tema]|[assunto]|[foco]|[lema].
n_t1(fem, sing, pred) --> [preocupação]|[previsão].
n_t1(masc, sing, planet)-->[júpiter]|[marte]|[vênus]|[urano].
n_t1(masc, sing, sug)--> [esforço]|[gasto]|[medo]|[sofrimento].
n_t1(masc, pl, sug)--> [cuidados]|[desperdícios]|[esforços].
n_t1(fem, sing, sug)--> [dedicação]|[reclamação]|[ansiedade].
n_t1(fem, pl,  sug)--> [angústias]|[alegrias]|[obsessões].
n_t1(masc, sing, concl) --> [otimismo]|[pessimismo]|[cigarro]|[stress]|[álcool].
n_t1(fem, sing, concl) --> [bebida]|[comida]|[dieta].
n_t2(masc, sing, pred) --> [trabalho]|[lazer]|[amor].
n_t2(masc, sing, planet)-->[mercúrio]|[saturno]|[netuno].
n_t2(masc, sing, sug)-->[trabalho]|[família]|[amor]|[amizades].

art(masc, sing) --> [o].
art(fem, sing) --> [a].
art(masc, pl) --> [os].
art(fem, pl) --> [as].

v(pred) --> [é].
v(planet)-->[está].
v(sug)-->[redobre]|[aumente]|[diminua]|[reduza]|[pare].
v(concl) --> [exagere]|[economize].

pnt --> [.].
a(planet)-->[alinhado]|[sintonizado]|[orbitando].

conj-->[então].

pp(pred) --> p(poss,pred), adv(time,pred).
pp(planet)-->p(planet),n_t2(_,sing, planet).
pp(sug)-->p(sug),n_t2(_,_,sug).
pp(Gen, Num, concl)--> p(Gen, Num, concl),n_t1(Gen,Num,concl).

n(Gen,Num, pred) --> n_t1(Gen, Num, pred), pp(pred).
np(Gen,Num, pred) --> art(Gen, Num), n(Gen,Num, pred).
np(Gen, Num, sug)-->art(Gen, Num),n_t1(Gen, Num, sug).

vp_2(Gen,Num, pred) --> v(pred), np(Gen,Num, pred).
vp_2(planet)-->v(planet), a(planet).
vp_2(sug)-->v(sug),np(_,_, sug).

vp_1(pred) --> n_t2(_,sing, pred), vp_2(_,sing, pred).
vp_1(planet)-->vp_2(planet), pp(planet).
vp_1(sug)-->vp_2(sug),pp(sug).
vp_1(Gen, Num, concl)-->v(concl), pp(Gen, Num, concl).

ap(concl)-->adv(mode, concl),adv(neg, concl).

s(planet)-->n_t1(_,sing, planet), vp_1(planet).
s(pred)-->vp_1(pred), pnt.
s(sug)-->vp_1(sug), pnt.
horoscope(concl)-->ap(concl), vp_1(_,_,concl).
horoscope(sug) --> s(sug), horoscope(concl).
horoscope(pred)-->conj,s(pred).
horoscope(planet) -->s(planet),horoscope(pred).
horoscope-->horoscope(planet), horoscope(sug).