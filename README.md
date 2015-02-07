# To build and run locally
```
npm install
brunch w -s
```

Navigate to http://localhost:3333

# To push to divshot
```
brunch b -e prod
divshot push
```
The dev version should now be available at http://development.ss15-teampw.divshot.io/

# To Scaffolt a new view
```
scaffolt view my-view module:my-module
```

If you messed up and need to delete the generated view
```
scaffolt view my-view module:my-module -r
```