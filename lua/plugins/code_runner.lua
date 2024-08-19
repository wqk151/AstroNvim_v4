return {
  "CRAG666/code_runner.nvim",
  cmd = {
    "RunCode",
    "RunFile",
    "RunProject",
  },
  opts = {
    term = {
      position = "belowright",
      size = 15,
    },
    filetype = {
      python = "time cd $dir && python3 $fileName",
      c = "time cd $dir && clang -lpthread -fno-omit-frame-pointer -pg -g -lm $fileName -o $fileNameWithoutExt.out  && $dir/$fileNameWithoutExt.out",
      cpp = "time cd $dir && clang++ -lpthread -g $fileName -o $fileNameWithoutExt.out  && $dir/$fileNameWithoutExt.out",
      html = "microsoft-edge $fileName",
      sh = "time bash $file",
      go = "time cd $dir && go run .",
      markdown = "cd $dir && typora $fileName",
    },
  },
}
