# 環境変数の指定（ここでは改行コード）
# linux
IFS=$'\n'
# windows
# IFS=$'\r\n'


#  ログ設定
logFile=log.txt

# ディレクトリ設定
rootDir=cpFiles
oldDistDir=${rootDir}/dist

# 出力先削除
if [ -d $oldDistDir ];  then
	rm -rf $oldDistDir
fi

# fileをすべて読み込み、改行区切りで配列に代入
srcFile=${rootDir}/cpFiles_in_src
cnvFile=${rootDir}/cpFiles_in_cnv
srcList=(`cat $srcFile | awk '{print $2}'`)
srcDir=(`cat $srcFile | awk '{print $1}'`)
cnvList=(`cat $cnvFile | awk '{print $2}'`)
distDir=(`cat $cnvFile | awk '{print $1}'`)

for d in ${distDir[@]}; do
	mkdir -p ${rootDir}/${d}
done

# ループしてファイルコピー
errCount=0
for ((i=0; i < ${#srcList[@]}; i++))
do
	# ファイルが存在しなかった場合はログに出力
	if [ ! -e ${rootDir}/${srcDir[$i]}/${srcList[$i]} ]; then
		echo "$(date '+%Y/%m/%d %H:%M:%S'): 行数： $(($i+1)): ファイルが存在しません。" >> ${rootDir}/${logFile}
		errCount=$((errCount++))
	fi

	src=${rootDir}/${srcDir[$i]}
	dist=${rootDir}/${distDir[$i]}
	cp -i ${src}/${srcList[$i]} ${dist}/${cnvList[$i]}
done

echo "処理数: ${#srcList[@]}" >> ${rootDir}/${logFile}
echo "成功: $((${#srcList[@]}-${errCount}))" >> ${rootDir}/${logFile}
echo "失敗: $errCount" >> ${rootDir}/${logFile}
