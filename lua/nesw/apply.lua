local M = {}

local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

function M.setup(palette)
    if vim.g.colors_name then
        vim.cmd("highlight clear")
    end
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    vim.cmd("highlight! clear TermCursor")
    vim.cmd("highlight! clear TermCursorNC")

    vim.o.background = palette.background
    vim.g.colors_name = palette.name

    -- terminal colors
    for i, color in ipairs(palette.ansi) do
        vim.g["terminal_color_" .. (i - 1)] = color
        hl("TerminalColor" .. (i - 1), { fg = color })
    end

    local u = palette.ui
    local s = palette.syntax
    local d = palette.diagnostic
    local g = palette.git

    -- base
    hl("Normal", { fg = u.fg, bg = u.bg })
    hl("NormalFloat", { fg = u.fg, bg = u.bg_soft })
    hl("FloatBorder", { fg = u.border, bg = u.bg_soft })
    hl("FloatTitle", { fg = u.fg_muted, bg = u.bg_soft, bold = true })
    hl("NormalNC", { fg = u.fg, bg = u.bg })
    hl("NormalSB", { fg = u.fg, bg = u.bg_soft })

    -- cursor
    hl("Cursor", { fg = u.bg, bg = u.cursor })
    hl("CursorIM", { fg = u.bg, bg = u.cursor })
    hl("CursorLine", { bg = u.line_highlight })
    hl("CursorColumn", { bg = u.line_highlight })
    hl("TermCursor", { fg = u.bg, bg = u.cursor })
    hl("TermCursorNC", { fg = u.bg, bg = u.fg_dim })

    -- line numbers
    hl("LineNr", { fg = u.line_nr })
    hl("LineNrAbove", { fg = u.line_nr })
    hl("LineNrBelow", { fg = u.line_nr })
    hl("CursorLineNr", { fg = u.line_nr_active, bold = true })
    hl("SignColumn", { fg = u.line_nr, bg = u.bg })
    hl("SignColumnSB", { fg = u.line_nr, bg = u.bg_soft })

    -- selection
    hl("Visual", { bg = u.selection, fg = u.fg })
    hl("VisualNOS", { bg = u.selection, fg = u.fg })

    -- search
    hl("Search", { fg = u.bg, bg = d.warn })
    hl("IncSearch", { fg = u.bg, bg = u.accent })
    hl("CurSearch", { fg = u.bg, bg = d.warn })
    hl("Substitute", { fg = u.bg, bg = d.warn })

    -- matching
    hl("MatchParen", { bg = u.bg_muted, bold = true })
    hl("ShowMarksHL", { fg = u.accent, bold = true })

    -- folding
    hl("Folded", { fg = u.fg_muted, bg = u.bg_soft })
    hl("FoldColumn", { fg = u.fg_dim, bg = u.bg })

    -- whitespace
    hl("NonText", { fg = u.fg_dim })
    hl("SpecialKey", { fg = u.fg_dim })
    hl("Whitespace", { fg = u.fg_dim })
    hl("Conceal", { fg = u.fg_dim })
    hl("EndOfBuffer", { fg = u.bg })

    -- misc ui
    hl("ColorColumn", { bg = u.bg_muted })
    hl("QuickFixLine", { bg = u.bg_muted })
    hl("ModeMsg", { fg = u.fg_muted })
    hl("MsgArea", { fg = u.fg })
    hl("MoreMsg", { fg = u.accent })
    hl("Question", { fg = u.accent })
    hl("WildMenu", { fg = u.bg, bg = u.accent })
    hl("Directory", { fg = u.accent })
    hl("Title", { fg = u.fg, bold = true })
    hl("HelpCommand", { fg = u.accent })
    hl("HelpExample", { fg = s.string })

    -- statusline
    hl("StatusLine", { fg = u.fg_muted, bg = u.bg_soft })
    hl("StatusLineNC", { fg = u.fg_dim, bg = u.bg })

    -- separators
    hl("WinSeparator", { fg = u.border })
    hl("VertSplit", { fg = u.border })

    -- tabline
    hl("TabLine", { fg = u.fg_dim, bg = u.bg_soft })
    hl("TabLineFill", { bg = u.bg_soft })
    hl("TabLineSel", { fg = u.fg, bg = u.bg, bold = true })
    hl("TabLineClose", { fg = u.fg_dim })
    hl("TabLineCloseSel", { fg = d.error })

    -- popup menu
    hl("Pmenu", { fg = u.fg, bg = u.bg_soft })
    hl("PmenuSel", { fg = u.fg, bg = u.selection })
    hl("PmenuSbar", { bg = u.bg_muted })
    hl("PmenuThumb", { bg = u.fg_dim })
    hl("PmenuKind", { fg = u.fg_muted })
    hl("PmenuKindSel", { fg = u.fg, bg = u.selection })
    hl("PmenuExtra", { fg = u.fg_dim })
    hl("PmenuExtraSel", { fg = u.fg, bg = u.selection })
    hl("PmenuMatch", { fg = u.accent })
    hl("PmenuMatchSel", { fg = u.accent, bg = u.selection })

    -- spelling
    hl("SpellBad", { undercurl = true, sp = d.error })
    hl("SpellCap", { undercurl = true, sp = d.warn })
    hl("SpellLocal", { undercurl = true, sp = d.info })
    hl("SpellRare", { undercurl = true, sp = d.hint })

    -- diff
    hl("DiffAdd", { bg = g.add .. "33" })
    hl("DiffChange", { bg = g.modify .. "33" })
    hl("DiffDelete", { bg = g.delete .. "33" })
    hl("DiffText", { bg = g.modify .. "66" })

    -- messages
    hl("Error", { fg = d.error, bg = u.bg })
    hl("ErrorMsg", { fg = d.error })
    hl("WarningMsg", { fg = d.warn })
    hl("InfoMsg", { fg = d.info })

    -- diagnostics
    hl("DiagnosticError", { fg = d.error })
    hl("DiagnosticWarn", { fg = d.warn })
    hl("DiagnosticInfo", { fg = d.info })
    hl("DiagnosticHint", { fg = d.hint })
    hl("DiagnosticOk", { fg = g.add })
    hl("DiagnosticUnderlineError", { undercurl = true, sp = d.error })
    hl("DiagnosticUnderlineWarn", { undercurl = true, sp = d.warn })
    hl("DiagnosticUnderlineInfo", { undercurl = true, sp = d.info })
    hl("DiagnosticUnderlineHint", { undercurl = true, sp = d.hint })
    hl("DiagnosticUnderlineOk", { undercurl = true, sp = g.add })
    hl("DiagnosticFloatingError", { fg = d.error, bg = u.bg_soft })
    hl("DiagnosticFloatingWarn", { fg = d.warn, bg = u.bg_soft })
    hl("DiagnosticFloatingInfo", { fg = d.info, bg = u.bg_soft })
    hl("DiagnosticFloatingHint", { fg = d.hint, bg = u.bg_soft })
    hl("DiagnosticFloatingOk", { fg = g.add, bg = u.bg_soft })
    hl("DiagnosticSignError", { fg = d.error })
    hl("DiagnosticSignWarn", { fg = d.warn })
    hl("DiagnosticSignInfo", { fg = d.info })
    hl("DiagnosticSignHint", { fg = d.hint })
    hl("DiagnosticSignOk", { fg = g.add })
    hl("DiagnosticVirtualTextError", { fg = d.error })
    hl("DiagnosticVirtualTextWarn", { fg = d.warn })
    hl("DiagnosticVirtualTextInfo", { fg = d.info })
    hl("DiagnosticVirtualTextHint", { fg = d.hint })
    hl("DiagnosticVirtualTextOk", { fg = g.add })
    hl("DiagnosticUnnecessary", { fg = u.fg_dim, strikethrough = true })

    -- lsp
    hl("LspReferenceText", { bg = u.line_highlight })
    hl("LspReferenceRead", { bg = u.line_highlight })
    hl("LspReferenceWrite", { bg = u.line_highlight })
    hl("LspInlayHint", { fg = u.fg_dim, bg = u.bg_muted })
    hl("LspCodeLens", { fg = u.fg_dim })
    hl("LspSignatureActiveParameter", { fg = s.number, underline = true })

    -- vim syntax
    hl("Comment", { fg = s.comment, italic = true })
    hl("Constant", { fg = s.constant })
    hl("String", { fg = s.string })
    hl("Character", { fg = s.string })
    hl("Number", { fg = s.number })
    hl("Boolean", { fg = s.number })
    hl("Float", { fg = s.number })
    hl("Identifier", { fg = s.variable })
    hl("Function", { fg = s["function"] })
    hl("Keyword", { fg = s.keyword })
    hl("Statement", { fg = s.keyword })
    hl("Conditional", { fg = s.keyword })
    hl("Repeat", { fg = s.keyword })
    hl("Label", { fg = s.constant })
    hl("Operator", { fg = s.operator })
    hl("Exception", { fg = s.keyword })
    hl("Type", { fg = s.type })
    hl("StorageClass", { fg = s.keyword })
    hl("Structure", { fg = s.type })
    hl("Typedef", { fg = s.type })
    hl("Special", { fg = s.type })
    hl("SpecialChar", { fg = s.number })
    hl("Tag", { fg = u.accent })
    hl("Delimiter", { fg = s.punctuation })
    hl("SpecialComment", { fg = s.comment, bold = true })
    hl("Debug", { fg = s.constant })
    hl("Underlined", { fg = u.accent, underline = true })
    hl("Ignore", { fg = u.fg_dim })
    hl("Error", { fg = d.error, bg = u.bg })
    hl("Todo", { fg = d.warn, bold = true })
    hl("PreProc", { fg = s.keyword })
    hl("Include", { fg = s.keyword })
    hl("Define", { fg = s.keyword })
    hl("Macro", { fg = s.keyword })
    hl("PreCondit", { fg = s.keyword })

    -- treesitter captures
    -- comments
    hl("@comment", { link = "Comment" })
    hl("@comment.documentation", { link = "Comment" })

    -- strings
    hl("@string", { link = "String" })
    hl("@string.escape", { fg = s.number })
    hl("@string.regex", { fg = s.string })
    hl("@string.special", { fg = s.constant })
    hl("@string.special.symbol", { fg = s.constant })
    hl("@string.special.url", { fg = u.accent })

    -- numbers
    hl("@number", { link = "Number" })
    hl("@number.float", { link = "@number" })

    -- characters
    hl("@character", { link = "Character" })
    hl("@character.special", { fg = s.number })

    -- booleans
    hl("@boolean", { link = "Boolean" })

    -- constants
    hl("@constant", { link = "Constant" })
    hl("@constant.builtin", { fg = s.constant })
    hl("@constant.macro", { fg = s.constant })

    -- keywords
    hl("@keyword", { link = "Keyword" })
    hl("@keyword.function", { link = "@keyword" })
    hl("@keyword.return", { link = "@keyword" })
    hl("@keyword.conditional", { link = "@keyword" })
    hl("@keyword.repeat", { link = "@keyword" })
    hl("@keyword.exception", { link = "@keyword" })
    hl("@keyword.import", { link = "@keyword" })
    hl("@keyword.export", { link = "@keyword" })
    hl("@keyword.async", { link = "@keyword" })
    hl("@keyword.operator", { link = "@keyword" })
    hl("@keyword.storage", { link = "@keyword" })
    hl("@keyword.type", { link = "@keyword" })

    -- variables
    hl("@variable", { link = "Identifier" })
    hl("@variable.builtin", { fg = s.constant })
    hl("@variable.parameter", { fg = s.parameter })
    hl("@variable.member", { fg = s.variable })
    hl("@variable.global", { fg = s.variable })
    hl("@variable.environment", { fg = s.constant })
    hl("@variable.magic", { fg = s.constant })

    -- functions
    hl("@function", { link = "Function" })
    hl("@function.builtin", { fg = s["function"] })
    hl("@function.call", { fg = s["function"] })
    hl("@function.macro", { fg = s["function"] })
    hl("@function.method", { fg = s["function"] })
    hl("@function.method.call", { fg = s["function"] })

    -- types
    hl("@type", { link = "Type" })
    hl("@type.builtin", { fg = s.type })
    hl("@type.definition", { fg = s.type })
    hl("@type.qualifier", { fg = s.keyword })

    -- constructors
    hl("@constructor", { fg = s.type })

    -- properties/fields
    hl("@property", { fg = s.variable })
    hl("@field", { fg = s.variable })

    -- namespaces/modules
    hl("@namespace", { fg = s.type })
    hl("@module", { fg = s.type })

    -- operators
    hl("@operator", { fg = s.operator })

    -- punctuation
    hl("@punctuation", { fg = s.punctuation })
    hl("@punctuation.delimiter", { fg = s.punctuation })
    hl("@punctuation.bracket", { fg = s.punctuation })
    hl("@punctuation.special", { fg = s.punctuation })

    -- tags
    hl("@tag", { fg = u.accent })
    hl("@tag.attribute", { fg = s.type })
    hl("@tag.delimiter", { fg = s.punctuation })

    -- labels
    hl("@label", { fg = s.constant })

    -- exceptions
    hl("@exception", { link = "@keyword" })

    -- includes
    hl("@include", { link = "@keyword" })

    -- symbol
    hl("@symbol", { fg = s.constant })

    -- treesitter markup
    hl("@markup", { fg = u.fg })
    hl("@markup.strong", { bold = true })
    hl("@markup.italic", { italic = true })
    hl("@markup.strikethrough", { strikethrough = true })
    hl("@markup.underline", { underline = true })
    hl("@markup.heading", { fg = s.heading, bold = true })
    hl("@markup.heading.1", { fg = s.heading, bold = true })
    hl("@markup.heading.2", { fg = s.heading, bold = true })
    hl("@markup.heading.3", { fg = s.heading, bold = true })
    hl("@markup.heading.4", { fg = s.heading, bold = true })
    hl("@markup.heading.5", { fg = s.heading, bold = true })
    hl("@markup.heading.6", { fg = s.heading, bold = true })
    hl("@markup.link", { fg = u.accent, underline = true })
    hl("@markup.link.url", { fg = u.accent, underline = true })
    hl("@markup.link.label", { fg = s["function"] })
    hl("@markup.list", { fg = u.accent })
    hl("@markup.list.checked", { fg = g.add })
    hl("@markup.list.unchecked", { fg = u.fg_dim })
    hl("@markup.raw", { fg = s.string })
    hl("@markup.raw.block", { fg = s.string })
    hl("@markup.raw.inline", { fg = s.string })
    hl("@markup.quote", { fg = u.fg_muted, italic = true })
    hl("@markup.math", { fg = s.type })
    hl("@markup.environment", { fg = s.type })
    hl("@markup.environment.name", { fg = s.type })

    -- treesitter diff
    hl("@diff.plus", { fg = g.add })
    hl("@diff.minus", { fg = g.delete })
    hl("@diff.delta", { fg = g.modify })

    -- treesitter lsp semantic tokens
    hl("@lsp.type.class", { fg = s.type })
    hl("@lsp.type.enum", { fg = s.type })
    hl("@lsp.type.enumMember", { fg = s.number })
    hl("@lsp.type.interface", { fg = s.type })
    hl("@lsp.type.struct", { fg = s.type })
    hl("@lsp.type.type", { fg = s.type })
    hl("@lsp.type.typeParameter", { fg = s.type })
    hl("@lsp.type.parameter", { fg = s.parameter })
    hl("@lsp.type.variable", { fg = s.variable })
    hl("@lsp.type.property", { fg = s.variable })
    hl("@lsp.type.field", { fg = s.variable })
    hl("@lsp.type.function", { fg = s["function"] })
    hl("@lsp.type.method", { fg = s["function"] })
    hl("@lsp.type.keyword", { fg = s.keyword })
    hl("@lsp.type.comment", { link = "Comment" })
    hl("@lsp.type.string", { fg = s.string })
    hl("@lsp.type.number", { fg = s.number })
    hl("@lsp.type.boolean", { fg = s.number })
    hl("@lsp.type.const", { fg = s.constant })
    hl("@lsp.type.namespace", { fg = s.type })
    hl("@lsp.type.decorator", { fg = s.number })
    hl("@lsp.type.macro", { fg = s.keyword })
    hl("@lsp.type.modifier", { fg = s.keyword })
    hl("@lsp.type.operator", { fg = s.operator })
    hl("@lsp.type.regexp", { fg = s.string })
    hl("@lsp.type.selfKeyword", { fg = s.keyword })
    hl("@lsp.type.builtinType", { fg = s.type })
    hl("@lsp.type.builtinConstant", { fg = s.constant })
    hl("@lsp.type.defaultLibrary", { fg = s.constant })

    -- markdown (legacy)
    hl("markdownH1", { fg = s.heading, bold = true })
    hl("markdownH2", { fg = s.heading, bold = true })
    hl("markdownH3", { fg = s.heading, bold = true })
    hl("markdownH4", { fg = s.heading, bold = true })
    hl("markdownH5", { fg = s.heading, bold = true })
    hl("markdownH6", { fg = s.heading, bold = true })
    hl("markdownHeadingDelimiter", { fg = s.heading, bold = true })
    hl("markdownCode", { fg = s.string })
    hl("markdownCodeBlock", { fg = s.string })
    hl("markdownCodeDelimiter", { fg = s.heading })
    hl("markdownBlockquote", { fg = u.fg_muted, italic = true })
    hl("markdownListMarker", { fg = u.accent })
    hl("markdownOrderedListMarker", { fg = u.accent })
    hl("markdownRule", { fg = u.fg_dim })
    hl("markdownUrl", { fg = u.accent, underline = true })
    hl("markdownLinkText", { fg = s["function"] })
    hl("markdownLinkTextDelimiter", { fg = s.punctuation })
    hl("markdownBold", { bold = true })
    hl("markdownItalic", { italic = true })
    hl("markdownBoldDelimiter", { fg = s.punctuation })
    hl("markdownItalicDelimiter", { fg = s.punctuation })
    hl("markdownIdDeclaration", { fg = s["function"] })
    hl("markdownFootnote", { fg = s["function"] })
    hl("markdownFootnoteDefinition", { fg = s["function"] })
    hl("markdownReference", { fg = s.variable })
    hl("markdownError", { fg = d.error })

    -- mini.nvim
    hl("MiniPickBorder", { fg = u.border, bg = u.bg })
    hl("MiniPickBorderText", { fg = u.fg_muted, bg = u.bg })
    hl("MiniPickBorderBusy", { fg = d.warn, bg = u.bg })
    hl("MiniPickNormal", { fg = u.fg, bg = u.bg })
    hl("MiniPickPrompt", { fg = u.fg, bg = u.bg, bold = true })
    hl("MiniPickMatchCurrent", { fg = u.fg, bold = true })
    hl("MiniPickMatchRanges", { fg = u.fg_dim })
    hl("MiniPickMatchMark", { fg = u.accent })
    hl("MiniPickIconDirectory", { fg = u.accent })
    hl("MiniPickIconFile", { fg = u.fg_muted })
    hl("MiniPickIconLink", { fg = u.accent, underline = true })
    hl("MiniPickPreviewRegion", { bg = u.bg_soft })
    hl("MiniPickPreviewLine", { bg = u.line_highlight })
    hl("MiniFilesBorder", { fg = u.border, bg = u.bg })
    hl("MiniFilesBorderModified", { fg = d.warn, bg = u.bg })
    hl("MiniFilesTitle", { fg = u.fg_muted, bg = u.bg_soft, bold = true })
    hl("MiniFilesTitleFocused", { fg = u.fg, bg = u.bg_soft, bold = true })
    hl("MiniFilesDirectory", { fg = u.accent })
    hl("MiniFilesFile", { fg = u.fg })
    hl("MiniFilesCursorLine", { bg = u.line_highlight })
    hl("MiniNotifyBorder", { fg = u.border, bg = u.bg_soft })
    hl("MiniNotifyNormal", { fg = u.fg, bg = u.bg_soft })
    hl("MiniNotifyTitle", { fg = u.fg_muted, bg = u.bg_soft })
    hl("MiniCompletionActiveParameter", { fg = s.number, underline = true })
    hl("MiniSurround", { fg = u.bg, bg = u.accent })

    -- mason
    hl("MasonNormal", { fg = u.fg, bg = u.bg_soft })
    hl("MasonHeader", { fg = u.bg, bg = u.accent, bold = true })
    hl("MasonHeaderSecondary", { fg = u.bg, bg = s.type, bold = true })
    hl("MasonHighlight", { fg = u.accent })
    hl("MasonHighlightBlock", { fg = u.bg, bg = u.accent })
    hl("MasonHighlightBlockBold", { fg = u.bg, bg = u.accent, bold = true })
    hl("MasonHighlightSecondary", { fg = s.type })
    hl("MasonHighlightBlockSecondary", { fg = u.bg, bg = s.type })
    hl("MasonHighlightBlockBoldSecondary", { fg = u.bg, bg = s.type, bold = true })
    hl("MasonLink", { fg = u.accent, underline = true })
    hl("MasonMuted", { fg = u.fg_dim })
    hl("MasonMutedBlock", { fg = u.bg, bg = u.fg_dim })
    hl("MasonError", { fg = d.error })
    hl("MasonWarning", { fg = d.warn })
    hl("MasonHeading", { fg = u.fg, bold = true })
    hl("MasonPackage", { fg = u.fg })
    hl("MasonPackageInstalled", { fg = g.add })
    hl("MasonPackagePending", { fg = d.warn })
    hl("MasonPackageUninstalled", { fg = u.fg_dim })
    hl("MasonDeprecation", { fg = d.warn, strikethrough = true })
    hl("MasonPackageObsolete", { fg = d.error, strikethrough = true })

    -- yanking / highlight-yank
    hl("HighlightYank", { bg = u.selection })

    -- inc_rename
    hl("IncRenameLabel", { fg = u.accent, bold = true })

end

return M
