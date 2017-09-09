#!/bin/bash

npm install
npm run build
echo $GIT_COMMIT > assets/commit.txt
zip -r assets.zip assets/
echo $JENKINS_HOME