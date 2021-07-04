# youtube-publish / Cross Application Navigation between two UI5 applications on BTP Launchpad
> Customer App and Order App

* clone the repository: `git clone https://github.com/developedbysom/youtube-publish.git --branch ui5-cross-app-navigation-btp-launchpad`

* Get into the respective application folders and run command from terminal:
`npm install`  You should have [node](https://nodejs.org/en/download/) installed in your machine

* Test the applications: ***Make sure current directory is the application folder which to be executed***
`npm run start` This will execute the concerned application locally 

* Deploy the application to SAP BTP:
* 
`npm deploy-config` This will create the config files and ensure you set the destination name as Northwind.

`npm deploy:mta` This will create the mta archive file, for that I have installed make software in my windows from http://gnuwin32.sourceforge.net/packages/make.htm and used the setup file from "Complete package, except sources"

* Finally deploy the respective apps into BTP as HTML5 applications
`npm deploy` 


