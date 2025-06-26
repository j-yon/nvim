local function imports()
    return require("luasnip"), require("neorg.modules.external.templates.default_snippets")
end

return {
    YESTERDAY_OF_FILEPATH = function() -- detect date from filename and return its file path to be used in a link
        local ls, m = imports()
        return ls.text_node(m.parse_date(-1, m.file_tree_date(), [[../../%Y/%m/%d]])) -- ../../2020/01/01
    end,
    TOMORROW_OF_FILEPATH = function() -- detect date from filename and return its file path to be used in a link
        local ls, m = imports()
        return ls.text_node(m.parse_date(1, m.file_tree_date(), [[../../%Y/%m/%d]])) -- ../../2020/01/01
    end,
}
