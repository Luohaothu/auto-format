#!/bin/sh -l
# Action script. This is the shell script that gets executed when the action
# runs.

# Go into the directory where the default checkout action stored the clone
# of the repository
cd "$GITHUB_WORKSPACE"

# Run clang-format-9 on all .hpp and .cpp files using the .clang-format or
# _clang-format file located in the root of the repository directory
find . \( -name '*.hpp' -or -name '*.cpp' \) \
  -exec clang-format-9 -style=file -i {} \;

# check if anything changed to the repository
if ! git diff --no-ext-diff --quiet --exit-code; then
  echo ::set-output name=status::"changed"
else
  echo ::set-output name=status::"unchanged"
fi
