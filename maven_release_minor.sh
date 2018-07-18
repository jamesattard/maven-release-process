mvn –B release:prepare
mvn release:perform
mvn build-helper:parse-version versions:set -B -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.nextMinorVersion}.0-SNAPSHOT
git add .
git commit –m "Minor Release Bump"
git push origin master
