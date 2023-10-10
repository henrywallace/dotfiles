local M = {}

-- function M.snippet_refs(max_refs)
--     max_refs = max_refs or 10 -- Set a default maximum number of references

--     -- This function is asynchronous, so we need a callback function to handle the result
--     vim.lsp.buf.references(function(_, _, result)
--         if not result then return end

--         local snippets = {}
--         for i, ref in ipairs(result) do
--             if i > max_refs then break end

--             -- Use Treesitter to get a snippet of code around the reference
--             local snippet = get_snippet(ref.uri, ref.range.start.line, ref.range.start.character)
--             table.insert(snippets, snippet)
--         end

--         -- Concatenate the snippets and display them
--         print(table.concat(snippets, "\n"))
--     end)
-- end

-- function M.snippet_def()
--     -- This function is asynchronous, so we need a callback function to handle the result
--     vim.lsp.buf.definition(function(_, _, result)
--         if not result then return end

--         -- Use Treesitter to get a snippet of code around the definition
--         local snippet = get_snippet(result.uri, result.range.start.line, result.range.start.character)

--         -- Display the snippet
--         print(snippet)
--     end)
-- end

return M
