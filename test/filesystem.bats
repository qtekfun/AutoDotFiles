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

@test "append line to file" {
    run touch "test_file.txt"
    run append_to_file "test_file.txt" "This works."
    run cat "test_file.txt"
    assert_output "This works."
    run rm "test_file.txt"
    [ "$status" -eq 0 ]
}

@test "check line in file that exists" {
    run touch "test_file.txt"
    run bash -c "echo 'line' > 'test_file.txt'"
    run find_in_file "test_file.txt" "line"
    [ "$status" -eq 1 ]
    run rm "test_file.txt"
}

@test "check line in file that not exists" {
    run touch "test_file.txt"
    run find_in_file "test_file.txt" "line"
    [ "$status" -eq 0 ]
    run rm "test_file.txt"
}

@test "create file" {
    run create_file "test_file.txt"
    [ "$status" -eq 0 ]
    run file_exists "test_file.txt"
    [ "$status" -eq 1 ]
    run rm "test_file.txt"
}