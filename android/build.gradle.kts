allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Force JVM 17 for all subprojects to fix plugin inconsistencies
subprojects {
    // Force JVM 17 for all subprojects to fix plugin inconsistencies
    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }
 
    // Configure Android extension directly for library modules
    project.pluginManager.withPlugin("com.android.library") {
        val android = project.extensions.getByType(com.android.build.gradle.BaseExtension::class.java)
        android.compileOptions {
            sourceCompatibility = JavaVersion.VERSION_17
            targetCompatibility = JavaVersion.VERSION_17
        }
    }

  
}

   
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
