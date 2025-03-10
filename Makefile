.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:


tools:
	@docker run \
		--rm \
		--interactive \
		--tty \
		--network host \
		--volume "/var/run/docker.sock:/var/run/docker.sock" \
		--volume $(shell pwd):$(shell pwd) \
		--volume ${HOME}/.ssh:/root/.ssh \
		--workdir $(shell pwd) \
		nixos/nix nix-shell


ansible:
	ansible-playbook -i inventory.yml deploylxcnix.yml --ask-pass

