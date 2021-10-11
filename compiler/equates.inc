
*************************************************************************
* EQUIVALENTS OF MISCELLANEOUS SYSTEM VARIABLES

; Variables normales
vecteurs       = 0                   ;blk.l 8,0
anc400         = 8*4                 ;dc.l 0
runonly        = anc400+4            ;dc.w 0     
ronom          = runonly+2           ;dc.l 0
roold          = ronom+4             ;dc.l 0 
ada            = roold+4             ;dc.l 0 ; pointer to TOS adaption vectors
adm            = ada+4               ;dc.l 0 ; pointer to mouse cursor location GCURX/GCURY
adk            = adm+4               ;dc.l 0 ; pointer to keyboard input buffer
ads            = adk+4               ;dc.l 0 ; address of TOS sndtable variable - no longer used
adc            = ads+4               ;dc.l 0 ; command tail - unused
runflg         = adc+4               ;dc.w 0
langue         = runflg+2            ;dc.w 0
foncon         = langue+2            ;dc.w 0
fonction       = foncon+2            ;dc.w 0
ins            = fonction+2          ;dc.w 0
oldi           = ins+2               ;dc.w 0
undoflg        = oldi+2              ;dc.w 0
remflg         = undoflg+2           ;dc.w 0
interflg       = remflg+2            ;dc.w 0
ancdb8         = interflg+2          ;dc.w 0
bip            = ancdb8+2            ;dc.w 0
waitcpt        = bip+2               ;dc.l 0
timer          = waitcpt+4           ;dc.l 0
coldflg        = timer+4             ;dc.w 0
shift          = coldflg+2           ;dc.w 0
ipflg          = shift+2             ;dc.w 0
lbkflg         = ipflg+2            ;dc.w 0
handle         = lbkflg+2            ;dc.w 0
upperflg       = handle+2            ;dc.w 0
unewpos        = upperflg+2          ;dc.l 0
unewbank       = unewpos+4           ;blk.l 16,0 
unewhi         = 16*4+unewbank       ;dc.l 0
searchd        = unewhi+4            ;dc.w 0
searchf        = searchd+2           ;dc.w 0
mousflg        = searchf+2           ;dc.w 0 
inputflg       = mousflg+2           ;dc.w 0
inputype       = inputflg+2          ;dc.w 0
orinput        = inputype+2          ;dc.w 0
oradinp        = orinput+2           ;dc.l 0
flginp         = oradinp+4           ;dc.w 0
chrinp         = flginp+2            ;dc.w 0
autoflg        = chrinp+2            ;dc.w 0
autostep       = autoflg+2           ;dc.w 0
lastline       = autostep+2          ;dc.w 0
paranth        = lastline+2          ;dc.w 0
gotovar        = paranth+2           ;dc.w 0

; Variable du print, un peu modifiees...
printflg       = gotovar+2
usingflg       = printflg
impflg         = printflg+1
printype       = printflg+2
printpos       = printflg+4
printfile      = printflg+8

*printflg       = gotovar+2           ;dc.w 0
*printpos       = printflg+2          ;dc.l 0
*printype       = printpos+4          ;dc.w 0
*printfile      = printype+2          ;dc.l 0
*usingflg       = printfile+4         ;dc.w 0

sortflg        = printflg+2+4+2+4+2  ;dc.w 0
*tokvar         = sortflg+2           ;dc.l 0
*varlong        = tokvar+4            ;dc.w 0
*tokch          = varlong+2           ;dc.l 0
*chlong         = tokch+4             ;dc.w 0
*nboucle        = chlong+2            ;dc.w 0
*tstnbcle       = nboucle+2           ;dc.w 0
*posbcle        = tstnbcle+2          ;dc.l 0
*tstbcle        = posbcle+4           ;dc.l 0
*posgsb         = tstbcle+4           ;dc.l 0
*cptnext        = posgsb+4            ;dc.w 0
*oldfind        = cptnext+2           ;dc.l 0
*nbdim          = oldfind+4           ;dc.w 0
scankey        = sortflg+2+4+2+4+2+2+2+4+4+4+2+4+2     ;dc.w 0
datastart      = scankey+2           ;dc.l 0
dataline       = datastart+4         ;dc.l 0
datad          = dataline+4          ;dc.l 0
folflg         = datad+4             ;dc.w 0
erroron        = folflg+2            ;dc.w 0
onerrline      = erroron+2           ;dc.l 0
errornb        = onerrline+4         ;dc.w 0
errorline      = errornb+2           ;dc.l 0
errorchr       = errorline+4         ;dc.l 0
contflg        = errorchr+4          ;dc.w 0
contchr        = contflg+2           ;dc.l 0
contline       = contchr+4           ;dc.l 0
brkinhib       = contline+4          ;dc.w 0
foldeb         = brkinhib+2          ;dc.w 0
folend         = foldeb+2            ;dc.w 0
ancrnd1        = folend+2            ;dc.w 0
ancrnd2        = ancrnd1+2           ;dc.l 0
ancrnd3        = ancrnd2+4           ;dc.l 0
fixflg         = ancrnd3+4           ;dc.w 0
expflg         = fixflg+2            ;dc.w 0
callreg        = expflg+2            ;blk.l 8+7,0
trahpile       = 15*4+callreg        ;dc.l 0
cursflg        = trahpile+4          ;dc.l 0 
dirsize        = cursflg+4           ;dc.l 0
;-----------------------------Graphique
mode           = dirsize+4           ;dc.w 0
deflog         = mode+2              ;dc.l 0
defback        = deflog+4            ;dc.l 0
adback         = defback+4           ;dc.l 0
adphysic       = adback+4            ;dc.l 0 
adlogic        = adphysic+4          ;dc.l 0
ambia          = adlogic+4           ;dc.w 0
laad           = ambia+2             ;dc.l 0
laintin        = laad+4              ;dc.l 0
laptsin        = laintin+4           ;dc.l 0
xmax           = laptsin+4           ;dc.l 0
ymax           = xmax+4              ;dc.l 0
colmax         = ymax+4              ;dc.l 0
ink            = colmax+4            ;dc.w 0
inkvdi         = ink+2               ;dc.w 0
plan0          = inkvdi+2            ;dc.w 0,0,0,0
autoback       = plan0+8             ;dc.w 0
xgraph         = autoback+2          ;dc.w 0
ygraph         = xgraph+2            ;dc.w 0
grwrite        = ygraph+2            ;dc.w 0
grh            = grwrite+2           ;dc.w 0
actualise      = grh+2               ;dc.w 0
valpen         = actualise+2         ;dc.w 0
valpaper       = valpen+2            ;dc.w 0
nbjeux         = valpaper+2          ;dc.w 0
defmod         = nbjeux+2            ;dc.w 0
;-----------------------------sons
volumes        = defmod+2            ;dc.l 0
        even
;-----------------------------Gestionneur de memoire
;programme edite
dbufprg        = volumes+4           ;dc.l 0
lbufprg        = dbufprg+4           ;dc.l 0
program        = lbufprg+4           ;dc.w 0
adatabank      = program+2           ;dc.l 0
adataprg       = adatabank+4         ;dc.l 0
dsource        = adataprg+4          ;dc.l 0
fsource        = dsource+4           ;dc.l 0
hichaine       = fsource+4           ;dc.l 0
lowvar         = hichaine+4          ;dc.l 0
himem          = lowvar+4            ;dc.l 0
topmem         = himem+4             ;dc.l 0
acldflg        = topmem+4            ;dc.w 0
posacc         = acldflg+2           ;dc.w 0
accflg         = posacc+2            ;dc.w 0
reactive       = accflg+2            ;dc.w 0
avanthelp      = reactive+2          ;dc.w 0
;autres PROGRAMMES: 16 en tout
dataprg        = avanthelp+2         ;blk.l 16*2,0
fbufprg        = 16*2*4+dataprg      ;dc.l 0
;BANKS de memoire dans les programmes: 16/PROGRAMMES
databank       = fbufprg+4           ;blk.l 16*16,0
;Multifenetrage
fenetre        = 16*16*4+databank    ;dc.w 0
typecran       = fenetre+2           ;dc.w 0
;table de repartition des programmes dans les fenetres
reparti        = typecran+2          ;blk.l 16,0
;-----------------------------MENUS DEROULANTS
mnd            = 16*4+reparti        ;0 menuflg
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
fsd            = mnd+140             ;DATAS FILE SELECTOR
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
;fsname   = buffer+256      ;nom recherche
;fsbuff   = buffer+256+32
;-----------------------------EXTENSIONS BASIC
adext          = fsd+28              ;dc.l 0
datext         = adext+4             ;blk.l 26*2,0
extchr         = 26*2*4+datext       ;dc.l 0
;-----------------------------PILE DES BOUCLES
;bufbcle        = 38*11+4+extchr
;-----------------------------PILE DES GOSUBS
;bufgsb         = 14*15+bufbcle

**************************************************************************
*       Adresses disponibles pour stocker des donnees compilees
*       Dans le debut de la pile des boucles
libre          = extchr+4+208        ;Sauter le BUG du basic!            

debut          = libre               ;Adresse debut du programme             
spile          = libre+4             ;Sauvegarde de la pile
table          = libre+8             ;Adresse de la table des adresses
buffer         = libre+12            ;Adresse du buffer
error          = libre+16            ;Traitement des erreurs
defloat        = libre+20            ;buffer ecriture float
lochaine       = libre+24            ;debut du buffer des chaines
chvide         = libre+28            ;Adresse de la chaine vide
bufpar         = libre+32            ;buffer des parametres
LiAd           = libre+36            ;Table #LIGNE----> ADRESSE
LowPile        = libre+40            ;Niveau ZERO de la pile
AdStr          = libre+44            ;Table Ad-Strings

intin          = libre+48
contrl         = libre+52
ptsin          = libre+56
vdipb          = libre+60
fichiers       = libre+64
dta            = libre+68
buffonc        = libre+72
deffonc        = libre+76
foncnom        = libre+80
Work           = libre+84
dfst           = libre+88
amb            = libre+92
name1          = libre+96
name2          = libre+100
fsbuff         = libre+104
fsname         = libre+108
AdMenu         = libre+112
FlaGem         = libre+116
OEnd           = libre+120
flola          = libre+124
flgrun         = libre+126
ZeroFl	       = libre+128
SVect          = libre+128+8

