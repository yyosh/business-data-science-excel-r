---
layout: page
title: ExcelとRで学ぶビジネスデータサイエンス入門 ― サポートサイト
---

# ExcelとRで学ぶビジネスデータサイエンス入門 ― サポートサイト

本サイトは書籍 **『ExcelとRで学ぶビジネスデータサイエンス入門』** の公式サポートページです。  
演習用データ（CSVファイル）やRスクリプトを配布し、学習をサポートします。  

---

## 📌 関連リンク
- 📖 書籍: 『ExcelとRで学ぶビジネスデータサイエンス入門』  
- 📂 GitHubリポジトリ: [yyosh/business-data-science-excel-r](https://github.com/yyosh/business-data-science-excel-r)  
- 🌐 サポートサイト: https://yyosh.github.io/business-data-science-excel-r/  

---

## 📂 データ（CSVファイル）
- [sample1.csv](./data/sample1.csv)  
- [sample2.csv](./data/sample2.csv)  
- [condo.csv](./data/condo.csv)  （不動産データ：UTF-8）  
- [df_train.csv](./data/df_train.csv)  （第13章で使用）  

👉 詳細な説明は [データ解説ページ](./data/README.md) を参照してください。  

---

## 📜 Rスクリプト
- [analysis.R](./scripts/Rscript_Chaps9-14.R)  

👉 解説は [スクリプトのREADME](./scripts/README.md) を参照してください。  

---

## 🚀 利用方法（Rから読み込む例）
```r
library(readr)

# GitHub Pages 経由でデータを読み込む
base <- "https://yyosh.github.io/business-data-science-excel-r"

condo <- read_csv(paste0(base, "/data/condo.csv"))
df_train <- read_csv(paste0(base, "/data/df_train.csv"))

head(condo)
