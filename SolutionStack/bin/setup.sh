#! /bin/sh

echo
echo "Solution Stack Setup/Preparation ..."
echo

# solutionstack="ss"

##
# Gather inputs
##

  # get StackLayer
  read -p "Please enter the relevant SUSE layer (e.g., 'k' for Kubernetes or 'l' for Linux) : "  StackLayer
  case $StackLayer in
    'k' | 'K' | 'Kubernetes' | 'kubernetes')
      stacklayer='Kubernetes'
    ;;
    'l' | 'L' | 'Linux' | 'linux')
      stacklayer='Linux'
    ;;
    *)
      echo "Please re-run ${0} and enter 'K' or 'L'."
      exit 1
      ;;
  esac

  # get SUSE product abbreviation
  read -p "Please enter the primary SUSE product name (e.g., 'rancher', 'sles', 'suma') : " SUSEProduct
  suseprod=$( echo ${SUSEProduct} | tr '[:upper:]' '[:lower:]' )
  # validate SUSE product
  case $suseprod in
    sles | slehpc | slemicro | suma | rancher)
      ;;
    *)
      echo "Valid SUSE products include: 'sles', 'slehpc', 'slemicro', 'suma', and 'rancher'."
      echo "Please re-run setup.sh and try again."
      exit 2
      ;;
  esac

  # get PartnerName
  read -p "Please enter the name of the primary partner : " PartnerName
  partnername=$( echo ${PartnerName} | tr '[:lower:]' '[:upper:]' )

  # get PartnerProduct
  read -p "Please enter the primary partner product name : " PartnerProduct
  partnerprod=$( echo ${PartnerProduct} | tr '[:upper:]' '[:lower:]' | tr ' ' '-' )

  # get DocumentType
  echo "Please enter the document scope type"
  echo "   (e.g., gs - Getting Started,"
  echo "         ri - Reference Implementation,"
  read -p "         rc - Reference Configuation) : " DocumentType
  documenttype=$( echo ${DocumentType} | tr '[:upper:]' '[:lower:]' )
  case ${documenttype} in
    gs | ri | rc)
      ;;
    *)
      echo "Please re-run ${0} and enter gs, ri, or rc."
      exit 3
      ;;
  esac


##
# setup structure, common elements
##

  echo
  echo "=== Create default directory structure"

  directoryname=$(echo ${partnername} | tr '[:upper:]' '[:lower:]')
  [ -d ${directoryname} ] || mkdir ${directoryname}
  cd ${directoryname}

    touch DC-TRD-${stacklayer}-${documenttype}-${suseprod}-${partnername}-${partnerprod}
    [ -d adoc ] || mkdir -p adoc

    echo "    - for Asciidoc (and common elements)"
    cd adoc && {
	[ -L common_gfdl1.2_i.adoc ] || \
		ln -s ../../../common/adoc/common_gfdl1.2_i.adoc .
	[ -L common_sbp_legal_notice.adoc ] || \
		ln -s ../../../common/adoc/common_sbp_legal_notice.adoc .
	[ -L common_trd_legal_notice.adoc ] || \
		ln -s ../../../common/adoc/common_trd_legal_notice.adoc .
	[ -L common_docinfo_vars.adoc ] || \
		ln -s ../../../common/adoc/common_docinfo_vars.adoc .
	[ -e TRD-${stacklayer}-${documenttype}-${suseprod}-${partnername}-${partnerprod}.adoc ] || { \
		touch TRD-${stacklayer}-${documenttype}-${suseprod}-${partnername}-${partnerprod}.adoc
	}
	[ -e TRD-${stacklayer}-${documenttype}-${suseprod}-${partnername}-${partnerprod}-docinfo.xml ] || { \
		touch TRD-${stacklayer}-${documenttype}-${suseprod}-${partnername}-${partnerprod}-docinfo.xml
	}
    } && cd ..

    [ -d media/src/png ] || mkdir -p media/src/png
    [ -d media/src/svg ] || mkdir -p media/src/svg
    cd media/src/svg && {
#	[ -L suse.svg ] || \
#		ln -s ../../../../../common/images/src/svg/suse.svg .
	[ -L suse-white-logo-green.svg ] || \
		ln -s ../../../../../common/images/src/svg/suse-white-logo-green.svg .
    } && cd ../../..

    [ -L images ] || \
	    ln -s media images

    echo
    echo "Setup is complete."
    echo "See $PWD/${partnername}."

