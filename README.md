eckis-nachlass
==============

Dieses Projekt enthält alle Dateien, die nötig sind, um die Webseiten
unter http://eckis-nachlass.github.io/ zu erzeugen.

Diese Webseiten werden automatisch aus einer großen Anzahl von
JPEG-Fotos erzeugt.  Die Beschriftung der einzelnen Fotos muss nicht auf
die jeweilige Webseite geschrieben werden.  Sie steht in der Foto-Datei
und wird beim Erzeugen der Webseiten automatisch auf die jeweilige Seite
übertragen.

Um die Webseiten zu gestalten, verändert man die Auswahl der Fotos und
die Beschriftung, die in den Foto-Dateien enthalten sind.  Das lässt sich
zum Beispiel mit dem Foto-Verwaltungsprogramm "Picasa" erledigen.  Die
Beschriftung ist in dem IPTC-Kommentar "Caption-Abstract" enthalten,
den Picasa im Foto einblenden kann.  Mit einem Maus-Klick lässt sie sich
verändern.

Außerdem gibt es ein Script, mit dem die Beschriftung eines Bildes
geändert werden kann z.B.: ./tagit moebel/moebel439.jpg

Um die Webseiten neu zu erzeugen, wechselt man auf der Unix-Kommandozeile in
den Ordner "eckis-nachlass"  und tippt

    make
    make install

Dies installiert die Webseiten in dem Ordner "eckis-nachlass.github.io",
der der Versionsverwaltung mit Git unterliegen muss.  Um die neu
erzeugten Webseiten auf den Github-Server zu übertragen, tippt man z.B.

    cd ../eckis-nachlass.github.io/
    git add --all
    git commit -a -m "Schreibfehler in IPTC-Kommentaren korrigiert"
    git push

Git sorgt dafür, dass nur die geänderten oder neu hinzugefügten Dateien
übertragen werden.

Hat man Änderungen gemacht, auf welche die Freunde und Verwandten des
Verstorben aufmerksam gemacht werden sollen, tippt man zuvor in dem
Ordner "eckis-nachlass"

    make changelog

