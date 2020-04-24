addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.9.2")

addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.1.0-M13")

// "dependencyUpdates" show updates
addSbtPlugin("com.timushev.sbt" % "sbt-updates" % "0.4.2")

//better errors
//addSbtPlugin("com.softwaremill.clippy" % "plugin-sbt" % "0.6.1")

// check dependencies CVEs "dependencyCheck"
addSbtPlugin("net.vonbuchholtz" % "sbt-dependency-check" % "1.3.0")
