[![Varbase](https://raw.githubusercontent.com/Vardot/varbase/11.0.x/images/varbase-logo.png)](https://www.drupal.org/project/varbase)

# Varbase AI VDB: MariaDB
[![Varbase AI VDB: MariaDB](https://img.shields.io/badge/Varbase%20AI%20VDB%3A%20MariaDB-1.0.0--alpha1-0d6efc?labelColor=001d38&style=flat-square)](https://www.drupal.org/project/varbase_ai_vdb_mariadb)

A Drupal recipe that uses MariaDB's native `VECTOR` type as the vector database for AI Search on a
Varbase 11 site. The vectors live in the **site's own database**, with no extra service, or on a **separate
MariaDB server**.

It is one of three interchangeable vector database recipes for [Varbase AI Search](https://www.drupal.org/project/varbase_ai_search_base).
The other is [Milvus](https://www.drupal.org/project/varbase_ai_vdb_milvus).
MariaDB is the only one with a **stable** provider release.

There is **no custom PHP and no custom shell code** in the recipe. Its no-key checks run inline in CI, so the repository holds no PHP file at
all.

## What it adds

| Where | Change |
|---|---|
| Modules | Installs `ai`, `ai_search` and `ai_vdb_provider_mariadb`. |
| Provider settings | Sets `use_drupal_database` to true. A separate server set in `settings.php` still wins over it. |

It does **not** create a Search API server or index. That needs an embeddings model and belongs to
[Varbase AI Search](https://www.drupal.org/project/varbase_ai_search_base).

## Requirements

- Drupal core `^11.4`, Varbase 11
- [`drupal/ai`](https://www.drupal.org/project/ai) `^1.4`
- [`drupal/ai_vdb_provider_mariadb`](https://www.drupal.org/project/ai_vdb_provider_mariadb) `^1.0` (stable)
- [`drupal/search_api`](https://www.drupal.org/project/search_api) `^1.40`, which AI Search needs
- **MariaDB 11.7 or later** wherever the vectors live. DDEV with MariaDB 11.8 qualifies. The Varbase Upsun
  template runs MariaDB 10.11, which has no `VECTOR` type, until its database service is upgraded.

## Install and apply

```bash
# 1. Fetch the recipe.
ddev composer config --json extra.drupal-recipe-unpack.ignore '["drupal/varbase_ai_vdb_mariadb"]'
ddev composer require drupal/varbase_ai_vdb_mariadb:1.0.x-dev

# 2. Apply it. Rebuild caches before and after: Drupal does not see the new module or its plugin until it does.
ddev drush cr
ddev drush recipe ../recipes/varbase_ai_vdb_mariadb
ddev drush cr

# 3. The recipe makes MariaDB the site's default vector database, which Varbase AI Search reads, also over the
#    amazee.io default of Drupal CMS AI. Only 1.0.2 and earlier need this line.
ddev drush cset ai.settings default_vdb_provider mariadb -y

```

The ignore line keeps the recipe a locked
package: without it core's recipe-unpack plugin moves its requirements into the project's `composer.json` and
drops the recipe itself. Re-applying the recipe is safe.

Check the database version at `/admin/reports/status`: it shows *MariaDB Vector support: MariaDB 11.8.x, Vector
index available*.

## Use it with Varbase AI Search

Varbase AI Search names its vector database `varbase_ai_search`. For MariaDB that is a real database, which must
exist and be open to the site's user, or the provider fails with
`Access denied for user ... to database 'varbase_ai_search'`. On DDEV the root account is `root`/`root`:

```bash
ddev exec "mysql -hdb -uroot -proot -e \"CREATE DATABASE IF NOT EXISTS varbase_ai_search; GRANT ALL PRIVILEGES ON varbase_ai_search.* TO 'db'@'%'; FLUSH PRIVILEGES;\""
```

Elsewhere a database administrator does this.

## Where the vectors live

| | Local: DDEV | Remote: a separate MariaDB server | Remote: the Upsun database |
|---|---|---|---|
| Where | The site's own database | A server you run, reached over the network | The site's own database, on Upsun |
| Needs | MariaDB 11.7+ (DDEV: 11.8) | MariaDB 11.7+ and a database and user for the vectors | The database service upgraded to 11.8 |
| Configured by | Nothing: it is the default | `settings.php` (a recipe cannot write it) | Nothing, once the service is upgraded |
| Tested | Yes, and in CI | The connection path, against the DDEV `db` service | No |

### A separate MariaDB server

Use this when the vectors should not share the site's database, for example for a high volume of vector writes.

1. On the server, run **MariaDB 11.7 or later**. Create a database and a user with all privileges on it only.
2. Add this to `settings.php`, reading the values from the environment. A recipe cannot write `settings.php`, and
   the password must never be stored in configuration:

   ```php
   $config['ai_vdb_provider_mariadb.settings'] = [
     'use_drupal_database' => FALSE,
     'host' => getenv('VDB_MARIADB_HOST'),
     'port' => 3306,
     'username' => getenv('VDB_MARIADB_USER'),
     'password' => getenv('VDB_MARIADB_PASSWORD'),
     'database' => getenv('VDB_MARIADB_DATABASE'),
   ];
   ```

3. Apply the recipe as above, then check it with the database name as the last argument:

   ```bash
   ```

Before choosing this:

- The provider's settings are host, port, username, password and database. There is **no TLS option**, so keep
  the server on a private network.
- With a separate server, vector changes no longer roll back with entity changes (the module's own warning).
- The Status report only checks the site's own database for MariaDB 11.7, never the separate server.

### The Upsun database

The template's database service is `mariadb:10.11` in `.upsun/config.yaml` and `.platform/services.yaml`. Upsun
lists MariaDB 11.8 and allows upgrading straight to a higher version. **A downgrade permanently deletes the
data**, so back up first and treat the change as one way. Confirm the `VECTOR` type on an environment before
relying on it. Below 11.7 the Status report shows the vector line as an error, and creating a collection fails.

## Automated testing

GitLab CI on [git.drupalcode.org](https://git.drupalcode.org/project/varbase_ai_vdb_mariadb) (`.gitlab-ci.yml`) runs on every merge
request and every push to `1.0.x`, like the other Varbase AI recipes: `composer validate` and a lint of every YAML
file.

The functional tests in `tests/features` (Playwright and Cucumber through
[`@vardot/varbase-e2e`](https://www.npmjs.com/package/@vardot/varbase-e2e)) run against a site of your own:
`yarn install`, then `LAUNCH_URL=https://your-site.ddev.site yarn test`.

## Checked

In CI on every change, as above. By hand on 5 October 2026, against the `Vardot/platformsh-varbase` template
(Drupal 11.4.5, `drupal/ai` 1.4.7, PHP 8.4) with `ai_vdb_provider_mariadb` 1.0.1 on MariaDB 11.8.9 in DDEV:

- The recipe applies and applies again, and stores the expected settings.
- The recipe check passes.
- The separate-server path passes over TCP, against the DDEV `db` service, and a `settings.php` override takes
  precedence over stored configuration.

**Not checked:** a genuinely separate MariaDB server, anything on an Upsun environment, and indexing real
content, which needs an embeddings provider key.

## Known issues in the provider

- The "database" a Search API server names is a real MariaDB database that the site's user must be able to open
  (see [Use it with Varbase AI Search](#use-it-with-varbase-ai-search)).
- The version check is only a line on the Status report, and it looks at the site's own database. It does not
  stop an install or a collection from being created, and it never checks a separate server.
- `insertIntoCollection()` expects every field as `['value' => ..., 'is_multiple' => ...]`, because the provider
  builds them that way in its own `indexItems()`. The recipe check uses that shape.
- Once the provider is installed, saving a Search API index that has no server yet crashes with
  `Call to a member function getBackend() on null`. The `search_api_index_update` hook in 1.0.1 calls
  `$index->getServerInstance()->getBackend()` without checking for a server. The Drupal CMS Search recipe saves
  such an index while it sets up its keyword index, and Varbase Search Base applies that recipe. The recipe's
  rollback can then hide the error behind a `ReverseContainer::generateServiceIdHash()` TypeError. **Workaround:**
  apply Varbase Search Base before installing the provider. A Varbase site already has it applied. An upstream fix
  is pending.

## Related recipes

| Recipe | What it does |
|---|---|
| [Varbase AI Search](https://www.drupal.org/project/varbase_ai_search_base) | The vector index of the site's content, on the default vector database. |
| [Varbase AI Answers](https://www.drupal.org/project/varbase_ai_answers_base) | Ask AI: cited answers over that index. |
| [Varbase AI Chatbot Base](https://www.drupal.org/project/varbase_ai_chatbot_base) | A visitor chatbot over that index. |
| [Varbase AI VDB: Milvus](https://www.drupal.org/project/varbase_ai_vdb_milvus) | Milvus or Zilliz Cloud as the vector database. |

## License

GPL-2.0-or-later. See [LICENSE](LICENSE). Maintained by [Vardot](https://www.vardot.com).
