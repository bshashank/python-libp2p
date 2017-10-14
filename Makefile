THIS_MAKEFILE := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
WORKSPACE_ROOT := $(dir $(abspath $(THIS_MAKEFILE)))
ENV_DIR := $(WORKSPACE_ROOT)env
.DEFAULT_GOAL := local

USER := $(USER)

PY_TEST_FILES=$(wildcard test*.py)

clean:
	@find . -type f -name '*.py[co]' -exec rm -f {} \;
	@rm -rf env

$(ENV_DIR):
	@echo "++    Creating new virtual environment..."
	/usr/bin/virtualenv \
		--unzip-setuptools \
		--python=/usr/bin/python3 \
		$(ENV_DIR)

	@echo "++    Upgrade pip to the latest version..."
	$(ENV_DIR)/bin/python -m pip install --upgrade pip
	@echo "++    Virtual env ready."

local: $(ENV_DIR)
	@echo "++    Installing bits from pip..."
	$(ENV_DIR)/bin/pip install --upgrade \
	  --quiet --requirement=requirements.txt
	@echo "++    Dependencies ready."
	@echo "++    Please run:"
	@echo	"source $(ENV_DIR)/bin/activate"
	@echo "++    to activate your environment, happy hacking!"

test: $(PY_TEST_FILES)
	@echo Running tests
	python3 -m unittest discover \
	--verbose \
	--buffer \
	--pattern 'test*.py' \
	--start-directory $(WORKSPACE_ROOT)

dev-web:
# Run the web service locally
	docker run \
		--env LOCAL_BUILD_CONFIG=/service/config/build-global-config.yaml \
		--env USER=$(USER) \
		--volume /build/apps:/build/apps \
		--volume /build/toolchain/noarch:/build/toolchain/noarch \
		--volume $(LOCAL_CONFIG):/service/config/build-global-config.yaml \
		--workdir /service/machineforge \
	 	-p 127.0.0.1:8081:8081 \
	sbharadwaj/python36 \
	/usr/local/bin/python3 manage.py runserver 0.0.0.0:8081

dev-celery:
# Run the web service locally
	docker run \
		--env LOCAL_BUILD_CONFIG=/service/config/build-global-config.yaml \
		--env USER=$(USER) \
		--volume /build/apps:/build/apps \
		--volume /build/toolchain/noarch:/build/toolchain/noarch \
		--volume $(LOCAL_CONFIG):/service/config/build-global-config.yaml \
		--workdir /service/machineforge \
	 	-p 127.0.0.1:8081:8081 \
		--env C_FORCE_ROOT=1 \
	sbharadwaj/python36 \
	/usr/local/bin/celery worker -A machineforge --loglevel=DEBUG

docker-test:
	docker run -it \
		--env LOCAL_BUILD_CONFIG=/service/config/build-global-config.yaml \
		--env USER=$(USER) \
		--volume /build/apps:/build/apps \
		--volume /build/toolchain/noarch:/build/toolchain/noarch \
		--volume $(LOCAL_CONFIG):/service/config/build-global-config.yaml \
		--workdir /service/machineforge \
		--entrypoint /bin/bash \
	sbharadwaj/python36

all: local

.PHONY: all clean local
