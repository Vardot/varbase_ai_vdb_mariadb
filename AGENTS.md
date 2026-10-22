# AGENTS.md

Guidance for AI coding agents working on the Varbase AI VDB: MariaDB recipe.

This is a **private** recipe on GitHub (`Vardot/varbase_ai_vdb_mariadb`), not a drupal.org project. Issues,
pull requests and CI all live on GitHub.

## Before you start

- **`CHANGELOG.md`**: what changed in each release, newest first. Read it before proposing a change.
- **Pull requests and their discussions** on
  [github.com/Vardot/varbase_ai_vdb_mariadb](https://github.com/Vardot/varbase_ai_vdb_mariadb/pulls): the
  reasoning behind recent changes.
- **Issues** on [github.com/Vardot/varbase_ai_vdb_mariadb/issues](https://github.com/Vardot/varbase_ai_vdb_mariadb/issues):
  the Problem/Motivation and Proposed resolution for each change.
- **`README.md`**: what was checked, what was not, and the known issues in the provider.

## When you make a change

- One issue and one pull request per change. The PR says `Closes #<issue>` and ends with the Checkpoints list
  from `.github/pull_request_template.md`.
- Add an entry under `## [Unreleased]` in `CHANGELOG.md`.
- CI must be green before merging: `.github/workflows/ci.yml` lints the repository, then applies the recipe on
  a real Drupal 11.4 site with MariaDB 11.8, applies it again and runs the no-key recipe check.
- No PHP in the repository at all: no `.php`, `.module`, `.install` or `.inc` file. The no-key checks run inline in
  `.github/workflows/ci.yml` (`drush php:eval`), and the lint job fails on any PHP file.
- Never store a password or token in configuration. A separate server is configured in `settings.php` from
  environment variables.
- Never bump the version or tag a release without explicit maintainer approval. Tags are three-segment
  (`1.0.0`) and are never moved once pushed.
