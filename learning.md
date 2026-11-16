# Databricks with dbt project

## Configure profiles.yml

在你的使用者資料夾下，找到 `.dbt` folder 會看到 `profiles.yml`
新增新的 profile

```yml
databricks:
  target: dev
  outputs:
    dev:
      type: databricks
      catalog: dev
      schema: default
      host: <your_databricks_host>
      http_path: <your_databricks_http_path>
      token: <your_databricks_token>
      threads: 4
    prod:
      type: databricks
      catalog: prod
      schema: default
      host: <your_databricks_host>
      http_path: <your_databricks_http_path>
      token: <your_databricks_token>
      threads: 4
```

我們已經先在 databricks 中建立了 dev, prod, raw catalog 了！

> 而每個 catalog 中，都有 `default` 的 schema（這裡我們先使用 `default` schema）

那如何找到 databricks 的 host, http_path 以及 token：

1. 進入 databricks 的介面後，可以在左手邊的 `SQL` section 中找到 `SQL Warehouses` 點選
2. 找到 `Serverless Starter Warehouse` 點擊進入
3. 在 tab 中找到 `Connection details`，可以看到
   1. Server hostname 此即為你的 host
   2. HTTP path 為你的 http_path
4. Token 的話則移到右上角，點選你的頭貼，找到 `Settings`
5. 在 `User` 端找到 `Developer`
6. 在 Access Token 的地方點選 `Manage`
7. Generate new token 且 `Scopes` 選擇 `SQL`
8. 最後把 token 複製起來，完成！

## dbt command

透過 project-name 指定專案名稱；profile 指定 profiles.yml 中設定好的 profile

```bash
dbt init --project-name analytics --profile databricks
```

如果想要查詢 databricks 裡面的 table 可以透過

```bash
dbt show --inline "SELECT COUNT(*) FROM raw.jobs.raw_job_postings"
```

```bash
dbt compile --inline "SELECT {{ slugify('Paid Time Off') }}"
```