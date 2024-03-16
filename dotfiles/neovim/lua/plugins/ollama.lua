return {
  -- Install plugin to bind with ollama
  {
    "David-Kunz/gen.nvim",
    cmd = {"Gen"},
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, require "configs.ollama")
    end,
    config = function(_, opts)
      gen = require("gen")
      gen.setup(opts)

      -- Add new prompts
      gen.prompts['Enhance_Grammar_Spelling'] = {
        prompt = "Detect the language of the following text and enhance its grammar and correct spelling mistakes. Only output the corrected text:\n$text",
        replace = true
      }
      gen.prompts['Elaborate_Text_FR'] = {
        prompt = "Élabore sur le texte suivant, en français :\n$text",
        replace = true
      }
      gen.prompts['Elaborate_Text_EN'] = {
        prompt = "Elaborate the following text in English:\n$text",
        replace = true
      }
      gen.prompts['Fix_Code'] = {
        prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```"
      }
      gen.prompts['Implement_Todo_Comment'] = {
        prompt = "In the following code, implement all comments marked as TODO. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```"
      }
      gen.prompts['Translate_Text'] = {
        prompt = "Translate the following text from French to English or from English to French:\n$text",
        replace = true
      }
    end,
  },
}
