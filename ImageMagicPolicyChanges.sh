#!/bin/bash

# We need to rise memory quota to be used by convert & compare commands
# to be able to process some of the largest HEPData records
# needed for 'scripts/CompareFigures_HepData_AnalysisWebpage.py' and
# 'scripts/CompareToOldGitPNGfiles.py' of https://gitlab.cern.ch/bozek/hepdatasubmissions

xmlstarlet ed -P  -u '//policy[@name="memory"]/@value' -v "2GB" \
	   -u '//policy[@name="map"]/@value' -v "2GB" \
	   /etc/ImageMagick-6/policy.xml > tmp.xml
cat tmp.xml | grep -v '\"PDF\"' > tmp2.xml
mv tmp2.xml /etc/ImageMagick-6/policy.xml
