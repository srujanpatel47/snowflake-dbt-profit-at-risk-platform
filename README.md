## Free-Safe CI Mode

This repository uses a free-safe GitHub Actions workflow for public validation.

Because the Snowflake trial account may expire or warehouses may be suspended, the default CI workflow runs:

```bash
dbt parse