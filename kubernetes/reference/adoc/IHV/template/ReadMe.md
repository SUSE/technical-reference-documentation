
The inclusion of any of this content is based up AsciiDoc attributes during the output builds:
- IHV-Partner
- IHV-Partner-Family

A simple outline of what should be provided for a given partner and what level of content resides in each of the AsciiDoc snippets.

- Best practices
  - create variables for each proper noun that is associated with this partner and use this in the content to make it easy to substitute/adjust as needed
  - the ordering of the snippets is basically top-down (general to detailed), and can also be laterally scaled out for multiple models
    - BPBV
    - CompMod
    - Deployment-Hardware
  - also create (either family or model variants)
    - family_vars.adoc (collection of name/value pairs)
    - family.adoc (named to match their offering for expansion in the CompMod and to include respective family_vars.adoc file)
    - family_BOM.adoc (row entries to provide a bill of material for the respective model)

Refer to [../HPE]../HPE for more detailed content examples

