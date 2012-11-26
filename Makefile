COFFEE = $(shell find -name "*.coffee")
JS = $(COFFEE:.coffee=.js)

test:	$(JS)
	mocha --reporter list

%.js: %.coffee
	coffee -bc $^

clean:
	rm -rf components $(JS)

.PHONY: clean test