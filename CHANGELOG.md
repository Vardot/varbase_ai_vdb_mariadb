# Changelog

All notable changes to the Varbase AI VDB: MariaDB recipe are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- The recipe sets `ai.settings` `default_vdb_provider` to `mariadb`, so indexing works on Drupal CMS, whose AI recipe
  makes amazee.io the default (#8).

## [1.0.2] - 2026-10-12
### Changed
- Removed `tests/verify.php`: the repository now holds no PHP file. CI runs the same no-key checks inline
  (`drush php:eval` in `.github/workflows/ci.yml`), and the lint job fails on any `.php`, `.module`, `.install` or
  `.inc` file (#7).

### Checked
- CI on 1.0.x (https://github.com/Vardot/varbase_ai_vdb_mariadb/actions/runs/38238518507): the lint job found no PHP file, the recipe applied twice, the inline
  check printed `RESULT: PASS` and the functional tests passed.

## [1.0.1] - 2026-10-11
### Added
- Functional tests in `tests/features`, run in CI after `tests/verify.php`: Playwright and Cucumber
  through `@vardot/varbase-e2e`, in Chromium, against the site CI builds. They check the admin pages the
  recipe sets up and that anonymous visitors cannot reach them.
### Changed
- README: link to the renamed Varbase AI Search Base and Varbase AI Answers Base repositories. No change
  to the recipe.

## [1.0.0] - 2026-10-08
### Added
- The recipe: installs AI, AI Search and the MariaDB VDB provider, and keeps the provider on the Drupal
  database connection (`use_drupal_database: true`).
- `tests/verify.php`: an end-to-end check of the provider that needs no AI key.
- GitHub Actions CI: lint, then a Drupal 11.4 site on MariaDB 11.8 that applies the recipe, applies it again
  and runs `tests/verify.php`.
- README in the Varbase AI recipe style, `AGENTS.md`, `LICENSE`, `logo.png`, composer metadata, and the Vardot
  issue and pull request templates.

### Fixed
- Require `drupal/search_api`. The recipe installs AI Search, which needs it, so on a site without Search API
  the apply stopped with "The following extensions are missing". Found by the new CI.

[Unreleased]: https://github.com/Vardot/varbase_ai_vdb_mariadb/compare/1.0.2...1.0.x
[1.0.2]: https://github.com/Vardot/varbase_ai_vdb_mariadb/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/Vardot/varbase_ai_vdb_mariadb/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/Vardot/varbase_ai_vdb_mariadb/releases/tag/1.0.0
