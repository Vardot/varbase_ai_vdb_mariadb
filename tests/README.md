# Varbase functional testing suite

Playwright and Cucumber through [`@vardot/varbase-e2e`](https://www.npmjs.com/package/@vardot/varbase-e2e), on a
Varbase 11 site with this recipe applied.

| Feature | Covers |
| --- | --- |
| `01-01-ai-vdb-mariadb-provider.feature` | The MariaDB provider on the site's own database, made the default vector database, and the status report check |
| `01-02-ai-vdb-mariadb-access.feature` | Only the webmaster sees the vector database settings |

The default provider choice are named selectors in `tests/selectors/ai-vdb-mariadb-selectors.json`.

## Run it

```bash
npm install
LAUNCH_URL=https://your-site.ddev.site npm test
```

The site needs the webmaster (`webmaster`) and one user per role, named after the role (`content_editor`,
`content_admin`, `seo_admin`, `site_admin`), all with the password in `LOGIN_PASS` (default `dD.123123ddd`).
`.gitlab-ci.yml` shows the whole setup.

## AI provider

The suite needs no AI provider and no key.
