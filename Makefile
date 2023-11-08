# Makefile to run ansible playbooks locally (on Jenkins) 
# and template the mountpoint variable files
TARGETS := dest/all.yml

.PHONY: deps all help clean cleandeps


help:
	@echo "Template playbooks:"
	@(for T in $(TARGETS); do echo "$$T"; done)
	@echo

deps:
	python -m venv ./ansible
	. ./ansible/bin/activate; pip install -r requirements.txt
	

all: deps $(TARGETS)

$(TARGETS):
	$(info Templating $@)
	ansible-playbook -i [localhost,] $(notdir $@)

clean:
	rm -f $(TARGETS); \

cleandeps:
	rm -rf ansible; \
    find -iname "*.pyc" -delete
