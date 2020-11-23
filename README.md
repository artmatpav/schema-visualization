# schema-visualization

Login to devhub org:
sfdx force:auth:web:login -d -a NameOfDevHubOrg

After login to dev hub it's time to create your scratch (org witch lives 30 days):
sfdx force:org:create -f config/project-scratch-def.json -d 30 -s -a NameofYourScratchOrg

If you got LIMIT Error please log into you dev hub org, in App Launcher open Active Scratch Orgs and delete 1, or you can use command to delete previous scratch:
sfdx force:org:delete -p

After successfull org creation need to push all the data:
sfdx force:source:push   (use -f if you have conflicts and you want to overwrite all in your scratch from you source)

Then open your org with next command
sfdx force:org:open

To test the component - Select Sales in Apps menu > Click gear icon > Edit Page > Drag and drop schemaVisualization component above left column > Click Save > Activate > Assign as Org Default > Save > Click Back Button > Then you can see the component, try to select SObject.
