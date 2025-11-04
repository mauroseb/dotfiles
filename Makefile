SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

PACKAGES	:= go zsh git vim tmux keychain unrar htop ctags vim-enhanced
PACKAGES	+= ruby python3 bind-utils bash-completion xz tree strace

PKG_MGR := dnf
PKG_FLAGS := -q -e0 -y
ROOT := sudo -E

CURDIR := $(HOME)/dotfiles
CONFIGDIR := ~/.config
DOTFILES := .bashrc .bashrc.ansible .bashrc.git .bashrc.k8s .zshrc .tmux.conf .gdbinit .vimrc .vim .gitconfig

.PHONY: all
all: check pkgs bash zsh vim ssh tmux gdb git ## Install all dotfiles


.PHONY: check
check: ## Check package manager
	@which $(PKG_MGR) > /dev/null
	@echo "$(PKG_MGR) available";

.PHONY: bash
bash: ## Setup Bash
	for file in $(shell find $(CURDIR) -type f -name ".bash*" ); do \
		f=$$(basename $$file); \
		ln -sf $$file ~/$$f; \
	done

.PHONY: zsh
zsh: ## Setup zsh
	for file in $(shell find $(CURDIR) -type f -name ".zsh*" ); do \
		f=$$(basename $$file); \
		ln -sf $$file ~/$$f; \
	done

.PHONY: tmux
tmux: ## Setup tmux
	for file in $(CURDIR)/.tmux.conf; do \
		f=$$(basename $$file); \
		ln -sf $$file ~/$$f; \
	done

.PHONY: gdb
gdb: ## Setup GDB
	for file in $(CURDIR)/.gdbinit; do \
		f=$$(basename $$file); \
		ln -sf $$file ~/$$f; \
	done

.PHONY: pkgs
pkgs: ## Install Packages
	@echo "Installing Packages.";
	$(ROOT) $(PKG_MGR) $(PKG_FLAGS) install $(PACKAGES)

.PHONY: git
git: ## Setup Git
	for file in $(CURDIR)/.gitconfig ; do \
		f=$$(basename $$file); \
		ln -sf $$file ~/$$f; \
	done


.PHONY: ssh
ssh:
	/bin/true
	
.PHONY: vim
vim:
	@echo "Setting up vim.";
	for file in  $(CURDIR)/.vimrc $(CURDIR)/.vim ; do \
		f=$$(basename $$file); \
		ln -sf $$file ~/$$f; \
	done; \
	cd ~/dotfiles/.vim; \
	git submodule update --init --recursive; \
	git submodule status


.PHONY: unlink
unlink: ## Unlink all dot files from $HOME
	@echo "Unlinking dot files."
	@for f in $(DOTFILES); do if [ -h ~/$$f ]; then rm -i ~/$$f; fi ; done

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


