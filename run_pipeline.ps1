Write-Host "Starting dbt pipeline..." -ForegroundColor Cyan

dbt debug
if ($LASTEXITCODE -ne 0) { throw "dbt debug failed" }

dbt source freshness
if ($LASTEXITCODE -ne 0) { throw "dbt source freshness failed" }

dbt build
if ($LASTEXITCODE -ne 0) { throw "dbt build failed" }

dbt docs generate
if ($LASTEXITCODE -ne 0) { throw "dbt docs generate failed" }

Write-Host "Pipeline completed successfully." -ForegroundColor Green