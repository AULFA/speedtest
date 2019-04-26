#!/bin/sh
VERSION=$(head -n 1 README-VERSION.txt) || exit 1
git archive --prefix "speedtest-${VERSION}/" --format zip develop > "speedtest-${VERSION}.zip" || exit 1
