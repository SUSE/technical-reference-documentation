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
# Verify readiness
##

# check present working directory
if [ $(basename $PWD) != "start" ]; then
  echo
  echo "Your current working directory is:"
  echo "  '$PWD'"
  echo "Make sure you change to 'kubernetes/start' or 'linux/start'"
  echo "  then execute this script again."
  echo
  exit 1
fi


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Initialize variables
##
templatesroot="../../../common/templates/start"
category=""
doctype=""
suseprod=""
partnername=""
partnerprod=""
usecase=""
documentbase=""


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Gather inputs
##

echo
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo " Gather some information"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo

# get solution category
while read -p "Please enter the relevant category (i.e., 'k' for Kubernetes or 'l' for Linux) : " response
do
  case ${response} in
    'k' | 'K' | 'Kubernetes' | 'kubernetes')
      category='kubernetes'
      break
    ;;
    'l' | 'L' | 'Linux' | 'linux')
      category='linux'
      break
    ;;
    'q' | 'quit')
      echo "Quitting ... nothing done."
      exit 1
    ;;
    *)
      echo "Invalid input.  Please try again or enter 'q' to quit."
    ;;
  esac
done


# get primary SUSE product
while read -p "Please enter the primary SUSE product name (e.g., 'rancher', 'k3s', 'sles', 'suma', etc.) : " response
do
  suseprod=$( echo ${response} | tr '[:upper:]' '[:lower:]' )
  # validate SUSE product
  case $suseprod in
    'sles' | 'slehpc' | 'slemicro' | 'suma')
      break
    ;;
    'rancher' | 'rke' | 'rke2' | 'k3s' | 'longhorn' | 'harvester')
      break
    ;;
    'q' | 'quit')
      echo "Quitting ... nothing done."
      exit 2
    ;;
    *)
      echo "Invalid input.  Please try again or enter 'q' to quit."
    ;;
  esac
done

# get Partner Name
read -p "Please enter the name of the primary partner : " response
partnername=$( echo ${response} | tr '[:upper:]' '[:lower:]' )


# get Partner Product
read -p "Please enter the primary partner product name : " response
if [ -n "$response" ]; then
  partnerprod="-$( echo ${response} | tr '[:upper:]' '[:lower:]' )"
else
  # allow the partner product name to be left blank
  partnerprod=""
fi

# get Use Case
read -p "If you would like a use case or description (1-3 words), enter it now or just press ENTER : " response
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
echo "- About to create the following structure:"
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
cp ${templatesroot}/_DC-file \
   DC-${documentbase}
# update adoc reference
sed -i "s/MAIN=\"gs_suseprod_partner-partnerprod.adoc\"/MAIN=\"${documentbase}.adoc\"/g" DC-${documentbase}

# create adoc directory if it does not already exist
[ -d adoc ] || mkdir -p adoc
#cd adoc

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
