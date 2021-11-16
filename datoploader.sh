#!/bin/sh

for argument in "$@"; do
  if [ ! -f "$argument" ]; then
    echo "Error: No such file or directory: \"$argument\"" 1>&2;
    continue
  fi

  if file $argument | grep -v -q "Composite Document File V2 Document"; then
    echo "Error: File \"$argument\" does not appear to be a \"Composite Document File V2 Document\"" 1>&2;
    continue
  fi

  xls2csv "$argument" | sed 's/""*/"/g; s/"&"//g' | tr "," "\n" | grep "://" | sort -u | tr -d '"' | sort -u
done
