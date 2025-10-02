# IW01

Acest folder contine scripturi de automatizare si scripting scrise in Bash, specifice pentru IW01.

### cleanup.sh

Script pentru eliminarea fisierelor temporare dintr-un director specificat.

**Utilizare:**

```bash
./cleanup.sh <directory> [extensions...]
```

**Argumente:**

- `directory` - Necesar. Calea catre directorul care trebuie curatat
- `extensions` - Optional. Extensiile de fisiere care trebuie eliminate (implicit: .tmp)
 