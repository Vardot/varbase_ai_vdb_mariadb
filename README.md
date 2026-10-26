[![Varbase](https://raw.githubusercontent.com/Vardot/varbase/11.0.x/images/varbase-logo.png)](https://www.drupal.org/project/varbase)

# Varbase AI VDB: MariaDB
[![Varbase AI VDB: MariaDB](https://img.shields.io/badge/Varbase%20AI%20VDB%3A%20MariaDB-1.0.0--alpha1-0d6efc?labelColor=001d38&style=flat-square)](https://www.drupal.org/project/varbase_ai_vdb_mariadb)

A Drupal recipe that uses MariaDB's native `VECTOR` type as the vector database for AI Search on a
Varbase 11 site. The vectors live in the **site's own database**, with no extra service, or on a **separate
MariaDB server**.

## Documentation

Read the [Varbase AI VDB: MariaDB documentation](https://docs.varbase.vardot.com/developers/understanding-varbase/varbase-ai-recipes/varbase-ai-vdb-mariadb) on the Varbase docs site.

## Install and apply

```bash
# 1. Fetch the recipe.
ddev composer config --json extra.drupal-recipe-unpack.ignore '["drupal/varbase_ai_vdb_mariadb"]'
ddev composer require drupal/varbase_ai_vdb_mariadb:~1

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

## Automated testing

GitLab CI on [git.drupalcode.org](https://git.drupalcode.org/project/varbase_ai_vdb_mariadb) (`.gitlab-ci.yml`) builds
a Varbase 11 site, applies this recipe twice and runs the Varbase functional testing suite in `tests/` on it. See
[tests/README.md](tests/README.md) to run it against a site of your own.

## License

GPL-2.0-or-later. See [LICENSE](LICENSE). Maintained by [Vardot](https://www.vardot.com).
