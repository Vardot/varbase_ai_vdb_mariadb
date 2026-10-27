# Changelog

All notable changes to the Varbase AI VDB: MariaDB recipe are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0-beta1] - 2026-10-27
### Added
- Automated functional acceptance tests for the MariaDB vector database setup and accessibility, run in CI on a fresh Varbase 11 site ([#3633129](https://www.drupal.org/i/3633129)).

### Changed
- Move the documentation to docs.varbase.vardot.com ([#3633026](https://www.drupal.org/i/3633026)).
- Install the Varbase Starter dev line in CI, which carries the search view fix for Drupal CMS Search 2.2.7.
- Update the version badge to `1.0.0-beta1` in `README.md`.

## [1.0.0-alpha1] - 2026-10-24
### Added
- Initialize Varbase AI VDB: MariaDB recipe ([#3632422](https://www.drupal.org/i/3632422)).
### Removed
- The GitHub Actions workflows and the `.github` templates: CI runs on git.drupalcode.org.

[Unreleased]: https://git.drupalcode.org/project/varbase_ai_vdb_mariadb/-/compare/1.0.0-beta1...1.0.x
[1.0.0-beta1]: https://git.drupalcode.org/project/varbase_ai_vdb_mariadb/-/compare/1.0.0-alpha1...1.0.0-beta1
[1.0.0-alpha1]: https://git.drupalcode.org/project/varbase_ai_vdb_mariadb/-/tags/1.0.0-alpha1
