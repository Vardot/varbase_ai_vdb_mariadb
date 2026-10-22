# AGENTS.md

Guidance for AI coding agents working on the Varbase AI VDB: MariaDB recipe.

This is a drupal.org project: [drupal.org/project/varbase_ai_vdb_mariadb](https://www.drupal.org/project/varbase_ai_vdb_mariadb).
Issues live in its [issue queue](https://www.drupal.org/project/issues/varbase_ai_vdb_mariadb) and merge requests on
[git.drupalcode.org](https://git.drupalcode.org/project/varbase_ai_vdb_mariadb). Its default branch is `1.0.x`; the
GitHub repository is a mirror and takes no issues or pull requests.

## Before you start

- **`CHANGELOG.md`**: what changed in each release, newest first. Read it before proposing a change.
- **Issues and merge requests** on drupal.org: the Problem/Motivation, Proposed resolution and the reasoning
  behind recent changes.
- **`README.md`**: what was checked, what was not, and the known issues in the provider.

## When you make a change

- One drupal.org issue and one issue-fork merge request per change, titled `<type>: #<issue> Summary`. The MR
  description ends with the Checkpoints list from `.gitlab/merge_request_templates/default.md`.
- CI must be green before merging: `.gitlab-ci.yml` on git.drupalcode.org validates `composer.json` and lints
  every YAML file.
- No PHP in the repository at all: no `.php`, `.module`, `.install` or `.inc` file.
- Add an entry under `## [Unreleased]` in `CHANGELOG.md`.
- Never store a password or token in configuration. A separate server is configured in `settings.php` from
  environment variables.
- Never bump the version or tag a release without explicit maintainer approval. Tags are three-segment
  (`1.0.0`) and are never moved once pushed.
