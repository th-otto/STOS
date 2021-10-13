
*************************************************************************
* EQUIVALENTS OF MISCELLANEOUS SYSTEM VARIABLES

; Normal variables
	.offset 0
vectors:    .ds.l 8 ; copy of system vectors
anc400:     .ds.l 1 ; vector 50 herz
runonly:    .ds.w 1 ; flag RUN ONLY or NORMAL
ronom:      .ds.l 1 ; address of *.BAS filename RUN ONLY
roold:      .ds.l 1 ; old directory
ada:        .ds.l 1 ; pointer to TOS adaption vectors
adm:        .ds.l 1 ; pointer to mouse cursor location GCURX/GCURY
adk:        .ds.l 1 ; pointer to keyboard input buffer
ads:        .ds.l 1 ; address of TOS sndtable variable - no longer used
adc:        .ds.l 1 ; command tail - unused
runflg:     .ds.w 1
language:   .ds.w 1 ; language used: 0=GB/1=F/2=D
foncon:     .ds.w 1 ; function keys active?
funckey:    .ds.w 1 ; current function key being executed
ins:        .ds.w 1 ; insertion M/A
oldi:       .ds.w 1 ; old INS during a function key
undoflg:    .ds.w 1
remflg:     .ds.w 1
interflg:   .ds.w 1 ; flag break/interruption/etc...
ancdb8:     .ds.w 1 ; test of contrl/c
bip:        .ds.w 1 ; BEEP keys of on/off
waitcpt:    .ds.l 1 ; countdown: 50 hertz
timer:      .ds.l 1 ; timer counter
coldflg:    .ds.w 1 ; cold start flag
shift:      .ds.w 1 ; currently displayed function keys
ipflg:      .ds.w 1 ; flag printer on
lbkflg:     .ds.w 1 ; list of banks in HEXA or DECIMAL
handle:     .ds.w 1 ; open file handle
upperflg:   .ds.w 1 ; listing in lowercase or uppercase
unewpos:    .ds.l 1 ; size of the first line when unnew
unewbank:   .ds.l 16 ; copy of banks during NEW
unewhi:     .ds.l 1 ; start of data banks
searchd:    .ds.w 1 ; start of search
searchf:    .ds.w 1 ; end of search
mousflg:    .ds.w 1 ; anti bounce mouse
inputflg:   .ds.w 1 ; if INPUT, no more mice in KEY!
inputype:   .ds.w 1 ; input or lineinput?
orinput:    .ds.w 1 ; input on keyboard or file?
oradinp:    .ds.l 1 ; if file: buffer for the address
flginp:     .ds.w 1 ; flg for input: return = 13/10 or character
chrinp:     .ds.w 1 ; character serving as return for input #
autoflg:    .ds.w 1 ; auto active?
autostep:   .ds.w 1 ; auto STEP
lastline:   .ds.w 1 ; last line number entered
paranth:    .ds.w 1 ; parentheses level (interpreter only)
gotovar:    .ds.w 1 ; flag for GOTO VARIABLE

; Print variables, slightly modified...
usingflg:   .ds.b 1 ; print using active ???
impflg:     .ds.b 1
printype:   .ds.w 1
printpos:   .ds.l 1
printfile:  .ds.l 1
            .ds.w 1
sortflg:    .ds.w 1 ; flag: sort of findvar
tokvar:     .ds.l 1 ; interpreter only
varlong:    .ds.w 1 ; interpreter only
tokch:      .ds.l 1 ; interpreter only
chlong:     .ds.w 1 ; interpreter only
nboucle:    .ds.w 1 ; interpreter only
tstnbcle:   .ds.w 1 ; interpreter only
posbcle:    .ds.l 1 ; interpreter only
tstbcle:    .ds.l 1 ; interpreter only
posgsb:     .ds.l 1 ; interpreter only
cptnext:    .ds.w 1 ; interpreter only
oldfind:    .ds.l 1 ; interpreter only
nbdim:      .ds.w 1 ; interpreter only
scankey:    .ds.w 1 ; scancode of the last inkey
datastart:  .ds.l 1 ; address of the line containing the first DATA
dataline:   .ds.l 1 ; address of the current data line
datad:      .ds.l 1 ; current data address
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
lochaine:   .ds.l 1            ;start of channel buffer
chvide:     .ds.l 1            ;Adresse de la chaine vide
bufpar:     .ds.l 1            ;buffer des parametres
liad:       .ds.l 1            ;Table #LIGNE----> ADRESSE
lowpile:    .ds.l 1            ;Niveau ZERO de la pile
adstr:      .ds.l 1            ;Table Ad-Strings

intin:      .ds.l 1
contrl:     .ds.l 1
ptsin:      .ds.l 1
vdipb:      .ds.l 1
fichiers:   .ds.l 1
dta:        .ds.l 1
buffunc:    .ds.l 1
deffunc:    .ds.l 1
funcname:   .ds.l 1
work:       .ds.l 1
dfst:       .ds.l 1
amb:        .ds.l 1
name1:      .ds.l 1
name2:      .ds.l 1
fsbuff:     .ds.l 1
fsname:     .ds.l 1
admenu:     .ds.l 1
flaggem:    .ds.l 1
oend:       .ds.l 1
flola:      .ds.w 1
flgrun:     .ds.w 1
zerofl:     .ds.l 2
svect:      .ds.l 5  ; saved exception vectors

