
UGLIFYJS = ./node_modules/.bin/uglifyjs

CSS_FILES = $(wildcard themes/css/*.css)

#dist:  dist/cartodb.js dist/cartodb.full.js themes
dist:  dist/cartodb.js themes


dist/cartodb.uncompressed.js:
	node scripts/compress.js
	mv dist/_cartodb.js dist/cartodb.uncompressed.js

dist/cartodb.js: dist/cartodb.uncompressed.js
	$(UGLIFYJS) dist/cartodb.uncompressed.js > dist/cartodb.js

clean: 
	rm -rf dist/*

css: $(CSS_FILES) 
	cat $(CSS_FILES) > themes/css/cartodb.css

release: dist css
	node scripts/release.js


PHONY: clean themes dist

