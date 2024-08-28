# SUSE Technical Reference Documentation
Getting Started Guides - How to Contribute


For more detailed guidance, see the [Contributors Guide](https://documentation.suse.com/trd/contributors/single-html/suse-trd_contrib-guide/).


###


[Contribution instructions](CONTRIBUTING.md)


// GENERAL GUIDANCE
//
// See the Contributors Guide for more information:
// https://documentation.suse.com/trd/contributors/single-html/suse-trd_contrib-guide/
//
// Some points to keep in mind include:
// - This is a *getting started* guide and should illustrate a
//   solution through simple steps that the reader can follow
//   focused around a use case.
// - Write to the audience you are trying to reach.
// - Organize the guide as best fits the purpose.
//   Typical organization includes the following sections:
//   - Introduction - solution description, motivation, audience, needed skills
//   - Prerequisites - technologies reader should have have in place
//   - Installation - provide steps to perform installation of components
//   - Configuration - provide steps for any post-installation configurations
//   - Validation - provide steps to validate/demonstrate function
//   - Summary - summarize what was covered and suggest additional learning
// - Conform to the SUSE Documentation Style
//   https://documentation.suse.com/style/current/single-html/docu_styleguide/index.html
//
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// DIRECTORY & FILE STRUCTURE
//
// SUSE TRD getting started guides are built with multiple source files
// that provide content, metadata, and structure.
// These files are
// Principal among these files are:
// - Doc Config file:   Provides processing guidance, including
//                      which stylesheet to use, document type,
//                      draft status, name of the main AsciiDoc
//                      content file, and more.
//                      The is one DC file per guide and it is located
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
