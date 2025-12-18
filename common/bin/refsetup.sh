#! /bin/sh
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Set up new SUSE TRD Reference Configuration
# Collects input on new guide, then generates
# directory and file structure to allow authors
# to begin editing content.
##

## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# global variables
##
SUSEPRODUCTS=('sles', 'slessap', 'slehpc', 'slmicro', 'slelp', 'slert', 'sleha', 'slebci', 'smlm', 'rancher', 'sto', 'sec', 'obs', 'virt', 'ai', 'rke', 'rke2', 'k3s')



## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Functions
##

doctypes() {
# display list of valid document types

echo
echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "  - Enter a valid document type:"
echo "  -   - gs: Getting started guide"
echo "  -         An introduction to a joint SUSE + partner solution"
echo "  -         with step-by-step guidance to install, configure,"
echo "  -         and validate the solution in a non-production"
echo "  -         environment."
echo "  -   - ri: Reference implementation"
echo "  -         An architectural approach and basis for deployment"
echo "  -         of a solution featuring multiple elements of the"
echo "  -         SUSE product portfolio in a production environment."
echo "  -   - rc: Reference configuration"
echo "  -         A reference implementation with specified partner"
echo "  -         hardware and software."
echo "  -   - ea: Enterprise architecture"
echo "  -         A holistic overview of an enterprise landscape"
echo "  -         featuring joint SUSE and partner solutions."
echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo

}


suselist() {
# display list of SUSE products and abbreviations

echo
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "Abbrev.     | Product"
echo "- - - - - - | - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "sles        | SUSE Linux Enterprise Server"
echo "slessap     | SUSE Linux Enterprise Server for SAP applications"
echo "slehpc      | SUSE Linux Enterprise High Performance Computing"
echo "slmicro     | SUSE Linux Micro"
echo "slelp       | SUSE Linux Enterprise Live Patching"
echo "slert       | SUSE Linux Enterprise Real Time"
echo "sleha       | SUSE Linux Enterprise for High Availability"
echo "slebci      | SUSE Linux Enterprise Base Container Images"
echo "smlm        | SUSE Multi-Linux Manager Manager"
echo "rancher     | SUSE Rancher Prime"
echo "sec         | SUSE Security"
echo "virt        | SUSE Virtualization"
echo "obs         | SUSE Observability"
echo "sto         | SUSE Storage"
echo "ai          | SUSE AI"
echo "rke         | Rancher Kubernetes Engine"
echo "rke2        | Rancher Kubernetes Engine 2"
echo "k3s         | K3s"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo

}


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Display banner
##
echo
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo "= Set up workspace for a new technical reference document   ="
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo
echo " This script will prompt you for information about your"
echo " document, then use your responses to create the directories"
echo " and template files you will need."
echo
echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "  - Before proceeding make sure you have:"
echo "  - 1. created a local branch: \`git branch myproject\`"
echo "  - 2. checked out your new branch: \`git checkout myproject\`"
echo "  - 3. changed to the 'references' directory"
echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo 
echo "Are you ready to proceed?"
read -p "Press ENTER to continue or CTRL+C to cancel."


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Initialize variables
##
currentbranch="$(git branch --show-current)"
commonroot="../common"
templatesroot="${commonroot}/templates"
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


# Verify present working directory is correct for a reference configuration
if [[ ! $PWD =~ references$ ]] && [[ ! $PWD =~ references$ ]]; then
  echo
  echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  echo "  - Your current working directory is:"
  echo "  - '$PWD'"
  echo "  -"
  echo "  - Be sure you change to the 'references' directory,"
  echo "  - then execute this script again."
  echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  echo
  exit 2
fi



## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Gather inputs
##

echo
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "- Gathering some information"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo

#-----------
# get document type
while read -p ">> Document type (gs, ri, rc, ea, help) : " response
do
  resp=$( echo ${response} | tr '[:upper:]' '[:lower:]' )
  # validate input
  case $resp in
    'help')
      doctypes

    ;;
    'gs' | 'ri' | 'rc' | 'ea')
      doctype=$resp
      break
    ;;
    *)
      echo
      echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
      echo "  - Invalid input."
      doctypes
      echo "  - Press CTRL+C to cancel and exit the script."
      echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
      echo
    ;;
  esac
done
#-------------

#-----------
# get primary SUSE product
suseprods=""
echo "- - - - - -"
echo "- Identify the featured SUSE products by entering"
echo "- one product abbreviation at a time."
echo "- When done, press ENTER with no value."
echo "-"
echo "- TIPS:"
echo "-   - You do not need to list all products, only"
echo "-     the featured one or ones."
echo "-   - When featuring multiple products, start at"
echo "-     the top of the software stack."
echo "-     For example: 'rancher' then 'rke2' then 'sles'"
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
        case ${resp} in
         'sto')
          resp="storage"
         ;;
         'virt')
           resp="virtualization"
         ;;
         'obs')
           resp="observability"
         ;;
         'sec')
           resp="security"
         ;;
       esac
       if [[ "${suseprods}" = "" ]]; then
         suseprods="${resp}"
       else
         suseprods="${suseprods}-${resp}"
       fi
      else
        echo
        echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
        echo "  - Invalid input."
        echo "  - Enter a SUSE product abbreviation, 'list',"
        echo "  -   or leave blank to proceed to the next step."
        echo "  - Press CTRL+C to cancel and exit this script."
        echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
        echo
      fi
      echo
      echo "Featured SUSE products: \"${suseprods}\""
      echo
    ;;
  esac
done

if [[ $doctype =~ ^(rc|gs) ]]; then
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

  # set destination directory name
  destdir=${partnername}
  
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
else
  destdir="suse"
fi

# get Use Case or other text
echo
echo "- - - - - -"
echo "- OPTIONAL"
echo "-"
echo "- If a solution can address multiple use cases,"
echo "- it may be useful to create a separate guide to"
echo "- address unique concerns of each use case."
echo "-"
echo "-   NOTE:  This option appends the text to the document's"
echo "-          file name, so it should be used sparingly to"
echo "-          avoid especially long file names."
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

if [[ $doctype =~ ^(rc|gs) ]]; then
  documentbase="${doctype}_${suseprods}_${partnername}${partnerprod}${usecase}"
else
  documentbase="${doctype}_${suseprods}${usecase}"
fi


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# display plan and get user confirmation
##

echo
echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "  - Preparing to create the following structure:"
echo "  -"
echo "  -   references"
echo "  -   └── ${destdir}"
echo "  -       ├── DC-${documentbase}"
echo "  -       ├── adoc"
echo "  -       │   ├── ${documentbase}.adoc"
echo "  -       │   ├── ${documentbase}-docinfo.xml"
echo "  -       │   └── ${documentbase}-vars.adoc"
echo "  -       ├── images -> media"
echo "  -       └── media"
echo "  -           └── src"
echo "  -               ├── png"
echo "  -               └── svg"
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
[ -d ${destdir} ] || mkdir ${destdir}

# create DC file
if [ ! -f "${destdir}/DC-${documentbase}" ]; then
  cp -n ${templatesroot}/template_DC ${destdir}/DC-${documentbase}
else
  echo
  echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  echo "  - 'DC-${documentbase}' could not be created in"
  echo "  - '${destdir}'."
  echo "  -"
  echo "  - If 'DC-${documentbase}' already exists,"
  echo "  - re-run this script with different input."
  echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  echo
  exit 4
fi

# create adoc directory if it does not already exist
[ -d ${destdir}/adoc ] || mkdir -p ${destdir}/adoc

# create symlinks to common files
[ -L ${destdir}/adoc/common_gfdl1.2_i.adoc ] || \
  ln -sr ${commonroot}/adoc/common_gfdl1.2_i.adoc ${destdir}/adoc/
[ -L ${destdir}/adoc/common_sbp_legal_notice.adoc ] || \
  ln -sr ${commonroot}/adoc/common_sbp_legal_notice.adoc ${destdir}/adoc/
[ -L ${destdir}/adoc/common_trd_legal_notice.adoc ] || \
  ln -sr ${commonroot}/adoc/common_trd_legal_notice.adoc ${destdir}/adoc/
[ -L ${destdir}/adoc/common_docinfo_vars.adoc ] || \
  ln -sr ${commonroot}/adoc/common_docinfo_vars.adoc ${destdir}/adoc/

# create docinfo.xml file
[ -f "${destdir}/adoc/${documentbase}-docinfo.xml" ] || \
  cp ${templatesroot}/template_docinfo \
     ${destdir}/adoc/${documentbase}-docinfo.xml

# create vars file
[ -f "${destdir}/adoc/${documentbase}-vars.adoc" ] || \
  cp ${templatesroot}/template_vars \
     ${destdir}/adoc/${documentbase}-vars.adoc

# create main file
[ -f "${destdir}/adoc/${documentbase}.adoc" ] || \
  cp ${templatesroot}/template_main-${doctype} \
     ${destdir}/adoc/${documentbase}.adoc

# create media directory structure
[ -d ${destdir}/media/src/png ] || mkdir -p ${destdir}/media/src/png
[ -d ${destdir}/media/src/svg ] || mkdir -p ${destdir}/media/src/svg
# create symlink to logo
[ -L ${destdir}/media/src/svg/suse.svg ] || \
  ln -sr ${commonroot}/images/src/svg/suse.svg ${destdir}/media/src/svg/
# create images symlink
[ -L ${destdir}/images ] || \
  ln -sr ${destdir}/media ${destdir}/images

# update interdocument references
# ensure adoc file includes correct vars file
[ -f "${destdir}/adoc/${documentbase}.adoc" ] && sed -i "s/include::\.\/template_vars\[\]/include::.\/${documentbase}-vars.adoc\[\]/g" ${destdir}/adoc/${documentbase}.adoc
# ensure DC file references correct adoc file
[ -f "${destdir}/DC-${documentbase}" ] && sed -i "s/MAIN=\"template_main\"/MAIN=\"${documentbase}.adoc\"/g" ${destdir}/DC-${documentbase}

# update docinfo file to the correct document type


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# display closing banner
##
echo
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo "= Workspace for your new guide has been set up."
echo "="
echo "= Access your workspace in:"
echo "=   references/${destdir}"
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Set up script for TRD Getting Started Guides
#
# Contributors:
# - Terry Smith <terry.smith@suse.com>
# Revisions:
# - 20251208: Added document type selector
# - 20251204: Copied gssetup.sh to refsetup.sh and modified
