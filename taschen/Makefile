ifndef ordner
ordner=taschen
endif
ifndef prefix
destination_prefix=../../eckis-nachlass.github.io
gitprojektordner=../../eckis-nachlass
else
destination_prefix=../$(prefix)
gitprojektordner=../$(prefix)
endif
destination=$(destination_prefix)/$(ordner)
gitprojektziel=$(gitprojektordner)/$(ordner)
pictures := $(wildcard $(ordner)[0-9][0-9][0-9].jpg)
vorschau := $(patsubst $(ordner)%.jpg,vorschau-$(ordner)%.jpg,$(pictures))
vorrest  := $(wildcard vorschau-$(ordner)[0-9][0-9][0-9].jpg)
sympicts := $(wildcard symbol[0-9][0-9][0-9].jpg)
symbol   := $(patsubst symbol%.jpg,symbol-symbol%.jpg,$(sympicts)) 

all: index.html $(symbol)

symbol-symbol%.jpg: symbol%.jpg
	@echo $@ hängt ab von $^
	@echo aber nur $? ist neuer als $@
	../convert2symbol $?

vorschau-$(ordner)%.jpg: $(ordner)%.jpg
	@echo $@ hängt ab von $^
	@echo aber nur $? ist neuer als $@
	../convert2vorschau $?

index.html: generate-index cleaned $(vorschau)
	@echo $@ hängt ab von $^
	@echo aber nur $? ist neuer als $@
	./generate-index > index.html

ifneq ($(vorschau),$(vorrest))
.PHONY: cleaned
endif
cleaned:
	../cleanup vorschau-*.jpg

.PHONY: install
install:
	mkdir $(destination) || true
	rm -f $(destination)/*
	cp -iav index.html $(sympicts) $(symbol) $(pictures) $(vorschau) $(destination)/

.PHONY: clean
clean:
	rm -f *.jpg_original

.PHONY: dist-clean
dist-clean: clean
	rm -f index.html symbol-symbol*.jpg vorschau-$(ordner)*.jpg cleaned

.PHONY: gitprojekt
gitprojekt:
	mkdir $(gitprojektziel) || true
	rm -f $(gitprojektziel)/*
	cp -iav generate-index Makefile $(sympicts) $(pictures) $(gitprojektziel)/

