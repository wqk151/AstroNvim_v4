---
name: Git Commit (CN)
interaction: chat
description: Generate a Chinese commit message
opts:
  alias: commit_cn
  is_slash_cmd: true
  auto_submit: true
---

## user

请根据以下暂存代码的变动（git diff --staged），生成一个 Git 提交信息。
要求：

1. 使用中文。
2. 遵循 Conventional Commits 规范 (feat, fix, docs, style, refactor, perf, test, chore)。
3. 格式为：`<type>(<scope>): <subject>`。
4. 只要信息本身，不要废话。

Diff 内容:

```diff
${commit.diff}
```
