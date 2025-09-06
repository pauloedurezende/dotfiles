# Ansible Dotfiles Makefile
# Command manager for personal configuration automation

# Variables
VENV_DIR := venv
PYTHON := python3
PIP := $(VENV_DIR)/bin/pip
ANSIBLE := $(VENV_DIR)/bin/ansible
ANSIBLE_PLAYBOOK := $(VENV_DIR)/bin/ansible-playbook
ANSIBLE_VAULT := $(VENV_DIR)/bin/ansible-vault
ANSIBLE_LINT := $(VENV_DIR)/bin/ansible-lint
YAMLLINT := $(VENV_DIR)/bin/yamllint
VAULT_FILE := group_vars/all/vault.yml
PLAYBOOK := main.yml
INVENTORY := inventory.ini

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

# PHONY targets
.PHONY: help init run vault-edit vault-rekey clean lint check-venv

# Default target
.DEFAULT_GOAL := help

# Help - List all available commands
help:
	@echo "$(BLUE)=== Ansible Dotfiles - Available Commands ===$(NC)"
	@echo ""
	@echo "$(GREEN)make init$(NC)         - Create virtualenv and install Ansible"
	@echo "$(GREEN)make run$(NC)          - Run main playbook (prompts for vault password)"
	@echo "$(GREEN)make run TAGS=tag$(NC) - Run playbook with specific tags"
	@echo "$(GREEN)make vault-edit$(NC)   - Edit vault file"
	@echo "$(GREEN)make vault-rekey$(NC)  - Change vault password"
	@echo "$(GREEN)make lint$(NC)         - Run linters (ansible-lint and yamllint)"
	@echo "$(GREEN)make clean$(NC)        - Remove virtualenv and temporary files"
	@echo ""
	@echo "$(YELLOW)Workflow:$(NC)"
	@echo "  1. $(BLUE)make init$(NC)         # Install Ansible in virtualenv"
	@echo "  2. $(BLUE)make vault-edit$(NC)   # Edit vault with your secrets"
	@echo "  3. $(BLUE)make run$(NC)          # Run configurations"
	@echo ""
	@echo "$(YELLOW)Available tags:$(NC)"
	@echo "  - $(BLUE)system$(NC)           # OS detection and system setup"
	@echo "  - $(BLUE)homebrew$(NC)         # Install and configure Homebrew"
	@echo "  - $(BLUE)package-managers$(NC) # All package managers"

# Initialize - Create virtualenv and install dependencies
init:
	@echo "$(BLUE)[*] Creating virtual environment...$(NC)"
	@$(PYTHON) -m venv $(VENV_DIR)
	@echo "$(BLUE)[*] Installing Ansible and tools...$(NC)"
	@$(PIP) install --upgrade pip
	@$(PIP) install ansible ansible-lint yamllint
	@echo "$(GREEN)[✓] Environment setup complete!$(NC)"
	@echo ""
	@echo "$(YELLOW)Next step: $(BLUE)make vault-edit$(NC) (add your secrets)"

# Check if virtualenv exists
check-venv:
	@if [ ! -d $(VENV_DIR) ]; then \
		echo "$(RED)[!] Virtual environment not found!$(NC)"; \
		echo "$(YELLOW)Run 'make init' first.$(NC)"; \
		exit 1; \
	fi

# Run the main playbook
run: check-venv
	@echo "$(BLUE)[*] Running Ansible playbook...$(NC)"
ifdef TAGS
	@$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $(PLAYBOOK) --ask-vault-pass --ask-become-pass --tags "$(TAGS)"
else
	@$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $(PLAYBOOK) --ask-vault-pass --ask-become-pass
endif
	@echo "$(GREEN)[✓] Playbook executed successfully!$(NC)"

# Edit vault file
vault-edit: check-venv
	@if [ ! -f $(VAULT_FILE) ]; then \
		echo "$(RED)[!] Vault file doesn't exist!$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)[*] Opening vault file for editing...$(NC)"
	@$(ANSIBLE_VAULT) edit $(VAULT_FILE)
	@echo "$(GREEN)[✓] Vault file updated!$(NC)"

# Change vault password
vault-rekey: check-venv
	@if [ ! -f $(VAULT_FILE) ]; then \
		echo "$(RED)[!] Vault file doesn't exist!$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)[*] Changing vault password...$(NC)"
	@echo "$(YELLOW)You'll be prompted for the current password, then the new one.$(NC)"
	@$(ANSIBLE_VAULT) rekey $(VAULT_FILE)
	@echo "$(GREEN)[✓] Vault password changed successfully!$(NC)"

# Run linters
lint: check-venv
	@echo "$(BLUE)[*] Running ansible-lint...$(NC)"
	@$(ANSIBLE_LINT) $(PLAYBOOK) || true
	@echo ""
	@echo "$(BLUE)[*] Running yamllint...$(NC)"
	@find . -name "*.yml" -o -name "*.yaml" | grep -v venv/ | xargs $(YAMLLINT) || true
	@echo "$(GREEN)[✓] Linting complete!$(NC)"

# Clean the environment
clean:
	@echo "$(BLUE)[*] Removing virtual environment...$(NC)"
	@rm -rf $(VENV_DIR)
	@echo "$(BLUE)[*] Removing temporary files...$(NC)"
	@find . -type f -name "*.pyc" -delete
	@find . -type d -name "__pycache__" -delete
	@echo "$(GREEN)[✓] Cleanup complete!$(NC)"
