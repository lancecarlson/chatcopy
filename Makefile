all: shards build

shards:
	shards install

build:
	crystal build src/cli.cr -o chatcopy # TODO: linux -> --static

install:
	cp chatcopy /usr/local/bin # TODO: PREFIX