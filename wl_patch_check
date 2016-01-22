#!/bin/bash

. $HOME/.config/wayland-build-tools/wl_defines.sh

## == Code Review ==
## Is the code correct?
## Does it fix the problem that it proposed to fix? Or does it successfully
##  implement the feature it proposed to implement?
## Will it pose future problems, architecturally, security-wise, etc.?
## Does it have unit tests? Is it documenting the API?
## Is the code style correct?

## == Build Check ==
## Does it compile? Does it introduce new bugs?
## 1.  Tag applicable patches with 't'
## 2.  Run macro ('ctrl-h') to save them to ~/incoming-patches

# Apply the patches to a test branch
git_branch_from_mboxes() {
    branch_id=$1
    shift
    mboxes="$@"
    echo "Patching $branch_id"

#    echo $branch_id
#    echo $mboxes
#    return

    cd ~/Wayland/weston
    git clean -f || return 2
    git checkout master || return 3
    git pull || return 4
    git branch -D ${branch_id}
    git branch ${branch_id} || return 5
    git checkout ${branch_id} || return 6
    git am ~/incoming-patches/${branch_id}/*.mbox
    if [ $? != 0 ]; then
	git am --abort
	return 7
    fi
    return 0
}

# Verify build
rebuild_all() {
    branch_id=$1
    echo "Rebuilding $branch_id"
    cd ~/Wayland
    wl_build > ~/incoming-patches/${branch_id}/build-patched.log 2>&1
    grep error: ~/incoming-patches/${branch_id}/build-patched.log
}

# Run tests
test_weston() {
    branch_id=$1
    echo "Testing $branch_id"
    cd ~/Wayland/weston
    make check > ~/incoming-patches/${branch_id}/test-patched.log 2>&1
}

branch_id="wayland_review_0005"
git_branch_from_mboxes ${branch_id} $(ls ~/incoming-patches/${branch_id}/*.mbox)
if [ $? != 0 ]; then
    echo "Error creating git branch: $?"
    exit 2
fi
rebuild_all ${branch_id}
if [ $? != 0 ]; then
    echo "Error building branch: $?"
    exit 3
fi
test_weston ${branch_id}
if [ $? != 0 ]; then
    echo "Error testing branch: $?"
    exit 4
fi

#5.  Do a clean build for comparison
#    git checkout master
#    wl_build > ~/incoming-patches/build-master.log 2>&1
#    grep error: ~/incoming-patches/review_000N/build-patched.log
#    cd ~/Wayland/weston
#    make check > ~/incoming-patches/test-master.log 2>&1
#
#6.  Compare patched vs. clean
#    grep -i warning build-master.log > build-master-warnings.log
#    grep -i warning build-patched.log > build-patched-warnings.log
#    diff -wBd build-master-warnings.log build-patched-warnings.log
#
#    diff -Nurp test-master.log test-patched.log 
#
#This is starting to feel a bit like crucible all over again, with run
#id's and processing patches...
#
#Once I have this suitably scripted I can start doing reviews and tests
#daily, and start really mass producing stats for myself.
#
# TODO: Avoid needing to rebuild everything if we're only patching weston
# TODO: Separately cache each build so it's easier to test each
