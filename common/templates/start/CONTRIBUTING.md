# Contributing

Follow the steps below to contribute a getting started guide
to the SUSE Technical Reference Documentation.

. Fork the repository into your own GitHub account.
. Clone your fork to your local system.
. Create a branch: `git branch myproject`.
. Check out your new branch: `git checkout myproject`.
. Change to the `kubernetes/start` or `linux/start` directory (as appropriate).
. Run `bin/gssetup.sh` and follow the prompts to create basic template files in a new subdirectory.
. Enter the new subdirectory created for your project.
. Edit as needed:
  - `DC-gs_{generated-project-name}`
  - `adoc/gs-{generated-project-name}_vars.adoc`
  - `adoc/gs_{generated-project-name}.adoc`
  - `adoc/gs_{generated-project-name}-docinfo.xml`
. Upload media files under `media` by file type (e.g., `.svg`, `.png`).

