#! /bin/sh
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Set up new SUSE TRD Getting Start Guide
# Collects input on new guide, then generates
# directory and file structure to allow authors
# to begin editing content.
##

## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Display banner
##
echo
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo "= Set up workspace for new TRD getting started guide      ="
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo
echo " This script will prompt you for information about the"
echo "   solution and its components, then use your responses"
echo "   to name the files and directories required for your"
echo "   guide."
echo
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "- Before proceeding make sure you have:"
echo "- 1. created a local branch: \`git branch myproject\`"
echo "- 2. checked out your new branch: \`git checkout myproject\`"
echo "- 3. changed to the 'kubernetes/start' or"
echo "-    'linux/start' directory (as appropriate)"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo 
echo "Are you ready to proceed?"
read -p "Press ENTER to continue or CTRL-C to cancel."


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Initialize variables
##
currentbranch="$(git branch --show-current)"
templatesroot="../../../common/templates/start"
category=""
doctype=""
suseprod=""
partnername=""
partnerprod=""
usecase=""
documentbase=""


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Verify readiness
##

# Verify current branch is not 'main'
if [[ "${currentbranch}" == "main" ]]; then
  echo
  echo "Be sure to work in a branch other than 'main'."
  echo
  echo "Create a branch for your project and check it out,"
  echo "  then re-run this script."
  echo
  exit 1
fi


# Verify present working directory is correct for a getting started guide
if [[ ! $PWD =~ kubernetes/start$ ]] && [[ ! $PWD =~ linux/start$ ]]; then
  echo
  echo "Your current working directory is:"
  echo "  '$PWD'"
  echo "Make sure you change to the 'kubernetes/start' or 'linux/start'"
  echo "  subdirectory, then execute this script again."
  echo
  exit 2
fi



## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Gather inputs
##

echo
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo " Gathering some information"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo


# get primary SUSE product
echo "    Please enter the primary SUSE product name"
echo "    (e.g., 'rancher', 'neuvector', 'sles', 'slemicro', 'suma', etc.)"
while read -p "Primary SUSE product name : " response
do
  suseprod=$( echo ${response} | tr '[:upper:]' '[:lower:]' )
  # validate SUSE product
  case $suseprod in
    'sles' | 'slehpc' | 'slemicro' | 'suma')
      break
    ;;
    'rancher' | 'rke' | 'rke2' | 'k3s' | 'longhorn' | 'neuvector' | 'harvester')
      break
    ;;
    'q' | 'quit')
      echo "Quitting ... nothing done."
      exit 3
    ;;
    *)
      echo "Invalid input.  Please try again or enter 'q' to quit."
    ;;
  esac
done

# get Name of the Primary Partner
echo
echo "    Please enter the name of the primary partner or project"
echo "      contributing a component to this solution."
echo "    If you need it identify multiple partners or projects,"
echo "      this can be done manually after running this script."
read -p "Primary partner or project : " response
partnername=$( echo ${response} | tr '[:upper:]' '[:lower:]' | sed 's/\ //g' )


# get Name of the Primary Partner's product
echo "    Please enter the primary partner's product name."
echo "    Avoid using spaces or punctuation of any kind."
read -p "Primary partner's product name : " response
if [ -n "$response" ]; then
  partnerprod="-$( echo ${response} | tr '[:upper:]' '[:lower:]' | sed 's/\ //g' )"
else
  # allow the partner product name to be left blank
  partnerprod=""
fi

# get Use Case or other text
echo
echo "    Sometimes a solution with the same components can address"
echo "      more than one use case."
echo "    If you need to distinguish this guide from an existing one,"
echo "      you can provide up to 20 characters here that will be added"
echo "      to the directory and file names."
echo "    In most cases, you should leave this blank by just pressing ENTER."
read -p "Distinctive text (or ENTER) : " response
if [ -n "$response" ]; then
  usecase="_$( echo ${response} | tr '[:upper:]' '[:lower:]' | tr ' ' '-' )"
else
  usecase=""
fi


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# build base filename
##

documentbase="gs_${suseprod}_${partnername}${partnerprod}${usecase}"


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# display plan
##

echo
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "- Getting ready to create the following structure:"
echo "-"
echo "-   ${category}"
echo "-   └── start"
echo "-       └── ${partnername}"
echo "-           ├── DC-${documentbase}"
echo "-           ├── adoc"
echo "-           │   ├── ${documentbase}.adoc"
echo "-           │   ├── ${documentbase}-docinfo.xml"
echo "-           ├── images -> media"
echo "-           └── media"
echo "-               └── src"
echo "-                   ├── png"
echo "-                   └── svg"
echo "-"
echo "- Note: Several symbolic links will also be created."
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo 


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# confirm user is ready to proceed
##

read -p "Press ENTER to create document structure or CTRL-C to cancel."


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# setup structure, common elements
##

# create primary directory if it does not already exist
[ -d ${partnername} ] || mkdir ${partnername}
cd ${partnername}

# create DC- file
if [ ! -f "DC-${documentbase}" ]; then
  cp -n ${templatesroot}/_DC-file DC-${documentbase}
else
  echo
  echo "'DC-${documentbase}' could not be created in '${partnername}'."
  echo "Make sure 'DC-${documentbase}' does not already exist."
  echo "If it does, consider using a different name."
  echo
  exit 4
fi

# update adoc reference
[ -f "DC-${documentbase}" ] && sed -i "s/MAIN=\"gs_suseprod_partner-partnerprod.adoc\"/MAIN=\"${documentbase}.adoc\"/g" DC-${documentbase}

# create adoc directory if it does not already exist
[ -d adoc ] || mkdir -p adoc

# create symlinks to common files
[ -L common_gfdl1.2_i.adoc ] || \
  ln -s ../../../../common/adoc/common_gfdl1.2_i.adoc adoc/
[ -L common_sbp_legal_notice.adoc ] || \
  ln -s ../../../../common/adoc/common_sbp_legal_notice.adoc adoc/
[ -L common_trd_legal_notice.adoc ] || \
  ln -s ../../../../common/adoc/common_trd_legal_notice.adoc adoc/
[ -L common_docinfo_vars.adoc ] || \
  ln -s ../../../../common/adoc/common_docinfo_vars.adoc adoc/

# create .adoc file
[ -f "adoc/${documentbase}.adoc" ] || \
  cp ${templatesroot}/_adoc-file \
    adoc/${documentbase}.adoc

# create -docinfo.xml file
[ -f "adoc/${documentbase}-docinfo.xml" ] || \
  cp ${templatesroot}/_docinfo-file \
    adoc/${documentbase}-docinfo.xml

# create media directory structure
#cd ..
[ -d media/src/png ] || mkdir -p media/src/png
[ -d media/src/svg ] || mkdir -p media/src/svg
#cd media/src/svg
# create symlink to logo
[ -L media/src/svg/suse.svg ] || \
  ln -s ../../../../../../common/images/src/svg/suse.svg media/src/svg/
#cd ../../..
# create images symlink
[ -L images ] || \
  ln -s media images

# return to original directory
cd ..

## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# display closing banner
##
echo
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "- Your new workspace has been set up."
echo "-"
echo "- Access your workspace in:"
echo "-   ${category}/start/${partnername}"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Set up script for TRD Getting Started Guides
#
# Contributors:
# - Terry Smith <terry.smith@suse.com>
# - Bryan Gartner <bryan.gartner@suse.com>
# Revisions:
# - 20221213: Removed underscore prefix from generated DC file
# - 20220824: Migrated to common/bin; implemented run location test
# - 20220729: Removed extraneous space; created action preview banner
# - 20220203: Use renamed template files to avoid GitHub Actions validation
# - 20220127: Leverage template files
