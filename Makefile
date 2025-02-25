SMOOSH = ./node_modules/.bin/smoosh

all: test flotr2

$(SMOOSH):
	npm ci

test:
	cd spec; jasmine-headless-webkit -j jasmine.yml -c

libraries: $(SMOOSH)
	$(SMOOSH) make/lib.json
	cat ./build/bean.js > build/lib.js
	#cat ./build/underscore.js >> build/lib.js EspoCRM
	cat ./build/bean.min.js > build/lib.min.js
	echo ";" >> build/lib.min.js
	cat ./build/underscore.min.js >> build/lib.min.js
	echo ";" >> build/lib.min.js

ie: $(SMOOSH)
	$(SMOOSH) make/ie.json

flotr2: libraries ie $(SMOOSH)
	$(SMOOSH) make/flotr2.json
	cat build/lib.js build/flotr2.js > flotr2.js
	cat build/lib.min.js > flotr2.min.js
	cat build/flotr2.min.js >> flotr2.min.js
	echo ';' >> flotr2.min.js
	cp build/ie.min.js flotr2.ie.min.js
	cat build/flotr2.js > flotr2.nolibs.js

flotr2-basic: libraries ie $(SMOOSH)
	$(SMOOSH) make/basic.json
	cat build/lib.min.js > flotr2-basic.min.js
	cat build/flotr2-basic.min.js >> flotr2-basic.min.js

flotr-examples: $(SMOOSH)
	$(SMOOSH) make/examples.json
	cp build/examples.min.js flotr2.examples.min.js
	cp build/examples-types.js flotr2.examples.types.js

flotr-amd: flotr2
	cat js/amd/pre.js > flotr2.amd.js
	cat build/flotr2.js >> flotr2.amd.js
	cat js/amd/post.js >> flotr2.amd.js
