
*************************************************************************
* EQUIVALENTS OF MISCELLANEOUS SYSTEM VARIABLES

; Normal variables
	.offset 0
vecteurs:   .ds.l 8
anc400:     .ds.l 1
runonly:    .ds.w 1
ronom:      .ds.l 1
roold:      .ds.l 1
ada:        .ds.l 1 ; pointer to TOS adaption vectors
adm:        .ds.l 1 ; pointer to mouse cursor location GCURX/GCURY
adk:        .ds.l 1 ; pointer to keyboard input buffer
ads:        .ds.l 1 ; address of TOS sndtable variable - no longer used
adc:        .ds.l 1 ; command tail - unused
runflg:     .ds.w 1
langue:     .ds.w 1
foncon:     .ds.w 1
fonction:   .ds.w 1
ins:        .ds.w 1
oldi:       .ds.w 1
undoflg:    .ds.w 1
remflg:     .ds.w 1
interflg:   .ds.w 1
ancdb8:     .ds.w 1
bip:        .ds.w 1
waitcpt:    .ds.l 1
timer:      .ds.l 1
coldflg:    .ds.w 1
shift:      .ds.w 1
ipflg:      .ds.w 1
lbkflg:     .ds.w 1
handle:     .ds.w 1
upperflg:   .ds.w 1
unewpos:    .ds.l 1
unewbank:   .ds.l 16
unewhi:     .ds.l 1
searchd:    .ds.w 1
searchf:    .ds.w 1
mousflg:    .ds.w 1
inputflg:   .ds.w 1
inputype:   .ds.w 1
orinput:    .ds.w 1
oradinp:    .ds.l 1
flginp:     .ds.w 1
chrinp:     .ds.w 1
autoflg:    .ds.w 1
autostep:   .ds.w 1
lastline:   .ds.w 1
paranth:    .ds.w 1
gotovar:    .ds.w 1

; Variable du print, un peu modifiees...
usingflg:   .ds.b 1
impflg:     .ds.b 1
printype:   .ds.w 1
printpos:   .ds.l 1
printfile:  .ds.l 1
            .ds.w 1
sortflg:    .ds.w 1
tokvar:     .ds.l 1 ; no longer used
varlong:    .ds.w 1 ; no longer used
tokch:      .ds.l 1 ; no longer used
chlong:     .ds.w 1 ; no longer used
nboucle:    .ds.w 1 ; no longer used
tstnbcle:   .ds.w 1 ; no longer used
posbcle:    .ds.l 1 ; no longer used
tstbcle:    .ds.l 1 ; no longer used
posgsb:     .ds.l 1 ; no longer used
cptnext:    .ds.w 1 ; no longer used
oldfind:    .ds.l 1 ; no longer used
nbdim:      .ds.w 1 ; no longer used
scankey:    .ds.w 1
datastart:  .ds.l 1
dataline:   .ds.l 1
datad:      .ds.l 1
folflg:     .ds.w 1
erroron:    .ds.w 1
onerrline:  .ds.l 1
errornb:    .ds.w 1
errorline:  .ds.l 1
errorchr:   .ds.l 1
contflg:    .ds.w 1
contchr:    .ds.l 1
contline:   .ds.l 1
brkinhib:   .ds.w 1
foldeb:     .ds.w 1
folend:     .ds.w 1
ancrnd1:    .ds.w 1
ancrnd2:    .ds.l 1
ancrnd3:    .ds.l 1
fixflg:     .ds.w 1
expflg:     .ds.w 1
callreg:    .ds.l 15
trahpile:   .ds.l 1
cursflg:    .ds.l 1
dirsize:    .ds.l 1
;-----------------------------Graphique
mode:       .ds.w 1
deflog:     .ds.l 1
defback:    .ds.l 1
adback:     .ds.l 1
adphysic:   .ds.l 1
adlogic:    .ds.l 1
ambia:      .ds.w 1
laad:       .ds.l 1
laintin:    .ds.l 1
laptsin:    .ds.l 1
xmax:       .ds.l 1
ymax:       .ds.l 1
colmax:     .ds.l 1
ink:        .ds.w 1
inkvdi:     .ds.w 1
plan0:      .ds.w 4
autoback:   .ds.w 1
xgraph:     .ds.w 1
ygraph:     .ds.w 1
grwrite:    .ds.w 1
grh:        .ds.w 1
actualise:  .ds.w 1
valpen:     .ds.w 1
valpaper:   .ds.w 1
nbjeux:     .ds.w 1
defmod:     .ds.w 1
;-----------------------------sons
volumes:    .ds.b  4
;-----------------------------Gestionneur de memoire
;programme edite
dbufprg:    .ds.l 1
lbufprg:    .ds.l 1
program:    .ds.w 1
adatabank:  .ds.l 1
adataprg:   .ds.l 1
dsource:    .ds.l 1
fsource:    .ds.l 1
hichaine:   .ds.l 1
lowvar:     .ds.l 1
himem:      .ds.l 1
topmem:     .ds.l 1
acldflg:    .ds.w 1
posacc:     .ds.w 1
accflg:     .ds.w 1
reactive:   .ds.w 1
avanthelp:  .ds.w 1
;autres PROGRAMMES: 16 en tout
dataprg:    .ds.l 16*2
fbufprg:    .ds.l 1
;BANKS de memoire dans les programmes: 16/PROGRAMMES
databank:   .ds.l 16*16
;Multifenetrage
fenetre:    .ds.w 1
typecran:   .ds.w 1
;table de repartition des programmes dans les fenetres
reparti:    .ds.l 16
;-----------------------------MENUS DEROULANTS
mnd:        .ds.b 140        ;0 menuflg
                                        ;2 oldmnflg
                                        ;4 menuchg
                                        ;6 menukey
                                        ;8 menuhaut
                                        ;10 menuline
                                        ;12 menubar
                                        ;14 menubank
                                        ;16 menutemp
                                        ;18 menuchoix
                                        ;20 menusschx
                                        ;22 menutx
                                        ;24 menunb
                                        ;26 menutour
                                        ;28 menupen
                                        ;30 menupaper
                                        ;32 menuold
                                        ;34 menutext  
                                        ;34+32=66 menumous
                                        ;34+32+32=98 onmnflg
                                        ;100 onmnjmp
                                        ;100+40=140 Taille totale MND
;-----------------------------FILE SELECTOR
fsd:        .ds.b 28             ;DATAS FILE SELECTOR
                                        ;+0: fsnb
                                        ;+2: 
                                        ;+4
                                        ;+6
                                        ;+8
                                        ;+10
                                        ;+14
                                        ;+16
                                        ;+18
                                        ;+20
                                        ;+22
                                        ;+24
                                        ;+26
;-----------------------------EXTENSIONS BASIC
adext:      .ds.l 1
datext:     .ds.l 26*2
extchr:     .ds.l 1
            .ds.b 208 ; unused

**************************************************************************
*       Adresses disponibles pour stocker des donnees compilees
*       Dans le debut de la pile des boucles
libre:                         ;Sauter le BUG du basic!            
debut:      .ds.l 1            ;Adresse debut du programme             
spile:      .ds.l 1            ;Sauvegarde de la pile
table:      .ds.l 1            ;Adresse de la table des adresses
buffer:     .ds.l 1            ;Adresse du buffer
error:      .ds.l 1            ;Traitement des erreurs
defloat:    .ds.l 1            ;buffer ecriture float
lochaine:   .ds.l 1            ;debut du buffer des chaines
chvide:     .ds.l 1            ;Adresse de la chaine vide
bufpar:     .ds.l 1            ;buffer des parametres
LiAd:       .ds.l 1            ;Table #LIGNE----> ADRESSE
LowPile:    .ds.l 1            ;Niveau ZERO de la pile
AdStr:      .ds.l 1            ;Table Ad-Strings

intin:      .ds.l 1
contrl:     .ds.l 1
ptsin:      .ds.l 1
vdipb:      .ds.l 1
fichiers:   .ds.l 1
dta:        .ds.l 1
buffonc:    .ds.l 1
deffonc:    .ds.l 1
foncnom:    .ds.l 1
Work:       .ds.l 1
dfst:       .ds.l 1
amb:        .ds.l 1
name1:      .ds.l 1
name2:      .ds.l 1
fsbuff:     .ds.l 1
fsname:     .ds.l 1
AdMenu:     .ds.l 1
FlaGem:     .ds.l 1
OEnd:       .ds.l 1
flola:      .ds.w 1
flgrun:     .ds.w 1
ZeroFl:     .ds.l 2
SVect:      .ds.l 5  ; saved exception vectors

