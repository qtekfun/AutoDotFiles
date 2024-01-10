setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    # ... the remaining setup is unchanged

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/..:$PATH"
}

@test "can run our script" {
    run install.sh
    assert_output 'Hello it is installed'
}

@test "file exists" {
    source ./src/common/filesystem.sh
    run file_exists $BATS_TEST_FILENAME
    assert_output "$BATS_TEST_FILENAME exists."
    [ "$status" -eq 1 ]
}

@test "file not exists" {
    source ./src/common/filesystem.sh
    run file_exists "~/dummy"
    assert_output "~/dummy doesn't exist."
    [ "$status" -eq 0 ]
}