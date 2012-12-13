COFFEE = $(shell find -name "*.coffee")
JS = $(COFFEE:.coffee=.js)

# mocha --compilers coffee:coffee-script

test:	$(JS)
	mocha --reporter min

%.js: %.coffee
	coffee -bc $^

clean:
	rm -rf components $(JS)

.PHONY: clean test