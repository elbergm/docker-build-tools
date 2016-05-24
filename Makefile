.PHONY: test build

test: $(wildcard spec/bats/*)
	for tag in $$(ls -1 docker-platforms); do \
	  docker run --rm  -ti -v $$(pwd)/spec:/spec  trinitronx/build-tools:$${tag} \
	    /bin/bash -c "git clone https://github.com/sstephenson/bats.git && cd bats && ./install.sh /usr/local && bats /spec/bats " ; \
	done

build: bin/docker-build
	./bin/docker-build