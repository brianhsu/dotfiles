function _tide_item_gtd
    set inbox_icon ''
    set inbox_count (task +inbox +PENDING count)
    set action_icon ''
    set action_count (task +next +PENDING count)
    _tide_print_item gtd "$inbox_icon $inbox_count $action_icon $action_count"
end
