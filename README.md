# Opentofu Multi Environment App

The purpose of this code is to create an opentofu template to create multiple instances on AWS Cloud, the aproach used here was using tofu workspaces + configuration files.

## Requirements
- Open Tofu

## Getting started
Make is used to orchestrate tofu commands, so, for intializing or running the project for first time you should execute:

```
make execute_plan env=development layer=network
```
Under the hood make command execute (init, workspace creation and plan) the creation of one workspace per environment as you need according parameters you set, for example development, stage, production, besided the layer initialization like networking, compute, etc.

