iOS Client for SparkleShare Project at http://www.sparkleshare.org

## Current Development Status ##

SparkleShare for iOS is in Alpha development stage

### Implemented features ###

 - Linking with Dashboard (both with QR code or manual)
 - Browsing repos contents
 - Previewing files

### Planned features ###

 - Uploading files

### Build on osx


* install git [[http://help.github.com/mac-set-up-git/]]

* start `Terminal` and execute:

        mkdir projects
        cd projects
        git clone git://github.com/darvin/SparkleShare-iOS.git
        cd SparkleShare-iOS
        git submodule update --init
        
* start xcode and open project at:

projects/SparkleShare-iOS/SparkleShare.xcodeproj


### Known issues & workarounds

* If subversion fails on SVProgressHUD then do this:
        
        close xcode (to avoide xcode crash)
        cd projects/SparkleShare-iOS/libs/
        rm -rf SVProgressHUD
        git clone git://github.com/samvermette/SVProgressHUD.git
        git clone git://github.com/darvin/UIImage-FileType.git
        
