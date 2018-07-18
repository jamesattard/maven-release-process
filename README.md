# Why?

Looks like there are no documented scripts to do simple Maven releases that one can easily follow. This repository has three different use cases scripts that can be used to perform the following kind of releases with version bumping and tagging:

1.  Major Releases
2.  Minor Releases
3.  BugFix Releases

Note that the version bumping assumes the following version format:
`<major><minor><bugfix>`

# Prerequisites

Before running the scripts for your Java/Scala project, make sure that the _pom.xml_ file is configured appropriately to support both the **SCM** and **Maven Release Plugin**:

_pom.xml:_

```xml
<project>
...
<version>1.0.0-SNAPSHOT</version>
  <scm>
      <connection>scm:git:ssh://git@some-repo.com:7999/demo.git</connection>
      <developerConnection>scm:git:ssh://some-repo.com:7999/demo.git</developerConnection>
      <url>https://some-repo.com:7999/demo/browse</url>
      <tag>@{project.version}</tag>
  </scm>
  <build>
    <plugins>
      <plugin>
        <artifactId>maven-assembly-plugin</artifactId>
        <version>3.0.0</version>
        <configuration>
          <archive>
            <manifest>
              <addDefaultImplementationEntries>true</addDefaultImplementationEntries>
              <addDefaultSpecificationEntries>true</addDefaultSpecificationEntries>
              <mainClass>org.ea.VersioningDemo</mainClass>
            </manifest>
          </archive>
          <descriptorRefs>
            <descriptorRef>jar-with-dependencies</descriptorRef>
          </descriptorRefs>
        </configuration>
        <executions>
            <execution>
                <phase>package</phase>
                <goals>
                    <goal>single</goal>
                </goals>
            </execution>
        </executions>
      </plugin>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-release-plugin</artifactId>
        <version>2.5.3</version>
        <configuration>
          <goals>pre-integration-test</goals>
          <preparationGoals>package</preparationGoals>
          <allowTimestampedSnapshots>true</allowTimestampedSnapshots>
          <tagNameFormat>@{project.version}</tagNameFormat>
          <remoteTagging>false</remoteTagging>
          <checkModificationExcludes>
              <checkModificationExclude>pom.xml</checkModificationExclude>
          </checkModificationExcludes>
        </configuration>
      </plugin>
    </plugins>
  </build>
...
</project>
```

# Effects

When running the release scripts, the following will happen:

1.  Build the project (product JAR files)
2.  Create a tag (remote and local) by stripping the _SNAPSHOT_ string from _pom.xml_ file. Example: If the current pom.xml file is at version _1.0.0-SNAPSHOT_ a new tag _1.0.0_ is created.
3.  Increment the version inside pom.xml file and put the _SNAPSHOT_ suffix again.
