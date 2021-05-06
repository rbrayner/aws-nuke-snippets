# AWS Nuke Examples

- [AWS Nuke Examples](#aws-nuke-examples)
  - [1. Commands](#1-commands)
  - [2. Example-1](#2-example-1)

## 1. Commands

Run a single example without removing any resources, but listing only:

```shell
aws-nuke --config example-1.yml --profile example-1
```

By adding a --no-dry-run flag, the resources should be removed, but forces the user to accept the changes:

```shell
aws-nuke --config example-1.yml --profile example-1 --no-dry-run
```

DANGER: the below example wipes your AWS account without asking anything:

```shell
aws-nuke --config example-1.yml --profile example-1 -q --force --no-dry-run
```

Source: https://github.com/rebuy-de/aws-nuke

## 2. Example-1

Removes buckets only, either by time, tag, env or name. Comment the `presets` items you don't want to filter. This file also allows you to set multiple accounts. 

