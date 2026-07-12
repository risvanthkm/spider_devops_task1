## Before Fixing

```
Report Summary

┌───────────────────────────────────────────────────────┬──────────┬─────────────────┬─────────┐
│                        Target                         │   Type   │ Vulnerabilities │ Secrets │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ risvanthkm/devops-task-backend:latest (alpine 3.24.1) │  alpine  │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ app/server                                            │ gobinary │       20        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/bin/go                                   │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/bin/gofmt                                │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/asm                 │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/cgo                 │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/compile             │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/cover               │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/link                │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/preprofile          │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/vet                 │ gobinary │        0        │    -    │
└───────────────────────────────────────────────────────┴──────────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)


app/server (gobinary)

Total: 20 (UNKNOWN: 1, LOW: 1, MEDIUM: 6, HIGH: 10, CRITICAL: 2)

┌─────────────────────────┬────────────────┬──────────┬──────────┬───────────────────┬───────────────┬──────────────────────────────────────────────────────────────┐
│         Library         │ Vulnerability  │ Severity │  Status  │ Installed Version │ Fixed Version │                            Title                             │
├─────────────────────────┼────────────────┼──────────┼──────────┼───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ github.com/jackc/pgx/v5 │ CVE-2026-33815 │ CRITICAL │ fixed    │ v5.7.5            │ 5.9.0         │ github.com/jackc/pgx/v5: github.com/jackc/pgx: Memory-safety │
│                         │                │          │          │                   │               │ vulnerability                                                │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-33815                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-33816 │          │          │                   │               │ github.com/jackc/pgx/v5: github.com/jackc/pgx: Memory-safety │
│                         │                │          │          │                   │               │ vulnerability                                                │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-33816                   │
│                         ├────────────────┼──────────┤          │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-41889 │ LOW      │          │                   │ 5.9.2         │ github.com/jackc/pgx: golang: pgx: SQL injection via         │
│                         │                │          │          │                   │               │ specific SQL query conditions                                │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-41889                   │
├─────────────────────────┼────────────────┼──────────┤          ├───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ golang.org/x/crypto     │ CVE-2025-47913 │ HIGH     │          │ v0.37.0           │ 0.43.0        │ golang.org/x/crypto/ssh/agent:                               │
│                         │                │          │          │                   │               │ golang.org/x/crypto/ssh/agent: SSH client panic due to       │
│                         │                │          │          │                   │               │ unexpected SSH_AGENT_SUCCESS                                 │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2025-47913                   │
│                         ├────────────────┤          │          │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-39828 │          │          │                   │ 0.52.0        │ golang.org/x/crypto/ssh: golang.org/x/crypto/ssh:            │
│                         │                │          │          │                   │               │ Unauthorized command execution via discarded SSH permissions │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-39828                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-39829 │          │          │                   │               │ golang.org/x/crypto/ssh: golang.org/x/crypto/ssh: Denial of  │
│                         │                │          │          │                   │               │ Service via crafted public key with excessive parameters...  │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-39829                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-39830 │          │          │                   │               │ golang.org/x/crypto/ssh: golang.org/x/crypto/ssh: Denial of  │
│                         │                │          │          │                   │               │ Service via resource leak from unsolicited SSH responses...  │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-39830                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-39831 │          │          │                   │               │ golang.org/x/crypto/ssh: golang.org/x/crypto/ssh: Security   │
│                         │                │          │          │                   │               │ key bypass due to missing user presence check                │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-39831                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-39832 │          │          │                   │               │ golang.org/x/crypto/ssh/agent:                               │
│                         │                │          │          │                   │               │ golang.org/x/crypto/ssh/agent: Security bypass due to        │
│                         │                │          │          │                   │               │ improper handling of key restrictions                        │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-39832                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-39835 │          │          │                   │               │ golang.org/x/crypto/ssh: golang: golang.org/x/crypto/ssh:    │
│                         │                │          │          │                   │               │ Denial of Service via crafted SSH certificate                │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-39835                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-42508 │          │          │                   │               │ golang.org/x/crypto/ssh/knownhosts: golang:                  │
│                         │                │          │          │                   │               │ golang.org/x/crypto/ssh/knownhosts: Revocation bypass via    │
│                         │                │          │          │                   │               │ unchecked SignatureKey                                       │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-42508                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-46595 │          │          │                   │               │ golang.org/x/crypto/ssh: golang.org/x/crypto/ssh:            │
│                         │                │          │          │                   │               │ Authorization bypass due to skipped source-address           │
│                         │                │          │          │                   │               │ validation                                                   │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-46595                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-46597 │          │          │                   │               │ golang.org/x/crypto/ssh: golang.org/x/crypto/ssh: Denial of  │
│                         │                │          │          │                   │               │ Service via crafted AES-GCM packet decoder inputs            │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-46597                   │
│                         ├────────────────┼──────────┤          │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│                         │ CVE-2025-47914 │ MEDIUM   │          │                   │ 0.45.0        │ golang.org/x/crypto/ssh/agent: SSH Agent servers: Denial of  │
│                         │                │          │          │                   │               │ Service due to malformed messages                            │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2025-47914                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2025-58181 │          │          │                   │               │ golang.org/x/crypto/ssh: golang.org/x/crypto/ssh: Denial of  │
│                         │                │          │          │                   │               │ Service via unbounded memory consumption in GSSAPI           │
│                         │                │          │          │                   │               │ authentication...                                            │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2025-58181                   │
│                         ├────────────────┤          │          │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-39827 │          │          │                   │ 0.52.0        │ golang.org/x/crypto/ssh: golang: golang.org/x/crypto/ssh:    │
│                         │                │          │          │                   │               │ Denial of Service via repeated rejected channel openings     │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-39827                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-39833 │          │          │                   │               │ golang.org/x/crypto/ssh/agent:                               │
│                         │                │          │          │                   │               │ golang.org/x/crypto/ssh/agent: Security bypass due to        │
│                         │                │          │          │                   │               │ unenforced key confirmation                                  │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-39833                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-39834 │          │          │                   │               │ golang.org/x/crypto/ssh: golang: golang.org/x/crypto/ssh:    │
│                         │                │          │          │                   │               │ Denial of Service due to integer overflow in SSH...          │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-39834                   │
│                         ├────────────────┤          │          │                   │               ├──────────────────────────────────────────────────────────────┤
│                         │ CVE-2026-46598 │          │          │                   │               │ golang.org/x/crypto/ssh/agent: golang:                       │
│                         │                │          │          │                   │               │ golang.org/x/crypto/ssh/agent: Denial of Service via         │
│                         │                │          │          │                   │               │ malformed input                                              │
│                         │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2026-46598                   │
│                         ├────────────────┼──────────┼──────────┤                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│                         │ GO-2026-5932   │ UNKNOWN  │ affected │                   │               │ The golang.org/x/crypto/openpgp package is unmaintained,     │
│                         │                │          │          │                   │               │ unsafe by design, and has known security...                  │
└─────────────────────────┴────────────────┴──────────┴──────────┴───────────────────┴───────────────┴──────────────────────────────────────────────────────────────┘

📣 Notices:
  - Version 0.72.0 of Trivy is now available, current version is 0.71.2

To suppress version checks, run Trivy scans with the --skip-version-check flag
```

## After Fixing 
> Fixed the vulnerabilities by updating the Postgres Driver to the latest version

``` bash
otus@otus:~/Documents/DevOps/SPIDER_DEVOPS/SPIDER_DEVOPS_TASK1/spider_devops_task1/DevOPS_Task1/backend$ go get github.com/jackc/pgx/v5@latest
go mod tidy
go: downloading github.com/jackc/pgx/v5 v5.10.0
go: downloading github.com/jackc/pgx v3.6.2+incompatible
go: downloading golang.org/x/text v0.29.0
go: downloading github.com/stretchr/testify v1.11.1
go: downloading golang.org/x/sync v0.17.0
go: upgraded github.com/jackc/pgx/v5 v5.7.5 => v5.10.0
go: upgraded golang.org/x/sync v0.13.0 => v0.17.0
go: upgraded golang.org/x/text v0.24.0 => v0.29.0
```

```
Report Summary

┌───────────────────────────────────────────────────────┬──────────┬─────────────────┬─────────┐
│                        Target                         │   Type   │ Vulnerabilities │ Secrets │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ risvanthkm/devops-task-backend:latest (alpine 3.24.1) │  alpine  │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ app/server                                            │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/bin/go                                   │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/bin/gofmt                                │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/asm                 │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/cgo                 │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/compile             │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/cover               │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/link                │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/preprofile          │ gobinary │        0        │    -    │
├───────────────────────────────────────────────────────┼──────────┼─────────────────┼─────────┤
│ usr/local/go/pkg/tool/linux_amd64/vet                 │ gobinary │        0        │    -    │
└───────────────────────────────────────────────────────┴──────────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)


📣 Notices:
  - Version 0.72.0 of Trivy is now available, current version is 0.71.2

To suppress version checks, run Trivy scans with the --skip-version-check flag

```

