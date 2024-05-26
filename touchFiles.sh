# 環境変数の指定（ここでは改行コード）
IFS=$'\n'

# ディレクトリ初期化
directory=touchFiles
if [ -d $directory ];  then
  rm -rf $directory
fi
mkdir $directory

# fileをすべて読み込み、改行区切りで配列に代入
file=(`cat touchFiles_in.txt`)

# 配列をループを回して表示
count=0
for i in "${file[@]}" ; do
  count=$(($count + 1))
  touch ${directory}/${i}
done

echo インプット数： `grep -v '^$' touchFiles_in.txt | wc -l`
echo 作成ファイル数： `ls -l $directory | grep -v 'total*' | wc -l`
