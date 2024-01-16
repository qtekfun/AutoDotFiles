setup() {
    load 'test_helper/common-setup'
    _common_setup

    source "$PROJECT_ROOT/src/common/logging.sh"
    TEST_FOLDER="$PROJECT_ROOT/testing_stuff"
    run bash -c "mkdir -p $TEST_FOLDER"
    LOG_FILE="$TEST_FOLDER/log_file.txt"
}

teardown() {
    run bash -c "rmdir $TEST_FOLDER"
}

@test "log 'Hello'" {
    run log "Hello" $LOG_FILE
    run cat $LOG_FILE
    assert_output -p "Hello"
    [ "$status" -eq 0 ]
    run rm $LOG_FILE
}