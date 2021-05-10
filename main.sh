#!/bin/sh

# Import .env file
export $(egrep -v '^#' .env | xargs)

if [ -z "${RDS_PARAM_PREFIX}" ]; then
  echo "${red}RDS_PARAM_PREFIX is undefined! Set it by creating a .env file.${reset}"
  exit 1;
else
  echo "${green}OK, RDS_PARAM_PREFIX is set within a .env file.${reset}"
fi

# Colors
red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 6`
purple=`tput setaf 4`
reset=`tput sgr0`

# aws sts get-caller-identity | jq '.Account'
devRootAccountId="555"
testRootAccountId="777"

export awsRootAccountId="${testRootAccountId}"

listOfResourcesType="CloudFormationStack RDSDBParameterGroup S3Bucket LambdaFunction"
listOfEnvs="aaaaaaaa bbbbbbbb ccccccccc"

for awsResource in $listOfResourcesType; do
    for awsEnv in $listOfEnvs; do
        case $awsResource in
            CloudFormationStack)
                export awsNukePreset='cf-by-env'
                ;;
            RDSDBParameterGroup)
                export awsNukePreset='rds-param-by-env'
               ;;
            S3Bucket)
                export awsNukePreset='s3-by-env'
                ;;
            LambdaFunction)
                export awsNukePreset='lambda-by-env'
                ;;
            *)
                export awsNukePreset='null'
                echo "${red}[ERROR] - No Resource Type Selected!${reset}"
                exit 1;
                ;;
        esac
        export awsEnv=${awsEnv}
        export awsResource=${awsResource}
        envsubst < ./template.yml.tpl > ./template.yml
        echo "Removing ${purple}ENV=${red}${awsEnv}${reset} of ${purple}resource${reset} type ${red}$awsResource${reset} with aws-nuke ${purple}preset${reset} ${red}${awsNukePreset}${reset}"
        aws-nuke --config template.yml
        # aws-nuke --config template.yml --no-dry-run
        # aws-nuke --config template.yml --no-dry-run --force
    done
done
