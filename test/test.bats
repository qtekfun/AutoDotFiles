setup() {
    load 'test_helper/common-setup'
    _common_setup
}

@test "can run our script" {
    run $PROJECT_ROOT/install.sh
    assert_output 'Hello it is installed'
    [ "$status" -eq 0 ]
}