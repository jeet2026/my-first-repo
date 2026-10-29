# my-first-repo

跟着教程敲出来的第一个 Git 仓库：从 `git init` 到 `git push`，每一步都真跑过。

## 里面有什么

| 文件 | 用途 |
| --- | --- |
| `hello.txt` | 练习用的文本，记录了一次合并冲突的解决过程 |
| `index.html` | 单页，用来演示 GitHub Pages |
| `tools/push-to-github.ps1` | 一键把仓库推到 GitHub 的脚本（登录后用） |
| `.gitignore` | 不该提交的东西 |

## 这条历史是怎么来的

```text
init → 提交 → 改文件 → 分支 → 合并冲突 → 推送 → 克隆 → 拉取
     → pull --rebase → stash → 补文件发版
```

用一条命令看全貌：

```bash
git log --oneline --graph --decorate --all
```

## 教给别人的三句话

1. 提交是快照，不是保存；`add` 只是把改动放进待提交清单。
2. 分支只是指向某个提交的可移动指针，切分支会真的换掉工作区文件。
3. 远程就是一个裸仓库；`origin` 只是个别名，GitHub 只是多了一层网页。

## 发布记录

- `v1.0.0` — 第一个可发布版本
