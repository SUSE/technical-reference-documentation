#! /bin/sh

# usage
[ $# -ge 1 ] || {
echo "Usage : $(basename $0) <output-format>" 2>&1
  echo -e "\twhere" 2>&1
  echo -e "\t\toutput-format options are" 2>&1
  echo -e "\t\t\tepub" 2>&1
  echo -e "\t\t\thtml" 2>&1
  echo -e "\t\t\thtml --single" 2>&1
  echo -e "\t\t\tpdf" 2>&1
  exit 1
}

# setup
#
  # utilize DAPS Configuration template file
  templateDC="TRD-kubernetes_reference"

  # source completed/ready/available document variations
  [ -e ./bin/Makefile.cf ] && source ./bin/Makefile.cf

  # if needed, limit/override/augment above values
  [ -e ./bin/Makefile.override ] && source ./bin/Makefile.override

[ -n "${trdTemplate}" ] && for template in ${trdTemplate}
  do

    [ -n "${trdFocus}" ] && for focus in ${trdFocus}
      do

        [ -n "${trdLayerOS}" ] && for layerOS in ${trdLayerOS}
          do

	    # Getting Started
	      [ "${template}" = "GS" ] && {

		output=$(echo ${template}_${focus}-${layerOS} | tr '[:upper:]' '[:lower:]') && echo ${output}
		DC="DC-kubernetes_${output}"
		[ ! -e "./${DC}" ] && {
		  cp ${templateDC} ${DC} && {
		    echo ADOC_ATTRIBUTES+=\" --attribute ${template}=1\"
		    echo ADOC_ATTRIBUTES+=\" --attribute focus${focus}=1\"
		    echo ADOC_ATTRIBUTES+=\" --attribute layer${layerOS}=1\"
		    echo ADOC_ATTRIBUTES+=\" --attribute FLVR=1@\" 
		    echo ADOC_ATTRIBUTES+=\" --attribute PoC=1\"
		    echo ADOC_ATTRIBUTES+=\" --attribute Production=1\"
		    echo ADOC_ATTRIBUTES+=\" --attribute Scaling=1\"
		    echo ADOC_ATTRIBUTES+=\" --attribute FCTR=1\"
		    echo ADOC_ATTRIBUTES+=\" --attribute Availability=1\"
		    echo ADOC_ATTRIBUTES+=\" --attribute Security=1\"
		    } >> ${DC}
		}
		daps --force -d ${DC} $@ --name "${output}"

	      }

	    # Reference Implementation
	      [ -n "${trdLayerK8s}" ] && for layerK8s in ${trdLayerK8s}
	        do
		  [ "${template}" = "RI" ] && {

		    if [ "${focus}" = "Rancher" ]
		      then

	  		output=$( echo ${template}_${focus}-${layerK8s}-${layerOS} | tr '[:upper:]' '[:lower:]') && echo ${output}
		        DC="DC-kubernetes_${output}"
			[ ! -e "./${DC}" ] && {
			  cp ${templateDC} ${DC} && {
			    echo ADOC_ATTRIBUTES+=\" --attribute ${template}=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute focus${focus}=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute layer${layerK8s}=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute layer${layerOS}=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute FLVR=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute PoC=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Production=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Scaling=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute FCTR=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Automation=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Availability=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Security=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Integrity=1\"
			  } >> ${DC}
			}
			daps --force -d ${DC} $@ --name "${output}"

		      else

	  		output=$( echo ${template}_${focus}-${layerOS} | tr '[:upper:]' '[:lower:]') && echo ${output}
		        DC="DC-kubernetes_${output}"
			[ ! -e "./${DC}" ] && {
			  cp ${templateDC} ${DC} && {
			    echo ADOC_ATTRIBUTES+=\" --attribute ${template}=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute focus${focus}=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute layer${layerK8s}=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute layer${layerOS}=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute FLVR=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute PoC=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute PoC=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Production=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Scaling=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute FCTR=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Automation=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Availability=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Security=1\"
			    echo ADOC_ATTRIBUTES+=\" --attribute Integrity=1\"
			  } >> ${DC}
			}
			daps --force -d ${DC} $@ --name "${output}"

		    fi

		  }
		done


	    # Reference Configuration
	      [ -n "${trdIHVPartner}" ] && for partner in ${trdIHVPartner}
		do
		  [ "${template}" = "RC" ] && {

		    case ${partner} in

		      Cisco) PL="${trdIHVCiscoPlatform}" ;;
		      DELL) PL="${trdIHVDELLPlatform}" ;;
		      Fujitsu) PL="${trdIHVFujitsuPlatform}" ;;
		      HPE) PL="${trdIHVHPEPlatform}" ;;
		      Supermicro) PL="${trdIHVSupermicroPlatform}" ;;
		      *) break ;;

		    esac

		    [ -n "${PL}" ] && {
		      for productline in ${PL}
		        do
			  if [ "${focus}" = "Rancher" ]
			    then

			      output=$( echo ${template}_${focus}-${layerK8s}-${layerOS}_${partner}-${productline} | tr '[:upper:]' '[:lower:]') && echo ${output}
			      DC="DC-kubernetes_${output}"
			      [ ! -e "./${DC}" ] && {
			        cp ${templateDC} ${DC} && {
			          echo ADOC_ATTRIBUTES+=\" --attribute ${template}=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute focus${focus}=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute layer${layerK8s}=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute layer${layerOS}=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute FLVR=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute PoC=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute PoC=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Production=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Scaling=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute FCTR=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Automation=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Availability=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Security=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Integrity=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute iIHV=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute IHV-${partner}=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute IHV-${partner}-${productline}=1\"
			        } >> ${DC}
			      }
			      daps --force -d ${DC} $@ --name "${output}"

			    else

			      output=$( echo ${template}_${focus}-${layerOS}_${partner}-${productline} | tr '[:upper:]' '[:lower:]' ) && echo ${output}
			      DC="DC-kubernetes_${output}"
			      [ ! -e "./${DC}" ] && {
			        cp ${templateDC} ${DC} && {
			          echo ADOC_ATTRIBUTES+=\" --attribute ${template}=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute focus${focus}=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute layer${layerOS}=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute FLVR=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute PoC=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute PoC=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Production=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Scaling=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute FCTR=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Automation=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Availability=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Security=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute Integrity=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute iIHV=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute IHV-${partner}=1\"
			          echo ADOC_ATTRIBUTES+=\" --attribute IHV-${partner}-${productline}=1\"
			        } >> ${DC}
			      }
			      daps --force -d ${DC} $@ --name "${output}"

			  fi
		      done
		    }
		  }
		done
          done
      done
  done

# update matrix of included adoc files per DC
./bin/asciidoctor-include
