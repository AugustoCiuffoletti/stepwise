Stepwise HOWTO

Se si ha a disposizione un archivio già organizzato stepwise, si possono fare una serie di clone, uno per ogni step. L'elenco di tutti i tag, con il relativo commento, si ottiene con

$ git tag -n

Ogni clone genera una nuova directory con nome "repo-Step_X", nella directory si fa poi checkout dello 
step desiderato, e si rimuove la directory .git.

$ git clone https://github.com/AugustoCiuffoletti/ssw_login Step_1
$ cd Step_1
$ git checkout ssw_login-Step_1
$ rm -Rf .git
$ cd ..

Oppure si possono scaricare tutti gli zip nella visuale dei tag su github.

Per vedere le differenze tra versioni successive:

diff -x README.md -r ssw_login-Step_1 ssw_login-Step_2

Nella directory creare un file ''commit.lst'' con la serie dei commenti (una riga) ai vari step. Il formato di ogni riga è
<nome tag> <commento>

Ora è possibile invocare il comando ''build.sh che costruisce un nuovo repository (è necessario rimuovere o spostare quello vecchio).

Creare un repository su github per il repository, e, ne repository appena creato, dare la solita sequenza

$ git remote add origin git@github.com:AugustoCiuffoletti/ssw_login.git
cd ssw	$ git branch -M main
$ git push -u origin main
$ git push origin --tags

Ora da Stackblitz è possibile provare i singoli step

