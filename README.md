# AWS Nuke Examples

- [AWS Nuke Examples](#aws-nuke-examples)
  - [1. Commands](#1-commands)
  - [2. Configure AWS Credentials](#2-configure-aws-credentials)
  - [3. Getting the Root Account ID](#3-getting-the-root-account-id)
  - [4. Before running the aws-nuke](#4-before-running-the-aws-nuke)
  - [5. Examples](#5-examples)
    - [5.1. Example-1](#51-example-1)

## 1. Commands

Run a single example without removing any resources, but listing only:

```shell
aws-nuke --config example-1.yml
```

You can also set the aws profile:

```shell
aws-nuke --config example-1.yml --profile configured-aws-profile
```


By adding a --no-dry-run flag, the resources should be removed, but forces the user to accept the changes:

```shell
aws-nuke --config example-1.yml --no-dry-run
```

DANGER: the below example wipes your AWS account without asking anything. The `-q` option does not print any information on the screen. The `--force` forces the delete without asking for confirmation.

```shell
aws-nuke --config example-1.yml -q --force --no-dry-run
```

Source: https://github.com/rebuy-de/aws-nuke

## 2. Configure AWS Credentials

```shell
aws configure
```

## 3. Getting the Root Account ID

```shell
aws sts get-caller-identity | jq '.Account'
```

## 4. Before running the aws-nuke

First, change the account ID (`ROOTACCOUNTID_1_NUMBER`) as described in [Getting the Root Account ID](#3-getting-the-root-account-id). Also, fill a production account id to avoid removing resources from this account. If you don't have a production account, just fill with `99999999999` or whatever value.

## 5. Examples

### 5.1. Example-1

This example removes buckets only, either by time, tag, env or name. Comment the `presets` items you don't want to filter. This file also allows you to set multiple accounts. 

