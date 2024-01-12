setup() {
    load 'test_helper/common-setup'
    _common_setup

    source "$PROJECT_ROOT/src/common/filesystem.sh"
    TEST_FOLDER="$PROJECT_ROOT/testing_stuff"
    run bash -c "mkdir -p $TEST_FOLDER"
    TEST_FILE="$TEST_FOLDER/test_file.txt"
}

teardown() {
    run bash -c "rmdir $TEST_FOLDER"
}

@test "file exists" {
    run file_exists $BATS_TEST_FILENAME
    [ "$status" -eq 1 ]
}

@test "file not exists" {
    run file_exists "~/dummy"
    [ "$status" -eq 0 ]
}

@test "append line to file" {
    run touch $TEST_FILE
    run append_to_file $TEST_FILE "This works."
    run cat $TEST_FILE
    assert_output "This works."
    run rm $TEST_FILE
    [ "$status" -eq 0 ]
}

@test "append line to file multiple lines" {

    run touch $TEST_FILE
    run append_to_file $TEST_FILE "This works.\nand in two lines."
    run cat $TEST_FILE
    assert_output "This works.
and in two lines."
    run rm $TEST_FILE
    [ "$status" -eq 0 ]
}

@test "check line in file that exists" {
    run touch $TEST_FILE
    run bash -c "echo 'line' > $TEST_FILE"
    run find_in_file $TEST_FILE "line"
    [ "$status" -eq 1 ]
    run rm $TEST_FILE
}

@test "check line in file that not exists" {
    run touch $TEST_FILE
    run find_in_file $TEST_FILE "line"
    [ "$status" -eq 0 ]
    run rm $TEST_FILE
}

@test "create file" {
    run create_file $TEST_FILE
    [ "$status" -eq 0 ]
    run file_exists $TEST_FILE
    [ "$status" -eq 1 ]
    run rm $TEST_FILE
}