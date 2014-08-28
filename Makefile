namensliste=Anne Carsten Jan
ordnerliste=moebel teppiche taschen
destination_prefix=../eckis-nachlass.github.io
destination=$(destination_prefix)
gitprojektordner=../eckis-nachlass
claimslist := $(patsubst %,%.html,$(namensliste))
changelist := $(wildcard changelog/*)
dateiliste := $(filter-out ./index.html,$(shell find -maxdepth 1 -type f))
ordnersympcts := $(foreach dir,$(ordnerliste),$(wildcard $(dir)/symbol[0-9][0-9][0-9].jpg))
ordnersymbole := $(subst symbol,symbol-symbol,$(ordnersympcts))
indices := $(patsubst %,%/index.html,$(ordnerliste))
sympcts := $(filter-out symbole/symbol-%.jpg,$(wildcard symbole/*.jpg))
symbole := $(subst symbole/,symbole/symbol-,$(sympcts))


all: index.html

.PHONY: $(ordnerliste)
$(ordnerliste):
	make -C $@ ordner=$@ prefix=$(destination_prefix)

# Regel für $(indices)
%/index.html: %
	@echo $@ hängt ab von $^

# Regel für $(ordnersymbole)
%/symbol-*.jpg: %
	@echo $@ hängt ab von $^

# Regel für $(symbole)
symbole/symbol-%.jpg: symbole/%.jpg
	@echo $@ hängt ab von $^
	@echo aber nur $? ist neuer als $@
	./convert2symbol $?

# Wenn $(symbole) und $(ordnersymbole) sich geändert haben, müssen die
# geänderten Exiftool-Tags in die Datei index.html eingebaut werden.
# Wenn die $(indices) der Unterordner sich geändert haben, muss index.html
# ebenfalls neu generiert werden, damit sein Änderungsdatum später ist
# als in den $(indices) der Unterordner.
index.html: generate-index $(symbole) $(indices) $(ordnersymbole) changelog.html $(claimslist)
	@echo $@ hängt ab von $^
	@echo aber nur $? ist neuer als $@
	NAMENSLISTE="$(namensliste)" ./generate-index $(ordnerliste) > index.html

.PHONY: changelog
changelog:
	@echo $@ hängt ab von $^
	@echo aber nur $? ist neuer als $@
	./generate-changelog changelog > changelog.html
	./generate-claims changelog $(namensliste)

.PHONY: install
install:
	cp -av index.html grabplatte.jpg robots.txt style.css changelog.html $(claimslist) $(destination)/
	mkdir $(destination)/symbole || true
	rm -f $(destination)/symbole/*
	cp -iav $(symbole) $(sympcts) $(destination)/symbole/
	for dir in $(ordnerliste) ;do \
	    make -C $$dir  ordner=$$dir prefix=$(destination_prefix) install; \
	done

.PHONY: clean
clean:
	rm -f symbole/*.jpg_original
	for dir in $(ordnerliste) ;do \
	    make -C $$dir  ordner=$$dir prefix=$(destination_prefix) clean; \
	done

.PHONY: dist-clean
dist-clean: clean
	rm -f index.html $(symbole)
	for dir in $(ordnerliste) ;do \
	    make -C $$dir  ordner=$$dir prefix=$(destination_prefix) dist-clean; \
	done

.PHONY: gitprojekt
gitprojekt:
	cp -av $(dateiliste) $(gitprojektordner)/
	mkdir $(gitprojektordner)/symbole || true
	rm -f $(gitprojektordner)/symbole/*
	cp -iav $(sympcts) $(gitprojektordner)/symbole/
	mkdir $(gitprojektordner)/changelog || true
	rm -f $(gitprojektordner)/changelog/*
	cp -iav $(changelist) $(gitprojektordner)/changelog/
	for dir in $(ordnerliste) ;do \
	    make -C $$dir  ordner=$$dir prefix=$(gitprojektordner) gitprojekt; \
	done

