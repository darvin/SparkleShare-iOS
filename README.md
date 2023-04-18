iOS Client for [SparkleShare Project](http://www.sparkleshare.org)

# [SparkleShare](https://www.sparkleshare.org/)

[SparkleShare](https://www.sparkleshare.org/) is a file sharing and collaboration app. It works just like Dropbox, and you can run it on your own server. It's available for Linux distributions, macOS, and Windows.

![Banner](https://raw.githubusercontent.com/hbons/SparkleShare/master/SparkleShare/Common/Images/readme-banner.png)

You can support this project through [💕 GitHub Sponsors](https://github.com/sponsors/hbons).

## How does it work?

SparkleShare creates a special folder on your computer. You can add remotely hosted folders (or "projects") to this folder. These projects will be automatically kept in sync with both the host and all of your peers when someone adds, removes or edits a file.

## Set up a host

Under the hood SparkleShare uses the version control system [Git](https://git-scm.com/) and the large files extension [Git LFS](https://git-lfs.github.com), so setting up a host yourself is relatively easy. Using your own host gives you more privacy and control, as well as lots of cheap storage space and higher transfer speeds. We've made a simple [script](https://github.com/hbons/Dazzle) that does the hard work for you. If you need to manage a lot of projects and/or users we recommend hosting a [GitLab Community Edition](https://about.gitlab.com/installation/) instance.




### Build on osx

* Execute:

```sh
git clone git://github.com/darvin/SparkleShare-iOS.git
cd SparkleShare-iOS
git submodule update --init
open SparkleShare.xcodeproj
```

* Build SparkleShare for iOS
