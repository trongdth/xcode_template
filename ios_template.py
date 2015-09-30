import os
import sys
import getopt
import subprocess
import re

__author__ = 'Trong Dinh (trongdth@gmail.com)'
__ERR1__ = 'Missing path to template folder'
__ERR2__ = 'There is an error with your Xcode!!!'
__xcode4_project_template_path = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates"
__xcode6_project_template_path = "/Users/" + subprocess.check_output("echo $USER", shell=True).rstrip() + "/Library/Developer/Xcode/Templates/Project Templates"
__sudo_pwd = "{YOUR_SU_PWD_HERE}"


def go_to_template_folder(xcode_template):
    root_template = "MroomSoftware"
    try:
        os.chdir(xcode_template)
        os.system("echo " + __sudo_pwd + " | sudo -S mkdir -p " + root_template)
        os.chdir(xcode_template + "/" + root_template)
    except OSError as e:
        print __ERR2__ + " " + e
        exit()


def copy_template(path):
    value = subprocess.check_output(["xcodebuild", "-version"])
    xcode_version = re.search("\\d.\\d", value)
    if xcode_version.group() < 6.0:
        go_to_template_folder(__xcode4_project_template_path)

    go_to_template_folder(__xcode6_project_template_path)
    os.system("echo " + __sudo_pwd + " | sudo -S cp -R " + path + " .")


def main(argv):
    path_to_template = ''
    try:
        opts, args = getopt.getopt(argv, "hd:", ["dTemplatePath="])
    except getopt.GetoptError:
        print __ERR1__
        sys.exit()
    for opt, arg in opts:
        if opt == '-h':
            print "python ios_template.py -d {path_to_your_template}"
            sys.exit()
        elif opt in ("-d", "--dTemplatePath"):
            path_to_template = arg

    if len(path_to_template) == 0 | len(opts) != 1:
        print __ERR1__
        exit()
    copy_template(path_to_template)


if __name__ == '__main__':
    main(sys.argv[1:])
