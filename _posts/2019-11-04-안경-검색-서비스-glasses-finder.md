---
layout: post
title: 메트릭러닝 기반 안경 검색 서비스 개발기(1)
tags: [AI, AI가상피팅, AR피팅, Metric Learning, ROUNZ, 가상피팅, 개발기, 라운즈, 메트릭러닝, 상품검색, 서비스개발기, 선글라스검색, 안경검색, 이스트소프트, 인공지능]
cover-img:
comments: true
share-title: 메트릭러닝 기반 안경 검색 서비스 개발기(1)
share-description:  Glass Finder의 개발 요구사항(Requirements Specification) 정리, 전반적인 시스템 구성, 관련 개념들에 대한 개략적인 내용 관련 글
share-img: 
readtime: false
author: 
language: kor
use_math: true
---

<!-- wp:quote -->
<blockquote class="wp-block-quote"><p><strong>본 글은 AI 가상피팅 기반 안경쇼핑앱 '<a href="http://rounz.com">라운즈</a>'에 최근 추가된 안경 검색 서비스 'Glass Finder'의 개발기를 공유하고자 작성된 글입니다.</strong></p></blockquote>
<!-- /wp:quote -->

<!-- wp:paragraph -->
<p>SNS나 영화, 드라마, 잡지, 화보 등에서 연예인 또는 유명 인플루언서가 착용한 안경/선글라스 제품이 어떤 제품인지 궁금하신 적 없으신가요?</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><strong>Glass Finder</strong>는 이러한 이용자의 니즈를 해결하기 위해 개발된 서비스입니다. Glass Finder는 이미지만으로 안경을 검색하여 해당 안경 혹은 유사안경을 쉽고 편리하게 찾을 수 있도록 지원합니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>이번 글에서는 Glass Finder의 개발 요구사항(Requirements Specification) 정리, 전반적인 시스템 구성, 관련 개념들에 대한 개략적인 내용을 다루고, 2부에서 보다 기술적인 내용을 자세히 다룰 예정입니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":288,"align":"center"} -->
<center>
<div class="wp-block-image"><figure class="aligncenter">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/1.jpeg">
<img src="/assets/img/2019/1104/1.jpeg" alt="" />
</a>
<figcaption><small>그림1. 글라스파인더 소개 이미지</small></figcaption></figure></div>
</center>
<!-- /wp:image -->

<!-- wp:spacer {"height":20} -->
<div style="height:20px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:heading -->
<h2><strong>1. 서비스 개발의 시작: 기획 요구사항</strong></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>이미지에 기반한 안경 검색 프로젝트의 시작은 마케팅팀의 제안이었습니다. 현재 우리 회사에서 서비스 중인 가상 안경 착용 앱에 이미지 기반 안경 검색 기능을 접목하면 앱의 사용성도 좋아짐은 물론, 마케팅적으로 활용도 가능하다는 요지였습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>실제로 전달받은 Glass Finder의 기획의도는 그림2와 같이,<strong> “영화나 드라마, 스타의 공항패션, 잡지화보 등에서 너무 마음에 드는 안경/선글라스를 발견했을 때, 이 제품을 찾아주는 서비스가 있다면 이용자의 만족도를 높일 수 있겠다”</strong>는 것이었습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":289,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/2.jpeg">
<img src="/assets/img/2019/1104/2.jpeg" alt="" />
</a>
<figcaption><small>그림2. 기획의도</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>사용자 입장에서의 활용 모습은 그림 3과 같았습니다. <strong>“유저가 앱 상에서 카메라 앨범 안의 안경/선글라스 착용 이미지를 업로드하거나 촬영을 하면, 해당 제품을 찾아주는 것”</strong>이었습니다. 해당 제품을 찾는데 그치지 않고, 기존 안경 VF(Virtual Fitting)모듈과 연동돼 그 안경으로 가상으로 착용까지 할 수 있도록 연계된 서비스였기 때문에 기존 서비스와 시너지를 낼 수 있는 좋은 방향이라고 생각했습니다.<strong>&nbsp;</strong></p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":290,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/3.jpeg">
<img src="/assets/img/2019/1104/3.jpeg" alt="" />
</a>
<figcaption><small>그림3. 사용자 관점에서의 활용 예</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>마케팅팀의 프로젝트 제안서를 바탕으로 전체 서비스의 모습을 파악할 수 있었고, 관련 참여자들이 모여 회의를 거친 끝에 대략적인 모델 스펙을 협의할 수 있었습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>특히 모든 프로젝트의 개발 초창기에는 최종 산출물의 모습에 대해 참여원들간의 정확한 공감대 형성이 필요합니다. 일반적으로 기획 내용 파악 및 공유에 많은 공을 들여야 하지만, 제안된 안경 검색 기능은 이미 회사에서 서비스 중인 쇼핑앱을 기반으로 구상되었기 때문에 추가되는 기능의 목적이나 사용방식에 대해 프로젝트 참여자들이 크게 오해하거나 어려워 할 부분이 없어 초기 커뮤니케이션 비용을 많이 줄일 수 있었습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:spacer {"height":20} -->
<div style="height:20px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:heading -->
<h2><strong>2. 서비스 구현을 위한 기술 검토</strong></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>1차 스펙에서는 검색 쿼리 이미지를 일반적인 안경 이미지가 아닌, <strong>얼굴에 안경이 착용된 이미지로</strong> 제한하기로 사업부서와 협의했기 때문에, 기존에 진행했던 유사 프로젝트에서 사용했던 기술을 활용할 수 있었습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>기존에 진행했던 안경 VF 모듈 개발과 대검찰청 수사 도구 프로젝트에서 사용한 얼굴 식별 기술과 도메인만 다를 뿐, 문제 해결을 위해 구사해야 하는 기술이 유사해 딥러닝 모델&nbsp;개발 외에 특별히 새로운 기술을 적용할 부분이 없어 개발에 드는 리소스를 절감할 수 있을 것으로 예상했습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>상품 검색은 엄밀히 구분하자면<strong> Image retrieval </strong>분야라고 할 수 있지만, 현재 가장 활발히 연구되고 기술 수준이 높은<strong> 얼굴 인식 공략법</strong>을 이용해 안경 검색 문제를 해결하는 것이 효과적이라고 판단했습니다. 현재 얼굴 인식 기술은 사람의 뇌는 얼굴 인지에 매우 특화되어 있고 산업에서 얼굴 인식의 쓰임새가 매우 높기 때문에, 컴퓨터 비전 기술을 선도하는 분야 중 하나입니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>딥러닝 이전의 기계학습(Machine Learning)에서는 얼굴 인식 기술이 얼굴에 특화된 정보만을 활용했기 때문에 일반적인 이미지 서치 문제에 적용하기 어려웠으나, 딥러닝 시대에는 다루는 데이터만 다를 뿐 그 기술간의 간극이 작아져 얼굴 인식 기술을 일반적인 이미지 서치에도 활용할 수 있게 되었습니다. 이렇듯 도메인 지식의 비율이 점점 낮아지는 것은 딥러닝 기술의 일반적인 경향입니다.</p>
<!-- /wp:paragraph -->

<!-- wp:spacer {"height":20} -->
<div style="height:20px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:heading -->
<h2><strong>3. 데이터 샘플의 중요성&nbsp;</strong></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>기존 IT 프로젝트에서 기획서가 담당했던 많은 부분을 딥러닝 프로젝트에서는 데이터 샘플이 담당하게 되었습니다. 기존 IT 프로젝트의 경우, 개발 참여자들이 한 곳을 바라보고 개발 중간 과정마다 소소한 사항들을 결정짓기 위해 기획서의 명확성과 정확도가 매우 중요했습니다.&nbsp;</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>하지만, 딥러닝 프로젝트에서는 데이터 샘플의 퀄리티가 프로젝트의 방향을 좌지우지할 만큼 큰 역할을 하게 됩니다. 딥러닝이라는 기술이 일상 언어뿐만 아니라 수학이나 프로그래밍 언어를 포함한 인간이 발명한 그 어떤 언어로도 엄밀하게 정의 불가능한 개념을 데이터 샘플의 통계적 분포로 정의하고 있기 때문입니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>우리는 프로젝트의 명확한 방향 설정과 구성원간의 공유를 위해, 마케팅팀으로부터 딥러닝 모델이 처리해야 하는 이미지와 처리할 필요가 없는 이미지 샘플을&nbsp;그림4 , 그림5와 같이 전달 받았습니다. 한마디로 말하자면<strong><em> </em>"검색할 만하면 검색해 주고, 못 찾을 만하면 찾지 않아도 되는 문제" </strong>였습니다. 알파고와 같은 딥러닝 모델은 일반 사람들의 수준을 훨씬 넘어서 인간이 구사할 수 있는 극한 레벨의 실력을 보여주기도 하지만, 이번 프로젝트는 보통 사람 눈썰미 수준의 정확도를 달성하면 되는 문제로 협의되었습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":291,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/4.jpeg">
<img src="/assets/img/2019/1104/4.jpeg" alt="" />
</a>
<figcaption><small>그림4.&nbsp;결과값이 나와야 하는 이미지 예시</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:image {"id":293,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/5.jpeg">
<img src="/assets/img/2019/1104/5.jpeg" alt="" />
</a>
<figcaption><small>그림5. 결과값이 나오지 않아도 되는 이미지 예시</small> </figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>이러한 구분 외에도<strong> </strong>Glass Finder는&nbsp;B2B 서비스가 아니라<strong> B2C 서비스</strong>이기 때문에, <strong>메타 러닝 기술</strong>도 고려해야 했습니다. B2B 서비스에서는 시스템 입력을 제어하기가 쉽지만,&nbsp;B2C의 경우 사용자 입력을 통제하기 쉽지 않습니다. 예를 들어 Glass Finder의 경우 안경 검색 서비스지만, 실제 사용자가 유리잔이나 포크 등의 전혀 다른 물체의 이미지를 입력할 수 있기 때문입니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><span style="text-decoration: underline;">사용자가 다양한 종류의 입력을 시도하는 경우에도 딥러닝 모델이 이를 알아채고 대응할 수 있는 장치를 추가해야 했습니다.</span><strong> </strong>현재 개발된 서비스 상에서는 안경 외 타 물체 입력 시, 팝업창으로 <strong>"안경이나 선글라스를 얼굴에 착용한 사진으로 진행해 주세요."</strong>라는 문구를 안내하고 있습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":292,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/6.jpeg">
<img src="/assets/img/2019/1104/6.jpeg" alt="" />
</a>
<figcaption><small>그림6. 안경/선글라스 외 물체 촬영 시, Alert 화면</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:spacer {"height":20} -->
<div style="height:20px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:heading -->
<h2><strong>4. 시스템 설계와 구성</strong></h2>
<!-- /wp:heading -->

<!-- wp:heading {"level":5} -->
<h5><strong><em>데이터 흐름도</em></strong></h5>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>이미지 검색은 검색 대상이 되는 이미지들의 <strong>대표값</strong>을 구하여 색인해 놓은 후, 쿼리 이미지에 대한 대표값과의<strong> 유사도</strong>를 이용하여 검색을 수행합니다. 단, 여기서 대표값들간의 유사도(거리)는 사람이 감성적으로 인지하는 안경의 시각적 특성을&nbsp;유의미하게 반영하여야 합니다. 즉, 사람이 보기에 유사하면 수학적 정의로 계산한 수치도 작아야 하고, 사람이 보기에 서로 닮지 않았으면 계산된 거리값도 커져야 합니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>이와 같은 이미지 검색 시스템 구현을 위해<strong> </strong>그림7과 같은 데이터 흐름도를 설계했습니다. 쿼리 데이터와 등록 데이터의 흐름도는 다음과 같습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":294,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/7.jpeg">
<img src="/assets/img/2019/1104/7.jpeg" alt="" />
</a>
<figcaption><small>그림7. 데이터 흐름도</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>먼저, 안경 영역에 집중하여 처리하기 위해 검색 쿼리 이미지에서 전처리 과정을 거쳐 안경 영역을 잘라내야 합니다. 1차 스펙에서는 검색 쿼리 이미지로 일반적인 안경 이미지를 입력 받는 것이 아니라, 얼굴에 착용된 안경으로 제한하기로 사업 부서와 협의했기 때문에 얼굴 영역을 탐지하여 이미지 내의 안경 위치를&nbsp;찾아낼 수 있었습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>메트릭 러닝 기법으로 개발된 딥러닝 모델은 정렬된 이미지로부터 고차원의 특징값을 추출하게 됩니다. 안경 영역이 최대한 일관된 위치와 방향이 되도록 정렬하기 위해, 얼굴영역의 회전정보를 이용해 안경영역의 회전정보를 알아냈습니다. 등록 안경 데이터의 특징값은 해당 안경을 다양한 얼굴에 가상 착용시킨 합성 이미지를 생성하여 추출했고, 유사도 검색은 일반적인 Cosine 유사도 기반 정렬 방식을 사용했습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:spacer {"height":20} -->
<div style="height:20px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:heading {"level":5} -->
<h5><strong><em>4.1 얼굴 영역 탐지</em></strong></h5>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>쿼리 이미지 형태를 얼굴에 착용된 안경으로 제한했기 때문에 데이터 처리 파이프라인의 첫&nbsp;단계에서는 얼굴 영역 탐지 모델이 위치했습니다. 현재 서비스 중인 가상 안경 착용 앱 개발 과정에서 얼굴 탐지 연구가 충분히 되어 있었기 때문에, 이번 프로젝트의 대부분을 의미 있는 유사도 측정 가능한 임베딩 문제에 집중하였습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>가상 안경 착용 앱을 개발했던 당시(2017년)를 회고해보자면,&nbsp;얼굴 영역 탐지와 관련해 참고할 만한 모델로 S3FD[1], MTCNN[2] 등이 있었습니다. 컴퓨터 비전에서 얼굴 탐지는 매우 중요한 분야로, 지금까지 연구 성과가 꾸준히 공유되어 현재 다양한 특징을 갖는 여러 모델들이 존재합니다. 그 중 S3FD모델은 높은 정확도를 보이지만 속도가 꽤 느리다는 특징이 있고, MTCNN 모델은 비교적 속도가 빠르다는 특징이 있습니다. 그림8과 같이 이외 여러 모델들을 찾아볼 수 있습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Glass Finder<strong> </strong>시스템의 구성을 위해서는 총 3개 이상의 딥러닝 모델을 수행해야 했으므로, 얼굴 탐지 단계에서는 여러 모델의 특징을 참고하여 속도를 최적화하는 기법을 적용했습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":296,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/8.jpeg">
<img src="/assets/img/2019/1104/8.jpeg" alt="" />
</a>
<figcaption>
<small>그림8. 얼굴 탐지 문제 관련 기술들</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:spacer {"height":20} -->
<div style="height:20px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:heading {"level":5} -->
<h5><strong><em>4.2.얼굴 특징점 찾기</em></strong></h5>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>일반적으로 얼굴 인식 문제를&nbsp;풀기 위한 딥러닝 모델에서는 모델의 입력을 정렬된 얼굴로 한정합니다. 이 때, 입력이미지는 얼굴 영역의 크기가 일정하고, 눈, 코, 입등의 특징점들이 특정 위치에 최대한 가깝게 오도록 정렬되어 있어야 합니다. 이미지 형태를 제약함으로써 딥러닝 모델은 얼굴 정보의 좋은 표현법(임베딩 벡터) 찾기에 보다 집중할 수 있기 때문입니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>일반적으로 이러한 얼굴 정렬을 위해 얼굴의 주요 특징점을 사용하는 방식을 활용하고 있습니다. 참고로, 딥러닝을 활용해 얼굴의 주요 특징점을 찾는 문제를 가장 처음 높은 정확도로 해결한 기념비적인 모델로는 FAN[3] 모델이 유명합니다. 요즘은 딥러닝 모델이 특징점 뿐만 아니라 얼굴외양의 3D 복원을 위한&nbsp;매쉬 정도 예측까지 꽤 높은 정확도로 예측하고 있습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":297,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/9.jpeg">
<img src="/assets/img/2019/1104/9.jpeg" alt="" />
</a>
<figcaption><small>그림9. 얼굴 정렬 관련 기술들</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:spacer {"height":20} -->
<div style="height:20px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:heading {"level":5} -->
<h5><strong><em>4.3.딥러닝 모델을 사용한 특징값 추출</em></strong></h5>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>메트릭 러닝으로 학습된 딥러닝 모델에 정렬된 이미지를 입력하면 안경에 대한&nbsp;특징값이 추출됩니다. 수십만 장의 합성된 가상 안경 착용 이미지와 수천장의 실제 안경 착용 이미지를 사용하여&nbsp;메트릭 러닝 기법으로 안경 이미지간의 유사도(또는 거리)가 유의미하게 측정될 수 있는 표현법을 학습시켰습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":6} -->
<h6><strong><em>"왜 메트릭 러닝을 써야하죠?"</em></strong></h6>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>굳이 메트릭 러닝이라는 개념이 없이도 딥러닝은 의미적 유사성(인간의 인지 및 라벨) 즉, 의미적 거리관계와 상관성이 높은 표현법(임베딩, 특징값,...)을 찾아야 한다고 알고 있을 것입니다. 일반적인 분류 문제에서는 우리가 찾고자 하는 표현의 거리 관계가 정해진 분류만 만족할 수 있으면 목적을 달성했다고 볼 수 있습니다.&nbsp;예를 들어 고양이와 개 영상 분류 모델에서는 두 종의 표현법을 구분할 경계선만 찾을 수 있으면 목적을 달성했다고 볼 수 있는거죠.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>하지만, 학습에 사용되지 않은 분류(?)를 클러스터링(동일 그룹으로 묶어 내기)해야하는 응용 분야를 고려한다면 조금 더 생각해볼 필요가 있습니다. 예를 들어 고양이와 개 이미지로 학습이 완료된 후에 여우나 늑대를 분류하는 경우를 생각해보면 고양이와 개를 구분짓는 경계선을 그을 수 있는 표현법을 찾은 것에 만족하지 않고 더 발전된 방법을 고려해볼 수 있죠. 두 종을 가능한 한 멀리 떨어뜨려 놓고, 각 종류 내의 이미지들은 가능한한 모여 있게 만드는 표현법이 보다 좋은 표현법일 수 있습니다. 이러한 이유에서 메트릭 러닝의 역할이 중요해집니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>메트릭 러닝 기술이 가장 성공적으로 활용되는 얼굴 인식 분야를 들여다보면, 일반 분류 문제와의 차이점이 좀 더 분명해집니다. 일반적인 분류 문제의 대표적인 예인 이미지넷 분류 문제는 1,000 종류를 구분하는 표현법을 찾는 것입니다. 이렇게 학습된 모델은 추가로 별다른 전이 학습을 수행하지 않는 이상, 학습 때 사용한 1,000 종류의 객체만을 분류하는 모델로 사용됩니다. 반면 얼굴 인식 모델에서는 학습에 사용된 라벨 자체는 학습에서만 의미를 갖고, 실제 활용시에는 학습에 사용되지 않는 얼굴들을 얼마나 유의미하게 클러스터링하냐로 모델의 성능과 활용도가 측정됩니다.&nbsp;</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>실제 응용에서는 드물겠으나, 고정된 인원에 대해 얼굴 식별 서비스를 구축하는 경우 얼굴 식별 문제를 기존 분류 문제와 동일한 접근법으로 해결 할 수 있습니다. 그림 10에서는 두 경우를 각각<strong> Close-set, Open-set</strong> 인식 문제라고 분류하고 있습니다. 그림 10에서 얘기하고 있는 내용의 핵심은 <strong>Closed-set </strong>문제에서는 학습에 사용되지 않은 사람은 서비스 시에도 고려하지 않을 것이기 때문에 학습에 사용된 사람들만을 잘 구분하는 경계선을 찾으면 문제가 해결된 것이고,<strong> Open-set </strong>문제에서는&nbsp;학습에 사용되지 않은 수많은 사람들을 그룹지어야 되기 때문에 학습 데이터를 잘 클러스터링 하는 모델을 개발하는 것이 무엇보다 중요한 문제가 된다는 것입니다.&nbsp;메트릭 러닝 관련 기술적인 상세 내용과 딥러닝 모델의 구조 등은 2부에서 심도있게 다루겠습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":336,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/10.jpeg">
<img src="/assets/img/2019/1104/10.jpeg" alt="" />
</a>
<figcaption><small>그림10. closed-set 과 open-set의 비교 [4]</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:spacer {"height":20} -->
<div style="height:20px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:heading -->
<h2><strong>5. 데이터셋 구축: 평가 데이터 + 훈련 데이터</strong></h2>
<!-- /wp:heading -->

<!-- wp:heading {"level":5} -->
<h5><strong><em>5.1. 평가 데이터 구성: 쿼리 데이터 + 등록 데이터</em></strong></h5>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>사실상 딥러닝 프로젝트 진행에 있어서 일반적으로 가장 먼저 진행되어야 할 부분은 <span style="text-decoration: underline;">평가셋(set) 협의 및 구축</span>입니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>학계에서는 <strong>벤치마킹 데이터</strong>라고 하는 각 연구 주제별로 널리 쓰이는 데이터 세트가 마련되어 있습니다. 일반적인 학계 연구에서는&nbsp;모델 개발을 위한 훈련용 이미지와 모델 평가를 위한 평가용 이미지가 잘 구비되어 있습니다. 과거와 달리 요즘은 구글이나 페이스북과 같은 글로벌 테크 기업에서도 데이터 세트를 공개한 후 상금을 건 대회를 유치하고, 관련 논문을 출판하는 등 권위 있는 데이터 세트를 마련하는 모습을&nbsp;많이 볼 수 있습니다. 권위 있는 데이터 세트는 기술 발전의 방향을 제어할 수 있습니다. 글로벌 테크 기업 등의 리딩 그룹 연구자들은 말 그대로 기술을 리딩해야 되기 때문에 즉, 기술의 방향성을 제어해야 되기 때문에 데이터 세트를 분석하고 개선하여 새로운 데이터 세트를 제시하는 작업에 매우 공을 들이고 있습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>연구 성과를 입증하기 위한 데이터 세트가 이와 같이 기술 발전의&nbsp;방향을 제어하는 데 사용되고 있는 것처럼, <span style="text-decoration: underline;">기업 내부의 딥러닝 프로젝트에서의 데이터 세트는 개발되는 모델의 성격과 방향을 결정하는데 사용되고 있습니다.</span>&nbsp;데이터 준비 관련하여 가장 이상적인 모습은 프로젝트 초기 단계부터 양질의 데이터가 충분히 준비되어 있고, 그 데이터를 랜덤 샘플링하여 훈련데이터와 평가 데이터로 나누어 사용하는 경우일 것입니다. 그런 경우 프로젝트 기간 대부분을 모델 구조나 최적화에 몰두할 수 있는 업무환경이 갖춰지게 되죠.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>딥러닝 모델의 품질 향상을 위해 필수적인 질 좋은 훈련 데이터 준비는 매우 까다롭고 전문적인 일입니다. 기업의 서비스 모델 개발에서는 여러가지 제약으로 인해 질 좋은 훈련 데이터가 준비되지 못하는 경우가 많이 존재합니다.&nbsp;모델 개선에 필요한 훈련데이터는 개선 포인트에 따라 유동적이라 프로젝트 초반에 구축하기 쉽지 않죠. 반면, 훈련 셋에 비해 상대적으로 그 양이 적고 프로젝트 기간 내에 변화가 적을 수 있는 평가셋의 경우에는 프로젝트 초기에 유관 부서에서 모여 서로 협의하고 구축하는 것이 상대적으로 쉽습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>앞서 얘기했듯이 과거에 기획서를 통해 제품/서비스의 최종 모습을 구성원들이 상상하고 일을 해 나갔다면 이제는 평가셋을 통해 구성원들이 모델의 개발 방향성을 가늠할 수 있어야 합니다. Glass Finder 프로젝트에서도 초기에 사업 부서와 데이터 인텔리전스팀과의 협업으로 평가셋을 먼저&nbsp;구축했습니다. 당시 평가셋은 쿼리 데이터와 등록 데이터로 구성됬으며, 그 예시는 아래&nbsp;그림 11, 그림12와 같습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":299,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/11.jpeg">
<img src="/assets/img/2019/1104/11.jpeg" alt="" />
</a>
<figcaption><small>그림11. 모델 평가용 쿼리 데이터</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:image {"id":300,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/12.jpeg">
<img src="/assets/img/2019/1104/12.jpeg" alt="" />
</a>
<figcaption><small>그림12. 모델 평가용 등록 데이터</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>쿼리 데이터는 그림 11과 같이 기획 요구사항에 준하는 안경 착용 이미지들로 구성했습니다. 그 다음으로 등록 이미지를 확보하는 과정에서 <strong>예기치 못한 문제가 발생</strong>했습니다.&nbsp;회사에서 판매하고 있는 약 3,200여개의 안경을 등록하기 위해서는 각 안경에 대한 착용 이미지가 필요한데, 모든 안경에 대한 착용 이미지를 제공받는 것이 불가능했기 때문입니다. 향후 새로운 안경이 입점될 경우에는 추가 비용을 들여 다양한 착용 이미지를 촬영하는 프로세스 도입을 고려할 수 있겠으나, 기존에 판매하는 안경들에 대해서는 일일이 사진 촬영을 요청하여 리소스를 받은 후 딥러닝 모델을 개발하는 것은 현실적으로 불가능했습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>그 와중에, 우리 회사에서 판매하는 모든 안경은 가상 안경 리소스가 존재하기 때문에 <span style="text-decoration: underline;">가상 안경 착용 합성 이미지를 생성하여 문제를 해결하자는 의견이 제안</span>되었습니다. 이렇게 합성 데이터를&nbsp;이용할 경우, 안경당 사용할 수 있는 이미지 개수의 제약이 거의 사라지고, 얼굴의 회전 정도나 렌즈 컬러의 다양성 등을 제어할 수 있다는 이점도 생겼습니다.&nbsp;회사에서 서비스 중인 라운즈앱에서 생성한 가상 안경 착용 이미지 예시는 그림 13과 같습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":301,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/13.jpeg">
<img src="/assets/img/2019/1104/13.jpeg" alt="" />
</a>
<figcaption><small>그림13. 라운즈앱을 통해 생성한 안경 가상 착용 이미지 예시</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:spacer {"height":20} -->
<div style="height:20px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:heading {"level":5} -->
<h5><strong><em>5.2. 훈련 데이터</em></strong></h5>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>평가 데이터 구축에 사용된 가상 안경 착용 합성 이미지 생성 방식을 훈련 데이터 세트에도 사용했습니다. 가상으로 합성된 이미지의 예는<strong> </strong>그림 14와&nbsp;같습니다. 하지만, 가상 안경 데이터는 그림자나 선글라스 렌즈 컬러와 같이 실사 이미지와 구분되는 인공적인 특징이 존재할 수 있습니다.&nbsp;처음 가상 안경 착용 이미지를 활용하려고 했을 때는 3D 렌더링 라이브러리에서 추가하는 어떤 알 수 없는 특징들이 학습을 많이 방해할 것으로 예상되었습니다. 이로 인해 실제 착용 이미지로 검색하게 되면 낮은 성능을 보일 것으로 우려되어, 실사 이미지와 합성 이미지 두 도메인간의 차이를 고려하여&nbsp;학습하도록 하는 <strong>Domain-adaptation, Domain-adversarial</strong> 기법들을 고려했습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":302,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/14.jpeg">
<img src="/assets/img/2019/1104/14.jpeg" alt="" />
</a>
<figcaption><small>그림 14. 훈련에 사용된 가상 안경 착용 합성 이미지 예시</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>훈련용 데이터를&nbsp;분석해 보니 언제나처럼 <span style="text-decoration: underline;">라벨링 관련 여러가지 문제가 대두</span>되었습니다. 이 때, 시각적으로는 동일한 상품인데 반해 안경의 사이즈가 다르다던가, 이벤트를 위해 다른 상품 아이디로 등록하는 경우 즉 다른 라벨을 할당받은 경우가 꽤 있었습니다. 이 경우 훈련과정에서 딥러닝 모델이 시각적으로 동일하여, 동일하다고 예측하게 되면 페널티를 받는 경우가 있어 학습에 방해가 되었습니다. 이 외에도 실사 안경 이미지의 경우, 시각적으로 동일한 안경이 서로 다른 표기법(ex: 영문 vs 한글)의 브랜드명과 상품명으로&nbsp;라벨링되어 있어 문제가 발생했습니다. 첫 훈련 시도에는 라벨링 에러가 있는 데이터를 이용했지만, 예상보다 꽤 높은 정확도를 보여 주었습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:spacer {"height":20} -->
<div style="height:20px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:heading -->
<h2><strong>6. 결과</strong></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>1차 데이터 세트가 준비 된 후, 다양한 메트릭 러닝 방식으로 훈련된 모델들을 평가해 보았습니다. 약 3,200여개의 상품을 등록하고 평가해 본 결과 그림 15와 같은 정확도가 얻어졌습니다. 각각 top-1 정확도&nbsp;0.46337, top-10 정확도 0.83376 로 측정되었습니다. 즉, 쿼리 이미지에 대해 등록된 3200여 개의 안경을 유사도 순으로 정렬하면 첫번 째로 해당 안경이 오게 되는 확률은 약 46% 이고, 10위 안에 해당 안경이 들어갈 확률은 약&nbsp;83% 라는 의미입니다.&nbsp;</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>훈련 데이터에는 실사 이미지가 섞여 있으나, 대부분은 가상 합성 이미지를 이용한 데이터였고 라벨링 에러도 섞여 있는 1차 데이터에 대해 이와 같은 결과를 얻은 것은 꽤 만족스러운 상황이었습니다. 앞으로 등록되는 상품의 개수와 다양성이 증가하고, 정제된 훈련 데이터도 추가로 확보되고, Segment 기술 적용, 다양한 Backbone 모델 사용, 최신 최적화 기법 적용이 예정되어 있었기 때문에 매우 고무적인 상황으로 프로젝트가 시작되었습니다. 프로젝트의 이후 진행상황은 기회가 되면 세미나 등을 통해 공유하기로 하고, 2부에서는 몇몇 기술적인 이슈를 깊게 다뤄 보겠습니다.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":303,"align":"wide"} -->
<center>
<figure class="wp-block-image alignwide">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/15.jpeg">
<img src="/assets/img/2019/1104/15.jpeg" alt="" />
</a>
<figcaption><small>그림15. top-N 정확도</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:image {"id":422,"align":"full"} -->
<center>
<figure class="wp-block-image alignfull">
<a class="wp-editor-md-post-content-link" href="/assets/img/2019/1104/16.png">
<img src="/assets/img/2019/1104/16.png" alt="" />
</a>
<figcaption><small>그림16. 모델 평가 테스트 페이지</small></figcaption></figure>
</center>
<!-- /wp:image -->

<!-- wp:spacer {"height":20} -->
<div style="height:20px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:heading -->
<h1>참고문헌</h1>
<!-- /wp:heading -->

<!-- wp:paragraph -->
[1]&nbsp;<a href="http://openaccess.thecvf.com/content_ICCV_2017/papers/Zhang_S3FD_Single_Shot_ICCV_2017_paper.pdf">http://openaccess.thecvf.com/content_ICCV_2017/papers/Zhang_S3FD_Single_Shot_ICCV_2017_paper.pdf</a><br/>
<!-- /wp:paragraph -->
<!-- wp:paragraph -->
[2] <a href="https://arxiv.org/ftp/arxiv/papers/1604/1604.02878.pdf">https://arxiv.org/ftp/arxiv/papers/1604/1604.02878.pdf</a><br/>
<!-- /wp:paragraph -->
<!-- wp:paragraph -->
[3] <a href="https://www.adrianbulat.com/downloads/FaceAlignment/FaceAlignment.pdf">https://www.adrianbulat.com/downloads/FaceAlignment/FaceAlignment.pdf</a><br/>
<!-- /wp:paragraph -->
<!-- wp:paragraph -->
[4] <a href="https://arxiv.org/pdf/1704.08063.pdf">https://arxiv.org/pdf/1704.08063.pdf</a><br/>
<!-- /wp:paragraph -->