setup() {
    load 'test_helper/common-setup'
    _common_setup
    source "$PROJECT_ROOT/src/common/system.sh"
}

@test "get OS in ubuntu" {
    run get_os
    assert_output -p "ubuntu"
    [ "$status" -eq 0 ]
}