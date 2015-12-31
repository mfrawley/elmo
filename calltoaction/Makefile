all: makedir clean copyhtml copycss elmcompile 

makedir:
	mkdir -p build/
copyhtml: 
	cp index.html build/ 

copycss: 
	cp *.css build/ 

build/index.js : calltoaction.elm tabs.elm
	elm-make --output $@ $<

elmcompile : build/index.js 

clean: 
	rm -rf build/*.*
