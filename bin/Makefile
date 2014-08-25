all: justrun hugo

justrun:
	GOPATH=`pwd` go get github.com/jmhodges/justrun
	mv bin/justrun .
	rm -rf src pkg bin

hugo:
	GOPATH=`pwd` go get github.com/spf13/hugo
	mv bin/hugo .
	rm -rf src pkg bin
