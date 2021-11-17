
Peer Review:
- Prep work
  - review [SUSE Documentation Style Guide](https://documentation.suse.com/style/current/single-html/docu_styleguide/index.html)
  - for Technical Reference Documentation (TRD), refer to the [TechnicalRefDocsVennDiagram](./media/src/png/TechnicalRefDocsVennDiagram.png) to get an overview of document type/scope/factors/flavors) and [adoc/SA-Glossary.adoc](./adoc/SA-Glossary.adoc)

- Suggested Approach ... for any of generated output in [build](./build)
  - use a viewing tool that allows annotations/comments to be saved
  - scan/read the entire document from start to finish, then
    - assume you are one of the roles listed in the Audience section, and revisit from beginning to end to
      - capture any of the following feedback, issues, suggestions for
        - each included hyperlink is working and is relevant content
        - spelling/punctuation/capitalization corrections
        - grammar, syntax, acronyms, unit measurements
        - relevance/completeness of advisory admonitions
          - warning/important/tip/note
        - ensure figures/tables are appropriate and sufficiently explained/used
        - look for and call-out any "FixMe" text/image flags
        - any perceived missing information that should be included
    - and, if possible, try the actual deployment commands to validate the process
  - then send your saved copy of the document plus your feedback to the author or to the respective repository contributors
