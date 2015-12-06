all: clean copyhtml copyimages elmcompile 

copyimages: 
	cp *.jpg build/ 

copyhtml: 
	cp index.html build/ 

build/elm.js : cv.elm styles.elm
	elm-make --output $@ $<

elmcompile : build/elm.js 


clean: 

