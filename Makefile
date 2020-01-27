.PHONY: help prepare-dev test run

VENV_NAME?=venv
VENV_ACTIVATE=. $(VENV_NAME)/bin/activate
PYTHON=${VENV_NAME}/bin/python3
PIP=${VENV_NAME}/bin/pip

.DEFAULT: help

help:
	@echo "make prepare-dev"
	@echo "       prepare development environment, use only once"
	@echo "make clean"
	@echo "       clean project"
	@echo "make run"
	@echo "       run project"
	@echo "make build"
	@echo "       builds docker image"

clean:
	rm -rf $(VENV_NAME)

prepare-dev:
	#sudo apt-get -y install python3.5 python3-pip
	python3 -m pip install virtualenv
	make venv

# Requirements are in setup.py, so whenever setup.py is changed, re-run installation of dependencies.
venv: $(VENV_NAME)/bin/activate

$(VENV_NAME)/bin/activate:
	test -d $(VENV_NAME) || virtualenv -p python3 $(VENV_NAME)
	${PYTHON} -m pip install -U pip
	${PYTHON} -m pip install kubernetes
	touch $(VENV_NAME)/bin/activate

run: venv
	${PYTHON} main.py

build:
	docker build -t py-k8s-utils:local .
