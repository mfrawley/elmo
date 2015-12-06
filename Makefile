all: clean copyhtml copycss elmcompile 

copyhtml: 
	cp index.html build/ 

copycss: 
	cp index.css build/ 

build/elm.js : modules.elm
	elm-make --output $@ $<

elmcompile : build/elm.js 


clean: 
	rm -rf build/*.*
