# scripts ディレクトリについて

このディレクトリには、書籍 **『ExcelとRで学ぶビジネスデータサイエンス入門』** の読者向けに提供する  
Rスクリプトを配置しています。
---

## 📂 収録ファイル
- `Rscript_Chaps9-14.R`  
 
---

## 🚀 実行方法

### 方法1: ローカルで実行
1. 本リポジトリを右上の **「Code → Download ZIP」** からダウンロードして解凍  
2. RStudioで解凍したフォルダを開く  
3. `Rscript_Chaps9-14.R` を開いて、行ごとに実行、または「Source」ボタンで一括実行  

### 方法2: GitHub Pagesから直接読み込む（データ利用時）
Rコード内で、CSVを直接Webから読み込むことも可能です。  
```r
library(readr)
base <- "https://yyosh.github.io/business-data-science-excel-r"
df <- read_csv(paste0(base, "/data/sample1.csv"))
head(df)

