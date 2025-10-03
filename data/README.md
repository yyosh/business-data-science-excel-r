---
layout: page
title: データファイルの解説
---

# データファイルの解説

本ページでは、書籍 **『ExcelとRで学ぶビジネスデータサイエンス入門』** で利用する演習用データ（CSVファイル）の概要を説明します。  

---

## 📂 収録ファイル一覧

| ファイル名      | 説明                                  | 主な列（例）                    | 利用箇所（章など） |
|-----------------|---------------------------------------|---------------------------------|-------------------|
| `sample1.csv`   | 基本的な数値データ                    | `date`, `id`, `x`, `y`          | 第○章 ○○演習       |
| `sample2.csv`   | 集計・可視化用のデータ                | `date`, `group`, `value`        | 第△章 △△演習       |
| `condo.csv`     | 不動産データ（架空のマンション情報）  | `location`, `year`, `price`, `size`, `station_dist` | 第○章 不動産データ分析 |
| `df_train.csv`  | 機械学習用の訓練データ                | `feature1`, `feature2`, …, `label` | 第13章 モデル構築演習 |

---

## 📖 データの出典と性質
- 本リポジトリに収録しているCSVファイルは、著者が作成したサンプルデータです。  
- 公開統計や実務データを模した**架空データ**であり、個人情報や企業固有情報は含まれていません。  
- 書籍の演習・解説を再現できるように設計されています。  

---

## ⚖️ ライセンス
- データファイルは本書の読者が本書をお読みになる際の理解向上を目的として掲載しております．
- 他の用途での使用はなさらないでください．

---

## 🔧 利用方法

### Rで読み込む場合
```r
library(readr)

# ローカルに保存されている場合
condo <- read_csv("data/condo.csv")
df_train <- read_csv("data/df_train.csv")

# GitHub Pagesから直接読み込む場合
base <- "https://yyosh.github.io/business-data-science-excel-r"
condo <- read_csv(paste0(base, "/data/condo.csv"))
df_train <- read_csv(paste0(base, "/data/df_train.csv"))
