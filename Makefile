ESCAPE = 'includes\|extends\|git\|hg\|components\|node_modules'

JADE = $(shell find -L -name "*.jade" | grep -v $(ESCAPE) )
HTML = $(JADE:.jade=.html)

COFFEE 	= $(shell find -L -name "*.coffee" | grep -v $(ESCAPE) )
JS 			= $(COFFEE:.coffee=.js)

test: build
	@mocha-phantomjs -R dot test/support/index.html

build: $(HTML) $(JS)
	@component build --dev

%.html: %.jade
	jade -P < $< --path $< > $@

%.js: %.coffee
	coffee -bc $<

clean:
	rm -rf $(HTML) $(JS)

.PHONY: clean test