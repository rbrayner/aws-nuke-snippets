regions:
- us-east-1
- global

account-blocklist:
  - "999999999999" # avoid a production account, for example

resource-types:
  # nuke these resources only
  targets:
  - ${awsResource}

accounts:
  "${awsRootAccountId}": 
    presets:
    - "${awsNukePreset}"

presets:
  cf-by-env:
    filters:
      CloudFormationStack:
      - property: 'Name'
        type: glob
        value: "ih-*-${awsEnv}"
        invert: true
  rds-param-by-env:
    filters:
      RDSDBParameterGroup:
      - property: 'Name'
        type: glob
        value: "${RDS_PARAM_PREFIX}-${awsEnv}-*"
        invert: true
  s3-by-env:
    filters:
      S3Bucket:
      - property: 'Name'
        type: glob
        value: "ih-*-${awsEnv}"
        invert: true
  lambda-by-env:
    filters:
      LambdaFunction:
      - property: 'Name'
        type: glob
        value: "IH-*-${awsEnv}"
        invert: true
