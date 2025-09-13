# automatizare-si-scripting

Acest repository contine script-uri de automatizare si scripting pentru macOS scrise in Bash.

## Scripts

### cleanup.sh

Elimina fisiere temporare dintr-un director specificat.

**Usage:**

```bash
./cleanup.sh <directory> [extensions...]
```

**Arguments:**

- `directory` - Necesar. Calea catre directorul care trebuie curatat
- `extensions` - Optional. Extensiile de fisiere care trebuie eliminate (implicit: .tmp)

**Examples:**

```bash
./cleanup.sh /tmp
./cleanup.sh /var/log .log .bak
./cleanup.sh ~/Downloads tmp log
```

Scriptul valideaza existenta directorului si raporteaza numarul de fisiere eliminate.
