setup() {
    load 'test_helper/common-setup'
    _common_setup

    source "$PROJECT_ROOT/src/common/filesystem.sh"
}

@test "file exists" {
    run file_exists $BATS_TEST_FILENAME
    assert_output "$BATS_TEST_FILENAME exists."
    [ "$status" -eq 1 ]
}

@test "file not exists" {
    run file_exists "~/dummy"
    assert_output "~/dummy doesn't exist."
    [ "$status" -eq 0 ]
}