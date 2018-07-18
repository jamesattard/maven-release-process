mvn –B release:prepare
mvn release:perform
mvn build-helper:parse-version versions:set -B -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}.\${parsedVersion.nextIncrementalVersion}-SNAPSHOT
git add .
git commit –m "BugFix Release Bump"
git push origin master
