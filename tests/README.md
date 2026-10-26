# Varbase functional testing suite

Playwright and Cucumber through [`@vardot/varbase-e2e`](https://www.npmjs.com/package/@vardot/varbase-e2e), on a
Varbase 11 site with this recipe applied.

| Feature | Covers |
| --- | --- |
| `01-01-ai-vdb-mariadb-provider.feature` | The webmaster sees the site's own database is ready to store vectors, on the provider page and the status report |
| `01-02-ai-vdb-mariadb-access.feature` | Only the webmaster sees the database connection |
| `01-03-ai-vdb-mariadb-accessibility.feature` | The provider page gives every field a label and every link a name |

## Run it

```bash
npm install
LAUNCH_URL=https://your-site.ddev.site npm test
```

The site needs the webmaster (`webmaster`) and one user per role, named after the role (`content_editor`,
`content_admin`, `seo_admin`, `site_admin`), all with the password in `LOGIN_PASS` (default `dD.123123ddd`).
`.gitlab-ci.yml` shows the whole setup.

## AI provider

CI applies Drupal CMS AI before the recipe. It sets up an amazee.ai trial as the default provider, so no key
is needed. CI runs MariaDB 11.8, which supports vectors.

The provider page is held to the field label, link name and ARIA role checks rather than the full serious gate: its credit links
are smaller than the target size, which comes from the provider module, not this recipe.
