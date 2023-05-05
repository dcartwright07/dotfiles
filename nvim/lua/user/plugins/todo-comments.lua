require("todo-comments").setup {
  keywords = {
    FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" } },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "check" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", alt = { "INFO" } },
    QUESTION = { icon = " ", color = "test", alt = { "HELP", "TECHDEBT" } },
    DELETE = { icon = " ", color = "error", alt = { "REMOVE", "REM" } },
  },
  colors = {
    check = { "LspDiagnosticWarning", "#FFA500" },
    info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
    hint = { "LspDiagnosticDefaultHint", "#10B981" },
    test = { "LspDiagnosticsDefaultInformation", "#7C3AED" },
  },
}

-- FIX: Test
-- TODO: Test
-- HACK: Test
-- WARN: Test
-- PERF: Test
-- NOTE: Test
-- QUESTION: Test
-- DELETE: Test
-- TECHDEBT: Test
