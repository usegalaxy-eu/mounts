# Makefile to run ansible playbooks locally (on Jenkins) 
# and template the mountpoint variable files
TARGETS := dest/all.yml dest/vgcn-mounts.yml dest/destinations.yml

.PHONY: deps all help clean


help:
	@echo "Template playbooks:"
	@(for T in $(TARGETS); do echo "$$T"; done)
	@echo

deps:
	python -m venv ./ansible
	. ./ansible/bin/activate; pip install -r requirements.txt
	

all: deps $(TARGETS)

$(TARGETS): deps
	$(info Templating $@)
	. ./ansible/bin/activate; ansible-playbook -i [localhost,] $(notdir $@)

clean:
	rm -f $(TARGETS); \
	rm -rf ansible; \
    find -iname "*.pyc" -delete
