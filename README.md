# gitbook-oss-t2

This repository contains the RGitBook functions for the automated generation of Terradue's Open Source guide.

The GitBook is live at: http://terradue.github.io/gitbook-oss-t2

### Getting started - Structuring the GitBook

The GitBook first level structure is made of chapters defined by a JSON file named .config.json in the folder *src/main/doc* .
The chapters are defined as follows:

```json
{
"section": {
"title": "OWS Context"
},
"section": {
"title": "ElasticCAS"
},
"section": {
"title": "OpenNebula"
},
"section": {
"title": "DCS Field Guide"
}
}
```

The key is the SUMMARY.Rmd file, that is knitting the .config.json file and the GitHub API to:

* Generate the GitBook first level chapters 
* Generate the GitBook second level structure

In order to be included in the GitBook, an organization's repo must have at it's root a JSON file named .gitbook, with the name(s) of the chapter(s) it belongs to. 

For example: 

```json
{
"section": "DCS Field Guide"
}
```

### Deploying the GitBook

On the host server, simply use git clone and maven deploy.

```
cd
git clone git@github.com:terradue/gitbook-oss-t2.git
cd gitbook-oss-t2.git
mvn site-deploy
```

### Questions, bugs, and suggestions

Please file any bugs or questions as [issues](https://github.com/terradue/gitbook-oss-t2/issues/new) or send in a pull request.

### License

Copyright 2014 Terradue Srl

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
