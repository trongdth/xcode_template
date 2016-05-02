# Xcode template

It's used for importing your own template to Xcode

## REQUIREMENTS

1. python (https://www.python.org/downloads/).
2. Xcode

## USAGE

 1. Open and ios_template.py and change your own password at line 12: __sudo_pwd = "YOUR_PASSWORD_HERE"
 2. Open terminal and run: python ios_template.py -d {PATH_TO_YOUR_TEMPLATE}

## HOW TO USE MY TEMPLATE
 1. Create your own project with MroomSoftware template.
 2. Move Podfile to the same current path of .xcodeproj (http://imgur.com/mOLiVj8)
 3. Run pod install.
 4. Add prefix header in build settings: "$(PRODUCT_NAME)/MroomSoftware-Prefix.pch" (http://imgur.com/COZwGSv)
 5. Add flag "-fno-objc-arc" for EGORefreshTableHeaderView.m (http://imgur.com/JnOOXnX)
  

## Author

Trong Dinh, trongdth@gmail.com
