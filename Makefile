THIS_MAKEFILE := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
WORKSPACE_ROOT := $(dir $(abspath $(THIS_MAKEFILE)))
ENV_DIR := $(WORKSPACE_ROOT)env
.DEFAULT_GOAL := local

PY_TEST_FILES=$(wildcard test*.py)

clean-pyc:
	find . -type f -name '*.py[co]' -exec rm -f {} +
	find . -type f -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean: clean-pyc
	rm -rf env

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

.PHONY: all clean local
