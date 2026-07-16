# dotfiles

This project automates the installation and configuration of development tools, ensuring a consistent and reproducible environment across different machines.

## 📋 Prerequisites

- **Python 3.12+** installed on the system ([download here](https://www.python.org/downloads/))
- **make** (usually pre-installed on macOS and Linux)
- Administrative access (sudo) for package installationx

## 🚀 Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/your-username/dotfiles.git
cd dotfiles
```

### 2. Initialize the environment

```bash
make init
```

This command will:
- Create a Python virtual environment
- Install Ansible and development tools (ansible-lint, yamllint)
- Isolate dependencies from your system Python

### 3. Edit your personal settings

```bash
make vault-edit
```

Add your sensitive information such as:
- API tokens
- Passwords
- Private keys
- Other credentials

### 4. Run the configuration

```bash
make run
```

You'll be prompted for the vault password you created earlier.

## 📁 Project Structure

```
dotfiles/
├── Makefile                   # Automation commands
├── inventory.ini              # Ansible hosts (localhost)
├── main.yml                   # Main playbook
├── roles/                     # Directory for your custom roles
├── group_vars/                # Centralized variables
│   └── all/
│       ├── main.yml           # Public variables
│       └── vault.yml          # Secret variables (encrypted)
├── venv/                      # Virtual environment (auto-created)
└── README.md                  # This file
```

## 🛠️ Available Commands

| Command | Description |
|---------|-------------|
| `make help` | List all available commands |
| `make init` | Create virtualenv and install Ansible |
| `make run` | Run the main playbook |
| `make vault-create` | Create encrypted credentials file |
| `make vault-edit` | Edit credentials file |
| `make lint` | Check code quality |
| `make clean` | Remove virtualenv and temporary files |

## 🔧 Customization

### Creating your first role

1. Create a new role directory in `roles/your-role-name/`
2. Add the standard Ansible role structure:
   ```
   roles/your-role-name/
   ├── tasks/main.yml      # Main tasks for the role
   ├── defaults/main.yml   # Default variables
   ├── templates/          # Jinja2 templates
   └── files/              # Static files
   ```
3. Add the role to `main.yml`:
   ```yaml
   roles:
     - role: your-role-name
       tags: ['your-tag']
   ```

### Configuration variables

- **Public variables**: Edit `group_vars/all/main.yml`
- **Secret variables**: Use `make vault-edit` to edit `group_vars/all/vault.yml`

## 🔐 Security

### Ansible Vault

All sensitive information is stored encrypted using Ansible Vault:

- **Never** commit the decrypted `vault.yml` file
- Use a strong password for the vault
- Keep the vault password in a secure password manager
- The `.gitignore` file is already configured to ignore temporary files

### Best practices

1. Always use `make vault-edit` to edit credentials
2. Never store passwords in plain text
3. Review changes before running the playbook
4. Keep backups of your configurations

## 🏷️ Available Tags

Run only specific parts of the configuration using tags:

```bash
# Run specific role by tag
playbook -i inventory.ini main.yml --tags your-tag --ask-vault-pass

# Run multiple roles by tags
playbook -i inventory.ini main.yml --tags "tag1,tag2" --ask-vault-pass
```

## 📚 Additional Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
- [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

## 📄 License

This project is under the MIT license. See the [LICENSE](LICENSE) file for more details.
