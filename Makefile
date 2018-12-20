run: build
	docker run -it \
	 					 -v ${PWD}/config:/etc/opendnssec/ \
						 --network=host \
	 					 ods-testbed

build:
	docker build -t ods-testbed .
