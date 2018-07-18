mvn –B release:prepare
mvn release:perform
mvn build-helper:parse-version versions:set -B -DnewVersion=\${parsedVersion.nextMajorVersion}.\${parsedVersion.minorVersion}.0-SNAPSHOT
git add .
git commit –m "Major Release Bump"
git push origin master
