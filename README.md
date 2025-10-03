# ExcelとRで学ぶビジネスデータサイエンス入門 ― サポートリポジトリ

このリポジトリは、書籍 **『ExcelとRで学ぶビジネスデータサイエンス入門』** の読者向けに  
掲載しているデータ（CSVファイル）やRスクリプト、訂正情報・補足資料を提供するためのものです。  

---

## 📌 サポートサイト
👉 [サポートサイトはこちら](https://yyosh.github.io/business-data-science-excel-r/)  
（見やすいWebページ形式で、データやスクリプトの使い方を解説しています）

---

## 📂 ディレクトリ構成
- `/data` : 演習用データ（CSVファイル、データ説明READMEあり）  
- `/scripts` : Rスクリプト（演習用コード、READMEあり）  
- `/docs` : 訂正情報・補足資料（READMEあり）  
- `/index.md` : GitHub Pages のトップページ  

---

## 🚀 使い方
1. **ZIPでまとめて入手**  
   - 右上の「Code → Download ZIP」で一括ダウンロード  
2. **個別に取得**  
   - 各フォルダからファイルをクリック → 「Download」  

Rで直接読み込む場合は以下のように利用できます：

```r
library(readr)
base <- "https://yyosh.github.io/business-data-science-excel-r"

condo <- read_csv(paste0(base, "/data/condo.csv"))
df_train <- read_csv(paste0(base, "/data/df_train.csv"))
