all: .packages \
	dist/app.js \
	.static

.static: $(shell find static/ -type f)
	rsync -r static/ dist/
	touch $@

dist/app.js: $(shell find src -type f -name '*.elm')
	elm-make src/App.elm --yes --warn --output=$@

.packages: elm-package.json
	elm package install --yes
	touch $@

clean: 
	-@rm -r dist/ elm-stuff/ .static .packages 2>/dev/null || true
