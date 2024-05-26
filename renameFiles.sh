# 環境変数の指定（ここでは改行コード）
IFS=$'\n'

# ディレクトリ設定
rootDir=renameFiles
srcDir=${rootDir}/src
distDir=${rootDir}/dist

# outputディレクトリ初期化
if [ -d $distDir ];  then
    rm -rf $distDir
    mkdir $distDir
fi

# fileをすべて読み込み、改行区切りで配列に代入
src=${rootDir}/mvFiles_src
cnv=${rootDir}/mvFiles_cnv
srcList=(`cat $src`)
cnvList=(`cat $cnv`)

# リスト内のファイル数チェック
if [ ! ${#srcList[@]} == ${#cnvList[@]} ]; then
  echo "リストの数が一致しません。\n -src: ${#srcList[@]} \n -dir: ${#cnvList[@]}"
  echo 処理を終了します。
  exit 1
fi

# 配列をループを回して表示
for ((i=0; i < ${#srcList[@]}; i++))
do
  cp -i ${srcDir}/${srcList[$i]} ${distDir}/${cnvList[$i]}
done
