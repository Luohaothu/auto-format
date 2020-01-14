# Action to automatically format C++ code using clang-format

This action automatically formats all `*.cpp` and `*.hpp` files in a
repository using `clang-format-9`. It uses a `.clang-format` or
`_clang-format` style file stored in the root of the repository.

This action can only be executed after the repository has been checked
out using `actions/checkout` (we strongly recommend using
`actions/checkout@v2`). Upon exit, the action will set a status variable
that indicates whether any changes were made to the repository. A
workflow that includes this action can decide to automatically commit
the reformatted files based on this status.

## Inputs

None.

## Outputs

### `status`

Status code that indicates if formatting was performed (based on a `git
diff`).

Possible values are
 - `changed`: one or more files in the repository were reformatted
 - `unchanged`: all files were already correctly formatted and no changes were
    made

## Example usage

The following example workflow runs the automatic formatting whenever a
`git push` event occurs:

```
on: [push]
jobs:
  autoformat_job:
    runs-on: ubuntu-latest
    name: Automatic formatting
    steps:
    - name: Checkout
      uses: actions/checkout@v2
    - name: Autoformat
      id: format
      uses: SKIRT/auto-format@master
    - name: Autocommit
      if: steps.format.outputs.status == 'changed'
      run: |
        git config --global user.name 'auto-format'
        git config --global user.email 'auto-format@auto.format'
        git commit -am "Autoformat"
        git push
```

Note that this only works with `actions/checkout@v2` due to the
fundamentally different way the repository is checked out between `v1`
and `v2`. If you are only interested in the status and do not want to
automatically commit the changes, `v1` also works.

Also note that `actions/checkout@v2` ensures that the `git push` in the
last step of the workflow does not trigger another call of the workflow,
to avoid infinite loops.
