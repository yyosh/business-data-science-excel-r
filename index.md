---
layout: page
title: ExcelとRで学ぶビジネスデータサイエンス入門 ― サポートサイト
---

# ExcelとRで学ぶビジネスデータサイエンス入門 ― サポートサイト

本サイトは書籍 **『ExcelとRで学ぶビジネスデータサイエンス入門』** の公式サポートページです。  
演習用データ（CSVファイル）やRスクリプト、訂正情報（正誤表）を公開し、学習をサポートします。  

---

## 📘 書籍情報

<p align="center">
  <a href="https://www.kspub.co.jp/book/detail/5411339.html" target="_blank" rel="noopener">
    <img src="{{ '/assets/images/bdser-cover.jpg' | relative_url }}" 
         alt="『ExcelとRで学ぶビジネスデータサイエンス入門』書籍カバー" 
         style="max-width: 320px; height: auto; border: 1px solid #ddd; border-radius: 6px; box-shadow: 0 2px 6px rgba(0,0,0,0.1);">
  </a>
</p>

<p align="center">
  <a href="https://www.kspub.co.jp/book/detail/5411339.html" target="_blank" rel="noopener">
    出版社（講談社サイエンティフィク）公式ページはこちら
  </a>
</p>

---

## 📂 データ（CSVファイル）

- [stock.csv](./data/stock.csv)　（株価データ例）  
- [condo.csv](./data/condo.csv)　（不動産データ：UTF-8）  
- [df_train.csv](./data/df_train.csv)　（第13章で使用）

👉 詳細は [データ解説ページ](./data/README.md) をご覧ください。  

---

## 📜 Rスクリプト

- [Rscript_Chaps9-14.R](./scripts/Rscript_Chaps9-14.R)  

👉 解説は [スクリプトのREADME](./scripts/README.md) に掲載しています。  

---

## 📑 訂正・補足情報
本書の訂正情報（正誤表）は以下のPDFでご確認ください。  
👉 [訂正情報（PDF）](./docs/errata.pdf)

---

## 🚀 利用方法（Rから読み込む例）
```r
library(readr)
base <- "https://yyosh.github.io/business-data-science-excel-r"

# 株価データと不動産データの例
stock <- read_csv(paste0(base, "/data/stock.csv"))
condo <- read_csv(paste0(base, "/data/condo.csv"))
df_train <- read_csv(paste0(base, "/data/df_train.csv"))

head(stock)
