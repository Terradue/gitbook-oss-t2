# gitbook-oss-t2

This repo contains the RGitBook that automatically creates the Terradue Open Source guide 

The GitBook is live at: live at http://fabricebrito.github.io/gitbook-oss-t2

### Getting started

The first level structure, the chapters are defined in a JSON file named .config.json
in the folder *src/main/doc*  ontaining the chapters:

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

The key is the SUMMARY.Rmd file that is knitted to:

* Generate the chapters 
* Generate the GitBook second level structure using the GitHub API.

To be included in the GitBook, the organization repos must have a JSON file name .gitbook at the root of the repository with the chapter they belong to. 

Below an example of such file: 

```json
{
"section": "DCS Field Guide"
}
```

### Deploy the GitBook

```
cd
git clone git@github.com:fabricebrito/gitbook-oss-t2.git
cd gitbook-oss-t2.git
mvn site-deploy
```

### Questions, bugs, and suggestions

Please file any bugs or questions as [issues](https://github.com/fabricebrito/gitbook-oss-t2/issues/new) or send in a pull request.

### License

Copyright 2014 Terradue Srl

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
