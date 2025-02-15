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
        prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```. Output all the code, do not strip it if it remains the same.",
        replace = true,
        extract = "```$filetype\n(.-)```"
      }
      gen.prompts['Implement_Todo_Comment'] = {
        prompt = "In the following code, implement all comments marked as TODO. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```. Output all the code, do not strip it if it remains the same.",
        replace = true,
        extract = "```$filetype\n(.-)```"
      }
      gen.prompts['Comment_code'] = {
        prompt = "Understand the following code and add all necessary comments to make it clear. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```. Output all the code, do not strip it if it remains the same.",
        replace = true,
        extract = "```$filetype\n(.-)```"
      }
      gen.prompts['Generate_doc_comment'] = {
        prompt = "Understand the following code and add or update the documentation comment for each component which support it. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```. Output all the code, do not strip it if it remains the same.",
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
