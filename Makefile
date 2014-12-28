build: fetch compile

fetch:
	ruby fetch.rb

compile:
	ruby build.rb

cp:
	cp build/* ../jsonschema-schema.org
