/* applicationRollback --appId= [--target=] [--zsurl=] [--zskey=] [--zssecret=] [--zsversion=] [--http=]

Rollback an existing application to its previous version. This process is asynchronous, meaning the initial request will start the rollback process and the initial response will show information about the application being rolled back. You must continue checking the application status using the applicationGetStatus method until the process is complete
  --appId    The application ID you would like to rollback.

*/