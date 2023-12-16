#! /bin/sh
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Set up new SUSE TRD Getting Start Guide
# Collects input on new guide, then generates
# directory and file structure to allow authors
# to begin editing content.
##

## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# global variables
##
SUSEPRODUCTS=('sles', 'slessap', 'slehpc', 'slemicro', 'slelp', 'slert', 'sleha', 'slebci', 'suma', 'rancher', 'neuvector', 'harvester', 'rke', 'rke2', 'k3s', 'longhorn')



## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Functions
##

suselist() {
# display list of SUSE products and abbreviations

echo
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "Abbrev.   | Product"
echo "- - - - - | - - - -- - - - - - - - - - - - - - - - - - - - - - -"
echo "sles      | SUSE Linux Enterprise Server"
echo "slessap   | SUSE Linux Enterprise Server for SAP Applications"
echo "slehpc    | SUSE Linux Enterprise High Performance Computing"
echo "slemicro  | SUSE Linux Enterprise Micro"
echo "slelp     | SUSE Linux Enterprise Live Patching"
echo "slert     | SUSE Linux Enterprise Real Time"
echo "sleha     | SUSE Linux Enterprise for High Availability Extension"
echo "slebci    | SUSE Linux Enterprise Base Container Images"
echo "suma      | SUSE Manager"
echo "rancher   | Rancher Prime by SUSE"
echo "neuvector | NeuVector Prime by SUSE"
echo "harvester | Harvester by SUSE"
echo "rke       | Rancher Kubernetes Engine"
echo "rke2      | Rancher Kubernetes Engine 2"
echo "k3s       | K3s by SUSE"
echo "longhorn  | Longhorn by SUSE"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo

}


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Display banner
##
echo
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo "= Set up workspace for new TRD getting started guide        ="
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo
echo " This script will prompt you for information about your"
echo " guide, then use your responses to create the directories"
echo " and template files for your guide"
echo
echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "  - Before proceeding make sure you have:"
echo "  - 1. created a local branch: \`git branch myproject\`"
echo "  - 2. checked out your new branch: \`git checkout myproject\`"
echo "  - 3. changed to the 'kubernetes/start' or"
echo "  -    'linux/start' directory (as appropriate)"
echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo 
echo "Are you ready to proceed?"
read -p "Press ENTER to continue or CTRL+C to cancel."


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Initialize variables
##
currentbranch="$(git branch --show-current)"
commonroot="../../common"
templatesroot="${commonroot}/templates/start"
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
  echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  echo "  - Be sure to work in a branch other than 'main'."
  echo "  -"
  echo "  - Create a branch for your project and check it out,"
  echo "  - then re-run this script."
  echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  echo
  exit 1
fi


# Verify present working directory is correct for a getting started guide
if [[ ! $PWD =~ kubernetes/start$ ]] && [[ ! $PWD =~ linux/start$ ]]; then
  echo
  echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  echo "  - Your current working directory is:"
  echo "  - '$PWD'"
  echo "  -"
  echo "  - Be sure you change to the 'kubernetes/start' or"
  echo "  - 'linux/start' subdirectory, then execute this"
  echo "  - script again."
  echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  echo
  exit 2
else
  # Set category from the path (kubernetes or linux)
  # category=$(dirname $PWD)
  category=${PWD%/*}
fi



## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Gather inputs
##

echo
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "- Gathering some information"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo


# get primary SUSE product
suseprods=""
echo "- - - - - -"
echo "- Identify the featured SUSE products by entering"
echo "- one product abbreviation at a time."
echo "- When done, press ENTER with no value."
echo "-"
echo "- TIP: Start at the top of the software stack."
echo "-      For example: 'rancher' then 'rke2' then 'sles'"
echo "-"
echo "- Additional options:"
echo "-   'list': display accepted abbreviations."
echo "-   'clear': clear the product list and start over."
echo "-   Press CTRL+C to cancel and exit the script."
echo "- - - - - -"
echo
while read -p ">> SUSE product : " response
do
  resp=$( echo ${response} | tr '[:upper:]' '[:lower:]' )
  # validate input
  case $resp in
    '')
      echo
      echo "Featured SUSE products: \"${suseprods}\""
      echo
      break
    ;;
    'list')
      suselist
      echo
      echo "Featured SUSE products: \"${suseprods}\""
      echo
    ;;
    '')
      # no more products entered
      echo
      echo "Featured SUSE products: \"${suseprods}\""
      echo
      break
    ;;
    'clear')
      # clear the product list to start over
      suseprods=""
      echo
      echo "Featured SUSE products: \"${suseprods}\""
      echo
    ;;
    *)
      if [[ "${SUSEPRODUCTS[*]}" =~ "${resp}" ]]; then
	if [[ "${suseprods}" = "" ]]; then
	  suseprods="${resp}"
	else
          suseprods="${suseprods}-${resp}"
	fi
      else
        echo
        echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
        echo "  - Invalid input."
	echo "  - Enter a SUSE product abbreviation, 'list', or leave blank."
	echo "  - Press CTRL+C to cancel and exit the script."
        echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	echo
      fi
      echo
      echo "Featured SUSE products: \"${suseprods}\""
      echo
    ;;
  esac
done

# get Name of the Primary Partner
echo
echo "- - - - - -"
echo "- Enter the name of the primary partner."
echo "-"
echo "- TIP: Select one partner whose product is at the top"
echo "-      of the software stack and provides the key"
echo "-      functionality for the featured use case."
echo "- - - - - -"
echo
while read -p ">> Primary partner : " response
do
  partnername=$( echo ${response} | tr '[:upper:]' '[:lower:]' | sed 's/\ //g' )
  if [ -n "$partnername" ]; then
    break
  else
    echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
    echo "  - Invalid input."
    echo "  - Primary partner cannot be blank."
    echo "  - Press CTRL+C to cancel and exit the script."
    echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  fi
done
echo "Primary partner: \"${partnername}\""
echo

# get Name of the Primary Partner's product
echo
echo "- - - - - -"
echo "- Enter the name of the primary partner's product."
echo "-"
echo "-   TIP: If the primary partner and the product"
echo "-        share the same name, you can leave the"
echo "-        partner product blank to avoid repetition."
echo "-"
echo "- - - - - -"
echo
read -p ">> Primary partner's product : " response
if [ -n "$response" ]; then
  partnerprod="-$( echo ${response} | tr '[:upper:]' '[:lower:]' | sed 's/\ //g' )"
else
  # allow the partner product name to be left blank
  partnerprod=""
fi
echo "Primary partner product: \"${partnerprod}\""
echo

# get Use Case or other text
echo
echo "- - - - - -"
echo "- OPTIONAL"
echo "-"
echo "- If a solution can address multiple use cases,"
echo "- it may be useful to create a separate guide to"
echo "- address unique concerns of each use case."
echo "- Since the product stack is insufficient to distinguish"
echo "- each guide, some additional text can be added to the"
echo "- file name."
echo "-"
echo "-   TIP: It is preferable to leave this blank."
echo "-        If needed, use fewer than 20 characters for the"
echo "-        additional text."
echo "- - - - - -"
echo
read -p ">> Distinctive text : " response
if [ -n "$response" ]; then
  usecase="_$( echo ${response} | tr '[:upper:]' '[:lower:]' | tr ' ' '-' )"
else
  usecase=""
fi
echo "Distinctive text: \"${usecase}\""
echo


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# build base filename
##

documentbase="gs_${suseprods}_${partnername}${partnerprod}${usecase}"


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# display plan and get user confirmation
##

echo
echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "  - Preparing to create the following structure:"
echo "  -"
echo "  -   ${category}"
echo "  -   └── start"
echo "  -       └── ${partnername}"
echo "  -           ├── DC-${documentbase}"
echo "  -           ├── adoc"
echo "  -           │   ├── ${documentbase}.adoc"
echo "  -           │   ├── ${documentbase}-docinfo.xml"
echo "  -           ├── images -> media"
echo "  -           └── media"
echo "  -               └── src"
echo "  -                   ├── png"
echo "  -                   └── svg"
echo "  -"
echo "  - NOTE: Several symbolic links will also be created."
echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo 
read -p ">> Press ENTER to create document structure or CTRL+C to cancel."
echo


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# create structure
##

# create primary directory if it does not already exist
[ -d ${partnername} ] || mkdir ${partnername}

# create DC- file
if [ ! -f "${partnername}/DC-${documentbase}" ]; then
  cp -n ${templatesroot}/_DC-file ${partnername}/DC-${documentbase}
else
  echo
  echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  echo "  - 'DC-${documentbase}' could not be created in"
  echo "  - '${partnername}'."
  echo "  -"
  echo "  - If 'DC-${documentbase}' already exists,"
  echo "  - re-run this script with different input."
  echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  echo
  exit 4
fi

# update adoc reference
[ -f "${partnername}/DC-${documentbase}" ] && sed -i "s/MAIN=\"gs_suseprod_partner-partnerprod.adoc\"/MAIN=\"${documentbase}.adoc\"/g" ${partnername}/DC-${documentbase}

# create adoc directory if it does not already exist
[ -d ${partnername}/adoc ] || mkdir -p ${partnername}/adoc

# create symlinks to common files
[ -L ${partnername}/adoc/common_gfdl1.2_i.adoc ] || \
  ln -sr ${commonroot}/adoc/common_gfdl1.2_i.adoc ${partnername}/adoc/
[ -L ${partnername}/adoc/common_sbp_legal_notice.adoc ] || \
  ln -sr ${commonroot}/adoc/common_sbp_legal_notice.adoc ${partnername}/adoc/
[ -L ${partnername}/adoc/common_trd_legal_notice.adoc ] || \
  ln -sr ${commonroot}/adoc/common_trd_legal_notice.adoc ${partnername}/adoc/
[ -L ${partnername}/adoc/common_docinfo_vars.adoc ] || \
  ln -sr ${commonroot}/adoc/common_docinfo_vars.adoc ${partnername}/adoc/

# create .adoc file
[ -f "${partnername}/adoc/${documentbase}.adoc" ] || \
  cp ${templatesroot}/_adoc-file \
     ${partnername}/adoc/${documentbase}.adoc

# create -docinfo.xml file
[ -f "${partnername}/adoc/${documentbase}-docinfo.xml" ] || \
  cp ${templatesroot}/_docinfo-file \
     ${partnername}/adoc/${documentbase}-docinfo.xml

# create media directory structure
[ -d ${partnername}/media/src/png ] || mkdir -p ${partnername}/media/src/png
[ -d ${partnername}/media/src/svg ] || mkdir -p ${partnername}/media/src/svg
# create symlink to logo
[ -L ${partnername}/media/src/svg/suse.svg ] || \
  ln -sr ${commonroot}/images/src/svg/suse.svg ${partnername}/media/src/svg/
# create images symlink
[ -L ${partnername}/images ] || \
  ln -sr ${partnername}/media ${partnername}/images


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# display closing banner
##
echo
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo "= Workspace for your new guide has been set up."
echo "="
echo "= Access your workspace in:"
echo "=   ${category}/start/${partnername}"
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Set up script for TRD Getting Started Guides
#
# Contributors:
# - Terry Smith <terry.smith@suse.com>
# - Bryan Gartner <bryan.gartner@suse.com>
# Revisions:
# - 20231214: Updated SUSE product list, added support for multiple products
# - 20230907: Simplified paths; added more checks; clarified prompts
# - 20221213: Removed underscore prefix from generated DC file
# - 20220824: Migrated to common/bin; implemented run location test
# - 20220729: Removed extraneous space; created action preview banner
# - 20220203: Use renamed template files to avoid GitHub Actions validation
# - 20220127: Leverage template files
