# SUSE Technical Reference Documentation
Getting Started Guides - How to Contribute


## Introduction

[SUSE Technical Reference Documentation (SUSE TRD)](https://documentation.suse.com/trd-supported.html) is part of the [SUSE Documentation](https://documentation.suse.com/) ecosystem with the objective of providing well-structured, clear, and concise technical information that facilitates real-world problem-solving.
SUSE TRD focuses on delivering practical guidance for combinations of SUSE, partner, and community technologies.
Documentation is modular and rendered into various formats (such as HTML and PDF) from multiple source files, which are open source licensed and freely available in the [GitHub repository](https://github.com/SUSE/technical-reference-documentation).

SUSE TRD features of four types of documentation:

- Getting Started Guide: an introduction to an approach that addresses a use case. featuring a combination of component technologies that includes step-by-step guidance for installation, configuration, and validation.

- Reference Implementation: an introductory architectural basis and approach for deployment of a solution that features the SUSE software portfolio.

- Reference Configuration: a reference implementation with specific partner hardware and software components.

- Enterprise Architecture: an architectural overview of solution as part of an enterprise landscape.


Community engagement is highly encouraged.
Quick fixes, you can use the `Report an issue` links in each of the HTML versions of the documentation published at the [SUSE Documentation portal](https://documentation.suse.com/trd-supported.html).
To contribute longer updates or new documentation, is is recommended to fork and clone the [GitHub repository](https://github.com/SUSE/technical-reference-documentation), so you can work locally with your favorite code editor.

The remainder of this document provides guidance to authors of SUSE TRD Getting Started Guides.



## Style

Using a consistent writing style and formatting contributes to this mission.
Writing style goes beyond the essential elements of spelling, grammar, and punctuation to include tone of voice, point of view, word choice, sentence and paragraph structure, and more.
SUSE TRD conforms to the [SUSE Documentation Style Guide](https://documentation.suse.com/style/current/single-html/docu_styleguide/index.html), which helps maintain consistency throughout the ecosystem.


As you develop and implement your content for a SUSE TRD getting started guide, keep these highlights in mind:

- This is a *getting started* guide, not a dissertation.

- Highlight a practical use case.

- Feature a combination of SUSE and partner or community components.

- Be clear, concise, and complete.

- Use a conversational yet professional tone.

- Use the active voice and the present tense.

- Avoid contractions and abbreviations.

- Address the reader in the second person (with the personal pronoun, "you").

- Use inclusive language.

- Follow [SUSE Brand Guidelines](https://brand.suse.com/)

- Leverage [Search Engine Optimization](https://en.wikipedia.org/wiki/Search_engine_optimization) (SEO) practices, such as surfacing keywords in titles and metadata, to raise ranking by search engines and help others find your documentation.







## Organization

- Organize the guide as best fits the purpose.
  Typical organization includes the following sections:
  - Introduction - solution description, motivation, audience, needed skills
  - Prerequisites - technologies reader should have have in place
  - Installation - provide steps to perform installation of components
  - Configuration - provide steps for any post-installation configurations
  - Validation - provide steps to validate/demonstrate function
  - Summary - summarize what was covered and suggest additional learning

- Conform to the SUSE Documentation Style
//   https://documentation.suse.com/style/current/single-html/docu_styleguide/index.html
- Keep in mind that this is a *getting started* guide that illustrates a solution to a use case through simple steps the reader can follow.

- Write to the audience you are trying to reach.

- Conform to the [SUSE Documentation Style](https://documentation.suse.com/style/current/single-html/docu_styleguide/index.html)

- Organize the guide as best fits its intended purpose and audience.
  Typical organization includes the following sections:
  - Introduction: solution description, motivation, audience, needed skills
  - Prerequisites: technologies reader should have have in place
  - Installation: steps to perform installation of components
  - Configuration: steps for any post-installation configuration
  - Validation: steps to validate/demonstrate functionity
  - Summary: quick review and suggestions for additional learning


## Process Overview

The general process you will follow for contributing a new getting started guide is as follows:

*Create your workspace*
. Fork the repository into your own GitHub account.
. Clone your fork to your local system.
. Create a branch: `git branch myproject`.
. Check out your new branch: `git checkout myproject`.
. Change to the `kubernetes/start` or `linux/start` directory (depending on the focus of your documentation project).
. Run `bin/gssetup.sh` and follow the prompts to create basic template files in a (new, if necessary) project subdirectory named for the primary partner.
. Enter the project subdirectory.

*Create your content*
. Develop your documentation by editing (as needed) the source files.
  The primary files you will need to edit are:
  - `DC-gs_{generated-project-name}`
  - `adoc/gs-{generated-project-name}_vars.adoc`
  - `adoc/gs_{generated-project-name}.adoc`
  - `adoc/gs_{generated-project-name}-docinfo.xml`
. Upload any needed media files to the appropriate subdirectory (e.g., `.svg`, `.png`) under `media` directory.
. Use the [DocBook Authoring and Publishing Suite (DAPS)](https://opensuse.github.io/daps/), which is also available as a container with [Daps2Docker](https://github.com/openSUSE/daps2docker), to frequently render and check the appearance of your documentation.
. Frequenctly, commit and push your edits to your GitHub clone.

*Submit your documentation for review*
. Sync any updates of the upstream [GitHub repository](https://github.com/SUSE/technical-reference-documentation) to your fork and push these to your clone.
. Submit a pull request (PR) to merge your branch into the main branch of the upstream repository.
. Respond to questions, suggestions, and requests by the SUSE Documentation Team.
. Wait for the documentation to be published to the [SUSE Documentation portal](https://documentation.suse.com/trd-supported.html).
. Celebrate!


## DIRECTORY & FILE STRUCTURE

Documentation source files are organized by category (Linux-focused or Kubernetes-focused), document type (enterprise architectures, reference configurations and implementations, and getting started guides), and lastly by partner (a company or open source project that supplies the primary, third-party component highlighted in the guide).

```
├── common
│   └── templates
├── kubernetes
│   ├── enterprise
│   ├── reference
│   └── start
└── linux
    ├── enterprise
    ├── reference
    └── start
```

See the [Repository structure](https://github.com/SUSE/technical-reference-documentation) section of the Contributors Guide for more details on the general repository organizational structure.

Getting started guides are


Files you will work with for each guide include:
- Doc Config file: provides processing guidance, including which stylesheet to use, document type, draft status, name of the main AsciiDoc content file, and more.

- //                      The is one DC file per guide and it is located
//                      at the root of the project directory.
//                      There is one DC file per guide.
// - DocBook Info file: Provides metadata to describe the contents.
//                      There is one DOCINFO file per guide and it is
//                      located in the adoc subdirectory.
// - ASCIIDoc files:    AsciiDoc is the lightweight, semantic markup
//                      language designed for writing technical
//                      content.
//                      There is one main ADOC file per guide, which can
//                      be accompanied by multiple ancillary ADOC files.
//                      These file are located in the adoc subdirectory
//                      and are merged ("included") during when the
//                      document is rendered for publication.
//                      Some additional ADOC files that are common to all
//                      guides, including the GNU Free Documentation License
//                      and the disclaimer, are located elsewhere and
//                      "included" automatically by these templates.
// - Media files:       Graphical content, such as diagrams, screenshots,
//                      and logos can enhance your document.
//                      Media files are stored under the media subdirectory
//                      by image type.
//                      Preferred image formats are:
//                      - Scaled Vector Graphics (SVG)
//                      - Portable Network Graphics (PNG)
//
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
