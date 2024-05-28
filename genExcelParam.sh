########################################
# 引数のカラム情報を利用して
# excelの式を作成する
# 
# @param:
#	genExcelParam_in.txt
# 
########################################

IFS=$'\n'

# ファイル存在確認

file=genExcelParam_in.txt
if [ ! -e $file ]; then
	echo ${file}が存在しません。
	exit 1
fi
list=(`cat $file`)

# ループで式を作成する
result=""
for ((i=0; i < ${#list[@]}; i++))
do
	if [ $i == $((${#list[@]}-1)) ]; then
		str="\"'\"&"${list[$i]}"&\"'\""
		result+=$str	
	else
		str="\"'\"&"${list[$i]}"&\"',\"&"
		result+=$str	
	fi
done

echo $result

