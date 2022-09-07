printf "문서명. : "
read title
printf "작성자. : "
read author
# printf "Subtitle : "
# read subtitle
# printf "태그들(ex: AI 시계열분석 인공지능) 한칸씩 띄워서 작성해주세요. : "
# read tags
# printf "문서명(메타태그). : "
# read shareTitle
# printf "문서설명(메타태그). : "
# read shareDescription
# printf "수학함수사용유무 (true or false). : "
# read useMath

# if [${useMath} -ne 'true' -o ${useMath} -ne 'false'];then
# echo "true or false 로 부탁드립니다."
# fi

#Remove punctuations
parseTitle=`echo $title | sed -e "s/[[:punct:]]//g"`
#Replace space with -
parseTitle=`echo $parseTitle | sed -e "s/ /-/g"`

create_date=`date +"%Y-%m-%d"`
create_date_time=`date +"%Y-%m-%d %H:%M:%S"`
md_name="_posts/$create_date-$parseTitle.md"

# echo "---" > $md_name
# echo "layout : post" >> $md_name
# echo "title: $title" >> $md_name
# echo "subtitle: $subtitle" >> $md_name
# # echo "date: '$create_date_time'" >> $md_name
# echo "tags: [${bar}]" >> $md_name
# echo "cover-img:" >> $md_name
# echo "thumbnail-img:" >> $md_name
# echo "comments: true" >> $md_name
# echo "share-title: $shareTitle" >> $md_name
# echo "share-description: $shareDescription" >> $md_name
# echo "share-img:" >> $md_name
# echo "readtime: true" >> $md_name
# echo "last-updated:" >> $md_name
# echo "gh-repo:" >> $md_name
# echo "gh-badge:" >> $md_name
# echo "language: kor" >> $md_name
# echo "use_math: $useMath" >> $md_name
# echo "---" >> $md_name

echo "---" > $md_name
echo "layout : post" >> $md_name
echo "title: $title" >> $md_name
echo "tags: []" >> $md_name
echo "cover-img:" >> $md_name
echo "comments: true" >> $md_name
echo "share-title:" >> $md_name
echo "share-description:" >> $md_name
echo "share-img:" >> $md_name
echo "readtime: false" >> $md_name
echo "author: $author" >> $md_name
echo "language: kor" >> $md_name
echo "use_math: true" >> $md_name
echo "---" >> $md_name

echo "<!-- 서론 작성 시작-->" >> $md_name

echo "서론 내용을 작성해주세요.  " >> $md_name

echo "<!-- 서론 작성 끝-->" >> $md_name
echo "" >> $md_name
echo "&nbsp;" >> $md_name
echo "" >> $md_name
echo "---" >> $md_name
echo "" >> $md_name
echo "&nbsp;" >> $md_name
echo "" >> $md_name
echo "<!-- 본론 작성 시작 -->" >> $md_name

echo "# 대제목1" >> $md_name
echo "" >> $md_name
echo "## 소제목1  " >> $md_name
echo "## 소제목2" >> $md_name
echo "## 소제목3" >> $md_name
echo "" >> $md_name
echo "# 대제목2" >> $md_name
echo "" >> $md_name
echo "# 대제목3" >> $md_name
echo "" >> $md_name
echo "<!-- 본론 작성 끝 -->" >> $md_name
echo "" >> $md_name
echo "&nbsp;" >> $md_name
echo "" >> $md_name
echo "---" >> $md_name
echo "" >> $md_name
echo "&nbsp;" >> $md_name
echo "" >> $md_name
echo "<!-- 결론 작성 시작 -->" >> $md_name

echo "결론 내용을 작성해주세요." >> $md_name

echo "<!-- 결론 작성 끝 -->" >> $md_name
echo "" >> $md_name
echo "<!-- 참고문헌 작성 시작 -->" >> $md_name

echo "# 참고문헌" >> $md_name
echo "참고문헌을 작성해주세요." >> $md_name
echo "<!-- 참고문헌 작성 끝 -->" >> $md_name
